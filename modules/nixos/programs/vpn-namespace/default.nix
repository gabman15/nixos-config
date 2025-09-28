{ config, lib, pkgs, ...}:

with lib; let
  cfg = config.custom.nixos.programs.vpn-namespace;
in
  {
    options.custom.nixos.programs.vpn-namespace = {
      enable = mkEnableOption "vpn namespace service";
    };
    config = let
      namespace = "mullvadns";
      interfaceName = "${namespace}wg0";
    in mkIf cfg.enable {
      age.secrets.vpn-namespace-wg = {
        file = ../../../../secrets/vpn-namespace-wg.age;
      };
      age.secrets.vpn-namespace-ipv4 = {
        file = ../../../../secrets/vpn-namespace-ipv4.age;
      };
      systemd.services."${namespace}" = let
        configfile = config.age.secrets.vpn-namespace-wg.path;
        ipv4file = config.age.secrets.vpn-namespace-ipv4.path;
      in {
        description = "wg network interface";
        requires = [ "network-online.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          LoadCredential = mkMerge [
            (mkIf (configfile != null) [ "wg.conf:${configfile}" ])
            (mkIf (ipv4file != null) [ "ipv4.txt:${ipv4file}" ])
          ];
          ExecStart = with pkgs; writers.writeBash "wg-up" ''
        # set -e
        ${iproute2}/bin/ip netns add ${namespace}
        ${iproute2}/bin/ip link add ${interfaceName} type wireguard
        ${iproute2}/bin/ip link set ${interfaceName} netns ${namespace}
        ipv4="$(cat ''${CREDENTIALS_DIRECTORY}/ipv4.txt)"
        ${iproute2}/bin/ip -n ${namespace} address add $ipv4 dev ${interfaceName}
        ${iproute2}/bin/ip netns exec ${namespace} \
          ${wireguard-tools}/bin/wg setconf ${interfaceName} ''${CREDENTIALS_DIRECTORY}/wg.conf
        ${iproute2}/bin/ip -n ${namespace} link set ${interfaceName} up
        ${iproute2}/bin/ip -n ${namespace} route add default dev ${interfaceName}
        ${iproute2}/bin/ip -n ${namespace} -6 route add default dev ${interfaceName}
      '';
          ExecStop = with pkgs; writers.writeBash "wg-down" ''
        ${iproute2}/bin/ip -n ${namespace} route del default dev ${interfaceName}
        ${iproute2}/bin/ip -n ${namespace} link del ${interfaceName}
        ${iproute2}/bin/ip netns del ${namespace}
      '';
        };
      };
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "${namespace}-run" ''
          username=$(whoami)
          sudo ip netns exec ${namespace} sudo -u $username $@
        '')
      ];
    };
  }

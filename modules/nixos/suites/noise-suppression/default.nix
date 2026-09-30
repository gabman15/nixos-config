{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.noise-suppression;
in
  {
    options.custom.nixos.suites.noise-suppression = {
      enable = mkEnableOption "Enable noise suppression for input devices in pipewire";
    };
    
    config = mkIf cfg.enable {
      services.pipewire.extraLadspaPackages = [ pkgs.rnnoise-plugin ];

      services.pipewire.extraConfig.pipewire."99-input-denoising" = {
        "context.modules" = [
          {
            name = "libpipewire-module-filter-chain";
            args = {
              "node.description" = "ncs";
              "media.name" = "ncs";
              "filter.graph" = {
                nodes = [
                  {
                    type = "ladspa";
                    name = "rnnoise";
                    plugin = "librnnoise_ladspa";
                    label = "noise_suppressor_mono";
                    control = {
                      "VAD Threshold (%)" = 50.0;
                      "VAD Grace Period (ms)" = 200;
                      "Retroactive VAD Grace (ms)" = 0;
                    };
                  }
                ];
              };
              "capture.props" = {
                "node.name" = "capture.rnnoise_source";
                "node.passive" = true;
                "audio.rate" = 48000;
              };
              "playback.props" = {
                "node.name" = "rnnoise_source";
                "media.class" = "Audio/Source";
                "audio.rate" = 48000;
                "filter.smart" = true;
                "filter.smart.name" = "rnnoise";
              };
            };
          }
        ];
      };

    };
  }

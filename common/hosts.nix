lib:
{
  nixoshosts = [ "yukari" "patchouli" "suwako" "koishi" "rikako" ];
  homemgrhosts = [ "gensokyo" "nitori" "aya" ];
  
  username = let
    username-override = {
      "sekibanki" = "steamos";
    };
    default-username = "lord_gabem";
  in (host: if (lib.hasAttr host username-override)
            then username-override.${host}
            else default-username);
}

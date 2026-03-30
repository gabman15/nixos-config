lib: final: prev: {
  gamescope = (prev.gamescope.overrideAttrs( oldAttrs: {
    patches = oldAttrs.patches ++ [
      (final.fetchpatch {
        url = "https://github.com/zlice/gamescope/commit/fa900b0694ffc8b835b91ef47a96ed90ac94823b.diff";
        hash = "sha256-eIHhgonP6YtSqvZx2B98PT1Ej4/o0pdU+4ubdiBgBM4=";
      })
    ];
  }));
  yt-dlp = (prev.yt-dlp.overrideAttrs( oldAttrs: {
    patches = [
      (final.fetchpatch {
        url = "https://github.com/vpertys/yt-dlp/commit/5cba77ae324f14c02b909b2f1600e7418e91bced.diff";
        hash = "sha256-fL4R0WVsVRewTgEWSSC8GnG8P1JYaWx3+C1su/xmETM=";
      })
    ];
  }));
  dosbox-x = (prev.dosbox-x.overrideAttrs( oldAttrs: {
    configureFlags = oldAttrs.configureFlags ++ [ "--enable-debug=heavy" ];
  }));
}
    

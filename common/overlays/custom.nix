lib: final: prev: {
  gamescope = (prev.gamescope.overrideAttrs( oldAttrs: {
    patches = oldAttrs.patches ++ [
      (final.fetchpatch {
        url = "https://github.com/zlice/gamescope/commit/fa900b0694ffc8b835b91ef47a96ed90ac94823b.diff";
        hash = "sha256-eIHhgonP6YtSqvZx2B98PT1Ej4/o0pdU+4ubdiBgBM4=";
      })
    ];
  }));
}
    

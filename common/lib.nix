lib: with lib; rec {
  # file helpers (from jbwar22)

  # get all files and directories in a directory matching predicates on type and name
  # example: import all directories (all must contain default.nix) except "asdf"
  # imports = filterFromDir ./. (type: type == "directory") (name: name != "asdf");
  filterFromDir = dir: typepredicate: filepredicate: pipe dir [
    (builtins.readDir)
    (filterAttrs (file: type:
      typepredicate type && filepredicate file
    ))
    (mapAttrsToList (file: _: (lib.path.append dir file)))
  ];
  getDirsFilter = dir: filepredicate: filterFromDir dir (type: type == "directory") filepredicate;
  getDirs = dir: getDirsFilter dir (_: true);
  getFilesFilter = dir: filepredicate: filterFromDir dir (type: type != "directory") filepredicate;
  getFiles = dir: getFilesFilter dir (_: true);

  getDir = dir: mapAttrs (file: type:
    if type == "directory" then getDir (lib.path.append dir file) else type
  ) readDir dir;

  # logic helpers

  mkIfElse = p: yes: no: mkMerge [
    (mkIf p yes)
    (mkIf (!p) no)
  ];
}

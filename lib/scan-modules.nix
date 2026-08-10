{ lib }: let
  inherit (builtins) readDir concatLists;
  inherit (lib) filterAttrs hasSuffix mapAttrsToList;

  scanModules = dir:
    let
      entries = readDir dir;
      isRelevant = name: type:
        (type == "regular" && hasSuffix ".nix" name && name != "default.nix")
        || type == "directory";
      process = name: type:
        if type == "directory"
        then scanModules (dir + "/${name}")
        else [ (dir + "/${name}") ];
    in
      concatLists (mapAttrsToList process (filterAttrs isRelevant entries));
in {
  inherit scanModules;
}

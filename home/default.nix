{
  lib,
  inputs,
  ...
}:
let
  shared_imports = [
    ./shared/default.nix
  ];

  inherit (builtins) readDir attrNames;

  # 获取所有用户目录名（排除 shared）
  userNames =
    let
      dirs = lib.filterAttrs (
        name: type: type == "directory" && name != "shared" && !(lib.hasPrefix "." name)
      ) (readDir ./.);
    in
    attrNames dirs;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs; };
    users = builtins.listToAttrs (
      map (user: lib.nameValuePair user { imports = shared_imports ++ [ ./${user} ]; }) userNames
    );
  };
}

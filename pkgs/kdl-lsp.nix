{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
let
  version = "6.7.1";
in
rustPlatform.buildRustPackage {
  pname = "kdl-lsp";
  inherit version;

  src = fetchFromGitHub {
    owner = "kdl-org";
    repo = "kdl-rs";
    rev = "v${version}"; # 或具体的 commit hash
    hash = "sha256-LqKYhJ0puOaqgIfSdw4b8ctWfiRYZmvL8AK3C2v0sSE="; # 替换为实际 hash
  };

  cargoHash = "sha256-+5XdCrlnxtdlhj07G2VFL1ICb0Ji+dqxfwJLpZlthmA=";

  # 只构建工作空间中的 kdl-lsp 包
  cargoBuildFlags = [
    "--package"
    "kdl-lsp"
  ];

  meta = {
    description = "LSP Server for the KDL Document Language";
    homepage = "https://kdl.dev";
    license = lib.licenses.asl20;
    maintainers = [ ]; # 或你自己的 handle
  };
}

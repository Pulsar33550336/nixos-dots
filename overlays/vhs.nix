{ ... }: {
  nixpkgs.overlays = [
    # 使用 vhs 的 Fork 版本 agentstation/vhs
    (self: super: {
      vhs = super.vhs.overrideAttrs (oldAttrs: {
        version = "0.11.1";

        src = super.fetchFromGitHub {
          owner = "agentstation";
          repo = "vhs";
          tag = "v0.11.1";
          hash = "sha256-VqNTRRFk/kZPGn/mpejXFR7ui+878Z3gx+TUlRtn8/0=";
        };

        vendorHash = "sha256-WiCSn84cr42yQFgg36H/NrVsfiBA/ZDAGd0WmC6LAa4=";
      });
    })
  ];
}

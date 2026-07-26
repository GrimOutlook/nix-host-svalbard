{
  inputs = {
    backup-host.url = "github:GrimOutlook/nix-backup-host";
    homelab.follows = "backup-host/homelab";
    nix-config.follows = "backup-host/nix-config";
    nixpkgs.follows = "backup-host/nixpkgs";
  };

  outputs =
    inputs@{
      nix-config,
      backup-host,
      ...
    }:
    nix-config.lib.mkHost {
      hostname = "svalbard";
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        backup-host.nixosModules.default
        ./modules/configuration.nix
      ];
    };
}

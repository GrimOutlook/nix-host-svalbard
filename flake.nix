{
  inputs = {
    backup-host.url = "github:GrimOutlook/nix-backup-host";
    homelab.follows = "backup-host/homelab";
    nix-config.follows = "backup-host/nix-config";
    nixpkgs.follows = "backup-host/nixpkgs";
  };

  outputs =
    inputs@{
      self,
      backup-host,
      nix-config,
      nixpkgs,
      ...
    }:
    {
      nixosConfigurations.svalbard = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          nix-config.nixosModules.default
          backup-host.nixosModules.default
          ./modules/configuration.nix
        ];
      };
    };
}

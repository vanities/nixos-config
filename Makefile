.PHONY: build apply shell update upgrade gc clean

build:
	  nix run .#build

apply:
	  nix run .#apply

shell:
	  nix develop

update:
	  nix flake update

upgrade:
	  nix flake update
	  nixos-rebuild switch

gc:
	  nix-collect-garbage -d

clean:
	  nix flake check
	  nix-store --gc

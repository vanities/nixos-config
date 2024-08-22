.PHONY: build apply shell update upgrade gc clean

apply:
	  nix run .#apply

build:
	  nix run .#build

shell:
	  nix develop

update:
	  nix run .#build-switch

upgrade:
	  nix flake update
	  nixos-rebuild switch

gc:
	  nix-collect-garbage -d

clean:
	  nix flake check
	  nix-store --gc

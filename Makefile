.PHONY: build apply shell update upgrade gc clean uninstall_nix upgrade_nix

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
	  #nix flake check
	  nix-store --gc

uninstall_nix:
		nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A uninstaller ./result/bin/darwin-uninstaller
		sudo /nix/nix-installer uninstall

upgrade_nix:
		sudo -i nix upgrade-nix

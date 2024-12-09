.PHONY: update
update:
	home-manager switch -b backup --flake .#victor

.PHONY: clean
clean:
	nix-collect-garbage -d

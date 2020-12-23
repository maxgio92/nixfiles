.DEFAULT_GOAL: dryrun

.PHONY: deploy
deploy: test build
	@nixos-rebuild switch

.PHONY: build
build: test
	@nixos-rebuild build -I nixos-config=.

.PHONY: test
test:
	@nixos-rebuild test -I nixos-config=.

.PHONY: dryrun
dryrun:
	@nixos-rebuild dry-activate -I nixos-config=.

.PHONY: edit
edit:
	@nixos-rebuild edit

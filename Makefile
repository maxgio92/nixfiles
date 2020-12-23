.DEFAULT_GOAL: build

.PHONY: deploy
deploy: test build
	@nixos-rebuild switch

.PHONY: build
build: test
	@nixos-rebuild build -I nixos-config=.

.PHONY: test
test:
	@nixos-rebuild test -I nixos-config=.

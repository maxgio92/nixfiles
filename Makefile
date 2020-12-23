.DEFAULT_GOAL: deploy

.PHONY: deploy
deploy: test build
	@nixos-rebuild switch

.PHONY: build
build: test
	@nixos-rebuild build

.PHONY: test
test:
	@nixos-rebuild test

.DEFAULT_GOAL: dryrun

.PHONY: deploy
deploy:
	@nixos-rebuild switch

.PHONY: build
build:
	@nixos-rebuild build -I nixos-config=.

.PHONY: try
try:
	@nixos-rebuild test -I nixos-config=.

.PHONY: test
test:
	@nixos-rebuild dry-activate -I nixos-config=.

.PHONY: edit
edit:
	@nixos-rebuild edit

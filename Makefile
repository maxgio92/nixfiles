.DEFAULT_GOAL: build

REPO := "https://github.com/maxgio92/nixfiles.git"
BRANCH := "main"
DEPLOYDIR := /etc/nixos
nixos-rebuild := $(shell command -v nixos-rebuild)

.PHONY: ensure-root
ensure-root:
ifneq ($(shell id -u), 0)
	$(error "You must be root to perform this action.")
endif

# Published version

.PHONY: deploy
deploy: update switch-deploy

.PHONY: stage
stage: update switch-stage

.PHONY: update
update: tmpdir := $(shell mktemp -d)
update: ensure-root
	@$(shell command -v git) clone $(REPO) $(tmpdir)
	@mkdir -p $(DEPLOYDIR)
	@cp $(tmpdir)/*.nix $(DEPLOYDIR)/
	@rm -rf $(tmpdir)

.PHONY: switch-stage
switch-stage: ensure-root
	@$(nixos-rebuild) switch -p staging

.PHONY: switch-deploy
switch-deploy: ensure-root
	@$(nixos-rebuild) switch

# Development version

.PHONY: test
test: ensure-root
	@$(nixos-rebuild) test -I nixos-config=./configuration.nix

.PHONY: build
build:
	@$(nixos-rebuild) build -I nixos-config=./configuration.nix

.PHONY: dry-activate
dry-activate:
	@$(nixos-rebuild) dry-activate -I nixos-config=./configuration.nix

.PHONY: edit
edit:
	@$(nixos-rebuild) edit

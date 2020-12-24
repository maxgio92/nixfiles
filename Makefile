REPO := "https://github.com/maxgio92/nixfiles.git"
BRANCH := "main"
DEPLOYDIR := /etc/nixos
nixos-rebuild := $(shell command -v nixos-rebuild)

.DEFAULT_GOAL: build

.PHONY: check-privileges
check-privileges:
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
update: check-privileges
	@$(shell command -v git) clone $(REPO) $(tmpdir)
	@mkdir -p $(DEPLOYDIR)
	@cp $(tmpdir)/*.nix $(DEPLOYDIR)/
	@rm -rf $(tmpdir)

.PHONY: switch-deploy
switch-deploy: check-privileges
	@$(nixos-rebuild) switch

.PHONY: switch-stage
switch-stage: check-privileges
	@$(nixos-rebuild) switch -p staging

# Development version

.PHONY: test
test: check-privileges
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

.DEFAULT_GOAL: dryrun

REPO := "https://github.com/maxgio92/nixfiles.git"
BRANCH := "main"
DEPLOYDIR := /etc/nixos
nixos-rebuild := $(shell command -v nixos-rebuild)

# Published version

.PHONY: deploy
deploy: update switch-deploy

.PHONY: release
release: update switch-release

.PHONY: update
update: tmpdir := $(shell mktemp -d)
update:
ifneq ($(shell id -u), 0)
	@echo "You must be root to perform this action."
	@exit 1
else
	@$(shell command -v git) clone $(REPO) $(tmpdir)
	@mkdir -p $(DEPLOYDIR)
	@cp $(tmpdir)/*.nix $(DEPLOYDIR)/
	@rm -rf $(tmpdir)
endif

.PHONY: switch-release
switch-release:
ifneq ($(shell id -u), 0)
	@echo "You must be root to perform this action."
	@exit 1
else
	@$(nixos-rebuild) switch -p "release_$(shell date '+%Y%m%d_%H%M%S')"
endif

.PHONY: switch-deploy
switch-deploy:
ifneq ($(shell id -u), 0)
	@echo "You must be root to perform this action."
	@exit 1
else
	@$(nixos-rebuild) switch
endif

# Development version

.PHONY: build
build:
ifneq ($(shell id -u), 0)
	@echo "You must be root to perform this action."
	@exit 1
else
	@$(nixos-rebuild) build -I nixos-config=.
endif

.PHONY: test
test:
ifneq ($(shell id -u), 0)
	@echo "You must be root to perform this action."
	@exit 1
else
	@$(nixos-rebuild) test -I nixos-config=.
endif

.PHONY: dry-activate
dry-activate:
	@$(nixos-rebuild) dry-activate -I nixos-config=.

.PHONY: edit
edit:
	@$(nixos-rebuild) edit

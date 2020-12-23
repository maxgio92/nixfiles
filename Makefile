.DEFAULT_GOAL: dryrun

REPO := "https://github.com/maxgio92/nixfiles.git"
BRANCH := "main"
DEPLOYDIR := /etc/nixos

# Published version

.PHONY: deploy
deploy: tmpdir := $(shell mktemp -d)
deploy:
ifneq ($(shell id -u), 0)
	@echo "You must be root to perform this action."
else
	@$(shell command -v git) clone $(REPO) $(tmpdir)
	@mkdir -p $(DEPLOYDIR)
	@cp $(tmpdir)/*.nix $(DEPLOYDIR)/
	@rm -rf $(tmpdir)
	@nixos-rebuild switch -p $(shell date '+%Y-%m-%d-%H-%M-%S')
endif

# Development version

.PHONY: build
build:
ifneq ($(shell id -u), 0)
	@echo "You must be root to perform this action."
else
	@nixos-rebuild build -I nixos-config=.
endif

.PHONY: test
test:
ifneq ($(shell id -u), 0)
	@echo "You must be root to perform this action."
else
	@nixos-rebuild test -I nixos-config=.
endif

.PHONY: dry-activate
dry-activate:
	@nixos-rebuild dry-activate -I nixos-config=.

.PHONY: edit
edit:
	@nixos-rebuild edit

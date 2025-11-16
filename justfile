# Default recipe to display help information
default:
    @just --list

# Install Ansible and dependencies
install:
    ./install

# Run the full bootstrap playbook
bootstrap:
    ./bootstrap

# Update git submodules
submodules:
    ansible-playbook bootstrap.yml --tags submodules

# Install Neovim configuration
nvim:
    ansible-playbook bootstrap.yml --tags nvim -K

# Install CLI tools
cli:
    ansible-playbook bootstrap.yml --tags cli -K

# Install LSP servers
lsp:
    ansible-playbook bootstrap.yml --tags lsp -K

# Install GUI applications (native Linux and macOS)
gui:
    ansible-playbook bootstrap.yml --tags gui -K

# Install desktop environment configuration (native Linux only)
desktop:
    ansible-playbook bootstrap.yml --tags desktop -K

# Run stow to symlink dotfiles
stow:
    ansible-playbook bootstrap.yml --tags stow

# Install shell enhancements (zsh plugins)
shell:
    ansible-playbook bootstrap.yml --tags shell

# Run a custom Ansible playbook with optional tags
run-playbook playbook tags="":
    #!/usr/bin/env bash
    if [ -n "{{ tags }}" ]; then
        ansible-playbook {{ playbook }} --tags {{ tags }}
    else
        ansible-playbook {{ playbook }}
    fi

# Check Ansible syntax without running
check:
    ansible-playbook bootstrap.yml --syntax-check

# Run in check mode (dry run)
dry-run:
    ansible-playbook bootstrap.yml --check -K

# Update all tools to latest versions (runs bootstrap)
update: bootstrap

# Clean up temporary files and caches
clean:
    @echo "Cleaning up temporary files..."
    @find . -type f -name "*.retry" -delete
    @find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    @echo "Clean complete"

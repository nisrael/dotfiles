# Default recipe to display help information
default:
    @just --list
    @echo ""
    @echo "Examples (local):"
    @echo "  just minimal                    # Run minimal setup locally (default)"
    @echo "  just cli                        # Install CLI tools locally"
    @echo "  just nvim                       # Install Neovim config locally"
    @echo "  just jetbrains                  # Install all JetBrains IDEs"
    @echo "  just intellij                   # Install IntelliJ IDEA Ultimate only"
    @echo "  just dry-run                    # Preview changes without applying"
    @echo ""
    @echo "Examples (remote - use positional args, NOT key=value):"
    @echo "  just minimal wasp.sxda.io       # Run minimal setup on wasp (specific host)"
    @echo "  just cli remote                 # Install CLI tools on [remote] group"
    @echo "  just nvim remote                # Install Neovim on all remote hosts"
    @echo "  just pycharm remote             # Install PyCharm on all remote hosts"

# Install Ansible and dependencies
install:
    ./install

# Run the full bootstrap playbook
bootstrap:
    ./bootstrap

# Update git submodules
submodules:
    ansible-playbook bootstrap.yml --tags submodules

# Install minimal essential tools (cross-distribution servers)
minimal target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags minimal -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags minimal -K
    fi

# Install Neovim configuration
nvim target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags nvim -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags nvim -K
    fi

# Install CLI tools
cli target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags cli -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags cli -K
    fi

# Install LSP servers
lsp target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags lsp -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags lsp -K
    fi

# Install GUI applications (native Linux and macOS)
gui target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags gui -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags gui -K
    fi

# Install desktop environment configuration (native Linux only)
desktop target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags desktop -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags desktop -K
    fi

# Install all JetBrains IDEs (IntelliJ, PyCharm, RubyMine, CLion, RustRover)
jetbrains target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags jetbrains -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags jetbrains -K
    fi

# Install IntelliJ IDEA Ultimate
intellij target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags intellij -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags intellij -K
    fi

# Install PyCharm Professional
pycharm target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags pycharm -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags pycharm -K
    fi

# Install RubyMine
rubymine target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags rubymine -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags rubymine -K
    fi

# Install CLion
clion target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags clion -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags clion -K
    fi

# Install RustRover
rustrover target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags rustrover -K
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags rustrover -K
    fi

# Run stow to symlink dotfiles
stow target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags stow
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags stow
    fi

# Install shell enhancements (zsh plugins)
shell target="local":
    #!/usr/bin/env bash
    if [ "{{ target }}" = "local" ]; then
        ansible-playbook bootstrap.yml --connection=local -i "localhost," --tags shell
    else
        ansible-playbook -i inventory.ini bootstrap.yml --limit {{ target }} --tags shell
    fi

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

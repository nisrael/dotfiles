My configuration files for Linux and macOS.

# Install git

| Ubuntu | Fedora | macOS |
| ------ | ------ | ----- |
| `sudo apt install -y git` | `sudo dnf install -y git` | `xcode-select --install` |

# Clone the repository

```sh
git clone git@github.com:phelipetls/dotfiles.git
cd dotfiles
```

# Install Ansible

```sh
./install
```

# Run playbook

```sh
./bootstrap
```

# Updating GNOME settings

GNOME settings are managed in two ways:
- **System settings** (keybindings, sound, etc.) - Individual tasks in `roles/linux-desktop/tasks/gnome.yml`
- **Extension settings** - Bulk dconf dumps in `roles/linux-desktop/files/`

## Updating system settings

For GNOME desktop preferences, edit `roles/linux-desktop/tasks/gnome.yml` directly:

```yaml
- name: Show battery percentage
  community.general.dconf:
    key: "/org/gnome/desktop/interface/show-battery-percentage"
    value: "true"
```

## Updating extension settings

To save extension settings after customization:

```sh
# Export extension settings
dconf dump /org/gnome/shell/extensions/dash-to-dock/ > roles/linux-desktop/files/dconf-org.gnome.shell.extensions.dash-to-dock.dump
dconf dump /org/gnome/shell/extensions/blur-my-shell/ > roles/linux-desktop/files/dconf-org.gnome.shell.extensions.blur-my-shell.dump
```

## Apply to other systems

After updating settings, apply them:

```sh
./bootstrap
# or
ansible-playbook bootstrap.yml --tags linux
```

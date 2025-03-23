# Usage

To update the system
```
sudo nixos-rebuild switch --flake .#<hostname>
```

To update user config
```
home-manager switch --flake .#<username>@<hostname>
```

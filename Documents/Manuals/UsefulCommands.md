# Useful commands

## Generate SSH key and add it to Github

```bash
ssh-keygen -t ed25519 -C "alexander.kno+github@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/geektimus_github_ed25519

gpg --edit-key 9D92C3C7850D850C
gpg --import geektimus-private-key.asc
```

## Mount Host folders into the VM

```bash
sudo mkdir /run/media/<folder-name/> && sudo mount -t vboxsf -o gid=vboxsf <folder-name/> /run/media/<folder-name/>
```

## Update mirrors using reflector

```bash
reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```
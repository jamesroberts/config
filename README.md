### Setup

If on a new machine, create a new SSH key and add it to Github:

```bash
ssh-keygen -t ed25519 -C "<email>"
```

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
echo -e "\nAdd above to: https://github.com/settings/keys"
```

Clone and setup the repo:

```bash
cd $HOME
git clone git@github.com:jamesroberts/config.git
./config/repo_setup.sh
```

If any files fail to checkout after setup, fix with:

```bash
config checkout --force
```

On a new machine, setup editor and dependencies:

```bash
./setup_scripts/setup_nvim.sh
./setup_scripts/setup_deps.sh
```

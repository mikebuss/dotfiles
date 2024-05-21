#!/bin/zsh

cd ~

# Check if the dotfiles directory already exists
if [ -d "dotfiles" ]; then
  echo "The dotfiles directory already exists. Skipping git clone."
else
  git clone git@github.com:mikebuss/dotfiles.git
fi

cd dotfiles

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found, please install it first."
  exit 1
fi

# List of packages to install
packages=(eza fzf bat neovim zoxide stow)

for package in "${packages[@]}"; do
  if brew list --formula | grep -q "^${package}$"; then
    echo "${package} is already installed. Skipping."
  else
    brew install "${package}"
  fi
done

stow .
echo "Ran 'stow .' to symlink dotfiles."

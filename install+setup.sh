#!/bin/bash
if [ $EUID -eq 0 ]; then
	echo "Please don't run root."
	exit 1
fi

if ! which git >/dev/null 2>&1; then
	echo "Git is not installed. Please install Git before running the script."
	exit 1
fi

# Clone repo
git clone https://github.com/100tch/1488dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles

config_dir=$HOME/.dotfiles/config

# Getting a list of configuration files
dotfiles=()
while IFS= read -r -d '' file; do
  dotfiles+=("$file")
done < <(find $config_dir -type f -print0)

# Backup existing dotfiles
hash_t=$(date +%s | md5sum | awk '{print $1}')
backup_dir=$HOME/.dotfiles_backup/$hash_t
mkdir -p $backup_dir

for file in "${dotfiles[@]}"; do
	relative_path="${file#$config_dir/}"
	if [ -f $HOME/$relative_path ] || [ -d $HOME/$relative_path ]; then
		mv $HOME/$relative_path $backup_dir
		filename=$(basename "$file")
		echo "Created a backup for $filename in $backup_dir"
	fi
done

# Creating symbolic links to dotfiles
for file in "${dotfiles[@]}"; do
	relative_path="${file#$config_dir/}"
	filename=$(basename "$file")
	ln -s $file $HOME/$relative_path
	echo "Created a symbolic link for $filename"
done

# Transfer of executable files
local_bin=$HOME/.dotfiles/local/bin
target_bin=$HOME/.local/bin
mkdir -p $target_bin

for file in "$local_bin"/*; do
	if [ -f "$file" ]; then
		filename=$(basename "$file")
		target_file="$target_bin/$filename"
		if [ -f "$target_file" ] && ! cmp -s "$file" "$target_file"; then
			mv -v "$target_file" "$target_file.bak"
		fi
		cp "$file" "$target_bin"
		echo "Created a copy of the file $filename in $target_bin"
	fi
done

# Installing additional dependencies or plugins
mkdir -p $HOME/.vim/autoload/ $HOME/.vim/plugged
curl -o $HOME/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installation completed."

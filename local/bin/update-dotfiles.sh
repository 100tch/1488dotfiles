#!/usr/bin/env bash
if [ $EUID -eq 0 ]; then
	echo "Please don't run root."
	exit 1
fi

dotfiles_dir=$HOME/.dotfiles
if [ ! -d "$dotfiles_dir" ]; then
	echo "Directory .dotfiles not found"
	exit 1
fi

cd "$dotfiles_dir" || exit 1
git pull

# Creating symbolic links to dotfiles
config_dir=$dotfiles_dir/config

find $config_dir -type f | while read -r file; do
	relative_path="${file#$config_dir/}"
	target_file="$HOME/$relative_path"

	if [[ ! -e "$target_file" ]]; then
		filename=$(basename "$file")
		ln -s "$file" "$target_file"
		echo "Created a symbolic link for new file $filename"
	fi
done

# Transfer of executable files
local_bin=$dotfiles_dir/local/bin
target_bin=$HOME/.local/bin
mkdir -p $target_bin

for file in "$local_bin"/*; do
	if [ -f "$file" ]; then
		filename=$(basename "$file")
		target_file="$target_bin/$filename"
		if [[ -e "$target_file" ]]; then
			if ! cmp -s "$file" "$target_file"; then
				mv -v "$target_file" "$target_file.bak"
				cp "$file" "$target_bin"
				echo "Created a copy of the file $filename in $target_bin"
			fi
		else
			cp "$file" "$target_bin"
			echo "Created a copy of the file $filename in $target_bin"
		fi
	fi
done

#!/bin/sh

: "${CONF_HOME:=$HOME}"

echo "$CONF_HOME"

if test ! -d "${CONF_HOME}/.config"; then
	mkdir -p "${CONF_HOME}/.config"
fi

if test ! "$DISABLE_ZSH" = "YES"; then
	if test ! -f "${CONF_HOME}/.zshrc"; then
		ln -s "${PWD}/zshrc" "${CONF_HOME}/.zshrc"
	fi
fi


if test ! "$DISABLE_NVIM" = "YES"; then
	if test ! -d "${CONF_HOME}/.config/nvim"; then
		ln -s "${PWD}/nvim" "${CONF_HOME}/.config/nvim"
	fi
	
	# Clone Packer
	git clone --depth 1 "https://github.com/wbthomason/packer.nvim"\
		"${CONF_HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim" || true
	
fi


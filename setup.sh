#!/bin/sh

: "${CONF_HOME:=$HOME}"

echo "$CONF_HOME"

if test ! -d "${CONF_HOME}/.config"; then
	mkdir -p "${CONF_HOME}/.config"
fi

if test ! "$DISABLE_ZSH" = "YES"; then
	test ! -f "${CONF_HOME}/.zshrc" && \
		ln -s "${PWD}/zshrc" "${CONF_HOME}/.zshrc"
	test ! -f "${CONF_HOME}/.zprofile" && \
		ln -s "${PWD}/zprofile" "${CONF_HOME}/.zprofile"
fi


if test ! "$DISABLE_NVIM" = "YES"; then
	if test ! -d "${CONF_HOME}/.config/nvim"; then
		ln -s "${PWD}/nvim" "${CONF_HOME}/.config/nvim"
	fi
	
	# Clone Packer
	git clone --depth 1 "https://github.com/wbthomason/packer.nvim"\
		"${CONF_HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim" || true
	
fi


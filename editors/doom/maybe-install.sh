#!/bin/sh
DOOM="$HOME/.config/emacs"

if [ ! -d "$DOOM" ]; then
	git clone --depth 1 \
		--single-branch \
		https://github.com/hlissner/doom-emacs.git $DOOM
	$DOOM/bin/doom install
fi

$DOOM/bin/doom sync

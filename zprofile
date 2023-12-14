export QT_FONT_DPI=140

[ -f ~/.config/LF_ICONS ] && {
	LF_ICONS="$(tr '\n' ':' <~/.config/LF_ICONS)" \
		&& export LF_ICONS
}

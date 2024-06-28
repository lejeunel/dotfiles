{ config, pkgs, ... }:

{
  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;
    commands = {
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
      ''${{
        printf "Directory Name: "
        read DIR
        mkdir $DIR
      }}
    '';
    fzf-jump = ''
    ''${{
      res="$(find . -maxdepth 1 | fzf --reverse --header='Jump to location')"
      if [ -n "$res" ]; then
          if [ -d "$res" ]; then
              cmd="cd"
          else
              cmd="select"
          fi
          res="$(printf '%s' "$res" | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id $cmd \"$res\""
      fi
    }}
    '';

    bulk-rename = ''
    ''${{
      old="$(mktemp)"
      new="$(mktemp)"
      if [ -n "$fs" ]; then
          fs="$(basename -a $fs)"
      else
          fs="$(ls)"
      fi
      printf '%s\n' "$fs" >"$old"
      printf '%s\n' "$fs" >"$new"
      vim "$new"
      [ "$(wc -l < "$new")" -ne "$(wc -l < "$old")" ] && exit
      paste "$old" "$new" | while IFS= read -r names; do
          src="$(printf '%s' "$names" | cut -f1)"
          dst="$(printf '%s' "$names" | cut -f2)"
          if [ "$src" = "$dst" ] || [ -e "$dst" ]; then
              continue
          fi
          mv -- "$src" "$dst"
      done
      rm -- "$old" "$new"
      lf -remote "send $id unselect"
    }}
    '';
    trash = ''
    $IFS="$(printf '\n\t')"; mv $fx ~/.trash
    '';
    };

    keybindings = {
      "+" = "mkdir";
      f = "fzf-jump";
      R = "bulk-rename";
      DD = "trash";
      "." = "set hidden!";
      "<enter>" = "open";
      "g~" = "cd";
      gh = "cd";
      "g/" = "/";

      ee = "editor-open";
      "<c-o>" = "$$SHELL";

    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = false;
      icons = true;
      ignorecase = true;
    };
  };

}

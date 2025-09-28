{
  pkgs,
  config,
  ...
}:

{
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/share/nvim/mason/bin"
  ];
  home.packages = with pkgs; [
    vimgolf
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

}

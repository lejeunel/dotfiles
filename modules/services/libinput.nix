{
  flake.modules.nixos.libinput = {
    services.libinput = {
      enable = true;
      mouse.disableWhileTyping = true;
    };

  };

}

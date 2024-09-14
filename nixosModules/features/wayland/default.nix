{ config, lib, pkgs, ... }:

{
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.xterm.enable = true;
    xkb.extraLayouts.qwerty-fr = {
      description = "US layout with alt-gr french";
      languages   = [ "eng" ];
      symbolsFile = ./qwerty-fr;
    };
  };

  programs.sway = {
	enable = true;
	wrapperFeatures.gtk = true;
	extraPackages = with pkgs; [
		waylock
		swayidle
		wl-clipboard
		wf-recorder
		mako
		grim
		slurp
		];
  };

  programs.waybar.enable = true;

  console.useXkbConfig = true;


  # for touchpad
  services.libinput.enable = true;

}

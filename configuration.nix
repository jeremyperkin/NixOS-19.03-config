# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, callPackage, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];
  boot.supportedFilesystems = [ "exfat" ] ;

  
 #environment.etc."i3status.conf".source = "./config/i3"; 
 environment.pathsToLink = [ "/libexec"  "/etc" ]; # links /libexec from derivations to /run/current-system/sw
 nixpkgs.config.allowUnfree = true;
 #nixpkgs.config.packageOverrides = pkgs:  rec {
    #polybar = pkgs.polybar.override {
      #alsaSupport = true;
      #i3Support = true;
      #iwSupport = true;
      #githubSupport = true;
      #mpdSupport = true;
     #};
 #};

  
  # Select internationalisation properties.
    i18n = {
      consoleFont = "Lat2-Terminus16";
      consoleKeyMap = "us";
      defaultLocale = "en_US.UTF-8";
};

  # Set your time zone.
  time.timeZone = "America/Vancouver";

   environment.extraInit = ''
  #these are the defaults, but some applications are buggy so we set them
  # here anyway
 export XDG_CONFIG_HOME=$HOME/.config
 export XDG_DATA_HOME=$HOME/.local/share
 export XDG_CACHE_HOME=$HOME/.cache
 '';




  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   (polybar.override { i3Support = true; mpdSupport = true;  pulseSupport = true; githubSupport = true; })
    
    
    tk
    atom
    pango
    pandoc
    pamixer
    pasystray
    pavucontrol                            
    qbittorrent   
    neofetch
    urlview
    rtv
    speedtest-cli
    p7zip
    htop
    git
    zathura
    calibre
    ark
    discord
    kate
    fish
    polybar 
    firefox
    dnscrypt-proxy    
    open-vm-tools
    rofi
    i3
    dunst
    i3-gaps    
    i3status
    i3blocks
    vlc
    lxappearance
    compton
    mpv
    cmus
    youtube-dl
    ffmpeg
    git
    neofetch
    dolphin
    ranger
    gimp
    lightdm
    rxvt_unicode
    dunst
    fontconfig
    i3lock
    xss-lock
    xclip
    xsel
    unclutter
    argyllcms
    nitrogen  # better multihead support than feh
    pinentry_qt4

   xlibs.xbacklight
   xlibs.xmodmap
  xlibs.xev
  xlibs.xinput
  xlibs.xmessage
  xlibs.xkill
  xlibs.xgamma
  xlibs.xset
  xlibs.xrandr
  xlibs.xrdb
  xlibs.xprop
  xlibs.libXScrnSaver # for argyllcms
 
 ];
  
  programs = {

   bash.enableCompletion = true;       # Enable completion in bash shell
   fish.enable = true;                 # Holdup... why is this here?
   fish.shellAliases = {               # Extra fish commands
    neofetchnix = "neofetch --ascii_colors 68 110";
    fonts = "fc-list : family | cut -f1 -d\",\" | sort";
    prettify = "python -m json.tool"; # Prettify json!
    dotp = "dot -Tpdf -o $1.pdf";
    doti = "dot -Tpng -o $1.png";
    };
    less.enable = true;                 # Enables config for the `less` command
    less.commands = { h = "quit"; };    # Rebind the `h` key to quit 

    qt5ct.enable = true;                # Enable qt5ct (fixes Qt applications) 
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  
    services.openssh.enable = true;
    virtualisation.vmware.guest = {
        enable = true;
	};
 
  hardware.opengl.driSupport32Bit = true;
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;



 

  # Enable the X11 windowing system.
 # services.xserver.enable = true;
 # services.xserver.layout = "us";
 # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  services.compton = {
    enable = true;
    fade = true;
    inactiveOpacity = "0.7";
    shadow = true;
    fadeDelta = 4;
};

#DNSCrypt
    services.dnscrypt-proxy.enable = true;
    services.dnscrypt-proxy.customResolver = {
     address = "142.4.204.111";
     port = 443;
     name = "2.dnscrypt-cert.ns3.ca.luggs.co";
     key = "1C19:7933:1BE8:23CC:CF08:9A79:0693:7E5C:3410:2A56:AC7F:6270:E046:25B2:EDDB:04E3";
   };


  networking.hostName = "Seneca";
  networking.networkmanager.enable = true;
  networking.nameservers = ["127.0.0.1"];

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.v0id = {
    isNormalUser = true;
    shell = pkgs.fish;
    createHome = true;
    home = "/home/v0iD";  
    description = "v0iD";
    extraGroups = [ 
         "wheel"
         "networkmanager"
         "audio"
         "video"
         "pulse"]; 
    uid = 1000;
   };
   
systemd.user.services = {
nm-applet = {
description = "Network manager applet";
wantedBy = [ "graphical-session.target" ];
partOf = [ "graphical-session.target" ];
serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
    };
};
  
fonts = {
    fonts = with pkgs; [

      #corefonts
      hack-font
      #emojione                          # Emoji font
      #fira-code-symbols                 # Fancy font with programming #ligatures
      #fira-code                         # Fancy font with programming #ligatures
      font-awesome_5                    # Fancy icons font
      nerdfonts
      powerline-fonts
      roboto
      roboto-mono
      roboto-slab      
      #siji                              # Iconic bitmap font
      source-code-pro ];

   fontconfig = {
    ultimate.enable = true;
    defaultFonts = {
        monospace = [ "roboto-mono" ];
        sansSerif = [ "roboto" ];
        serif = [ "roboto-slab" ];
    };
};

    };

  services.xserver = {
      enable = true;
      layout = "us";
      exportConfiguration = true;
      xkbOptions = "eurosign:e";
      desktopManager = {
           plasma5.enable  =  true;
           xterm.enable = false;
     };
      windowManager.i3 = {
            enable = true;
           # configFile = "/.config/i3/config"; 
             package = pkgs.i3-gaps;
             extraPackages = with pkgs; [
                i3lock #default i3 screen locker
                i3status #if you are planning on using i3blocks over i3status
    ];
    
     };

     displayManager.lightdm = {
          enable = true;
     };
};
#environment.etc."i3status.conf".text = pkgs.callPackage $HOME/.config/i3-config.nix {};
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?






}

{pkgs, ...}: {
  programs.gnupg = {
    package = pkgs.gnupg;
    dirmngr.enable = false;
    agent = {
      enable = true;
      enableSSHSupport = false;
      enableExtraSocket = false;
      enableBrowserSocket = false;
      pinentryPackage = pkgs.pinentry-qt;
      settings = {};
    };
  };
}

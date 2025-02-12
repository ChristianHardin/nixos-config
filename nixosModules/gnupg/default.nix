{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    gnupg.enable =
      lib.mkEnableOption "enable gnupg";
  };

  config = lib.mkIf config.gnupg.enable {
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
  };
}

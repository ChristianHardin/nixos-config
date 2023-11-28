{ lib, ... }: {
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    # supportedLocales = lib.mkDefault [ "en_US.UTF-8" ];
  };
  time.timeZone = "America/New_York";
}
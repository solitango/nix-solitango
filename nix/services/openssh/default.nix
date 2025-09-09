{
  config,
  lib,
  ...
}: let
  cfg = config.solitango.services.openssh;
in {
  options.solitango.services.openssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];
      openFirewall = true;

      hostKeys = [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          rounds = 100;
          type = "ed25519";
        }
      ];

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    solitango.storage.persistent.files = (
      builtins.map (key: key.path) config.services.openssh.hostKeys
    );
  };
}

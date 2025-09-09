{
  config,
  lib,
  ...
}: let
  cfg = config.solitango.services.ssh;
in {
  options.solitango.services.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];
      openFirewall = true;

      hostKeys = [
        {
          comment = "key comment";
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

    solitango.storage.persistent.directories = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };
}

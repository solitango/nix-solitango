{
  config,
  lib,
  ...
}: let
  cfg = config.solitango.services.maddy;
  certificateDirectory = config.security.acme.certs."${cfg.primaryDomain}".directory;
in {
  options.solitango.services.maddy = {
    enable = lib.mkEnableOption "Maddy";

    user = lib.mkOption {
      type = lib.types.string;
      default = "maddy";
    };

    primaryDomain = lib.mkOption {
      type = lib.types.string;
      example = "solitango.com";
    };

    hostname = lib.mkOption {
      type = lib.types.string;
      default = "mail.${cfg.primaryDomain}";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      25
      465
      993
    ];

    solitango.storage.persistentDirectories = [
      "/var/lib/maddy"
    ];

    users.users."${cfg.user}".extraGroups = ["acme"];

    services.maddy = {
      enable = true;

      inherit (cfg) primaryDomain hostname;

      tls = {
        loader = "file";
        certificates = [
          {
            keyPath = "${certificateDirectory}/key.pem";
            certPath = "${certificateDirectory}/fullchain.pem";
          }
        ];
      };

      config = builtins.readFile ./maddy.conf;
    };
  };
}

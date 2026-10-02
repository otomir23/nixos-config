{
  mixed-port = 7890;
  external-controller = "0.0.0.0:9090";
  ipv6 = false;
  find-process-mode = "always";

  tun.enable = true;
  dns = {
    enable = true;
    nameserver = [ "https://doh.pub/dns-query" ];
  };

  proxy-groups = [
    {
      name = "VPN";
      type = "select";
      include-all = true;
      proxies = [ "DIRECT" ];
    }
  ];

  rule-providers = {
    torrent-trackers = {
      type = "http";
      behavior = "domain";
      format = "mrs";
      url = "https://github.com/legiz-ru/mihomo-rule-sets/raw/main/other/torrent-trackers.mrs";
      path = "./rule-sets/torrent-trackers.mrs";
      interval = 86400;
    };
    torrent-websites = {
      type = "http";
      behavior = "domain";
      format = "mrs";
      url = "https://github.com/legiz-ru/mihomo-rule-sets/raw/main/other/torrent-websites.mrs";
      path = "./rule-sets/torrent-websites.mrs";
      interval = 86400;
    };
    torrent-clients = {
      type = "http";
      behavior = "classical";
      format = "yaml";
      url = "https://github.com/legiz-ru/mihomo-rule-sets/raw/main/other/torrent-clients.yaml";
      path = "./rule-sets/torrent-clients.yaml";
      interval = 86400;
    };
    geosite-ru = {
      type = "http";
      behavior = "domain";
      format = "mrs";
      url = "https://github.com/MetaCubeX/meta-rules-dat/raw/meta/geo/geosite/category-ru.mrs";
      interval = 86400;
    };
    geoip-ru = {
      type = "http";
      behavior = "ipcidr";
      format = "text";
      url = "https://raw.githubusercontent.com/Davoyan/ipinfo/main/geo/geoip/ru.lst";
      interval = 86400;
    };
    category-ru = {
      type = "http";
      behavior = "domain";
      format = "mrs";
      url = "https://raw.githubusercontent.com/hydraponique/roscomvpn-geosite/release/mihomo/category-ru.mrs";
      interval = 86400;
    };
  };

  rules = [
    "GEOIP,lan,DIRECT,no-resolve"
    "RULE-SET,geosite-ru,DIRECT"
    "RULE-SET,geoip-ru,DIRECT"
    "PROCESS-NAME-WILDCARD,cs2*,DIRECT"
    "PROCESS-NAME-WILDCARD,*torrent*,DIRECT"
    "MATCH,VPN"
  ];
}

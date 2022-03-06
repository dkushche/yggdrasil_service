import json

CONFIG_PATH = "/yggdrasil/yggdrasil.conf"

ukranian_peers = [
    "tcp://193.111.114.28:8080",
    "tcp://78.27.153.163:33165",
    "tls://193.111.114.28:1443",
    "tls://78.27.153.163:33166",
    "tls://91.224.254.114:18001"
]

yggdrasil_conf = None

with open(CONFIG_PATH, 'r', encoding='utf-8') as conf:
    yggdrasil_conf = json.load(conf)
    yggdrasil_conf["Peers"] = ukranian_peers
    yggdrasil_conf["IfName"] = "portal0"

print(f"Configuration: {json.dumps(yggdrasil_conf, indent=4)}")

with open(CONFIG_PATH, 'w', encoding='utf-8') as conf:
    json.dump(yggdrasil_conf, conf, ensure_ascii=False, indent=4)

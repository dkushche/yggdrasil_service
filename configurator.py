import json

CONFIG_PATH = "/mnt/storage/yggdrasil.conf"
PEERS_PATH = "/mnt/storage/peers.json"

peers_conf = None
yggdrasil_conf = None

with open(PEERS_PATH, 'r', encoding='utf-8') as conf:
    peers_conf = json.load(conf)

with open(CONFIG_PATH, 'r', encoding='utf-8') as conf:
    yggdrasil_conf = json.load(conf)
    yggdrasil_conf["Peers"] = peers_conf["peers"]
    yggdrasil_conf["IfName"] = "portal0"

print(f"Configuration: {json.dumps(yggdrasil_conf, indent=4)}")

with open(CONFIG_PATH, 'w', encoding='utf-8') as conf:
    json.dump(yggdrasil_conf, conf, ensure_ascii=False, indent=4)

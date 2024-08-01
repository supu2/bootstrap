#!/bin/sh
curl -sL https://talos.dev/install | sh
wget -c https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_Linux_amd64.tar.gz -O - | tar -zx k9s && mv k9s /usr/bin/k9s
talosctl cluster create --workers 0  --memory 10000 --cpus 8 \
	--config-patch '[{"op": "add", "path": "/cluster/allowSchedulingOnControlPlanes", "value": true},{"op": "add", "path": "/cluster/extraManifests", "value": ["https://raw.githubusercontent.com/supu2/bootstrap/main/flux.yaml","https://raw.githubusercontent.com/supu2/bootstrap/main/jitsi.yaml","https://raw.githubusercontent.com/supu2/bootstrap/main/ingress-nginx.yaml","https://raw.githubusercontent.com/supu2/bootstrap/main/local-path-provisioner.yaml"]}]' \
	-p 80:31000/tcp,443:31001/tcp,10000:31002/udp

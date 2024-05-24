#!/usr/bin/env bash

cat > /tmp/Dockerfile << EOF
FROM centos:7
LABEL com.datacanvas.aps.env_start=1
RUN echo haha > /tmp/test
LABEL A=2
LABEL A=3
EOF


mkdir -p /kaniko
mkdir -p /kaniko/.docker


cat > /kaniko/.docker/config.json << EOF
{
	"auths": {
		"harbor.zetyun.cn": {
			"auth": "YXBzOkR5QWwweFdyNQ=="
		},
		"harbor.zetyun.com": {
			"auth": "YWRtaW46emV0eXVuSEFSYm9y"
		},
		"https://index.docker.io/v1/": {},
		"registry.aps.datacanvas.com:5000": {
			"auth": "YWRtaW46U2VydmVyMjAwOCE="
		},
		"registry.cn-hangzhou.aliyuncs.com": {}
	},
	"credsStore": "desktop",
	"currentContext": "desktop-linux",
	"aliases": {
		"builder": "buildx"
	}
}
EOF


/workspace/executor  --dockerfile /tmp/Dockerfile  --snapshot-mode=redo --insecure=true --skip-tls-verify=true --context . --tar-path=./img.tar --no-push --force-build-metadata --custom-platform=linux/amd64

# CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./devlop/executor ./cmd/executor
# docker run --rm -it -v `pwd`/devlop:/workspace -w /workspace centos:7 bash
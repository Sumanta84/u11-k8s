command: ['sh', '-c', 'until nslookup k8sbook; do echo waiting for k8sbook service; sleep 1; done; echo Service found!']

until 
    nslookup k8sbook
do
    echo 'waiting for k8sbook service'
    sleep 1
done

echo 'Service found!'
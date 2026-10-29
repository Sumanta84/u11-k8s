$ PS C:\WINDOWS\System32> kubectl get ns
NAME              STATUS   AGE
default           Active   6m53s
kube-node-lease   Active   6m53s
kube-public       Active   6m53s
kube-system       Active   6m53s

$ kubectl apply -f 'C:\Users\elphi\OneDrive\Desktop\u11-k8s\5.namespaces\shield-ns.yml'
namespace/shield created
$ kubectl get ns
NAME              STATUS   AGE
default           Active   7m49s
kube-node-lease   Active   7m49s
kube-public       Active   7m49s
kube-system       Active   7m49s
shield            Active   3s

$ kubectl apply -f 'C:\Users\elphi\OneDrive\Desktop\u11-k8s\5.namespaces\app.yml'
Warning: resource serviceaccounts/default is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
serviceaccount/default configured
service/the-bus created
pod/triskelion created

$ kubectl config set-context --current --namespace shield
Context "lke683040-ctx" modified.

$ kubectl get all --all-namespaces
NAMESPACE     NAME                                                 READY   STATUS    RESTARTS        AGE
kube-system   pod/calico-kube-controllers-74d6f48977-m6r8r         1/1     Running   0               11m
kube-system   pod/calico-node-498f4                                1/1     Running   0               10m
kube-system   pod/calico-node-5rr8g                                1/1     Running   0               10m
kube-system   pod/calico-node-jplsb                                1/1     Running   0               10m
kube-system   pod/calico-typha-687cc8b96f-lclfr                    1/1     Running   0               11m
kube-system   pod/calico-typha-687cc8b96f-phfpr                    1/1     Running   0               10m
kube-system   pod/calico-typha-autoscaler-5dc98cf489-tjfs5         1/1     Running   0               12m
kube-system   pod/coredns-549fdd9bd4-7rpq2                         1/1     Running   0               10m
kube-system   pod/coredns-549fdd9bd4-xl6q4                         1/1     Running   0               12m
kube-system   pod/coredns-autoscaler-5dd9fbdf44-wqm8v              1/1     Running   0               12m
kube-system   pod/csi-linode-controller-0                          4/4     Running   2 (9m27s ago)   12m
kube-system   pod/csi-linode-node-c4t8p                            2/2     Running   0               10m
kube-system   pod/csi-linode-node-jsvjb                            2/2     Running   0               10m
kube-system   pod/csi-linode-node-n2q8t                            2/2     Running   0               10m
kube-system   pod/konnectivity-agent-5f6784fb75-ftctr              1/1     Running   0               12m
kube-system   pod/konnectivity-agent-5f6784fb75-g2z4c              1/1     Running   0               10m
kube-system   pod/konnectivity-agent-autoscaler-755d658c94-kr7gk   1/1     Running   0               12m
kube-system   pod/kube-proxy-d8xst                                 1/1     Running   0               10m
kube-system   pod/kube-proxy-mthdg                                 1/1     Running   0               10m
kube-system   pod/kube-proxy-rkh88                                 1/1     Running   0               10m
shield        pod/triskelion                                       1/1     Running   0               3m44s

NAMESPACE     NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)                  AGE
default       service/kubernetes     ClusterIP      10.128.0.1     <none>         443/TCP                  12m
kube-system   service/calico-typha   ClusterIP      10.128.36.93   <none>         5473/TCP                 12m
kube-system   service/kube-dns       ClusterIP      10.128.0.10    <none>         53/UDP,53/TCP,9153/TCP   12m
shield        service/the-bus        LoadBalancer   10.128.8.35    45.79.122.57   8080:30787/TCP           3m45s

NAMESPACE     NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/calico-node       3         3         3       3            3           kubernetes.io/os=linux   12m
kube-system   daemonset.apps/csi-linode-node   3         3         3       3            3           <none>                   12m
kube-system   daemonset.apps/kube-proxy        3         3         3       3            3           <none>                   12m

NAMESPACE     NAME                                            READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/calico-kube-controllers         1/1     1            1           12m
kube-system   deployment.apps/calico-typha                    2/2     2            2           12m
kube-system   deployment.apps/calico-typha-autoscaler         1/1     1            1           12m
kube-system   deployment.apps/coredns                         2/2     2            2           12m
kube-system   deployment.apps/coredns-autoscaler              1/1     1            1           12m
kube-system   deployment.apps/konnectivity-agent              2/2     2            2           12m
kube-system   deployment.apps/konnectivity-agent-autoscaler   1/1     1            1           12m

NAMESPACE     NAME                                                       DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/calico-kube-controllers-74d6f48977         1         1         1       12m
kube-system   replicaset.apps/calico-typha-687cc8b96f                    2         2         2       12m
kube-system   replicaset.apps/calico-typha-autoscaler-5dc98cf489         1         1         1       12m
kube-system   replicaset.apps/coredns-549fdd9bd4                         2         2         2       12m
kube-system   replicaset.apps/coredns-autoscaler-5dd9fbdf44              1         1         1       12m
kube-system   replicaset.apps/konnectivity-agent-5f6784fb75              2         2         2       12m
kube-system   replicaset.apps/konnectivity-agent-autoscaler-755d658c94   1         1         1       12m

NAMESPACE     NAME                                     READY   AGE
kube-system   statefulset.apps/csi-linode-controller   1/1     12m

$ kubectl describe node lke683040-1007982-rwt7m
***--(1. no explanation.md) showing details of node 
$ kubectl get node lke683040-1007982-rwt7m
NAME                      STATUS   ROLES    AGE   VERSION
lke683040-1007982-rwt7m   Ready    <none>   19m   v1.36.5

$ kubectl get pods -n shield
NAME         READY   STATUS    RESTARTS   AGE
triskelion   1/1     Running   0          8m9s


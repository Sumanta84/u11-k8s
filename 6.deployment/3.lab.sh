elphi@DESKTOP-SGOQ3PJ MINGW64 ~/OneDrive/Desktop/u11-k8s (main)
$ kubectl get nodes
NAME                    STATUS   ROLES           AGE   VERSION
desktop-control-plane   Ready    control-plane   13d   v1.36.4
desktop-worker          Ready    <none>          13d   v1.36.4
desktop-worker2         Ready    <none>          13d   v1.36.4

###>>Remote command execution:-

elphi@DESKTOP-SGOQ3PJ MINGW64 ~/OneDrive/Desktop/u11-k8s (main)
$ kubectl exec hello-pod -- ps
PID   USER     TIME  COMMAND
    1 root      0:00 {MainThread} node ./app.js
   19 root      0:00 ps

   $ kubectl exec -it hello-pod -- sh
/src #

elphi@DESKTOP-SGOQ3PJ MINGW64 ~/OneDrive/Desktop/u11-k8s (main)
$ kubectl exec hello-pod -- sh -c 'echo $HOSTNAME'
hello-pod
---
PS C:\Users\elphi> kubectl apply -f 'C:\Users\elphi\OneDrive\Desktop\u11-k8s\4.working-with-pods\0.source-code\initpod.yml'
pod/initpod created
PS C:\Users\elphi> kubectl get pods -o wide
NAME        READY   STATUS     RESTARTS      AGE   IP           NODE              NOMINATED NODE   READINESS GATES
hello-pod   1/1     Running    8 (71m ago)   9d    10.244.2.2   desktop-worker2   <none>           <none>
initpod     0/1     Init:0/1   0             25s   10.244.1.2   desktop-worker    <none>           <none>
PS C:\Users\elphi>  kubectl get pods --watch
NAME        READY   STATUS     RESTARTS      AGE
hello-pod   1/1     Running    8 (74m ago)   9d
initpod     0/1     Init:0/1   0             3m22s

---
open new shell
PS C:\Users\elphi> kubectl describe pod initpod
Name:             initpod
Namespace:        default
Priority:         0
Service Account:  default
Node:             desktop-worker/172.18.0.5
Start Time:       Wed, 14 Oct 2026 07:13:17 +0530
Labels:           app=initializer
Annotations:      <none>
Status:           Pending
IP:               10.244.1.2
IPs:
  IP:  10.244.1.2
Init Containers:
  init-ctr:
    Container ID:  containerd://db13747a0e8a7cb788cb38cbe3e10cb81fe1b2fce8a06b2aa2beec99a5886a06
    Image:         busybox:1.28.4
    Image ID:      docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      until nslookup k8sbook; do echo waiting for k8sbook service; sleep 1; done; echo Service found!
    State:          Running
      Started:      Wed, 14 Oct 2026 07:13:24 +0530
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-shsrr (ro)
Containers:
  web-ctr:
    Container ID:
    Image:          nigelpoulton/web-app:1.0
    Image ID:
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       PodInitializing
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-shsrr (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 False
  Ready                       False
  ContainersReady             False
  PodScheduled                True
Volumes:
  kube-api-access-shsrr:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  7m47s  default-scheduler  Successfully assigned default/initpod to desktop-worker
  Normal  Pulling    7m45s  kubelet            spec.initContainers{init-ctr}: Pulling image "busybox:1.28.4"
  Normal  Pulled     7m40s  kubelet            spec.initContainers{init-ctr}: Successfully pulled image "busybox:1.28.4" in 5.792s (5.792s including waiting). Image size: 727869 bytes.
  Normal  Created    7m40s  kubelet            spec.initContainers{init-ctr}: Container created
  Normal  Started    7m40s  kubelet            spec.initContainers{init-ctr}: Container started
PS C:\Users\elphi>
---

open new shell
to do intaractive session inside the init container, to check hostname

PS C:\Users\elphi> kubectl get pods
NAME        READY   STATUS     RESTARTS      AGE
hello-pod   1/1     Running    8 (82m ago)   9d
initpod     0/1     Init:0/1   0             12m
PS C:\Users\elphi> kubectl exec -it initpod --container init-ctr -- sh
/ # pwd
/
/ # ls -la
total 48
drwxr-xr-x    1 root     root          4096 Oct 14 01:43 .
drwxr-xr-x    1 root     root          4096 Oct 14 01:43 ..
drwxr-xr-x    2 root     root         12288 May 22  2018 bin
drwxr-xr-x    5 root     root           360 Oct 14 01:43 dev
drwxr-xr-x    1 root     root          4096 Oct 14 01:43 etc
drwxr-xr-x    2 nobody   nogroup       4096 May 22  2018 home
dr-xr-xr-x  332 root     root             0 Oct 14 01:43 proc
-rw-r--r--    1 root     root            37 Oct 14 01:43 product_uuid
drwx------    1 root     root          4096 Oct 14 01:57 root
dr-xr-xr-x   13 root     root             0 Oct 14 01:43 sys
drwxrwxrwt    2 root     root          4096 May 22  2018 tmp
drwxr-xr-x    3 root     root          4096 May 22  2018 usr
drwxr-xr-x    1 root     root          4096 Oct 14 01:43 var
/ # cat /etc/os-released
cat: can't open '/etc/os-released': No such file or directory
/ # cat /etc/os-release
cat: can't open '/etc/os-release': No such file or directory
/ # hostname
initpod
/ #
---

PS C:\Users\elphi> kubectl exec initpod --container init-ctr -- hostname
initpod

--- fro shell1
PS C:\Users\elphi> kubectl apply -f 'C:\Users\elphi\OneDrive\Desktop\u11-k8s\4.working-with-pods\0.source-code\initpod.yml'
pod/initpod created
PS C:\Users\elphi> kubectl get pods -o wide
NAME        READY   STATUS     RESTARTS      AGE   IP           NODE              NOMINATED NODE   READINESS GATES
hello-pod   1/1     Running    8 (71m ago)   9d    10.244.2.2   desktop-worker2   <none>           <none>
initpod     0/1     Init:0/1   0             25s   10.244.1.2   desktop-worker    <none>           <none>
PS C:\Users\elphi>  kubectl get pods --watch
NAME        READY   STATUS     RESTARTS      AGE
hello-pod   1/1     Running    8 (74m ago)   9d
initpod     0/1     Init:0/1   0             3m22s
initpod     0/1     Init:0/1   0             3m47s
initpod     0/1     Init:0/1   0             4m58s
hello-pod   1/1     Running    8 (76m ago)   9d
hello-pod   1/1     Running    8 (78m ago)   9d
initpod     0/1     Init:0/1   0             11m
initpod     0/1     Init:0/1   0             12m
hello-pod   1/1     Running    8 (89m ago)   10d
hello-pod   1/1     Running    8 (90m ago)   10d
initpod     0/1     Init:0/1   0             22m
hello-pod   1/1     Running    8 (94m ago)   10d
hello-pod   1/1     Running    8 (95m ago)   10d
initpod     0/1     Init:0/1   0             25m
initpod     0/1     Init:0/1   0             32m
initpod     0/1     Init:0/1   0             33m
initpod     0/1     PodInitializing   0             34m
initpod     1/1     Running           0             35m
hello-pod   1/1     Running           8 (107m ago)   10d

-- stop watching after starting web-ctr
initpod     0/1     PodInitializing   0             34m
initpod     1/1     Running           0             35m
hello-pod   1/1     Running           8 (107m ago)   10d
hello-pod   1/1     Running           8 (108m ago)   10d
PS C:\Users\elphi>

---
after start web-ctr pod status

PS C:\Users\elphi> kubectl describe pod initpod
Name:             initpod
Namespace:        default
Priority:         0
Service Account:  default
Node:             desktop-worker/172.18.0.5
Start Time:       Wed, 14 Oct 2026 07:13:17 +0530
Labels:           app=initializer
Annotations:      <none>
Status:           Running
IP:               10.244.1.2
IPs:
  IP:  10.244.1.2
Init Containers:
  init-ctr:
    Container ID:  containerd://db13747a0e8a7cb788cb38cbe3e10cb81fe1b2fce8a06b2aa2beec99a5886a06
    Image:         busybox:1.28.4
    Image ID:      docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      until nslookup k8sbook; do echo waiting for k8sbook service; sleep 1; done; echo Service found!
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Wed, 14 Oct 2026 07:13:24 +0530
      Finished:     Wed, 14 Oct 2026 07:47:47 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-shsrr (ro)
Containers:
  web-ctr:
    Container ID:   containerd://6bc1cc3dac274778128d1f79d5a8083e26a6d65dacf3a26ccac5cc18595bed7f
    Image:          nigelpoulton/web-app:1.0
    Image ID:       docker.io/nigelpoulton/web-app@sha256:201b2df1aae045c7f7fe3148e9f793e602aaf019d4afc6f65b625fe3dee6515b
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 14 Oct 2026 07:48:56 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-shsrr (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       True
  ContainersReady             True
  PodScheduled                True
Volumes:
  kube-api-access-shsrr:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  40m    default-scheduler  Successfully assigned default/initpod to desktop-worker
  Normal  Pulling    40m    kubelet            spec.initContainers{init-ctr}: Pulling image "busybox:1.28.4"
  Normal  Pulled     39m    kubelet            spec.initContainers{init-ctr}: Successfully pulled image "busybox:1.28.4" in 5.792s (5.792s including waiting). Image size: 727869 bytes.
  Normal  Created    39m    kubelet            spec.initContainers{init-ctr}: Container created
  Normal  Started    39m    kubelet            spec.initContainers{init-ctr}: Container started
  Normal  Pulling    5m32s  kubelet            spec.containers{web-ctr}: Pulling image "nigelpoulton/web-app:1.0"
  Normal  Pulled     4m24s  kubelet            spec.containers{web-ctr}: Successfully pulled image "nigelpoulton/web-app:1.0" in 1m10.441s (1m10.442s including waiting). Image size: 136820450 bytes.
  Normal  Created    4m24s  kubelet            spec.containers{web-ctr}: Container created
  Normal  Started    4m24s  kubelet            spec.containers{web-ctr}: Container started
PS C:\Users\elphi>

---Remotely checking container hostname 1. init-ctr, after terminated init-ctr 2. web-ctr
PS C:\Users\elphi> kubectl exec initpod --container init-ctr -- hostname
initpod
PS C:\Users\elphi> kubectl exec initpod --container web-ctr -- hostname
initpod
PS C:\Users\elphi>

--- running initsvc.yml 
PS C:\Users\elphi> kubectl apply -f 'C:\Users\elphi\OneDrive\Desktop\u11-k8s\4.working-with-pods\0.source-code\initsvc.yml'
service/k8sbook created
PS C:\Users\elphi> kubectl get all
NAME            READY   STATUS            RESTARTS       AGE
pod/hello-pod   1/1     Running           8 (105m ago)   10d
pod/initpod     0/1     PodInitializing   0              35m

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/k8sbook      ClusterIP   10.96.45.239   <none>        80/TCP    33s
service/kubernetes   ClusterIP   10.96.0.1      <none>        443/TCP   17d
PS C:\Users\elphi>
PS C:\Users\elphi> kubectl get all
NAME            READY   STATUS    RESTARTS       AGE
pod/hello-pod   1/1     Running   8 (106m ago)   10d
pod/initpod     1/1     Running   0              36m

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/k8sbook      ClusterIP   10.96.45.239   <none>        80/TCP    102s
service/kubernetes   ClusterIP   10.96.0.1      <none>        443/TCP   17d
PS C:\Users\elphi>

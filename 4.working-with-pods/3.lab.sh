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
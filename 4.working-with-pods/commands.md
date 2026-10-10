## 1. kubectl get nodes
=> showing control Plane and Worker-nodes,based on context location (can be window system host or remote host)
# Kubernetes: `kubectl get nodes`

## 1. Purpose

The command `kubectl get nodes` displays the nodes in a Kubernetes cluster.

A node is a machine that runs containerized applications. A node can be a physical machine or a virtual machine.

Kubernetes uses nodes to run your applications inside Pods.

Use this command to:

- List the nodes in your cluster.
- Check the status of each node.
- Check the Kubernetes version on each node.
- Check the node's role and age.

## 2. Understand the command syntax

## `kubectl get nodes`

`kubectl`

Purpose: Run a command against the Kubernetes API.

`kubectl` is the Kubernetes command-line tool.

`get`

Purpose: Retrieve and display resources.

It reads information about the requested resources.

`nodes`

Purpose: Specify the resource type.

It requests the list of Node resources in the cluster.

### Why do we use `nodes` instead of `node`?

Both forms are valid:

```
kubectl get node
kubectl get nodes
```

Kubernetes accepts the singular and plural resource names. Both commands list nodes.

## 3. Example output

Run this command in your terminal:

```
kubectl get nodes
```

Example output:

```
NAME           STATUS   ROLES           AGE   VERSION
worker-node1   Ready    <none>          10d   v1.33.2
worker-node2   Ready    <none>          10d   v1.33.2
master-node    Ready    control-plane   10d   v1.33.2
```

This output is an example. Your actual output depends on your cluster.

## 4. Understand each column

| Column    | Meaning                                       |
| --------- | --------------------------------------------- |
| `NAME`    | The name of the node.                         |
| `STATUS`  | The current reported status of the node.      |
| `ROLES`   | The role labels associated with the node.     |
| `AGE`     | The time since the node object was created.   |
| `VERSION` | The Kubernetes version reported for the node. |

### A. `NAME`

Example:

```
worker-node1
```

This is the name of the node registered in the Kubernetes API.

You can use the name to inspect the node:

```
kubectl describe node worker-node1
```

Reason: `kubectl get nodes` provides a summary. `kubectl describe node` provides more detailed information.

### B. `STATUS`

Example:

```
Ready
```

The status tells you whether the node is reporting that it can run Pods.

Common status values include:

- `Ready` — the node reports that it is ready to accept Pods.
- `NotReady` — the node reports that it is not ready to accept Pods.
- `SchedulingDisabled` — scheduling is disabled for the node, usually because it has been cordoned.

Important: `SchedulingDisabled` is not a Node condition. It is a status displayed by `kubectl` when scheduling has been disabled for that node.

A node showing `Ready` does not guarantee that every application on the node is working correctly.

### C. `ROLES`

Example:

```
control-plane
```

A control-plane node runs components that manage the Kubernetes cluster.

A worker node runs application workloads. A worker node can show:

```
<none>
```

This usually means that the node does not have a role label recognized by this command. It does not mean that the node cannot run Pods.

### D. `AGE`

Example:

```
10d
```

This means that the Node resource was created approximately 10 days ago.

It does not necessarily mean that the physical machine has been running for 10 days.

### E. `VERSION`

Example:

```
v1.33.2
```

This is the Kubernetes version reported for the node, generally the version of its kubelet.

The kubelet is the agent that runs on each node and communicates with the Kubernetes control plane.

## 5. What happens when you run the command?

1\. You run the command

`kubectl get nodes`

2\. kubectl reads your configuration

It identifies the API server and credentials for the selected context.

3\. kubectl sends a request

The request asks the Kubernetes API server for Node resources.

4\. The API server returns the result

kubectl displays the node information in your terminal.

Important: The command does not create a node, start a node, or change the cluster. It reads information from the cluster.

## 6. Useful variations

Show additional node information

```
kubectl get nodes -o wide
```

Displays extra columns, such as the node's internal IP address, operating system image, kernel version, and container runtime.

Display detailed node information

```
kubectl describe nodes
```

Shows conditions, capacity, allocated resources, labels, taints, and events for the nodes.

Display node labels

```
kubectl get nodes --show-labels
```

Useful for understanding node roles and scheduling rules.

Display nodes in YAML format

```
kubectl get nodes -o yaml
```

Shows the resource fields in YAML format. The output can be long.

Continuously watch node status

```
kubectl get nodes --watch
```

Displays updates when relevant changes occur. Press `Ctrl+C` to stop watching.

## 7. Important distinction: nodes versus Pods

| Resource   | What it represents                               | Command                   |
| ---------- | ------------------------------------------------ | ------------------------- |
| Node       | A machine in the cluster                         | `kubectl get nodes`       |
| Pod        | The smallest deployable Kubernetes workload unit | `kubectl get pods`        |
| Deployment | Manages replicated application Pods              | `kubectl get deployments` |
| Service    | Provides network access to a set of Pods         | `kubectl get services`    |

For example, one node can run several Pods. Therefore, the number of nodes is not necessarily equal to the number of Pods.

## 8. Practice exercise

Run these commands in order:

### Command checklist

0 of 4 completed

kubectl get nodes

List the nodes.

kubectl get nodes -o wide

Inspect additional node details.

kubectl describe nodes

Inspect node conditions and events.

kubectl get pods -o wide

See which nodes host your Pods.

## 9. Knowledge check

Question: What does `kubectl get nodes` do?

Creates a new Kubernetes node.

Lists the Node resources in the selected cluster.

Lists only the Pods running in the cluster.

Key takeaway: `kubectl get nodes` is a read-only command that lists the nodes registered in the Kubernetes cluster selected by your current kubectl context.
---
## 2. Win11-system32> kubectl config view  
(location: C:\Users\elphi\.kube\config.yml->for local-win-host,Created by Docker-Desktop-Kuberneties)
=> Showing config file(yaml), using creation of cluster by KinD(K8S in Docker)

3. Win11-system32> kubectl expalin pods
=> Showing yaml-config file's create pod details of code minimum

4. Win11-system32> kubectl expalin pods --recursive 
=> Showing yaml-config file's create pod details of code all details

----
If I create cluster Linode-akamai Cloud, Then download and copy-paste the file(location: C:\Users\elphi\.kube\config.yml) same location and merge the file create environ variable name "KUBECONFIG"

Using GitBash:-
5. $export KUBECONFIG=~\.kube\config:~\.kube\linode-config
=> merge the both file for temporery, if need it permanent we need to do the same in .bashrc folder (for linux)
**temporery means when we kill the terminal it will destroy.

6. $kubectl config view
=> it's first search the "KUBECONFIG" environment variable then present config file..Showing yaml file code details and omit Certificate and Key value..

7. $kubectl config view --flatten
=> Showing yaml file code details and all Certificate and Key value

8. $kubectl config view --flatten > config
=> Delete local config file, we merged local-win-host+remote-LKE files...this command redirect the new merged code to new config file..and create parmanent.
kubectl version
kubectl get nodes
kubectl config view
cat config
echo $KUBECONFIG
echo $"KUBECONFIG"
echo ${KUBECONFIG}
echo $HOME
whoami
env
env | grep "KUBECONFIG"
mv config config-bkp
ls -l
cat tkb-kubeconfig.yaml
export KUBECONFIG=~/.kube/config-bkp:~/.kube/tkb-kubeconfig.yaml
kube ctl config view
kubectl config view --flatten
kubectl tkb-kubeconfig.yaml view
kubectl config --help
kubectl config view tkb-kubeconfig.yaml
kubectl config view "tkb-kubeconfig.yaml"
kubectl config view -h
kubectl --kubeconfig ~/.kube/tkb-kubeconfig.yaml config view
kubectl --kubeconfig --help
mv config config-backup
export KUBECONFIG=~/.kube/config-backup:~/.kube/tkb-kubeconfig.yaml
ubctl config view
ubectl config view
kubectl config view --flaten
kubectl config view --flatten > ~/.kube/config
kubectl config veiw
rm config
unset KUBECONFIG
export KUBECONFIG=~/.kube/config-backup:~/.kube/tkb-kubeconfig.yaml:~/.kube/tkb2-kubeconfig.yaml
kubectl get ns
kubectl config get-contexts
kubectl config use-context lke659928-ctx
kubectl config current-contexts
kubectl config current-context
kubectl describe lke659928-ctx
kubectl cluster-info
kubectl cluster-info dump
kubectl get nodes -o wide
kubectl cluster-info > ~/.kube/cluster-info.txt
kubectl explain pods
kubectl explain pods --recursive
kubectl explain pods --recursive | more
kubectl explain pod.metadata.managedFields.fieldsType
kubectl explain pod.spec.restartPolicy

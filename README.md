# Kubernetes Installation

This project provide a simple way to deploy Kubernetes cluster. This project is provided by CapyBlock team, and it is
based on [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/).

This project is only tested on Ubuntu 22.04 LTS, and it is not guaranteed to work on other versions of Ubuntu or other
Linux distributions. Use at your own risk.

## Prerequisites

- At least 1 node with Ubuntu 22.04 installed.
- At least 2 CPUs and 2GB of RAM.
- At least 20GB of disk space.
- Internet connection.
- Root access.
- SSH access to the node.

## Installation

1. Clone this repository to your local machine.

```bash
git clone https://github.com/capyblock/kubernetes.git
```

2. Change directory to the cloned repository.

```bash
cd kubernetes
```

3. Run the installation script.

```bash
./install.sh
```

4. Follow the instructions on the screen.
5. After the installation is complete, you can access the Kubernetes cluster using `kubectl`.

```bash
kubectl get nodes
```

## Uninstallation

1. Run the uninstallation script.

```bash
./uninstall.sh
```

2. Follow the instructions on the screen.
3. After the uninstallation is complete, you can remove the cloned repository.

```bash
rm -rf kubernetes
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
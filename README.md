![logo](https://vtun.sourceforge.net/vtun.gif)
# Virtual Tunnel - vtun
Virtual Tunnel VTun is a project of Maxim Krasnyansky hosted on [SourceForge](https://vtun.sourceforge.net/).

Unfortunatelly, the last release has been published in 2016 and currently does not even compile in mudern GCC compiler environment.
This project is (still) not a fork. We provide the following:

- patch applicable to original vtun software version 3.0.4 to be able to compile.
- Dockerfile which compiles from source and builds an image suitable to run vtund in a container
- kubernetes deployment example

## Patch details
- missing some include system header files (for functions htonl, nanosleep, getpt)
- inline functions have to be not only declared but also defined in header files => removed ``inline`` modifier
- openssl data structure EVP_CIPHER_CTX can not be declared statically. It has to be allocated by
  ``EVP_CIPHER_CTX_new()``. Fixed by changing it to a dynamic and calling the allocation directly from ``main()``.

## Container detais
Containers brings many benefits:
- the compilation happens in the container, not depending on a toolchain installed on the developer's computer
- when running in a container ``vtund`` is no longer depenent on other software installed on the server or client host.
- containers contain the correct version of all required dynamic libraries => no longer problem with upgrades
- easier method to deploy ``vtund``
- more secure

The container is expected to mount the real config as a volume under ``/etc/vtund.conf``.

## Testing **vtun** in a container
- open a new terminal and run script [``server-test.sh``](server-test.sh). You can see the server instance messages.
- open a new terminal and run script [``client-test.sh``](client-test.sh). You can see how client is trying to connect the server.
  Finally, the connection should be established.
- open a new terminal and run ``ip link`` or ``ifconfig`` to verify there are 2 new network interfaces
  ``vtun-server`` and ``vtun-client``, they are up and they have IP addresses assigned.

## Running vtun on Kubernetes
This project provides also a proof that vtun can run also in Kubernetes
cluster as a pod. All files needed are located in
[``kubernetes``](kubernetes/) subdirectory. Just run [``deploy-server.sh``](kubernetes/deploy-server.sh)
on kubernetes where you want to deploy a vtun server. Then run
[``deploy-client.sh``](kubernetes/deploy-client.sh) on kubernetes where the
client should run. ``deploy-client.sh`` script requires IP address of the
server as a parameter. Note, that server should configure a firewall (if you
have one) to accept connections to default port TCP/5000. You can do it by command:
```iptables -I INPUT -p tcp --dport 5000 -j ACCEPT```

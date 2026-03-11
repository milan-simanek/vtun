![logo](https://vtun.sourceforge.net/vtun.gif)
# Virtual Tunnel - vtun
Virtual Tunnel VTun is a project of Maxim Krasnyansky hosted on [SourceForge](https://vtun.sourceforge.net/).

Unfortunatelly, the last release has been published in 2016 and currently does not even compile in mudern GCC compiler environment.
This project is (still) not a fork. We provide the following:

- patch applicable to original vtun software version 3.0.4 to be able to compile.
- Dockerfile which compiles from source and builds an image suitable to run vtund in a container

## patch details
- missing some include system header files (for functions htonl, nanosleep, getpt)
- inline functions have to be not only declared but also defined in header files => removed ``inline`` modifier
- openssl data structure EVP_CIPHER_CTX can not be declared statically. It has to be allocated by
  ``EVP_CIPHER_CTX_new()``. Fixed by changing it to a dynamic and calling the allocation directly from ``main()``.

## containers detais
Containers brings many benefits:
- the compilation happens in the container, not depending on a toolchain installed on the developer's computer
- when running in a container ``vtund`` is no longer depenent on other software installed on the server or client host.
- containers contain the correct version of all required dynamic libraries => no longer problem with upgrades
- easier method to deploy ``vtund``

The container is expected to mount the real config as a volume under ``/etc/vtund.conf``.


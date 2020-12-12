---
title: Installing updates to Zato installation
---

In accordance with [Zato release life-cycle policy ](../../../release/policy), each major release receives
periodic updates to functionality, including security and stability fixes.

Each such update is always backwards-compatible within the same major release.

To install updates, run the commands below:

-   On RHEL/CentOS, Ubuntu and Debian:

        $ sudo su - zato
        zato$ cd /opt/zato/current
        zato$ git pull

-   On Alpine Linux

        $ sudo su - zato
        zato$ cd /pkg/zato/current
        zato$ git pull

-   Next, regardless of the OS:

        $ ./update.sh

-   Afterwards, all Zato components need to be stopped and started again. To increase high-availability, stop and start the
    components in the order as below, which will ensure that the window of time without any server available is as small
    as possible:

    -   Stop/start web-admin
    -   Stop/start each of servers, one by one, waiting for each to boot up before proceeding to the next one
    -   Stop/start the load-balancer
    -   Stop/start the scheduler

-   The commands to stop and start web-admin, load-balancer and scheduler are
    [zato stop ](../../cli/stop)
    and
    [zato start ](../../cli/start)

-   The command to stop servers is also *zato stop* but, additionally and unlike web-admin or load-balancer, Zato servers need
    to be started with the *\--sync-internal* flag, as below:

        zato$ zato start /path/to/server --sync-internal

-   Flag *\--sync-internal* triggers re-synchronization of internal caches, which lets servers start faster. Consequently,
    this flag should be used only after code updates and its continuous usage in other circumstances is detrimental to
    performance, use it only after following the instructions in this chapter, otherwise it is not needed.

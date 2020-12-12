---
title: Installing services
---

There are several ways to install Zato services

-   [Hot-deploy them from an IDE \<admin-installing-services-hot-ide\>]
-   [Hot-deploy them from the web-admin \<admin-installing-services-hot-web-admin\>]
-   [Hot-deploy them from command line \<admin-installing-services-hot-deploy-cli\>]
-   [Add them to zato_extra_paths \<admin-installing-services-zato_extra_paths\>]
-   [Add them to service-sources.txt \<admin-installing-services-service-sources.txt\>]

Hot-deploying from an IDE {#admin-installing-services-hot-ide}
=========================

Zato supplies plug-ins for PyCharm and Visual Studio Code to make testing of an in-development service
simple. Please refer to [IDE integration chapter \<../../progguide/ide/index\>] in the programming guide for more information.

![image](../../gfx/progguide/ide-deploy/pycharm_ide_deploy_true.jpg)

![image](../../gfx/progguide/ide-deploy/vscode_ide_deploy_true.jpg)

Hot-deploying from the web admin {#admin-installing-services-hot-web-admin}
================================

Flat Python modules can also be hot-deployed in a cluster using the web admin.

![](/gfx/admin-upload-package.png)

Refer to
[web admin\'s docs \<../../web-admin/services/upload\>]
for more information.

Hot-deploying from command line {#admin-installing-services-hot-deploy-cli}
===============================

A Python module containing one or more services can be installed
from command line, this will make it available on all servers from a given cluster
regardless of which server picks up the Python module to import - the information
will be propagated automatically.

A service which has been installed in such a way will survive the server\'s restart.

Only flat Python modules can be hot-deployed. (Use [zato_extra_paths \<admin-installing-services-zato_extra_paths\>]
to install arbitrary Python code).

server.conf\'s option beginning with
[hot_deploy.\* \<admin-guide-config-server-hot_deploy.pickup_dir\>]
all describe the details of where
to listen for new services to be installed and where they should be installed,
how many backups to keep and more.

An example session would look like:

    $ cp crm_channel_customer.py ~/zato/server1/pickup-dir/
    $

Note that a service becomes available only after all servers confirm that it\'s
been deployed, in the example below there are 2 servers to wait in the logs
for a confirmation from.

    INFO - 6578:Thread-4 Uploaded package id:[22], payload_name:[crm_channel_customer.py]
    INFO - 6579:Thread-4 Uploaded package id:[22], payload_name:[crm_channel_customer.py]

zato_extra_paths {#admin-installing-services-zato_extra_paths}
================

Each Zato installation package contains a directory named zato_extra_paths,
[documented in its own chapter \<./enabling-extra-libs\>],
and whatever is put into zato_extra_paths will
automatically appears on PYTHONPATH.

This can be used in conjunction with
[service-sources.txt \<admin-installing-services-service-sources.txt\>] to install
services from sources other than flat Python modules.

This is a static method of installing the services and requires a restart
([zato stop \<../../admin/cli/stop\>]
&
[zato start \<../../admin/cli/start\>]) of each server that had its zato_extra_paths updated.
Note that for HTTP traffic a load-balancer will re-route traffic to other servers if one goes down.

service-sources.txt {#admin-installing-services-service-sources.txt}
===================

Each server has a file describing sources, such as directories or names of Python modules
to [import services off \<admin-guide-config-server-service-sources\>].
By convention, the file is called service-sources.txt but
[it can be renamed \<admin-guide-config-server-main.service_sources\>].

A new entry needs to be added to that file for each new source that
a starting server should pick up the services from.

A rollout using service-sources.text can take a couple of forms:

-   Using directories and flat Python modules:

    > -   Create a new directory
    > -   Copy Python modules containing the services to be released onto it,
    >     note that only flat Python modules can be used, no packages or archives
    >     are allowed (use [zato_extra_paths \<admin-installing-services-zato_extra_paths\>]
    >     to install arbitrary Python packages)
    > -   Add the path to the directory to service-sources.txt
    > -   Repeat steps above for each server
    > -   Restart the servers

-   Using flat or dotted Python module names:

    > -   Make Python modules containing the services available on \$PYTHONPATH
    > -   Add names of the modules, flat or dotted, to service-sources.txt
    > -   Repeat steps above for each server
    > -   Restart the servers

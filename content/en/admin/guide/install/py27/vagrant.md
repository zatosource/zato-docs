---
title: Installation under Vagrant (Python 2.7)
---

Requirements
============

-   Vagrant, any version

Installation steps
==================

Quickstart
----------

-   Get Zato Vagrantfile.

``` {.shell-session}
user@host$ mkdir -p ~/zato-vagrant && cd ~/zato-vagrant
user@host$ curl \
    https://raw.githubusercontent.com/zatosource/zato-build/master/vagrant/zato-3.1/download.sh | \
    bash
```

-   Deploy Zato in Vagrant.

``` {.shell-session}
user@host$ ZATO_PY_VERSION=py27 vagrant up
```

-   Access the virtual machine using ssh.

``` {.shell-session}
user@host$ vagrant ssh
vagrant@zato:$ sudo su - zato
zato@zato:~$
```

-   Retrieve your dynamically generated password for Zato web-admin.

``` {.shell-session}
user@host$ vagrant ssh -c 'cat /opt/zato/web_admin_password'
```

That concludes the process - a web-admin instance is running on <http://localhost:8183> and you can log into
it with the username \'admin\' using the password printed on the terminal above.

Specify environment variables
-----------------------------

-   Specify ZATO_WEB_ADMIN_PASSWORD.

``` {.shell-session}
user@host$ ZATO_WEB_ADMIN_PASSWORD=3f4bd629-ef5e-4e37-97a9-3ae67d4c98de ZATO_PY_VERSION=py27 vagrant up
```

-   Specify ZATO_HOST_DEPLOY_DIR.

``` {.shell-session}
user@host$ ZATO_HOST_DEPLOY_DIR=/tmp/zato-services ZATO_PY_VERSION=py27 vagrant up
```

Environment variables
---------------------

A couple of environment variables can be used to fine-tune the resulting installation. If any is missing,
a default value will be automatically generated.

  Variable                      Notes
  ----------------------------- --------------------------------------------------------------------------------
  ZATO_WEB_ADMIN_PASSWORD       Password to login to web-admin with
  ZATO_IDE_PUBLISHER_PASSWORD   Password for [IDE integration \<../../../../progguide/ide/index\>]
  ZATO_PY_VERSION               Python version. One of py3 or py27.
  ZATO_ENMASSE_FILE             Full path or URL to [an enmasse file \<../../enmasse\>] with
                                object definitions to been imported.
  ZATO_HOST_DEPLOY_DIR          Full path to folder containing the services for
                                [hot deploy \<../../installing-services\>]

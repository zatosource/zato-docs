---
title: Installation under Kubernetes (Python 3.x)
---

This image includes the last Zato version with an entrypoint script that can be used for every Zato component.

Requirements
============

-   Kubernetes
-   kubectl

Docker image
============

Download the Docker image for local usage:

``` {.sh}
host$ sudo docker pull registry.gitlab.com/zatosource/docker-registry/cloud:3.1
```

Start a local Kubernetes with Minikube
======================================

-   [Install Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
-   Start a Virtual Machine

``` {.sh}
host$ minikube start
```

Deploy Zato to local Kubernetes
===============================

-   Clone GitHub repository to the the template

``` {.sh}
host$ git clone https://github.com/zatosource/zato-build.git
host$ cd zato-build/docker/kubernetes/
```

-   Install [Dockerize](https://github.com/powerman/dockerize#installation) . It will be used to create the
    zato-k8.yaml file using environment variables.
-   Edit the **environment** file and customize the environment variables. SECRET_KEY and JWT_SECRET_KEY variables are mandatory
-   Generate the zato-k8.yaml with your values from environment

``` {.sh}
host$ dockerize -env environment -template zato-k8.yaml.template:zato-k8.yaml
```

-   Switch to Minikube context

``` {.sh}
host$ kubectl config use-context minikube
```

-   Deploy Zato to Kubernetes

``` {.sh}
host$ kubectl apply -f zato-k8.yaml
```

-   Check if components are running:

``` {.sh}
host$ kubectl get pods --namespace=zato
NAME                         READY   STATUS              RESTARTS   AGE
bootstrap-6fb6c85c4c-4nx6l   0/1     ContainerCreating   0          22s
postgres-57cf76f654-qcb2g    0/1     ContainerCreating   0          22s
redis-5c46c79bd7-tt6cs       0/1     ContainerCreating   0          22s
scheduler-9db4bb4d6-zgcmm    0/1     ContainerCreating   0          22s
server-85bcf4ccbd-2lw45      0/1     ContainerCreating   0          22s
server-85bcf4ccbd-gqbs2      0/1     ContainerCreating   0          22s
webadmin-54688f5445-n4xkz    0/1     ContainerCreating   0          22s
```

-   Check Zato server logs (pod name will be different)

``` {.sh}
host$ kubectl logs --namespace=zato server-85bcf4ccbd-2lw45
```

-   Get the URL for web-admin

``` {.sh}
host$ minikube service --namespace zato webadmin --url
http://192.168.99.138:8183
```

Environment variables available
-------------------------------

The Zato image uses several environment variables which can be used to fine-tune the resulting installation.

They are not required to use, and default values will be substituted if any is missing,
but they may be employed to configure particular details of each of the components.

  Variable                      Notes
  ----------------------------- -------------------------------------------------------------------------------------------------------
  CLUSTER_NAME                  Cluster name.
  LB_HOSTNAME                   Load balancer hostname. Used to communicate to the servers.
  LB_PORT                       Load balancer port. Used to communicate to the servers.
  ZATO_POSITION                 Specify the Zato component for this container. Must be one of: **load-balancer** (used only to create
                                the ODB and the cluster), **scheduler**, **server** and **webadmin**.
  ZATO_WEB_ADMIN_PASSWORD       Password for the web admin's technical account user to connect with. If not defined,
                                the value is generated automatically at runtime.
  ZATO_IDE_PUBLISHER_PASSWORD   Password for user [ide_publisher], used for IDE integration. If not defined,
                                the value has to be set manually.
  ZATO_ADMIN_INVOKE_PASSWORD    Password used for internal communication. If not defined, the value has to be set manually.
  ZATO_ENMASSE_FILE             Full path to a file or URL to [an enmasse file \<../../enmasse\>] with object
                                definitions to been imported. If the value is a path to a file, make sure the file available to
                                the Pod in the server.
  REDIS_HOSTNAME                Redis service hostname. Default value is **localhost**.
  ODB_TYPE                      ODB type to use. Must be one of: [mysql] or [postgresql].
  ODB_HOSTNAME                  ODB hostname.
  ODB_PORT                      ODB port.
  ODB_NAME                      ODB database.
  ODB_USERNAME                  ODB username.
  ODB_PASSWORD                  ODB password.
  SECRET_KEY                    A random secret key previously generated with
                                [zato crypto create-secret-key \<../../../cli/crypto/create-secret-key\>].
                                It is used to encrypt passwords and other sensitive data in ODB.
                                Must be the same for all servers in a single cluster. If not
                                provided, a new key will be generated automatically.
  JWT_SECRET_KEY                A random secret key previously generated with
                                [zato crypto create-secret-key \<../../../cli/crypto/create-secret-key\>].
                                Used by
                                [JWT security definitions \<../../../../web-admin/security/jwt\>].
                                If JWT is used, must be the same for all servers in a single
                                cluster. If not provided, a new key will be generated
                                automatically.
  VERBOSE                       Verbose output in logs.

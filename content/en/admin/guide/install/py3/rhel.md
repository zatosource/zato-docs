---
title: Installation on RHEL/CentOS (Python 3.x)
---

Requirements
============

-   RHEL/CentOS 7.x
-   Root access

Installation steps
==================

-   Log on as root

```{=html}
<!-- -->
```
    rhel$ su -

-   Add the package signing key

```{=html}
<!-- -->
```
    rhel# curl -sO https://zato.io/repo/zato-3.1-C9B13DF28CFE287D.pgp.txt
    rhel# rpm --import ~/zato-3.1-C9B13DF28CFE287D.pgp.txt

-   Add the following repository definition

```{=html}
<!-- -->
```
    rhel# vim /etc/yum.repos.d/zato-3.1.repo

    [zato-3.1]
    name=zato-3.1
    baseurl=https://zato.io/repo/stable/3.1/py3/rhel/el$releasever/$basearch
    enabled=1
    gpgcheck=1
    gpgkey=https://zato.io/repo/zato-3.1-C9B13DF28CFE287D.pgp.txt

-   Refresh the package list

```{=html}
<!-- -->
```
    rhel# yum clean expire-cache
    rhel# yum check-update

-   Install Zato

```{=html}
<!-- -->
```
    rhel# yum install zato

-   Install latest additions

```{=html}
<!-- -->
```
    rhel# su - zato
    rhel$ cd /opt/zato/current && git checkout -- ./requirements.txt
    rhel$ ./update.sh

-   Confirm the installation

```{=html}
<!-- -->
```
    rhel$ zato --version
    Zato 3.1+rev.nnnnnnn-py3.n.n
    rhel$

That concludes the process - you can refer to the main
[documentation index \<../../../../index\>]
now.

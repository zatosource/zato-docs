---
title: Installation on Debian (Python 3.x)
---

Requirements
============

-   Debian 8 Jessie, 9 Stretch (64-bit)
-   Root access

Installation steps
==================

-   Log in as root

```{=html}
<!-- -->
```
    debian# su -

-   Add the package signing key

```{=html}
<!-- -->
```
    debian# curl -s https://zato.io/repo/zato-3.1-C9B13DF28CFE287D.pgp.txt | apt-key add -

-   Add Zato repository

```{=html}
<!-- -->
```
    debian# add-apt-repository \
       "deb [arch=amd64] https://zato.io/repo/stable/3.1/py3/debian $(lsb_release -cs) main"

-   Install Zato

```{=html}
<!-- -->
```
    debian# apt-get install zato

-   Install latest additions

```{=html}
<!-- -->
```
    debian# su - zato
    debian$ cd /opt/zato/current && git checkout -- ./requirements.txt
    debian$ ./update.sh

-   Confirm the installation

```{=html}
<!-- -->
```
    debian$ zato --version
    Zato 3.1+rev.nnnnnnn-py3.n.n
    debian$

That concludes the process - you can refer to the main
[documentation index \<../../../../index\>]
now.

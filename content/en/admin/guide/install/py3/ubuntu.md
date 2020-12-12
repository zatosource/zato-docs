---
title: Installation on Ubuntu (Python 3)
---

Requirements
============

-   Ubuntu 16.04 LTS, 18.04 LTS (64-bit)
-   Sudo rights

Installation steps
==================

-   Install helper programs

```{=html}
<!-- -->
```
    ubuntu$ sudo apt-get install apt-transport-https curl
    ubuntu$ sudo apt-get install software-properties-common

-   Install an additional package on Ubuntu 16.04 LTS

```{=html}
<!-- -->
```
    ubuntu$ sudo apt-get install python-software-properties

-   Additional dependencies on Ubuntu 18.04 LTS

```{=html}
<!-- -->
```
    ubuntu$ sudo add-apt-repository universe
    ubuntu$ sudo apt-get install tzdata

-   Add the package signing key

```{=html}
<!-- -->
```
    ubuntu$ curl -s https://zato.io/repo/zato-3.1-C9B13DF28CFE287D.pgp.txt | sudo apt-key add -

-   Add Zato repository

```{=html}
<!-- -->
```
    ubuntu$ sudo add-apt-repository \
       "deb [arch=amd64] https://zato.io/repo/stable/3.1/py3/ubuntu $(lsb_release -cs) main"

-   Install Zato

```{=html}
<!-- -->
```
    ubuntu$ sudo apt-get install zato

-   Install latest additions

```{=html}
<!-- -->
```
    ubuntu$ sudo su - zato
    ubuntu$ cd /opt/zato/current && git checkout -- ./requirements.txt
    ubuntu$ ./update.sh

-   Confirm the installation:

```{=html}
<!-- -->
```
    ubuntu$ zato --version
    Zato 3.1+rev.nnnnnnn-py3.n.n
    ubuntu$

That concludes the process - you can refer to the main
[documentation index ](../../../../index)
now.

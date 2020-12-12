---
title: Installing Zato from source code (Python 3.x)
---

Requirements
============

-   RHEL/CentOS, Ubuntu, Debian or Alpine Linux
-   Sudo powers

Installation steps
==================

-   Check out the source code from [GitHub](https://github.com/zatosource/) and enter the newly created directory

```{=html}
<!-- -->
```
    $ git clone https://github.com/zatosource/zato && cd zato/code
    Cloning into 'zato'...
    [snip]
    code$

-   Run the installer. If required, it will ask for a password to sudo:

```{=html}
<!-- -->
```
    code$ ./install.sh -p python3
    [snip]

-   Confirm the installation

```{=html}
<!-- -->
```
    code$ ./bin/zato --version
    Zato 3.1+rev.nnnnnnn-py3.n.n
    code$

That concludes the process - you can refer to the main
[documentation index ](../../../../index)
now.

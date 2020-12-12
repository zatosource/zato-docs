---
title: Encrypted logging with zato-enclog
---

Overview
========

zato-enclog is a Python package available [from PyPI](https://pypi.python.org/pypi/zato-enclog/) that can be used to
safely store encrypted information in logs of [Zato \<../../index\>] or any other Python application.

It is a perfect fit if information such as
[PII](https://en.wikipedia.org/wiki/Personally_identifiable_information)
(Personally Identifiable Information) cannot be stored in clear text, for instance in
[HIPAA](https://en.wikipedia.org/wiki/HIPAA)-compliant applications.

The package is distributed separately [on PyPI](https://pypi.python.org/pypi/zato-enclog/).

Features
========

-   Can be plugged into any Python application
-   Stores logs encrypted with [Fernet keys](https://cryptography.io/en/latest/fernet/) (AES128)
-   Comes with command-line tools to generate keys and decrypt logs, including means to
    [tail -f](https://en.wikipedia.org/wiki/Tail_%28Unix%29) logs as they grow

Usage examples
==============

Zato \`services \<../../intro/esb-soa\>\`:

``` {.python}
from logging import getLogger
from zato.server.service import Service

enclog = getLogger('enclog')

class MyService(Service):
    def handle(self):
        enclog.info('This will be encrypted')
```

Any Python app:

``` {.python}
import logging
from zato.enclog import EncryptedLogFormatter, genkey

level = logging.INFO
format = '%(levelname)s - %(message)s'

key = genkey()
formatter = EncryptedLogFormatter(key, format)

handler = logging.StreamHandler()
handler.setFormatter(formatter)

logger = logging.getLogger('')
logger.addHandler(handler)
logger.setLevel(level)

logger.info('This will be encrypted')
```

CLI screenshots
===============

Key generation
--------------

![image](/gfx/progguide/enclog/genkey.png){.align-center}

Demo
----

![image](/gfx/progguide/enclog/demo.png){.align-center}

tail -f vs. enclog tailf
------------------------

Using regular *tail -f* will show the data is encrypted:

![image](/gfx/progguide/enclog/tailf.png){.align-center}

Using *enclog tailf* will work like tail -f but it will also decrypt data on fly.

![image](/gfx/progguide/enclog/enclog_tailf.png){.align-center}

Installation and usage
======================

-   Under [Zato \<./install/zato\>]
-   Under [any Python application \<./install/any\>]

CLI reference
=============

-   enclog [demo \<./cli/demo\>]
-   enclog [genkey \<./cli/genkey\>]
-   enclog [open \<./cli/open\>]
-   enclog [tailf \<./cli/tailf\>]
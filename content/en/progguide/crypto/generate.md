---
title: Crypto - generation of passwords and secrets
---

Functionality from this chapter is used for generating passwords and other secrets. All generated output is cryptographically
strong and safe, using a system source of randomness via os.urandom(). Data is always returned as a string suitable for use
in URLs.

Passwords are by default 192-bit strong. Other secrets are by default 256-bit strong.

Passwords
=========

Python
------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Generate a new password of default strength
        password = self.crypto.generate_password()
        self.logger.info('Password is `%s`', password)

        # Generate a new password of 64-bit strength
        password = self.crypto.generate_password(64)
        self.logger.info('Password is `%s`', password)

        # Generate a password of 384-bit strength
        password = self.crypto.generate_password(384)
        self.logger.info('Password is `%s`', password)
```

``` {.bash}
INFO - Password is `VUm6BxC1nZpOo6csDtJHOxTipijQfLrl`
INFO - Password is `msDwPWuvQGU=`
INFO - Password is `EPyzwB29s8UxjJW9pY-C35y5JNYm2ZgYoNJe_-mAmclMMAOc4ybTSri-u3__OucQ`
```

Secrets
=======

Python
------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Generate a new secret of default strength
        secret = self.crypto.generate_secret()
        self.logger.info('Secret is `%s`', secret)

        # Generate a secret of 48-bit strength
        secret = self.crypto.generate_secret(48)
        self.logger.info('Secret is `%s`', secret)
```

``` {.bash}
INFO - Secret is `KSFGcjIDLHgeUsR-6XDLjPof9agDSYOO9BCBALV8xWM=`
INFO - Secret is `BGqOVsBw`
```

Related information
===================

Other crypto APIs:

-   [Encryption and decryption \<./encrypt\>]
-   [Hashing \<./hash\>]

Changelog
=========

  Version   Notes
  --------- -----------------
  3.0       Added initially

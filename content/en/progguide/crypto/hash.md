---
title: Crypto - hashing
---

API calls below allow for cryptographically strong hashing of password and other secrets. For instance, if there is a need
to securely save a user\'s password to the database and later verify it - this is the API to use.

Note that Zato has an entire [Single-Sign On and user management API \<../../sso/index\>] that automates user authentication,
without programming needed, and the functionality below is meant to be used in situations when SSO and user API should be
extended with custom features. Otherwise, the SSO and user API is the most convenient one to use.

Implementation-wise, the key derivation function for hashing is [PBKDF2-512](https://en.wikipedia.org/wiki/PBKDF2). Defaults
are salt size of 64 bytes (512 bits) and 100,000 of hash rounds, adjustable in config file [sso.conf \<../../sso/config/index\>]

Hashing
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

        # Suppose there is a password to hash
        data = 'C61mBoPzpa2sA'

        # Log data to be manipulated
        self.logger.info('Data `%s`', data)

        # Hash it - the result can be saved to
        # some kind of storage in order to verify it later on
        hashed = self.crypto.hash_secret(data)

        # Log the resulting form
        self.logger.info('Hashed `%s`', hashed)
```

``` {.bash}
INFO - Data `C61mBoPzpa2sA`
INFO - Hashed `$pbkdf2-sha512$100000$3zvn3Hvv/V8LodQaA4CQ0hrDuJeyNEWJszfk/p7TWei8lxHhRCiN...`
```

Verification
============

To verify a hashed value, it first needs to be loaded from storage and then compared to incoming data, e.g. to a password
that the user sent in.

Python
------

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # This function should load the hashed from, e.g. from a database
        hashed = load_hashed()

        # This is the data to be checked against the hashed value,
        # e.g. a user's password
        data = load_data()

        # Returns a boolean flag to indicate if verification succeeeded
        is_valid = self.crypto.verify_hash(data, hashed)
```

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Data to hash
        data = '1234567890'

        # Log data to be manipulated
        self.logger.info('Data `%s`', data)

        # Hash it
        hashed = self.crypto.hash_secret(data)

        # Log the resulting form
        self.logger.info('Hashed `%s`', hashed)

        # Verify the hash
        is_valid = self.crypto.verify_hash(data, hashed)

        # Will be True
        self.logger.info('Is correct `%s`', is_valid)

        # Verify the hash, using invalid input
        is_valid = self.crypto.verify_hash('invalid', hashed)

        # Will be False
        self.logger.info('Is correct `%s`', is_valid)
```

``` {.bash}
INFO - Is correct `True`
INFO - Is correct `False`
```

Related information
===================

Other crypto APIs:

-   [Encryption and decryption \<./encrypt\>]
-   [Generating \<./generate\>] passwords and secrets

Changelog
=========

  Version   Notes
  --------- -----------------
  3.0       Added initially

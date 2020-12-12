---
title: Odoo (OpenERP)
---

After creating
[an Odoo connection \<../../web-admin/email/smtp\>],
connecting to its databases and issuing requests is as follows.

Note that the underlying connections are based on [openerp-client-lib](https://pypi.python.org/pypi/openerp-client-lib/)
and allow for everything the Odoo\'s client supports.

Issuing requests {#progguide-examples-odoo-req}
================

``` {.python}
from zato.server.service import Service

class MyService(Service):
   def handle(self):
        with self.outgoing.odoo.get('My Connection').conn.client() as client:

            # Use openerplib's syntax
            user_model = client.get_model('res.users')
            ids = user_model.search([('login', '=', 'admin')])
            user_info = user_model.read(ids[0], ['login'])

            # Let's check out what we have
            self.logger.info(user_info)

            # The actual connection's implementation
            self.logger.info(client)
```

``` {.python}
INFO - {'login': 'admin', 'id': 1}
INFO - <openerplib.main.Connection object at 0x7f1b585c9350>
```
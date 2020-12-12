---
title: Odoo connections
---

Overview
========

Synchronously issues queries against Odoo (OpenERP) servers.

The underlying client Odoo library is [openerp-client-lib](https://pypi.python.org/pypi/openerp-client-lib/).

API
===

self.outgoing.odoo\[name\].conn.client() {#progguide-outconn-odoo-conn-client}
----------------------------------------

Usage example
=============

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        with self.outgoing.odoo.get('My Connection').conn.client() as conn:

            model = conn.get_model('res.partner')

            for model_id in model.search([('name', 'like', 'Name')]):
                self.logger.info(model.read(model_id, ['name']))
```

``` {.python}
INFO - 3406:Dummy-260 - odoo1.my-service:22 - {'id': 7, 'name': 'My Name'}
INFO - 3406:Dummy-260 - odoo1.my-service:22 - {'id': 6, 'name': 'Another Name'}
```

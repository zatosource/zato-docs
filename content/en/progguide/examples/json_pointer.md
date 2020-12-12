---
title: JSON Pointers
---

Once
[a JSON Pointer \<../../web-admin/messages/json-pointer\>]
has been created, it can be used as follows. Building a library of reusable pointers is a great way to ensure
flexibility - if a data model changes only pointer definitions will have to be updated instead of code.

Evaluating expressions {#progguide-examples-json-pointer-expr}
======================

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # An API over the incoming request
        api = self.msg.json_pointer(self.request.payload)

        # Resolve pointers to actual data
        cust_name = api.get('CustomerName')
        cust_addr = api.get('CustomerAddress')

        # Log what we've found
        self.logger.info(cust_name)
        self.logger.info(cust_addr)
```

Such a service can be executed through any means, here web-admin\'s [service invoker \<../../web-admin/service-details/invoker\>]
is used:

![image](/gfx/progguide/examples/json-pointer.png){.align-center}

In server.log:

``` {.python}
INFO - My Name
INFO - My Address
```

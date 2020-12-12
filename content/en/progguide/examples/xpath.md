---
title: XPath
---

Once
[an XPath expression \<../../web-admin/messages/xpath\>]
has been created, it can be used as follows. Building a library of expressions lets one\'s solutions stay flexible. Should business
requirements change the data model only expressions definitions will be changed instead of code of services.

Evaluating expressions {#progguide-examples-xpath-expr}
======================

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # An API over the incoming request
        api = self.msg.xpath(self.request.payload)

        # Resolve expressions names to actual data
        cust_name = api.get('CustomerName')
        cust_addr = api.get('CustomerAddress')

        # Log what we've found
        self.logger.info(cust_name)
        self.logger.info(cust_addr)
```

Such a service can be invoked by external clients or, like here, from web-admin\'s
\`service invoker \<../../web-admin/service-details/invoker\>\`:

![image](/gfx/progguide/examples/xpath.png){.align-center}

In server.log:

``` {.python}
INFO - My Name
INFO - My Address
```

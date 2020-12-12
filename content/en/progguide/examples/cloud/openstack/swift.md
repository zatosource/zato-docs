---
title: OpenStack Swift
---

Once
[an OpenStack Swift connection \<../../../../web-admin/cloud/openstack/swift\>]
has been created it is possible to execute any and all calls the underlying Python
library offers.

Storing data in containers {#progguide-examples-cloud-openstack-swift-store}
==========================

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        with self.cloud.openstack.swift.get('My Connection').conn.client() as client:

            # What to store and where
            container = 'test123'
            object_name = 'my-document.txt'
            contents = 'Hi there'

            # Now store it
            client.put_object(container, object_name, contents)
```

And now on Rackspace:

![image](/gfx/progguide/examples/swift-sample-object.png){.align-center}

Accessing the underlying library {#progguide-examples-cloud-lib}
================================

Connections to to Swift are built using the OpenStack\'s
[swiftclient](http://docs.openstack.org/developer/python-swiftclient/swiftclient.html) library whose
swiftclient.client.Connection objects are what the *client* actually is.

The client offers means to access full Swift API for reading, deleting and other operations on Swift objects -consult the
[client\'s documentation](http://docs.openstack.org/developer/python-swiftclient/swiftclient.html)
for usage details.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        with self.cloud.openstack.swift.get('My Connection').conn.client() as client:

            # The actual connection's implementation
            self.logger.info(client)
```

``` {.python}
INFO - <swiftclient.client.Connection object at 0x7f1b5842bc90>
```

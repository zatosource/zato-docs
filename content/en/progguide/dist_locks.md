---
title: Distributed locks
---

A service\'s [self.lock \<progguide-write-service-lock\>] method runs a block of code with a distributed lock held.

It is guaranteed that no other services throughout all servers in a cluster will concurrently run any code that is guarded by
such a lock as long as the lock exists. This makes it possible to execute code that needs to be serialized and cannot be run in parallel.

Locks are named - by default a lock\'s name is the name of the service creating it but users are free to choose any names which
allows one to form advanced interactions between locks and services.

Services can either wait for a lock to be available or give up immediately if another service is already holding one.

All locks eventually time out and disappear so they with time become available again.

API and usage examples
======================

Serialize access to the same service
------------------------------------

Useful if a service cannot be invoked concurrently, for instance - if it accesses a resource that cannot handle parallel
requests.

Using *self.lock()* alone is equal to *self.lock(self.name)* - i.e. the service\'s name becomes the lock\'s name in that case.

:

``` {.python}
from zato.server.service import Service

class UpdateCustomer(Service):
    """ Updates customer data in CRM.
    """
    def handle(self):

        # A block of code that cannot run concurrently because,
        # for instance, the remote end cannot handle it properly.
        with self.lock():

            # Supposing there is an outgoing REST connection to a remote CRM

            conn = self.outgoing.plain_http['CRM'].conn
            conn.send(self.cid, {'cust_id':123})
```

Serialize access across multiple services
-----------------------------------------

Locks can be given arbitrary names - that lets them be held by otherwise unrelated services that indeed don\'t even need to know
of each other\'s existence.

The name may come from anywhere - below it is taken from a service\'s [SimpleIO \<./sio/index\>] input with the net result being that for a given
customer account only one service throughout the whole cluster can be executed.

``` {.python}
from zato.server.service import Service

class UpdateAccount(Service):
    """ Updates an account in CRM.
    """
    class SimpleIO:
        input_required = ('account_no', 'name')

    def handle(self):

        with self.lock(self.request.input.account_no):

            # Update the account here ..
            pass
```

``` {.python}
from zato.server.service import Service

class DeleteAccount(Service):
    """ Deletes an account in CRM.
    """
    class SimpleIO:
        input_required = ('account_no',)

    def handle(self):

        with self.lock(self.request.input.account_no):

            # Delete the account here ..
            pass
```

Lock expiration
---------------

By default, a lock expires after 20 seconds. That is, if a block of code doesn\'t complete within 20 seconds, the lock will expire
anyway and it\'s possible another service will hold it even if the original one has not finished yet.

If longer expiration time is need, provide it on input, as below:

``` {.python}
# Expires in 3 minutes
with self.lock(expires=180):
  ...
```

Waiting for locks
-----------------

By default, if a lock cannot be obtained within 10 seconds an exception will be raised - you should catch the
Python\'s generic Exception.

It\'s possible to provide information on how long to wait before giving up or not to wait at all if a lock cannot be created.

``` {.python}
# Wait half a minute for the lock, afterwards raise the exception
with self.lock(timeout=30):
  ...
```

``` {.python}
# Don't wait at all if we cannot have the lock, raise the exception straightaway
with self.lock(timeout=0):
  ...
```

---
title: IMAP
---

After creating
[an IMAP connection \<../../web-admin/email/imap\>]
messages can be fetched, mark as seen and deleted as below.

Receiving e-mails {#progguide-examples-imap-receive}
=================

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.email.imap.get('My Connection').conn

        for msg_id, msg in conn.get():

            # Access the message
            self.logger.info(msg.data)
```

Marking messages seen {#progguide-examples-imap-mark-seen}
=====================

Call *.mark_seen()* on a message object to mark it as seen.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.email.imap.get('My Connection').conn

        for msg_id, msg in conn.get():

            # Access the message
            self.logger.info(msg.data)

            # To mark the message seen
            msg.mark_seen()
```

Deleting messages {#progguide-examples-imap-delete}
=================

Call *.delete()* on a message object to mark it as seen.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        conn = self.email.imap.get('My Connection').conn

        for msg_id, msg in conn.get():

            # Access the message
            self.logger.info(msg.data)

            # To delete the message
            msg.delete()
```

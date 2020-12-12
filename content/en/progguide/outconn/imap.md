---
title: IMAP connections
---

Overview
========

Synchronously reads, deletes or mark as seen messages from remote IMAP servers.

The underlying client IMAP library is [imbox](https://github.com/martinrusev/imbox) wrapped in a set of Zato classes.

API
===

self.email.imap.get {#progguide-outconn-email-imap-get}
-------------------

Usage example
=============

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

            # To delete it
            msg.delete()
```

``` {.python}
2015-01-06 21:55:31,863 - INFO - 5451:Dummy-65 - imap1.my-service:22 -
  {'body': {'plain': ['\r\nHello\r\n'], 'html': []},
  'headers': [{'Name': 'MIME-Version', 'Value': '1.0'},
  {'Name': 'X-Spam-Score', 'Value': '-1.899'}, {'Name': 'X-Spam-Status', 'Value': 'No,
  score=-1.899 tagged_above=-999 required=3\r\n\ttests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]'},
  {'Name': 'Content-Type', 'Value': 'text/plain; charset=utf-8'}],
  'date': u'Tue, 06 Jan 2015 21:52:48 +0100',
  'subject': u'Hello', 'sent_from': [{'name': u'My Name',
  'email': 'myaddress@invalid'}],
  'message_id': u'<54AC4B20.1040703@invalid>',
  'sent_to': [{'name': u'', 'email': 'hello@invalid'}]}
```

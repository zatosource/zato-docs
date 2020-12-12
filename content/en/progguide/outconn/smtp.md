---
title: SMTP connections
---

Overview
========

Synchronously sends messages to SMTP servers.

The underlying client SMTP library is [outbox](https://github.com/martinrusev/imbox) wrapped in a set of Zato classes.

API
===

self.email.smtp.get {#progguide-outconn-email-smtp-get}
-------------------

Usage example
=============

``` {.python}
from zato.common import SMTPMessage
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Obtain a connection
        conn = self.email.smtp.get('My Connection').conn

        # Create an HTML email with attachments
        msg = SMTPMessage()
        msg.subject = 'Hello'
        msg.to = 'hello@invalid'
        msg.from_ = 'hello@invalid'
        msg.body = '<b>Hello, here are the attachments</b>'
        msg.is_html = True

        # Attachment 1
        msg.attach('attachment1.txt', '{"hi":"there"}')

        # Attachment 2
        msg.attach('attachment2.txt', '<hello>howdy</hello>')

        # Send the message
        conn.send(msg)
```

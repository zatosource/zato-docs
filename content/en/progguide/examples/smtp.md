---
title: SMTP
---

After creating
[an SMTP connection \<../../web-admin/email/smtp\>]
messages can be sent as in the examples below.

Sending regular e-mails {#progguide-examples-smtp-regular}
=======================

``` {.python}
from zato.common import SMTPMessage
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Obtain a connection
        conn = self.email.smtp.get('My Connection').conn

        # Create a regular e-mail
        msg = SMTPMessage()
        msg.subject = 'Hello'
        msg.to = 'hello@example.com'
        msg.from_ = 'howdy@example.com'
        msg.body = 'Hello, how are you?'

        # Send the message
        conn.send(msg)
```

Sending HTML e-mails {#progguide-examples-smtp-html}
====================

Set *is_html* to True to signal that the message contains HTML.

``` {.python}
from zato.common import SMTPMessage
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Obtain a connection
        conn = self.email.smtp.get('My Connection').conn

        # Create a regular e-mail
        msg = SMTPMessage()

        # The flag indicating it is HTML
        msg.is_html = True

        msg.subject = 'Hello'
        msg.to = 'hello@example.com'
        msg.from_ = 'howdy@example.com'
        msg.body = '<b>Hello, how are you?</b>'

        # Send the message
        conn.send(msg)
```

Sending e-mails with attachments {#progguide-examples-smtp-attachments}
================================

Provide attachments using the *attach(name, payload)* method, as below. This works with both regular and HTML emails although
only the former is shown here:

``` {.python}
from zato.common import SMTPMessage
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        # Obtain a connection
        conn = self.email.smtp.get('My Connection').conn

        # Create a regular e-mail
        msg = SMTPMessage()
        msg.subject = 'Hello'
        msg.to = 'hello@example.com'
        msg.from_ = 'howdy@example.com'
        msg.body = 'Hello, how are you?'

        # Send attachments along
        msg.attach('attachment_name1.txt', 'Attachment as string goes here')
        msg.attach('attachment_name2.txt', 'Here is another one')

        # Send the message
        conn.send(msg)
```

---
title: Outputting HTML with Django templates
---

Zato is [a middleware and backend server \<../intro/esb-soa\>] but at times it still desirable to be able to produce
HTML from services. For instance, a set of services performing background batch jobs may output HTML reports for administrators
to consult each week.

To use [Django](https://www.djangoproject.com/) templates in responses a service should subclass
[zato.server.service.internal.helpers.HTMLService](https://github.com/zatosource/zato/blob/support/2.0/code/zato-server/src/zato/server/service/internal/helpers.py)
and assign HTML output as using *self.set_html_payload* providing the method with a dictionary of context and a template
the context should be rendered in.

Consider the example below:

``` {.python}
from zato.server.service.internal.helpers import HTMLService

HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
  <head>
    <title>Report for {{ report_date }}</title>
  </head>
  <body>
    The result for {{ report_date }} is <strong>{{ result }}</strong>.
  </body>
</html>
"""

class MyReports(HTMLService):

    def handle(self):

        # Obtain current date and assume the imaginary job's result was OK
        ctx = {
            'report_date': self.time.today(),
            'result': 'OK'
        }

        # Set HTML payload, will also produce the Content-Type header
        self.set_html_payload(ctx, HTML_TEMPLATE)
```

The service can now be mounted on
[an HTTP channel \<../web-admin/channels/plain-http\>],
possibly
[secured with HTTP Basic Auth \<../web-admin/security/basic-auth\>],
and invoked from a browser:

![image](/gfx/progguide/html.png){.align-center}

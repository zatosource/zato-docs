---
title: Scheduler usage examples
---

Invoking services at predefined intervals {#progguide-examples-scheduler-invoking}
=========================================

No programming is needed to receive messages from scheduler. Create a new
[job \<../../web-admin/scheduler/main\>]
and a given service will be invoked each time it\'s scheduled to be run. Any extra
data provided in a job\'s definition will be available to a service in
self.request.raw_request

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('Got message: {}'.format(self.request.raw_request))
```

Scheduling jobs programmatically {#progguide-examples-zmq-scheduling-programmatically}
================================

It\'s possible to use the public API to create or otherwise manage scheduler jobs programmatically as in the example below.

``` {.python}
# stdlib
from datetime import datetime

# Zato
from zato.server.service import Service

class MyService(Service):
    def handle(self):

        request = {
            'cluster_id': self.server.cluster_id,
            'name': 'my-job-1',
            'is_active': True,
            'service': 'zato.ping',
            'job_type': 'cron_style',
            'start_date': datetime.utcnow().isoformat(), # Always in UTC
            'cron_definition': '@hourly'
        }

        self.invoke('zato.scheduler.job.create', request)
```

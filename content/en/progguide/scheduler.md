---
title: Scheduler
---

You can use [web admin \<../web-admin/scheduler/main\>]
and the public API
to specify a service be invoked once or at certain intervals. Jobs type supported
are one-time, interval-based and cron-style.

Among other things, the cluster\'s [singleton server \</architecture/servers\>]
runs a background thread whose sole purpose is to publish messages on
[Redis \</architecture/redis\>] when a service should be invoked. The message
is picked up by one of servers and Zato invokes the service specified.

It\'s worth emphasizing that publishing a message that a service should be run
and actually running it can be performed by two different servers, the process
is asynchronous.

Because Zato won\'t wait for a previous execution of a service to
complete before the next one can be started, multiple instances of a service
triggered by a scheduler\'s job are able to run in parallel.

From the perspective of a service, being triggered by a job is like any other
access method. Programmatically, if you need to check if a service was
invoked through a job, you can consult its
[channel \<progguide-write-service-channel\>]
and
[job_type \<progguide-write-service-job_type\>]
attributes.
Note that are service hooks specific to scheduler jobs available.

When creating a new job definition, you can specify extra data. In run-time,
this will accessible to a service in its [request.payload \<./reqresp/index\>]
attribute.

![image](/gfx/progguide/scheduler-job1.png){.align-center}

``` {.python}
INFO - {u'impl_name': u'zato.server.service.internal.helpers.InputLogger',
   u'name': u'zato.helpers.input-logger',
   u'cid': u'K224133255719936491308342248958867727969',
   u'invocation_time': datetime.datetime(2013, 2, 21, 0, 31, 50, 8451),
   u'job_type': u'interval_based', u'data_format': None,
   u'slow_threshold': 99999,
   u'request.payload': u'Extra data is\r\n\u0395\u03bb\u03bb\u03ac\u03b4\u03b1',
   u'wsgi_environ': None, u'environ': {}, u'user_msg': u'', u'usage': 114,
   u'channel': u'scheduler'}
```
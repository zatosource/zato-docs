---
title: Developing services
---

From a programmer\'s point of view, a service is a Python class that subclasses
[zato.server.Service](https://github.com/zatosource/zato/blob/support/2.0/code/zato-server/src/zato/server/service/__init__.py)
and implements a handle(self) method.

Below is the simplest possible Zato service meant to illustrate the point of how
little coding is needed to write services. Granted, it doesn\'t do much useful,
but still can be [hot-deployed \<../admin/guide/installing-services\>]
and while it\'s not possible to
[invoke \<./invoking-services\>]
it through
[channels \<./channels\>],
it\'s still a valid service.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        pass
```

::: {.note}
::: {.title}
Note
:::

Looking for a set of scaled-down practical examples to study?

[Click here \<./examples/index\>] to visit a separate chapter with sample services.
:::

Programming conventions {#progguide-conventions}
=======================

-   Services are developed in Python 2.7 or Python 3.6+. There is no functional difference
    between choosing either although new environments are advised to choose Python 3 unless
    there is a compelling reason to prefer 2.7.

-   You can\'t use the name \'zato\', case-insensitively, anywhere. Any such names
    are reserved and can\'t be used. For instance, \'zato.sample\', \'my:zato:data\',
    \'X-ZATO-SERVER\' and \'ZatoReceiver\' are all invalid.

    This applies to any Zato object you will use - services, connection names,
    channel names, any other.

-   All input and output is always in UTF-8. Zato doesn\'t use nor support any other
    encoding. Each request and response must always be in UTF-8. Being a subset
    of UTF-8, ASCII will also be accepted but you\'re advised to always use UTF-8 anyway.
    Any other encodings, such as ISO-8859-1 or EBCDIC, are invalid.

-   If using Python 2.7, you are strongly encouraged to use the following header in each source code
    file you will keep services in. In fact, if you stumble upon any issues
    and need support you will be first asked that this header be added before any
    other advice can be given. Don\'t forget to set your code editor to write out
    files in UTF-8 too.

    This serves a couple of purposes:

    -   Makes sure you actually use UTF-8 in your code
    -   Lets you get prepared for Python 3.x
    -   Ensures you use the same Python features Zato\'s own internal services

    ``` {.python}
    # -*- coding: utf-8 -*-

    from __future__ import absolute_import, division, print_function, unicode_literals
    ```

-   Each service invocation creates a new instance of the class the service is
    represented as.

-   Don\'t keep any state around if you want to use the [hot-deployment \<../admin/guide/installing-services\>] feature.
    Don\'t assign any values to classes the services are implemented in. Don\'t modify
    any module-global data. Use [Redis \<../architecture/redis\>] if you need to store data between
    invocations of a service. Otherwise it will still be possible to deploy a service
    but not without restarting a server.

-   Don\'t start your own threads. Given Zato\'s architecture, there shouldn\'t really
    be any need for threads but if your use-case calls for it,
    [please let the project know more](https://zato.io/support) about why you need threads.

What a service can do
=====================

Typically, a service will receive some input and produce an output. Both steps
are optional but usually at least one of them will be performed.

You can use
[Simple IO (SIO)\<./sio/index\>],
[JSON \<./json\>],
[XML \<./xml\>]
or
[any other data type \<./other-formats\>]
in your services.

Depending on the choices you make, it will be usually possible to make the very
same service, with no changes to the code, available across multiple
[channels \<./channels\>]
- AMQP, IBM MQ, Plain HTTP, SOAP and ZeroMQ

You can store data in
Redis,
SQL databases
and specify your services be
periodically invoked through the scheduler.

A service can
[invoke other services \<./invoking-services\>]
as well as access resources outside a Zato environment.
The latter ones include
[AMQP \<./outconn/amqp\>],
[IBM MQ \<./outconn/jms-wmq\>],
[Plain HTTP \<./outconn/http\>],
[SOAP \<./outconn/http\>],
[ZeroMQ \<./outconn/zmq\>]
and
[FTP \<./outconn/ftp\>].

Service API
===========

This chapter will introduce the service API - a set of
[attributes \<progguide-write-service-attributes\>]
and
[methods \<progguide-write-service-methods\>]
a service can make use of during processing of the messages.

Save the following code in service_api.py and [hot-deploy \<../admin/guide/installing-services\>] it - this will be
the service that will be modified throughout the rest of the text.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        pass
```

Service attributes {#progguide-write-service-attributes}
------------------

### broker_client

Services can publish messages on a [Redis \</architecture/redis\>] broker.
How to use a broker client is explained in a
[separate section \<progguide-write-service-broker-client\>].

### channel {#progguide-write-service-channel}

Type of the channel (not its name) a service has been invoked through.
Can be one of:

-   \'amqp\'
-   \'audit\'
-   \'fanout-call\'
-   \'fanout-on-final\'
-   \'fanout-on-target\'
-   \'internal-check\'
-   \'http-soap\'
-   \'invoke\'
-   \'invoke-async\'
-   \'invoke-async-callback\'
-   \'jms-wmq\'
-   \'notifier-run\'
-   \'notifier-target\'
-   \'scheduler\'
-   \'startup-service\'
-   \'worker\'
-   \'zmq\'

The constants are defined in the
[zato.common.CHANNEL](https://github.com/zatosource/zato/blob/support/2.0/code/zato-common/src/zato/common/__init__.py)
class.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('channel:[{}]'.format(self.channel))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - channel:[invoke]
```

### cid {#progguide-write-service-cid}

A correlation ID (CID) of this request. Each request is assigned a CID
which is 128 bits of random data, encoded as a string.

The string is prefixed with the letter \'K\' to ensure that it always start with a character. There
is nothing special about the letter \'K\', it is simply a character chosen as a prefix.
Don\'t assume the prefix
will always be \'K\', future Zato versions may make it configurable or change it
without prior notice.

Note that when
[publishing \<progguide-write-service-broker-client-publish\>]
a
[SERVICE.PUBLISH.value](https://github.com/zatosource/zato/blob/support/2.0/code/zato-common/src/zato/common/broker_message.py)
message to more than one server, each server worker will receive a request
with the same CID.

CID has always 28 characters.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('cid:[{}]'.format(self.cid))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - cid:[K280592090634247650299684980809341216327]
```

### data_format {#progguide-write-service-data_format}

Each channel can optionally define that the data flowing in will be in
a particular data format. It can be one of:

-   None
-   \'json\'
-   \'xml\'

The constants are defined in the
[zato.common.DATA_FORMAT](https://github.com/zatosource/zato/blob/support/2.0/code/zato-common/src/zato/common/__init__.py)
class.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('data_format:[{}]'.format(self.data_format))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service --data-format json
```

``` 
INFO - data_format:[json]
```

### environ {#progguide-write-service-environ}

A dictionary of user-specific data that can be used for passing information
between [service hooks \<./hooks/service\>]. The service can store information in a
hook method and consult it in another one using the environ dictionary.

Zato will never use environ for its own purposes.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def before_handle(self):
        self.environ['seen_before_invoke'] = True

    def handle(self):
        self.environ['seen_handle'] = True

    def after_handle(self):
        for name in('seen_before_invoke', 'seen_handle'):
            self.logger.info('{}:[{}]'.format(name, self.environ[name]))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - seen_before_invoke:[True]
INFO - seen_handle:[True]
```

### handle_return_time {#progguide-write-service-handle_return_time}

A [datetime.datetime](http://docs.python.org/2.7/library/datetime.html#datetime-objects)
objects representing the time a service\'s [handle \<progguide-write-service-handle\>] method returned at.
Always in UTC.

Note that it will be available as a non-None value only in the
[finalize_handle \<progguide-write-service-finalize_handle\>] service hook.

[invocation_time \<progguide-write-service-invocation_time\>] and
handle_return_time are used to compute the values of
[processing_time \<progguide-write-service-processing_time\>]
and
[processing_time_raw \<progguide-write-service-processing_time_raw\>].

### impl_name {#progguide-write-service-impl_name}

Name of the module and class implementing a given service. Contrast
with [name \<progguide-write-service-name\>].

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('impl_name:[{}]'.format(self.impl_name))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - impl_name:[service_api.MyService]
```

### invocation_time {#progguide-write-service-invocation_time}

A [datetime.datetime](http://docs.python.org/2.7/library/datetime.html#datetime-objects)
object representing the time a service has been invoked at. Always in UTC.

invocation_time and
[handle_return_time \<progguide-write-service-handle_return_time\>] are used to compute the values of
[processing_time \<progguide-write-service-processing_time\>]
and
[processing_time_raw \<progguide-write-service-processing_time_raw\>].

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('invocation_time:[{}]'.format(self.invocation_time))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - invocation_time:[2013-02-17 17:47:01.045913]
```

### job_type {#progguide-write-service-job_type}

If a service has been [invoked through a scheduler\'s job \<./scheduler\>], type of the job
it was. None if the scheduler wasn\'t used. Can be one of:

-   None
-   \'one_time\'
-   \'interval_based\'
-   \'cron_style\'

The constants are defined in the
[zato.common.SCHEDULER_JOB_TYPE class](https://github.com/zatosource/zato/blob/support/2.0/code/zato-common/src/zato/common/__init__.py).

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('job_type:[{}]'.format(self.job_type))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - job_type:[None]
```

### kvdb

An object which lets one use [Redis, Zato\'s key/value database (KVDB) \<../architecture/redis\>].
The underlying [redis-py connection](https://github.com/andymccurdy/redis-py)
is available as self.kvdb.conn.

``` {.python}
from zato.common import KVDB
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        key = '{}{}'.format(KVDB.SERVICE_USAGE, self.name)
        usage = self.kvdb.conn.get(key)
        self.logger.info('{} was invoked {} time(s)'.format(self.name, usage))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - service-api.my-service was invoked 16 time(s)
```

### logger {#progguide-write-service-logger}

A logger, instance of
[zato.server.log.ZatoLogger](https://github.com/zatosource/zato/blob/support/2.0/code/zato-server/src/zato/server/log.py),
used for writing messages out to server logs.
This is a thin wrapper around [Python\'s logging.Logger](http://docs.python.org/2.7/library/logging.html)
which lets one use a \'cid\' argument in addition to what is ordinarily available
when using a standard logger. This allows to use a \'cid\' parameter in server logs.

Observe how the log output contains the CID now:

``` 
%(asctime)s - %(cid)s - %(message)s
```

``` 
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('Hello!', cid=self.cid)
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
2013-02-17 19:48:33,585 - K300817487686039172650072756834592513215 - Hello!
```

### name {#progguide-write-service-name}

Name of the service under which it will be possible to [invoke it \<progguide-write-service-invoke\>] and point to it
in the web admin. Contrast with [impl_name \<progguide-write-service-impl_name\>].

Visit [get_name \<progguide-write-service-get_name\>] for a way to override it.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('name:[{}]'.format(self.name))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - name:[service-api.my-service]
```

### odb

An object through which one can access
[Zato\'s Operational Database (ODB) \</architecture/sql-odb\>].
An [SQLAlchemy](http://sqlalchemy.org) session object,
used to issue queries, is available as .session() - note that it always needs to be
closed manually hence the use of the
[closing](http://docs.python.org/2.7/library/contextlib.html#contextlib.closing)
context manager in the example below.

``` {.python}
# stdlib
from contextlib import closing

# Zato
from zato.common.odb.model import Cluster
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        with closing(self.odb.session()) as session:
            for item in session.query(Cluster).all():
                self.logger.info(item.name)
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - quickstart-351218
INFO - quickstart-807391
INFO - quickstart-984115
INFO - quickstart-136892
INFO - quickstart-758758
```

### outgoing

Lets one invoke external
[FTP \<./outconn/ftp\>],
[AMQP \<./outconn/amqp\>],
[ZeroMQ \<./outconn/zmq\>],
[IBM MQ \<./outconn/jms-wmq\>],
[SQL \<./outconn/sql\>],
[Plain HTTP \<./outconn/http\>]
and
[SOAP \<./outconn/http\>]
resources. Consult the documentation of each one for more information.

### processing_time {#progguide-write-service-processing_time}

Time it took for the service to complete its operation, in milliseconds. Compare with
[processing_time_raw \<progguide-write-service-processing_time_raw\>].

Note that it will be available as a non-None value only in the
[finalize_handle \<progguide-write-service-finalize_handle\>] service hook.

processing_time will be equal to 0 if it took less than 1 ms.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        pass

    def finalize_handle(self):
        self.logger.info('Processing took {} ms'.format(self.processing_time))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - Processing took 0 ms
```

### processing_time_raw {#progguide-write-service-processing_time_raw}

A [datetime.timedelta](http://docs.python.org/2.7/library/datetime.html#timedelta-objects)
object representing the time spent in a service, with microseconds precision.
Compare with [processing_time \<progguide-write-service-processing_time\>].

Note that it will be available as a non-None value only in the
[finalize_handle \<progguide-write-service-finalize_handle\>] service hook.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        pass

    def finalize_handle(self):
        self.logger.info('Processing took {}'.format(self.processing_time_raw))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - Processing took 0:00:00.000077
```

### request

Request
and
response
objects are discussed in
[a separate chapter \<./reqresp/index\>].

### response

Request
and
response
objects are discussed in
[a separate chapter \<./reqresp/index\>].

### schema {#progguide-write-service-schema}

A service may specify a \[JSON schema\](<https://json-schema.org/>) to be used for validation of input data via the
**schema** attribute. The value of the attribute is a filename containing the schema.

If the filename is an absolute path, it will be used as-is, e.g. if it is \'/opt/zato/schema/myschema.json\' then this is the
path to the schema in the filesystem where the schema needs to reside.

If the filename is a relative path, it is in relation to a server\'s *config/repo/schema/json* directory. For instance,
if a service is in directory /opt/zato/server1 and schema is \'myschema.json\' then the file will be expected to be found
in /opt/zato/server1/config/repo/schema/json/myschema.json.

Each time a JSON Schema changes any service using it needs to be redeployed.

JSON Schema is used for input validation only, it does not validate the output that a service produces.

From the perspective of a service that uses JSON Schema, if the service\'s handle method is called, it means that the validation
succeeded.

``` {.python}
from zato.server.service import Service

class MyService(Service):

    schema = 'myschema.json'

    def handle(self):
        self.logger.info('My input was validated with JSON Schema')
```

### slow_threshold

Response time threshold, in milliseconds, after exceeding of which a service
invocation will be considered [a slow one \<../web-admin/service-details/slow-responses\>].
Top 100 slow invocations
of a service are stored for a later inspection.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('My threshold is {} ms'.format(self.slow_threshold))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - My threshold is 99999 ms
```

### usage

How many times the service has run, including the current invocation.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('My usage is {}'.format(self.usage))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - My usage is 38
```

### time {#progguide-write-service-time}

Accesses utilities for working with date/time. Documented in [their own chapter \<./datetime\>].

### wsgi_environ {#progguide-write-service-wsgi_environ}

Zato\'s HTTP server is a
[WSGI](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface)
one. If a service has been invoked through HTTP, wsgi_environ will be a dictionary of WSGI data.

The dictionary under zato.http.response.headers must not be used directly to define
what HTTP response headers a service will return. Use
[self.response.headers \<./reqresp/response\>] instead.

Note that the example below assumes the service has been mounted at /service-api.my-service
through a plain HTTP channel,
otherwise, had [zato service invoke \<../admin/cli/service-invoke\>] been used
as an access method, wsgi_environ would\'ve been empty.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        for key, name in sorted(self.wsgi_environ.items()):
            self.logger.info('{}:{}'.format(key, name))
```

``` 
$ curl localhost:17010/service-api.my-service
```

``` 
INFO - HTTP_ACCEPT:*/*
INFO - HTTP_HOST:localhost:17010
INFO - HTTP_USER_AGENT:curl/7.22.0 (x86_64-pc-linux-gnu)
INFO - PATH_INFO:/service-api.my-service
INFO - QUERY_STRING:
INFO - RAW_URI:/service-api.my-service
INFO - REMOTE_ADDR:127.0.0.1
INFO - REMOTE_PORT:34707
INFO - REQUEST_METHOD:GET
INFO - SCRIPT_NAME:
INFO - SERVER_NAME:localhost
INFO - SERVER_PORT:17010
INFO - SERVER_PROTOCOL:HTTP/1.1
INFO - SERVER_SOFTWARE:gunicorn/0.16.1
INFO - gunicorn.socket:<socket fileno=12 sock=127.0.0.1:17010 peer=127.0.0.1:34707>
INFO - wsgi.errors:<open file '<stderr>', mode 'w' at 0x7f6bd98b6270>
INFO - wsgi.file_wrapper:gunicorn.http.wsgi.FileWrapper
INFO - wsgi.input:<gunicorn.http.body.Body object at 0x5711910>
INFO - wsgi.multiprocess:True
INFO - wsgi.multithread:False
INFO - wsgi.run_once:False
INFO - wsgi.url_scheme:http
INFO - wsgi.version:(1, 0)
INFO - zato.http.response.headers:{}
```

Service methods {#progguide-write-service-methods}
---------------

### accept {#progguide-write-service-accept}

One of the [hooks \<./hooks/service\>]. If a service returns False in this method, the processing stops. It\'s as though
the service has never been invoked, for instance, its usage count won\'t increase. Defaults to True and needs to be overriden
only if False should be returned.

Note that in accept the service has already full access to
[self.request \<./reqresp/request\>],
[self.environ \<progguide-write-service-environ\>]
or
[self.wsgi_environ \<progguide-write-service-wsgi_environ\>].
and these can be consulted in order to make a choice of returning True or False.

### after_add_to_store {#progguide-write-service-after_add_to_store}

Static method executed right after a service class has been added to the
service store. Explained further in the [chapter on service hooks \<./hooks/service\>].

### after_cron_style_job {#progguide-write-service-after_cron_style_job}

Method executed right after a service has been invoked through a cron-style job.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### after_handle {#progguide-write-service-after_handle}

Method executed right after a service\'s [handle \<progguide-write-service-handle\>]
method has returned. Explained further in the [chapter on service hooks \<./hooks/service\>].

### after_interval_based_job {#progguide-write-service-after_interval_based_job}

Method executed right after a service has been invoked through an interval-based job.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### after_job {#progguide-write-service-after_job}

Method executed right after a service has been invoked through a scheduler\'s
job, regardless of the latter\'s type.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### after_one_time_job {#progguide-write-service-after_one_time_job}

Method executed right after a service has been invoked through a one-time job.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### before_add_to_store {#progguide-write-service-before_add_to_store}

Static method executed right before a service class is added to the service store.
The service won\'t be deployed unless the method returns True.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### before_cron_style_job {#progguide-write-service-before_cron_style_job}

Method executed right before a service is invoked through a cron-style job.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### before_handle {#progguide-write-service-before_handle}

Method executed right before a service\'s [handle \<progguide-write-service-handle\>]
is run. Explained further in the [chapter on service hooks \<./hooks/service\>].

### before_interval_based_job {#progguide-write-service-before_interval_based_job}

Method executed right before a service is invoked through an interval-based job.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### before_job {#progguide-write-service-before_job}

Method executed right before a service is invoked through a scheduler\'s job,
regardless of the job\'s type.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### before_one_time_job {#progguide-write-service-before_one_time_job}

Method executed right before a service is invoked through a one-time job.
Explained further in the [chapter on service hooks \<./hooks/service\>].

### finalize_handle {#progguide-write-service-finalize_handle}

Method executed after [handle \<progguide-write-service-handle\>] and other service
hooks have completed. Explained further in the [chapter on service hooks \<./hooks/service\>].

### get_name {#progguide-write-service-get_name}

A static method that should be implemented to return
[service names \<progguide-write-service-name\>] other than what Zato
automatically generates.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.logger.info('My name is {}'.format(self.name))

    @staticmethod
    def get_name():
        return 'Something Else'
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - My name is Something Else
```

### handle {#progguide-write-service-handle}

The only method a service must implement. The central place where most of the
message processing will take place. Each time a channel accepts a message,
a new instance of the service class will be created and its handle method will
be called.

A service is fully initialized and ready to process the request at the time
handle is being invoked.

Request and response objects are documented in
[their own chapter \<./reqresp/index\>].

### invoke {#progguide-write-service-invoke}

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        payload = {'cluster_id': 1}
        response = self.invoke('zato.security.get-list', payload, as_bunch=True)
        for item in response.zato_security_get_list_response:
            self.logger.info(item.name)
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - techacct-98014
INFO - pubapi
INFO - zato.ping.plain_http.basic_auth
INFO - zato.ping.soap.basic_auth
INFO - zato.ping.soap.wss.clear_text
```

### invoke_async {#progguide-write-service-invoke_async}

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.invoke_async('zato.helpers.input-logger', 'My payload')
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - {u'impl_name': u'zato.server.service.internal.helpers.InputLogger',
  u'handle_return_time': datetime.datetime(2013, 2, 18, 20, 17, 1, 162872),
  u'name': u'zato.helpers.input-logger',
  u'cid': u'K241057352164304005274904154334359360347',
  u'processing_time': 0,
  u'invocation_time': datetime.datetime(2013, 2, 18, 20, 17, 1, 162850),
  u'processing_time_raw': datetime.timedelta(0, 0, 22),
  u'job_type': None, u'data_format': None, u'slow_threshold': 99999,
  u'request.payload': u'"My payload"', u'wsgi_environ': None,
  u'environ': {}, u'usage': 9, u'channel': u'publish'}
```

### invoke_by_impl_name

Same as [invoke \<progguide-write-service-invoke\>] but using
a service\'s
[impl_name \<progguide-write-service-impl_name\>]
instead of its
[name \<progguide-write-service-name\>].

### lock {#progguide-write-service-lock}

Creates distributed locks - documented in [its own chapter \<dist-locks\>].

### log_input {#progguide-write-service-log_input}

::: {.versionchanged}
2.0
:::

Note that below the service has been expoxed through a plain HTTP channel
at /service-api.my-service so it can be invoked from curl in order to show
input HTTP headers which log_input has access to.

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        self.log_input("Let's find out what the input was")
```

``` 
$ curl localhost:17010/service-api.my-service -d 'Hello'
```

``` 
INFO - Let's find out what the input was {u'impl_name': u'req_resp.MyService',
    u'name': u'req-resp.my-service',
    u'cid': u'K003047659946670542740630609961875870964',
    u'invocation_time': datetime.datetime(2013, 2, 19, 8, 16, 56, 253101),
    u'job_type': None, u'data_format': None,
    u'slow_threshold': 99999, u'request.payload': 'Hello',
    u'wsgi_environ': {'SERVER_PROTOCOL': 'HTTP/1.1',
      'SERVER_SOFTWARE': 'gunicorn/0.16.1', 'SCRIPT_NAME': '',
      'wsgi.input': <gunicorn.http.body.Body object at 0x5489e50>,
      'REQUEST_METHOD': 'GET', 'HTTP_HOST': 'localhost:17010',
      'PATH_INFO': '/service-api.my-service', 'wsgi.multithread': False,
      'QUERY_STRING': '', 'HTTP_ACCEPT': '*/*', 'HTTP_USER_AGENT':
      'curl/7.22.0', 'wsgi.version': (1, 0), 'REMOTE_PORT': '38617',
      'RAW_URI': '/service-api.my-service', 'REMOTE_ADDR': '127.0.0.1',
      'wsgi.run_once': False,
      'wsgi.errors': <open file '<stderr>', mode 'w' at 0x7f3c8f65d270>,
      'wsgi.multiprocess': True, 'wsgi.url_scheme': 'http',
      'gunicorn.socket': <socket at 0x525cb10 fileno=13 sock=127.0.0.1:17010 peer=127.0.0.1:38617>,
      'SERVER_NAME': 'localhost', 'SERVER_PORT': '17010',
    'wsgi.file_wrapper': <class gunicorn.http.wsgi.FileWrapper at 0x30a70b8>},
    u'environ': {}, u'usage': 4, u'channel': u'http-soap'}
```

### log_output {#progguide-write-service-log_output}

::: {.versionchanged}
2.0
:::

``` {.python}
# stdlib
import logging

# Zato
from zato.server.service import Service

class MyService(Service):

    def handle(self):
        self.response.payload = 'Greetings!'

    def finalize_handle(self):
        self.log_output('What was the output?', logging.DEBUG,
            ['wsgi_environ', 'name', 'impl_name'])
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
DEBUG - What was the output? {u'response.payload': 'Greetings!',
    u'handle_return_time': datetime.datetime(2013, 2, 19, 8, 37, 36, 469453),
    u'impl_name': u'(suppressed)', u'channel': u'http-soap',
    u'cid': u'K190324097308368662541391425956165369564',
    u'processing_time': 0, u'name': u'(suppressed)',
    u'invocation_time': datetime.datetime(2013, 2, 19, 8, 37, 36, 469320),
    u'processing_time_raw': datetime.timedelta(0, 0, 133),
    u'job_type': None, u'data_format': None, u'slow_threshold': 99999,
    u'environ': {}, u'usage': 8}
```

### translate {#progguide-write-service-translate}

``` {.python}
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        result = self.translate('CRM', 'COUNTRY_CODE', 'AUS', 'BILLING', 'COUNTRY_CODE')
        self.logger.info('Result is {}'.format(result))
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

``` 
INFO - Result is 036
```

Publish/subscribe broker client {#progguide-write-service-broker-client}
===============================

Each service can asynchronously publish messages to one or more services on
servers running in the same cluster the publishing service is in.

A message needs to be a dictionary of metadata whose only required key is \'action\'
which must point to a Zato service you want to invoke using constants
from the
[zato.common.broker_message](https://github.com/zatosource/zato/blob/feature/service-tests/code/zato-common/src/zato/common/broker_message.py)
module.

If you want to publish or send messages to all workers that contain your own services,
the action must be SERVICE.PUBLISH.value, this which will in turn publish the message to Zato\'s
*zato.service.invoke* service
which will next invoke the service of your choice by its
[name \<progguide-write-service-name\>].

Publishing a message to all servers (1:N) {#progguide-write-service-broker-client-publish}
-----------------------------------------

All workers of all servers in a cluster will receive a message, including the one which
is publishing the message.

It\'s possible that no subscriber will receive the message at all in a highly unlike
case when there\'s only one server with one worker in a cluster.
If the worker publishes a message - without the knowledge that it should be its
own sole recipient - and next goes down for any reason before the message
could be delivered - the message will be lost.

![image](/gfx/progguide/broker-client-publish.png){.align-center}

``` {.python}
from zato.common.broker_message import SERVICE
from zato.common.util import new_cid
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        msg = {
            'action': SERVICE.PUBLISH.value,
            'service': 'zato.helpers.input-logger',
            'payload': 'My payload',
            'cid': new_cid()
        }
        self.broker_client.publish(msg)
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-service
```

Note the data has been written out to logs twice because in this particular case
the cluster consisted of two servers, each running one worker.

Visit the [section on how to invoke only a single instance of a service \<progguide-write-service-broker-client-invoke_async\>]
if you don\'t want all of your services to receive the message.

``` 
INFO - {u'impl_name': u'zato.server.service.internal.helpers.InputLogger',
  u'handle_return_time': datetime.datetime(2013, 2, 18, 20, 27, 17, 111426),
  u'name': u'zato.helpers.input-logger',
  u'cid': u'K243384249163255697882446959015306592567', u'processing_time': 0,
  u'invocation_time': datetime.datetime(2013, 2, 18, 20, 27, 17, 111401),
  u'processing_time_raw': datetime.timedelta(0, 0, 25), u'job_type': None,
  u'data_format': None, u'slow_threshold': 99999,
  u'request.payload': u'My payload', u'wsgi_environ': None, u'environ': {},
  u'usage': 14, u'channel': u'publish'}

INFO - {u'impl_name': u'zato.server.service.internal.helpers.InputLogger',
  u'handle_return_time': datetime.datetime(2013, 2, 18, 20, 27, 17, 111497),
  u'name': u'zato.helpers.input-logger',
  u'cid': u'K243384249163255697882446959015306592567', u'processing_time': 0,
  u'invocation_time': datetime.datetime(2013, 2, 18, 20, 27, 17, 111478),
  u'processing_time_raw': datetime.timedelta(0, 0, 19), u'job_type': None,
  u'data_format': None, u'slow_threshold': 99999,
  u'request.payload': u'My payload', u'wsgi_environ': None, u'environ': {},
  u'usage': 13, u'channel': u'publish'}
```

Sending a message to one of the servers (1:1) {#progguide-write-service-broker-client-invoke_async}
---------------------------------------------

Exactly one worker among all servers in a cluster will receive a message, possibly
the one which is publishing the message.

Redis will store the message for a configurable amount of time under a key
starting with \'zato:broker:to-parallel:any:\' and then, if no worker picks it up,
it will expire. By default, expiration time is 15 seconds and can be specified when
sending the message.

Each service offers an [invoke_async \<progguide-write-service-invoke_async\>]
convenience wrapper to send a message to a single worker only.

![image](/gfx/progguide/broker-client-send.png){.align-center}

``` {.python}
from zato.common.broker_message import SERVICE
from zato.common.util import new_cid
from zato.server.service import Service

class MyService(Service):
    def handle(self):
        msg = {
            'action': SERVICE.PUBLISH.value,
            'service': 'zato.helpers.input-logger',
            'payload': 'My payload',
            'cid': new_cid()
        }
        self.broker_client.invoke_async(msg)
```

``` 
$ zato service invoke /opt/zato/server1 service-api.my-servicePUBLISH
```

Note the data has been written out to logs once only even though the cluster
consisted of two servers, each running one worker.

You may also be interested in the [section on how to invoke all instances of a service \<progguide-write-service-broker-client-publish\>]
instead of a single one.

``` 
INFO - {u'impl_name': u'zato.server.service.internal.helpers.InputLogger',
  u'handle_return_time': datetime.datetime(2013, 2, 18, 21, 42, 0, 783786),
  u'name': u'zato.helpers.input-logger',
  u'cid': u'K110292925198847762451855196826718257593', u'processing_time': 0,
  u'invocation_time': datetime.datetime(2013, 2, 18, 21, 42, 0, 783764),
  u'processing_time_raw': datetime.timedelta(0, 0, 22), u'job_type': None,
  u'data_format': None, u'slow_threshold': 99999,
  u'request.payload': u'My payload', u'wsgi_environ': None, u'environ': {},
  u'usage': 20, u'channel': u'publish'}
```

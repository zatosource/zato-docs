---
title: Zato API
---

Zato offers a full API to manage all the aspects of servers by user-built tools or applications. All the API services
can be used either via [REST](https://zato.io/docs/3.2/api/spec/) or from [command line \<../admin/cli/service-invoke\>].

It is possible to access
server resources in an automated manner, just like it is possible to do it using
[web-admin \<../web-admin/intro\>].
In fact, web-admin
is an API client itself and it uses the same services that users may employ in their own integrations.

This chapter introduces the core usage concepts and provides usage examples in Python and REST.

A separate chapter presents all the [public API services](https://zato.io/docs/3.2/api/spec/)
along with [their OpenAPI](https://zato.io/docs/3.2/api/spec/_downloads/openapi.yaml) specification.

Overview
========

Everything in Zato is built around services. Internally, there are several hundred services that servers use to implement
all the features that Zato offers. Web-admin is also a client of these services which means that anything that can be done
in web-admin is also available via an API call.

Most of the services follow the CRUD pattern, e.g. given AMQP connections, there are services to create, read, update and delete
them, respectively called Create, Get, Edit and Delete. Additionally, services such as GetList or Ping will expose
functionality outside of CRUD.

Each service\'s name reflects the domain it is concerned with, e.g. all services whose name starts with zato.email.smtp
will deal with SMTP connections only.

All of the public services are [listed separately](https://zato.io/docs/3.2/api/spec/). For each service, its description
and input/output are provided. [Their OpenAPI](https://zato.io/docs/3.2/api/spec/_downloads/openapi.yaml) specification can be used
to generate API clients automatically.

Collecting usage examples
=========================

The most convenient way to observe the API services in action, which also lets one collect usage examples, is to interact with
web-admin while keeping *admin.log* files opened. Each server has a file called admin.log, for instance, if the path to server
is /opt/zato/env/server1 then the file will be in /opt/zato/env/server1/logs/admin.log.

This file contains input and output of all the services that web-admin invokes, and, seeing as web-admin uses only public API
services, this is the file where usage examples can be found in.

For instance, after visiting the list of scheduler\'s jobs in web-admin, the following two entries will be written out to
admin.log.

The first one is the service that web-admin invoked and what request was used:

``` 
INFO - name:`zato.scheduler.job.get-list`,
       request:`{u'query': u'', u'paginate': True, u'cluster_id': 1, u'cur_page': 1}`
```

The second one is the response that the API service responded with:

``` 
INFO - name:`zato.scheduler.job.get-list`,
       response:`'{"zato_scheduler_job_get_list_response": [
         {"name": "zato.outgoing.sql.auto-ping", "extra": "", "seconds": null,
          "is_active": true, "cron_definition": null,
          "job_type": "interval_based", "days": null, "id": 204, "hours": null,
          "service_name": "zato.outgoing.sql.auto-ping", "service_id": 584, "weeks": null,
          "repeats": null, "minutes": 3, "start_date": "2018-11-11T22:01:57"},
         {"name": "zato.stats.aggregate-by-day", "extra": "", "seconds": null,
          "is_active": true, "cron_definition": null,
          "job_type": "interval_based", "days": null, "id": 208, "hours": null,
          "service_name": "zato.stats.aggregate-by-day",
          "service_id": 854, "weeks": null, "repeats": null, "minutes": 60,
          "start_date": "2018-11-11T22:01:57"}]
```

The same principle applies to any other services from the [public API](https://zato.io/docs/3.2/api/spec/) - any usage example
can be obtained from a live environment by using the web-admin and looking up requests and responses in admin.log.

API access via REST
===================

A dedicated endpoint lets one invoke any API service from REST. The endpoint\'s URL path pattern is
*/zato/api/invoke/{service_name}*, e.g. to invoke service zato.ping the full path will be /zato/api/invoke/zato.ping.

There is no difference which HTTP verb is used; to allow non-REST aware applications access to all the services,
each of them can be invoked with GET, POST or any other method.

The access endpoint is secured with an HTTP Basic Auth definition. The username is *pubapi* and there is no default password,
which means that one needs to configure it explicitly; in web-admin go to Security -\> HTTP Basic Auth -\> Change password.

To invoke a service via REST, the steps are:

-   Choose a service from the list of the available ones
-   Understand what it expects on input and what it returns
-   Optionally, look up its usage examples in admin.log
-   Construct a full URL for the service
-   Invoke it using JSON

Thus:

-   For illustration purposes, let\'s assume that the service chosen is
    [zato.server.get-list](https://zato.io/docs/3.2/api/spec/service_zato_server_get_list.html) which returns all servers
    defined for input cluster.

-   On its reference page, one can find that cluster_id is the only required parameter.

-   The full path to the service on localhost will be <http://localhost:11223/zato/api/zato.server.get-list>.

-   The service can now be invoked as below:

    ``` 
    $ curl http://pubapi:<pass>@localhost:11223/zato/api/invoke/zato.server.get-list?cluster_id=1
    [{
      "name": "server1",
      "bind_host": "0.0.0.0",
      "bind_port": 17010,
      "preferred_address": "192.168.0.10",
      "last_join_status": "accepted",
      "up_mod_date": "2018-12-05T14:00:49",
      "up_status": "running",
      "host": "",
      "crypto_use_tls": false,
      "opaque1": "",
      "last_join_mod_by": "zato@dev1",
      "id": 1,
      "last_join_mod_date": "2018-09-16T08:13:02"
     },
     {
      "name": "server2",
      "bind_host": null,
      "bind_port": null,
      "preferred_address": null,
      "last_join_status": "accepted",
      "up_mod_date": null,
      "up_status": null,
      "host": "",
      "crypto_use_tls": false,
      "opaque1": "",
      "last_join_mod_by": "zato@dev1",
      "id": 2,
      "last_join_mod_date": "2018-09-16T08:13:02"
     }]
    $
    ```

As noted earlier, any HTTP verb can be used, hence the two approaches below will achieve the same result:

``` {.bash}
$ curl -XPOST http://pubapi:<pass>@localhost:11223/zato/api/invoke/zato.server.get-list?cluster_id=1
$ curl -XPOST http://pubapi:<pass>@localhost:11223/zato/api/invoke/zato.server.get-list -d \
  '{"cluster_id":1}'
```

API access from Python
======================

The most straightforward way to access Zato API services is to use the dedicated [zato-client](https://pypi.org/project/zato-client/)
project, available from PyPI.

Under the hood, the client uses the REST endpoint described above which means that it also requires that a password be set
for HTTP Basic Auth user pubapi before it can be used. It can be install via pip or added to requirements.txt, as needed
in a particular situation.

The example below illustrates the usage of the same service as in the REST section:

``` {.python}
# Where to find the client
from zato.client import APIClient

# Credentials
username = 'pubapi'
password = 'zz'

# Remote address - note that the path may be left off
address = 'http://localhost:11223'

# Build the client
client = APIClient(address, username, password)

# Choose the service to invoke and its request
service_name = 'zato.server.get-list'
request = {'cluster_id':1}

# Invoke the API service
response = client.invoke(service_name, request)

# And display the response
print(response.data)
```

``` 
$ py apidocs1.py
[{
  u'name': u'server1',
  u'bind_host': u'0.0.0.0',
  u'bind_port': 17010,
  u'last_join_status': u'accepted',
  u'host': u'',
  u'up_status': u'running',
  u'up_mod_date': u'2018-12-05T14:00:49',
  u'preferred_address': u'192.168.0.10',
  u'opaque1': u'',
  u'last_join_mod_by': u'zato@dev1',
  u'crypto_use_tls': False,
  u'id': 1,
  u'last_join_mod_date': u'2018-09-16T08:13:02'
 },
 {
  u'name': u'server2',
  u'bind_host': None,
  u'bind_port': None,
  u'last_join_status': u'accepted',
  u'host': u'',
  u'up_status': None,
  u'up_mod_date': None,
  u'preferred_address': None,
  u'opaque1': u'',
  u'last_join_mod_by': u'zato@dev1',
  u'crypto_use_tls': False,
  u'id': 2,
  u'last_join_mod_date': u'2018-09-16T08:13:02'
 }]
$
```

This is the same response as in the REST call but the data is already deserialized from JSON into Python objects, here it is
a list of dictionaries.

Each response returned by the *.invoke* method has several attributes:

  Attribute   Datatype   Description
  ----------- ---------- ---------------------------------------------------------------------------------
  is_ok       bool       A boolean flag indicating whether the invocation was successful
  data        (varies)   Populated only if is_ok is True. Actual data produced by the service,
                         may be a string, list, dictionary or any other data type the service returned.
  details     string     Populated only if is_ok is not True. Details of an error caught on server side.
  cid         string     Correlation ID assigned to this request by Zato - can be found in server.log
                         and http_access.log files to correlate requests sent with activity on
                         Zato servers.

OpenAPI
=======

To facilitate access to the API from non-Python based applications, all of the services are formally represented
in the
[OpenAPI](https://zato.io/docs/3.2/api/_downloads/openapi.yaml)
[format](https://en.wikipedia.org/wiki/OpenAPI_Specification).

This allows one to access Zato API from any programming language or environment that support OpenAPI. For instance,
below is a sample invocation from
[Swagger Inspector](https://inspector.swagger.io/)
which uses the OpenAPI specification to discover endpoints
and parameters of all the Zato services. Again, this is the same service and request/response as in previous sections:

![image](/gfx/api/swagger-inspector.jpg){width="90.0%"}

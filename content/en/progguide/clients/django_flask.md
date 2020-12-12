---
title: Django and Flask integration
---

All Python applications can connect to Zato services using its [Python clients \<./python\>] and the following material
discusses ways of setting up Django and Flask projects in particular.

Note that applications in other programming languages can always connect to Zato using one of its [channels \<../channels\>].

Services and channels
=====================

There will be two services used throughout the chapter available as GitHub gists -[deploy \<../../admin/guide/installing-services\>]
them on a server before
continuing with the content that follows:

-   [customer.get1](https://gist.github.com/dsuch/2211f5960d68c03e4621)
-   [customer.get2](https://gist.github.com/dsuch/3fe0b42d73ff2f9aed81)

Their purpose is to look up a client\'s name based on their ID - if a match is found in Redis the response is served from the cache.
If it\'s not, it is looked up in backend, cached, and returned.

They are pretty much the same except for one difference - customer.get1 produces a string response whereas customer.get2
produces a dict response that is serialized to string by Zato automatically.

Why two services and when to use either?

Which approach to use, whether serialize manually or let Zato do it, depends on which Python client will be used:

-   [AnyServiceInvoker \<./python\>]
-   [JSONClient \<./python\>]

The difference between them is that AnyServiceInvoker connects to a special built-in service which in turn invokes user services
whereas JSONClient connects to target services directly.

The benefit of using the former is that only one channel is needed for an unlimited number of user services to be invoked
whereas with the latter each service needs its own channel. The drawback of using the former is that it\'s slightly slower because
of the additional level of indirection in using a dispatcher service instead of invoking the target one directly.

Another difference is that RBAC definitions for services are easier to manage when using the latter because the same service can
be exposed through multiple channels each using its own credentials serving as the basis for RBAC rules.

When using AnyServiceInvoker responses from services *must* be produced as strings. When using JSONClient responses *may* be produced
as strings but when they are not, serialization to JSON will be performed by Zato.

Both AnyServiceInvoker and JSONClient are based on [requests](https://pypi.python.org/pypi/requests) down under the hood.

Django
======

Steps:

-   Make sure both
    [customer.get1](https://gist.github.com/dsuch/2211f5960d68c03e4621)
    and
    [customer.get2](https://gist.github.com/dsuch/3fe0b42d73ff2f9aed81)
    are deployed
-   Create HTTP Basic Auth credentials and two Plain HTTP channels as on the screenshots. Set Django Integration\'s password
    to *my-password*.

![image](/gfx/progguide/clients/django-flask/django-create-security.png)

![image](/gfx/progguide/clients/django-flask/django-create-channel.png)

![image](/gfx/progguide/clients/django-flask/django-create-channel2.png)

-   A sample Django project is available on GitHub - <https://github.com/zatosource/zato-django-integration>.

-   To set it up locally, execute the commands below. This will clone the repository, install everything under
    [virtualenv](https://virtualenv.pypa.io/en/latest/) and run a Django development server on <http://localhost:8188/>

    ``` {.bash}
    $ git clone https://github.com/zatosource/zato-django-integration.git
    $ cd zato-django-integration
    $ make
    ```

-   Open <http://localhost:8188/> in a browser

-   Enter any string that will serve as an ID of a customer whose name to return

-   You can also pick whether to use [AnyServiceInvoker \<progguide-clients-python-AnyServiceInvoker\>] or
    [JSONClient \<./python\>] for calling Zato - either way the result will be the same.

![image](/gfx/progguide/clients/django-flask/django-result.png)

Discussion:

-   The project depends on
    [zato-client](https://pypi.python.org/pypi/zato-client)
    and
    [zato-common](https://pypi.python.org/pypi/zato-common)
    as expressed in its
    [requirements.txt](https://github.com/zatosource/zato-django-integration/blob/master/requirements.txt)

    -Python projects can add them to their
    [pip](https://pypi.python.org/pypi/pip),
    [buildout](https://pypi.python.org/pypi/zc.buildout/2.3.1)
    or
    [conda](http://conda.pydata.org/)
    dependencies to start using AnyServiceInvoker and JSONClient.

-   Both clients need credentials and URLs to connect to - here, they are stored in
    [settings.py](https://github.com/zatosource/zato-django-integration/blob/master/sampleapp/settings.py#L145)

-   The clients are added to each Django request in a [custom middleware](https://github.com/zatosource/zato-django-integration/blob/master/sampleapp/middleware.py)

``` {.bash}
# Skip imports
# ..

client_any = AnyServiceInvoker(CLIENT_ADDRESS, CLIENT_PATH_ANY, CLIENT_CREDENTIALS)
client_json = JSONClient(CLIENT_ADDRESS, CLIENT_PATH_JSON, CLIENT_CREDENTIALS)

class ZatoMiddleware(object):
    def process_request(self, req):
        req.client_any = client_any
        req.client_json = client_json
```

-   Both AnyServiceInvoker and JSONClient are stateless, they don\'t keep any state around. It\'s also cheap to create them
    on fly, they don\'t need to be instantiated upfront but doing it won\'t cause any harm either.
-   How Django [views](https://github.com/zatosource/zato-django-integration/blob/master/sampleapp/customer/views.py)
    call Zato depend on whether they use AnyServiceInvoker or JSONClient. When using the former
    the name of the target service needs to be provided on input in addition to the actual request. With the latter, only the
    request is needed. Regardless of which client is used the response is returned the same way.

``` {.bash}
if client_type == 'AnyServiceInvoker':
    response = req.client_any.invoke('customer.get1', request)
else:
    response = req.client_json.invoke(request)
```

-   No matter which client is used requests and responses can always be regular Python dicts - if any serialization is needed,
    the client performs it itself.

Flask
=====

Steps:

-   Make sure both
    [customer.get1](https://gist.github.com/dsuch/2211f5960d68c03e4621)
    and
    [customer.get2](https://gist.github.com/dsuch/3fe0b42d73ff2f9aed81)
    are deployed
-   Create HTTP Basic Auth credentials and two Plain HTTP channels as on the screenshots. Set Flask Integration\'s password
    to *my-password*.

![image](/gfx/progguide/clients/django-flask/flask-create-security.png)

![image](/gfx/progguide/clients/django-flask/flask-create-channel.png)

![image](/gfx/progguide/clients/django-flask/flask-create-channel2.png)

-   A sample Flask project is available on GitHub - <https://github.com/zatosource/zato-flask-integration>.

-   To set it up locally, execute the commands below. This will clone the repository, install everything under
    [virtualenv](https://virtualenv.pypa.io/en/latest/) and run a Django development server on <http://localhost:8199/>

    ``` {.bash}
    $ git clone https://github.com/zatosource/zato-flask-integration.git
    $ cd zato-flask-integration
    $ make
    ```

-   Open <http://localhost:8199/> in a browser

-   Enter any string that will serve as an ID of a customer whose name to return

-   You can also pick whether to use [AnyServiceInvoker \<progguide-clients-python-AnyServiceInvoker\>] or
    [JSONClient \<./python\>] for calling Zato - either way the result will be the same.

![image](/gfx/progguide/clients/django-flask/flask-result.png)

Discussion:

-   The project depends on
    [zato-client](https://pypi.python.org/pypi/zato-client)
    and
    [zato-common](https://pypi.python.org/pypi/zato-common)
    as expressed in
    [its requirements.txt](https://github.com/zatosource/zato-flask-integration/blob/master/requirements.txt)

    -Python projects can add them to their
    [pip](https://pypi.python.org/pypi/pip),
    [buildout](https://pypi.python.org/pypi/zc.buildout/2.3.1)
    or
    [conda](http://conda.pydata.org/)
    dependencies to start using AnyServiceInvoker and JSONClient.

-   Both clients need credentials and URLs to connect to - here, they are stored in
    [the same module the main application is in](https://github.com/zatosource/zato-flask-integration/blob/master/sampleapp/customer.py#L42)

-   The clients are created upfront in the main module

``` {.bash}
# Skip imports
# ..

client_any = AnyServiceInvoker(CLIENT_ADDRESS, CLIENT_PATH_ANY, CLIENT_CREDENTIALS)
client_json = JSONClient(CLIENT_ADDRESS, CLIENT_PATH_JSON, CLIENT_CREDENTIALS)
```

-   Both AnyServiceInvoker and JSONClient are stateless, they don\'t keep any state around. They can be simply created once and used
    when needed.
-   How Flask
    [calls Zato](https://github.com/zatosource/zato-flask-integration/blob/master/sampleapp/customer.py#L74)
    depends on whether AnyServiceInvoker or JSONClient is used. With the former
    the name of the target service needs to be provided on input in addition to the actual request. With the latter, only the
    request is needed. Regardless of which client is used the response is returned the same way.

``` {.bash}
if client_type == 'AnyServiceInvoker':
    response = client_any.invoke('customer.get1', zato_request)
else:
    response = client_json.invoke(zato_request)
```

-   No matter which client is used requests and responses can always be regular Python dicts - if any serialization is needed,
    the client performs it itself.

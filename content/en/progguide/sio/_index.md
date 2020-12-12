---
title: SimpleIO (SIO)
---

SimpleIO (SIO) is a feature of Zato that allows one to develop services in a way
that is reusable across multiple data formats and transports.

That is, a service can be written once but it is still possible to expose it, for instance, via XML
through AMQP, and via JSON over HTTP, all from the single source code without
any programming needed.

Once a service has been deployed, no code changes nor restarts are needed to make it
available over various access methods.

An SIO service is one which has an inner class named **SimpleIO** that conforms to a certain
API. Here is an example:

``` {.python}
from zato.server.service import Service

class MyService(Service):

    class SimpleIO:
        input  = 'name', 'type'
        output = 'is_allowed'

    def get_data(self):
        if self.request.input.name == 'Wendy' and self.request.input.type == 'AXC':
            return True

    def handle(self):
        self.response.payload.is_allowed = self.get_data()
```

Save it in an sio_example.py file, [hot-deploy\<../../admin/guide/installing-services\>] it
and new channels for the service can be added immediately now - each independent and possibly using
a different data format without influencing any other channel using the same service.

Features
========

-   Lets one program API integrations in a more high-level, abstract way, without having to deal
    with protocol or data format-level matters
-   Automatically parses incoming messages to validate and build developer-friendly input objects
-   Can use JSON, HTTP POST/GET, XML, SOAP and CSV over various channels
-   Can be used to generate API documentation in OpenAPI and WSDL formats

Details
=======

Each chapter is concerned with a particular aspect of SIO.

+----------------------------------+----------------------------------+
| Chapter                          | Notes                            |
+==================================+==================================+
| Quick tutorial                   | A brief introduction to SimpleIO |
|                                  | - creates a new service and      |
|                                  | exposes                          |
|                                  | it through a few independent     |
|                                  | channels, each with its own data |
|                                  | format without any changes to    |
|                                  | code                             |
+----------------------------------+----------------------------------+
| [How to declare input and output | o declare a service\'s input and |
| \<./declare\>] How t | output parameters in an          |
|                                  | idiomatic way                    |
+----------------------------------+----------------------------------+
| [Understanding SimpleIO data     | > is a range of SIO data types,  |
| types                            | > each with its own options,     |
| \                                |                                  |
| <./datatype/index\>] | all of them documented in this   |
| There                            | chapter                          |
+----------------------------------+----------------------------------+
| I/O data formats available       | Each SIO service can accept and  |
|                                  | produce messages in several      |
|                                  | formats,                         |
|                                  | all of which are documented here |
+----------------------------------+----------------------------------+
| [Configuration files             | > of SIO are configurable -      |
| \<./config/index\>]  | > learn more about the options   |
| Parts                            |                                  |
|                                  | available                        |
+----------------------------------+----------------------------------+
| Generating API documentation     | An SIO service can be            |
|                                  | automatically exposed via        |
|                                  | OpenAPI or WSDL,                 |
|                                  | learn the details in this        |
|                                  | chapter                          |
+----------------------------------+----------------------------------+
| Usage example for various data   | [JSON                            |
| formats and channels             | \<./example/json\>], |
|                                  | [XML                             |
|                                  | \<./example/xml\>],  |
|                                  | [SOAP                            |
|                                  | \<./example/soap\>], |
|                                  | [CSV                             |
|                                  | \<./example/csv\>],  |
|                                  | [POST                            |
|                                  | \<./example/post\>]  |
+----------------------------------+----------------------------------+

Changelog
=========

+---------+-----------------------------------------------------------+
| Version | Notes                                                     |
+=========+===========================================================+
| 3.2     | -   Redesigned and rewritten in Cython                    |
|         | -   Added many new attributes and options while retaining |
|         |     backward compatibility                                |
+---------+-----------------------------------------------------------+
| 3.0     | Introduced simple-io.conf                                 |
|         | to keep built-in and custom SimpleIO configuration in     |
|         |                                                           |
|         | Added new types:                                          |
|         |                                                           |
|         | -   Date                                                  |
|         | -   DateTime                                              |
|         |                                                           |
|         | Added new options:                                        |
|         |                                                           |
|         | -   skip_empty_keys                                       |
|         | -   force_empty_keys                                      |
+---------+-----------------------------------------------------------+
| 2.0     | Added new types:                                          |
|         |                                                           |
|         | -   CSV                                                   |
|         | -   Dict                                                  |
|         | -   Float                                                 |
|         | -   List                                                  |
|         | -   ListOfDicts                                           |
|         | -   Opaque                                                |
+---------+-----------------------------------------------------------+
| 1.0     | Added initially                                           |
+---------+-----------------------------------------------------------+

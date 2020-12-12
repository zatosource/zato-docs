---
title: JSON adapter
---

Invoking external endpoints using JSON is a common activity hence a dedicated JSON adapter, a utility service one\'s own services
can subclass, makes the effort even easier than with regular services.

Adapter services are intended to use either as pass-through proxy ones or as part of a deeper layer other services invoke, i.e.
unless they are proxies, they won\'t be typically mounted on HTTP channels.

After subclassing
[zato.server.service.adapter.JSONAdapter](https://github.com/zatosource/zato/blob/support/2.0/code/zato-server/src/zato/server/service/adapter.py)
it\'s possible to configure the service in a declarative manner, without a need to implement the
[handle \<progguide-write-service-handle\>] method.

The two required attributes a adapter needs to configure are *outconn* and *method* indicating which
[outgoing HTTP connection \<../../web-admin/outgoing/plain-http\>] to use and what the HTTP verb is.

A service such as the one below will use [self.request.payload \<../reqresp/index\>] as input to be *POST*-ed to the outgoing connection called
*billing.eai9*.

``` {.python}
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function, unicode_literals

from zato.server.service.adapter import JSONAdapter

class SetBillingInfo(JSONAdapter):
    """ Updates a customer's billing information.
    """
    outconn = 'billing.eai9'
    method = 'POST'
```

The following table lists all the configuration parameters.

  Name             Required   Default value Notes   
  ---------------- ---------- --------------------- ---------------------------------------------------------------------------------------------------------------------------------
  outconn          Yes        (None)                Name of an [outgoing HTTP connection \<../../web-admin/outgoing/plain-http\>] to use
  method           Yes        (None)                HTTP method to invoke the external resource with
  params_to_qs     \--        False                 Whether parameters from self.request.payload should form the query string or not
  force_in_qs      \--        \[\]                  A list of parameters that will always be placed in the query string even if params_to_qs is False
  load_response    \--        True                  Whether the response from the endpoint should be automatically deserialized into a Python object, such as a dictionary
  params           \--        {}                    A dictionary of additional parameters to use when building a request to the endpoint in addition to what has
                                                    been obtained from self.request.payload
  apply_params     \--        APPLY_AFTER_REQUEST   Must be either
                                                    APPLY_AFTER_REQUEST
                                                    or
                                                    APPLY_BEFORE_REQEUST
                                                    from
                                                    [zato.common.ADAPTER_PARAMS](https://github.com/zatosource/zato/blob/support/2.0/code/zato-common/src/zato/common/__init__.py).
                                                    If the former, self.params will take precedence over self.request.payload. The other way around if the latter.
  raise_error_on   \--        \[\'4\', \'5\'\]      A list of prefixes of status codes returned from the endpoint which will make the adapter raise
                                                    a [zato.common.HTTPException](https://github.com/zatosource/zato/blob/support/2.0/code/zato-common/src/zato/common/__init__.py)

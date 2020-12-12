---
title: SimpleIO data types reference
---

-   Each element in a [SimpleIO (SIO) definition \<../index\>] has a specific data type
-   All data types can be imported from the **zato.server.service** package, e.g.:

``` {.python}
from zato.server.service import AsIs, List
```

-   Unless it is overridden, the **data type** of an SIO element implictly **defaults to Text**
-   Various **convenience prefixes and suffixes** can be used by idiomatic declarations -read the [full documentation here\<./conv\>]

SIO data types available
========================

The table below contains all the SIO data types available along with a brief description for each. The following
sections document each in detail.

  Data type                                                Notes
  -------------------------------------------------------- -------------------------------------------------------------------------------------------
  [AsIs \<sio-datatype-asis\>] A pas           sthrough element which ensures that the service receives data exactly as it was sent,
                                                           without any conversions by Zato. It is useful in case where the automatic data type
                                                           conversion is not required, e.g. by default an element named is_active would be converted
                                                           to a boolean value but AsIs(\'is_active\') will indicate that no conversion should be
                                                           attempted.
  [Bool \<sio-datatype-bool\>] Conve           rts input data to a Python bool instance.
  [CSV \<sio-datatype-csv\>] Expec             ts for input data to be a comma-separated list and converts it to a Python list.
  [Date \<sio-datatype-date\>] Conve           rts input data to a datetime.date instance.
  [DateTime \<sio-datatype-datetime\>] Conve   rts input data to a datetime.datetime instance.
  [Decimal \<sio-datatype-decimal\>] Conve     rts input data to a decimal.Decimal instance.
  [Dict \<sio-datatype-dict\>] Conve           rts input data to a Python dict object.
  [DictList \<sio-datatype-dictlist\>] Conve   rts input data to a Python list of dict objects.
  [Float \<sio-datatype-float\>] Conve         rts input data to a Python float object.
  [Int \<sio-datatype-int\>] Conve             rts input data to a Python int object.
  [List \<sio-datatype-list\>] Conve           rts input data to a Python list instance.
  [Text \<sio-datatype-text\>] Conve           rts input data to a Python string (Unicode) object.
  [UUID \<sio-datatype-uuid\>] Conve           rts input data to a Python uuid.UUID4 object.

AsIs {#sio-datatype-asis}
----

Can be used with: JSON, XML/SOAP, CSV and POST

Elements of type AsIs are used to indicate that Zato should not convert input data in any way, e.g.,
to override default conversions through suffixes and prefixes.

For instance, in the definition below, values of user_id would be by default converted to integers by Zato
because the element ends in \_id which triggers automatic conversion per the [the default configuration\<./conv\>] ..

``` {.python}
class SimpleIO:
    input = 'user_id'
```

.. however, if user IDs are non-numeric then this would result in a conversion error whereas with AsIs,
no conversion will be carried out:

``` {.python}
class SimpleIO:
    input = AsIs('user_id')
```

Bool {#sio-datatype-bool}
----

Can be used with: JSON, XML/SOAP, CSV and POST

Converts input data to Python bool instances - True, False - based on following values, respectively:

-   \'true\', \'yes\', \'on\', \'y\', \'t\', \'1\'
-   \'false\', \'no\', \'off\', \'n\', \'f\', \'0\'

CSV {#sio-datatype-csv}
---

Can be used with: JSON, XML/SOAP and POST

Converts input comma-separated data to a list of string elements. For instance ..

``` {.python}
class SimpleIO:
    input = CSV('my_data')
```

.. if \'my_data\' is given the value of \'myuser,my_display_name,1997,off\' then the service will received a list of
the following strings on input in self.request.input.my_data: \[\'myuser\', \'my_display_name\', \'1997\', \'off\'\].

Date {#sio-datatype-date}
----

Can be used with: JSON, XML/SOAP, CSV and POST

Converts an input string to a Python\'s built-in [datetime.date](https://docs.python.org/3/library/datetime.html#date-objects)
instance. Input must have an unambiguous format, such as YYYY-MM-DD, otherwise conversion may have an undefined result,
e.g. if input is 12/12/12 it is not clear which of the elements is year, month or day.

DateTime {#sio-datatype-datetime}
--------

Can be used with: JSON, XML/SOAP, CSV and POST

Like Date but converts to [datetime.datetime](https://docs.python.org/3/library/datetime.html#datetime-objects) objects.

Decimal {#sio-datatype-decimal}
-------

Can be used with: JSON, XML/SOAP, CSV and POST

Converts an input string to a Python\'s built-in [decimal.Decimal](https://docs.python.org/3/library/decimal.html)
instance.

Dict {#sio-datatype-dict}
----

Can be used with: JSON

Converts an input JSON dict to a Python dict, optionally validating the existence or lack of keys and sub-keys. Can embed
other SIO elements including other Dict ones.

If no keys are listed in the element\'s declaration, any and all JSON keys will be accepted.

For instance:

``` {.python}
class SimpleIO:
    input = Dict('user_data')
```

The above will convert user_data to a Python dict in self.request.input.user_data regardless of its form in JSON as long
it is a dict (hashmap).

If keys are provided explicitly, only what is provided in the declaration will exist in the service\'s input, e.g.

``` {.python}
class SimpleIO:
    input = Dict('user_data', 'username', 'display_name')
```

The above created a definition in which an input \'user_data\' dictionary must exist and it must contain two keys:
\'username\' and \'display_name\'. Any other input keys from user_data will be ignored.

Dict keys may point to other SimpleIO definitions:

``` {.python}
class SimpleIO:
    input = Dict('user_data', 'username', 'display_name', Dict('address', 'street', 'region'))
```

That definition has an embedded Dict object which expects a JSON sub-dict under key \'address\' with keys \'street\' and \'region\',
such as below:

``` {.json}
{
  "user_data": {
    "username": "my_name",
    "display_name": "My Display Name",
    "address": {
      "street": "My Street",
      "region": "My Region"
    }
  }
}
```

DictList {#sio-datatype-dictlist}
--------

Can be used with: JSON

Works exactly like Dict but expects a JSON list od dictionaries (hashmaps) on input. Otherwise, everything that applies
to Dict applies to DictList as well.

Float {#sio-datatype-float}
-----

Can be used with: JSON, XML/SOAP, CSV and POST

Converts input data to Python float instances.

Int {#sio-datatype-int}
---

Can be used with: JSON, XML/SOAP, CSV and POST

Converts input data to Python int instances.

List {#sio-datatype-list}
----

Can be used with: JSON

Converts input data to Python list instances. Does not check the contents of the input list - if this is required,
use [Dict elements \<sio-datatype-dict\>].

Text {#sio-datatype-text}
----

Can be used with: JSON, XML/SOAP, CSV and POST

UUID {#sio-datatype-uuid}
----

Can be used with: JSON, XML/SOAP, CSV and POST

Converts input data to Python\'s built-in [uuid.UUID4](https://docs.python.org/3/library/uuid.html) instances.

SIO data types and data formats
===============================

The following table contains information which SIO data types are available for which data format. With JSON,
it is possible to use all of the SIO data types whereas other data formats cannot make use of container-like
data types.

A runtime exception will be raised if a service has an SIO definition over a channel whose data format that is incompatible,
e.g. if a CSV document is sent to a service whose SIO definition contains a DictList element, this will result
in an exception.

  Data type   JSON   XML/SOAP   CSV     POST
  ----------- ------ ---------- ------- -------
  AsIs        Yes    Yes        Yes     Yes
  Bool        Yes    Yes        Yes     Yes
  CSV         Yes    Yes        \-\--   Yes
  Date        Yes    Yes        Yes     Yes
  DateTime    Yes    Yes        Yes     Yes
  Decimal     Yes    Yes        Yes     Yes
  Dict        Yes    \-\--      \-\--   \-\--
  DictList    Yes    \-\--      \-\--   \-\--
  Float       Yes    Yes        Yes     Yes
  Int         Yes    Yes        Yes     Yes
  List        Yes    \-\--      \-\--   \-\--
  Text        Yes    Yes        Yes     Yes
  UUID        Yes    Yes        Yes     Yes

Convenience prefixes and suffixes
=================================

To make one\'s source code use less imports and declarations use fewer explicit SIO data types,
it is possible to apply [convenience prefixes and suffixes \<./conv\>].

For instance, both of the definitions below are equivalent, yet the first one is more convenient to read:

``` {.python}
class SimpleIO:
    input = 'user_id', 'is_active', 'has_account'
```

``` {.python}
class SimpleIO:
    input = Int('user_id'), Bool('is_active'), Bool('has_account')
```

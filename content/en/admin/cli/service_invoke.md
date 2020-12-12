---
title: zato service invoke
---

Overview
========

Invokes a service by its name through HTTP.

The command connects to ODB the server
pointed to by path uses and finds an HTTP channel and credentials matching the \--url-path.

The channel is invoked and response is printed out.
Passing \--verbose flag in allows to return additional details regarding the response.

If a service produces no response, \'(None)\' will be returned.

When using the command to invoke other services it\'s important to remember that
overhead of connecting to ODB, looking up channels and accessing the service
indirectly through the service invoker may be non-negligible. Hence the command
is meant to be a means to help out in debugging but is a poor candidate to measure
the performance of Zato services.

If executing a service in async mode, its response will be a CID it\'s been invoked with.

Command-specific parameters
===========================

+----------------------+----------------------+----------------------+
| Name                 | Description          | Example value        |
+======================+======================+======================+
| \--payload           | Payload to invoke    | \'{\"hello\":        |
|                      | the service with     | \"world\"}\'         |
+----------------------+----------------------+----------------------+
| \--headers           | Additional HTTP      | x-                   |
|                      | headers the service  | my-header1=myvalue1; |
| \--channel           | invoker              | x                    |
|                      | will receive in      | -my-header2=myvalue2 |
|                      | format of            |                      |
|                      | heade                | amqp                 |
|                      | r-name=header-value; |                      |
|                      | header               |                      |
|                      | 2-name=header2-value |                      |
|                      | Channel the service  |                      |
|                      | will be invoked      |                      |
|                      | through,             |                      |
|                      | default is           |                      |
|                      | \'invoke\'           |                      |
+----------------------+----------------------+----------------------+
| \--data-format       | Payload\'s data      | json                 |
| \--transport         | format, default is   |                      |
| \--url-path          | \'json\'             | 3                    |
| \--max-cid-repr      | Transport to invoke  |                      |
|                      | the service over     | 100                  |
| \--max-response-repr | URL path             |                      |
|                      | zato.service.invoke  |                      |
|                      | is exposed on        |                      |
|                      | How many characters  |                      |
|                      | of each end of a CID |                      |
|                      | to print out in      |                      |
|                      | verbose mode,        |                      |
|                      | default is 5         |                      |
|                      | How many characters  |                      |
|                      | of a response to     |                      |
|                      | print out in verbose |                      |
|                      | mode,                |                      |
|                      | default is 2500      |                      |
+----------------------+----------------------+----------------------+
| \--async             | Whether the service  | (None needed, simply |
| \--expiration        | should be executed   | specify the flag on  |
|                      | asynchronously       | command line)        |
|                      | If running in async  |                      |
|                      | mode, after how many | 6                    |
|                      | seconds the message  |                      |
|                      | published should     |                      |
|                      | expire, default is   |                      |
|                      | 15 seconds           |                      |
+----------------------+----------------------+----------------------+
| path                 | Path in the          | /opt/zato/server1    |
|                      | file-system to a     |                      |
|                      | server the service   |                      |
|                      | is deployed on       |                      |
+----------------------+----------------------+----------------------+
| name                 | Name of the service  | zato.                |
|                      | to invoke            | helpers.input-logger |
+----------------------+----------------------+----------------------+

Usage
=====

Note that the last response below has been slightly reformatted to improve clarity.

    zato service invoke [-h] [--store-log] [--verbose] [--store-config]
       [--payload PAYLOAD] [--headers HEADERS]
       [--channel CHANNEL] [--data-format DATA_FORMAT]
       [--transport TRANSPORT] [--url-path URL_PATH]
       [--max-cid-repr MAX_CID_REPR]
       [--max-response-repr MAX_RESPONSE_REPR]
       path name

    $ zato service invoke /opt/zato/server1/ zato.ping
    {u'pong': u'zato'}
    $

    $ zato service invoke /opt/zato/server1/ zato.ping --async
    K298080271471437690854141990651800989926
    $

    $ zato service invoke /opt/zato/server1/ zato.ping --verbose
    {u'pong': u'zato'}
    inner.text:[{"zato_env": {"details": "", "result": "ZATO_OK",
        "cid": "K057707985647839287036685825810024772962"},
        "zato_service_invoke_response": {"response":
    "eyJ6YXRvX3BpbmdfcmVzcG9uc2UiOiB7InBvbmciOiAiemF0byJ9fQ==\n"}}]
    response:[<ServiceInvokeResponse at 0x26cb7d0 ok:[True] inner.status_code:[200]
        cid:[K0577..72962], inner.text:[{"zato_env": {"details": "", "result": "ZATO_OK",
        "cid": "K057707985647839287036685825810024772962"}, "zato_service_invoke_response":
    {"response": "eyJ6YXRvX3BpbmdfcmVzcG9uc2UiOiB7InBvbmciOiAiemF0byJ9fQ==\n"}}]>]
    $

Changelog
=========

  Version   Notes
  --------- -----------------
  1.0       Added initially

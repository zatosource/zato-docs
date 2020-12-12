---
title: Programming examples
---

Subsequent chapters present how a typical code to perform a given operation,
such as manipulating JSON or XML, will look like. It is assumed the reader has already
completed
[the tutorial \<../../tutorial/01\>],
is familiar with Zato\'s
[architecture \<../../architecture/overview\>]
and read about
[channels \<../channels\>]
and
[outgoing connections \<../outconn/overview\>] - concepts explained in these chapters are not repeated here.

+----------------------------------+----------------------------------+
| Topic                            | Examples                         |
+==================================+==================================+
| [HTTP (REST)                     | posing a service over HTTP       |
| \<./http\>] \* \`Ex  | \<pro                            |
|                                  | gguide-examples-http-exposing\>[ |
|                                  | \* \`Accessing raw request       |
|                                  | \<progguide-examples             |
|                                  | -http-raw-request\>] |
|                                  | \* [Accessing request headers    |
|                                  | \<progguide-examples-htt         |
|                                  | p-request-headers\>] |
|                                  | \* [Accessing request URL query  |
|                                  | parameters                       |
|                                  | \<progguide-examples-http        |
|                                  | -access-url-query\>] |
|                                  | \* [Setting response headers     |
|                                  | \<progguide-examples-http        |
|                                  | -response-headers\>] |
|                                  | \* [Setting content type and     |
|                                  | status code                      |
|                                  | \                                |
|                                  | <progguide-examples-http-content |
|                                  | -type-status-code\>] |
|                                  | \* [Returning attachments        |
|                                  | \<progguide-examples             |
|                                  | -http-attachments\>] |
|                                  | \* REST services and connections |
|                                  | - documented in their own        |
|                                  | chapters:                        |
|                                  |                                  |
|                                  | > -   [Services                  |
|                                  | >     \                          |
|                                  | <../rest/services\>] |
|                                  | > -   [Channels                  |
|                                  | >     \                          |
|                                  | <../rest/channels\>] |
|                                  | > -   [Outgoing connections      |
|                                  | >     \                          |
|                                  | <../rest/outconns\>] |
|                                  | > -   [JSON adapter              |
|                                  | >     \<../                      |
|                                  | rest/json-adapter\>] |
+----------------------------------+----------------------------------+
| [SimpleIO (SIO)                  | king a service accept and return |
| \<./sio\>] \* \`Ma   | JSON/XML/SOAP                    |
|                                  | \<pr                             |
|                                  | ogguide-examples-sio-service\>\` |
+----------------------------------+----------------------------------+
| [JSON \<./json\>] \* | cessing JSON request             |
| \`Ac                             | \<pr                             |
|                                  | ogguide-examples-json-request\>[ |
|                                  | \* \`Converting JSON to Bunch    |
|                                  | \<progguide-ex                   |
|                                  | amples-json-bunch\>] |
|                                  | \* [Returning JSON               |
|                                  | \<progguide-exampl               |
|                                  | es-json-responses\>] |
|                                  | \* [Invoking a JSON service      |
|                                  | using GET                        |
|                                  | \<progguide-examples-            |
|                                  | json-invoking-get\>] |
|                                  | \* [Invoking a JSON service      |
|                                  | using POST                       |
|                                  | \<progguide-examples-j           |
|                                  | son-invoking-post\>] |
+----------------------------------+----------------------------------+
| [XML \<./xml\>] \*   | cessing XML request              |
| \`Ac                             | \<p                              |
|                                  | rogguide-examples-xml-request\>[ |
|                                  | \* \`Creating responses          |
|                                  | \<progguide-examp                |
|                                  | les-xml-responses\>] |
|                                  | \* [Invoking an XML              |
|                                  | service\<progguide-exam          |
|                                  | ples-xml-invoking\>] |
+----------------------------------+----------------------------------+
| [SOAP \<./soap\>] \* | cessing SOAP request             |
| \`Ac                             | \<pr                             |
|                                  | ogguide-examples-soap-request\>[ |
|                                  | \* \`Creating responses          |
|                                  | \<progguide-examp                |
|                                  | les-soap-response\>] |
|                                  | \* [Invoking a SOAP service      |
|                                  | (from WSDL)                      |
|                                  | \<progguide-examples-s           |
|                                  | oap-invoking-wsdl\>] |
|                                  | \* [Invoking a SOAP service (no  |
|                                  | WSDL)                            |
|                                  | \<progguide-examples-soap        |
|                                  | -invoking-no-wsdl\>] |
+----------------------------------+----------------------------------+
| [CSV \<./csv\>] \*   | ading CSV on input               |
| \`Re                             | \<p                              |
|                                  | rogguide-examples-csv-request\>[ |
|                                  | \* \`Producing CSV               |
|                                  | \<progguide-exam                 |
|                                  | ples-csv-response\>] |
+----------------------------------+----------------------------------+
| [Other data formats              | ading arbitrary data formats     |
| \<./other-formats\>] | \<progguide-e                    |
| \* \`Re                          | xamples-other-formats-reading\>[ |
|                                  | \* \`Accessing BASE64-encoded    |
|                                  | data                             |
|                                  | \<progguide-examples-oth         |
|                                  | er-formats-base64\>] |
+----------------------------------+----------------------------------+
| [AMQP \<./amqp\>] \* | ceiving messages from queues     |
| \`Re                             | \<prog                           |
|                                  | guide-examples-amqp-receiving\>[ |
|                                  | \* \`Sending messages to         |
|                                  | exchanges                        |
|                                  | \<progguide-exam                 |
|                                  | ples-amqp-sending\>] |
+----------------------------------+----------------------------------+
| [FTP \<./ftp\>] \*   | tting files on server            |
| \`Pu                             | \<p                              |
|                                  | rogguide-examples-ftp-putting\>[ |
|                                  | \* \`Listing directories         |
|                                  | \<progguide-exa                  |
|                                  | mples-ftp-listing\>] |
|                                  | \* [Reading files                |
|                                  | \<progguide-exa                  |
|                                  | mples-ftp-reading\>] |
+----------------------------------+----------------------------------+
| [IBM MQ                          | ceiving messages from queues     |
| \<./jms-wmq\>] \*    | \<proggui                        |
| \`Re                             | de-examples-jms-wmq-receiving\>[ |
|                                  | \* \`Sending messages to queues  |
|                                  | \<progguide-example              |
|                                  | s-jms-wmq-sending\>] |
+----------------------------------+----------------------------------+
| [Redis \<./redis\>]  | mple keys                        |
| \* \`Si                          | \<proggui                        |
|                                  | de-examples-redis-simple-keys\>[ |
|                                  | \* \`Lists                       |
|                                  | \<progguide-exa                  |
|                                  | mples-redis-lists\>] |
|                                  | \* [Dictionaries (hashmaps)      |
|                                  | \<progguide-examples-r           |
|                                  | edis-dictionaries\>] |
|                                  | \* [Transactions                 |
|                                  | \<progguide-examples-r           |
|                                  | edis-transactions\>] |
+----------------------------------+----------------------------------+
| [Scheduler                       | voking services at predefined    |
| \<./scheduler\>] \*  | intervals                        |
| \`In                             | \<progguid                       |
|                                  | e-examples-scheduler-invoking\>[ |
|                                  | \* \`Scheduling jobs             |
|                                  | programmatically                 |
|                                  | \<p                              |
|                                  | rogguide-examples-zmq-scheduling |
|                                  | -programmatically\>] |
+----------------------------------+----------------------------------+
| [SQL \<./sql\>] \*   | suing raw SQL                    |
| \`Is                             | \<progguide-examples-sql-raw\>[  |
|                                  | \* \`SQLAlchemy                  |
|                                  | \<progguide-exampl               |
|                                  | es-sql-sqlalchemy\>] |
+----------------------------------+----------------------------------+
| [ZeroMQ \<./zmq\>]   | ceiving messages from sockets    |
| \* \`Re                          | \<pro                            |
|                                  | gguide-examples-zmq-receiving\>[ |
|                                  | \* \`Sending messages to sockets |
|                                  | \<progguide-exa                  |
|                                  | mples-zmq-sending\>] |
+----------------------------------+----------------------------------+
| [SMTP \<./smtp\>] \* | ding [regular e-mails            |
| Sen                              | \<progguide-exam                 |
|                                  | ples-smtp-regular\>] |
|                                  | \* Sending [HTML e-mails         |
|                                  | \<progguide-e                    |
|                                  | xamples-smtp-html\>] |
|                                  | \* Sending [e-mails with         |
|                                  | attachments                      |
|                                  | \<progguide-examples             |
|                                  | -smtp-attachments\>] |
+----------------------------------+----------------------------------+
| [IMAP \<./imap\>] \* | ceiving e-mails                  |
| \`Re                             | \<pr                             |
|                                  | ogguide-examples-imap-receive\>[ |
|                                  | \* \`Marking messages seen       |
|                                  | \<progguide-exampl               |
|                                  | es-imap-mark-seen\>] |
|                                  | \* [Deleting messages            |
|                                  | \<progguide-exa                  |
|                                  | mples-imap-delete\>] |
+----------------------------------+----------------------------------+
| [Amazon S3                       | eating key/value pairs in S3     |
| \<./cloud/aws/s3\>]  | buckets                          |
| \* \`Cr                          | \<progguide                      |
|                                  | -examples-cloud-aws-s3-create\>[ |
|                                  | \* \`Accessing Boto              |
|                                  | \<progguide-examples-            |
|                                  | cloud-aws-s3-boto\>] |
+----------------------------------+----------------------------------+
| [OpenStack Swift                 | oring data in containers         |
| \<./clou                         | \<progguide-example              |
| d/openstack/swift\>] | s-cloud-openstack-swift-store\>[ |
| \* \`St                          | \* \`Accessing the underlying    |
|                                  | library                          |
|                                  | \<progguide-e                    |
|                                  | xamples-cloud-lib\>] |
+----------------------------------+----------------------------------+
| [ElasticSearch                   | dexing                           |
| \<./search/es\>] \*  | \<progg                          |
| \`In                             | uide-examples-search-es-index\>[ |
|                                  | \* \`Searching                   |
|                                  | \<progguide-examples             |
|                                  | -search-es-search\>] |
|                                  | \* [Deleting                     |
|                                  | \<progguide-examples             |
|                                  | -search-es-delete\>] |
|                                  | \* [More features                |
|                                  | \<progguide-exampl               |
|                                  | es-search-es-more\>] |
+----------------------------------+----------------------------------+
| [Solr                            | dexing                           |
| \<./search/solr\>]   | \<proggui                        |
| \* \`In                          | de-examples-search-solr-index\>[ |
|                                  | \* \`Searching                   |
|                                  | \<progguide-examples-s           |
|                                  | earch-solr-search\>] |
|                                  | \* [Deleting                     |
|                                  | \<progguide-examples-s           |
|                                  | earch-solr-delete\>] |
|                                  | \* [More features                |
|                                  | \<progguide-examples             |
|                                  | -search-solr-more\>] |
+----------------------------------+----------------------------------+
| [Odoo (OpenERP)                  | suing requests                   |
| \<./odoo\>] \* \`Is  | \                                |
|                                  | <progguide-examples-odoo-req\>\` |
+----------------------------------+----------------------------------+
| [JSON Pointers                   | aluating expressions             |
| \<./json-pointer\>]  | \<progguid                       |
| \* \`Ev                          | e-examples-json-pointer-expr\>\` |
+----------------------------------+----------------------------------+
| [XPath \<./xpath\>]  | aluating expressions             |
| \* \`Ev                          | \<p                              |
|                                  | rogguide-examples-xpath-expr\>\` |
+----------------------------------+----------------------------------+

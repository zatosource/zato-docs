---
title: zato quickstart create
---

Overview
========

Quickly creates a Zato cluster. Sets up a
[Certificate Authority (CA)](../../architecture/ca),
[web admin](../../architecture/web-admin),
a [load-balancer](../../architecture/load-balancer),
and [Zato servers](../../architecture/servers). This is a great way to get
started with Zato as its creates everything that is needed to familiarize yourself
with how a complete Zato environment looks like.

Before running the command, make sure the following are up and running

-   A Redis database
-   (Optionally) An SQL database, either MySQL, PostgreSQL or Oracle.
    SQLite can also be used and as such doesn\'t require any set-up.

On a successful completion, the following environment will be created:

-   [ODB objects](../../architecture/sql-odb), if they didn\'t already exist
-   A Certificate Authority
-   web admin running on <http://localhost:8183>
-   A load-balancer accepting HTTP connections on <http://localhost:11223>
-   A load-balancer\'s agent accepting XML-RPC requests on <https://localhost:20151>
-   Server \'server1\' accepting HTTP connection on <http://localhost:17010>
-   Server \'server2\' accepting HTTP connection on <http://localhost:17011>
-   Scripts to start, stop and restart the whole environment

```{=html}
<!-- -->
```
    path/
    ├── ca
    ├── load-balancer
    ├── server1
    ├── server2
    ├── web-admin
    ├── zato-qs-restart.sh
    ├── zato-qs-start.sh
    └── zato-qs-stop.sh

The CA will generate crypto certificates and all the components will be configured
to make use of them.

The web admin\'s user to log in with is \'admin\' and its randomly generated human-readable
password will be printed out to screen (such as *ohch-igor-tita-marc* in a usage example below).

Note that a new admin user will not be created if one already exists in the ODB, for instance,
if there\'s already been a quickstart cluster created using the ODB connection parameters
provided. In such case, you should use the already existing admin credentials for
connecting to the new cluster\'s web admin console. Tip: use the [zato update password ](./update-password)
command if you don\'t remember the password.

Any passwords asked for will not be echoed.

Command-specific parameters
===========================

  Name                   Description                                                                       Example value
  ---------------------- --------------------------------------------------------------------------------- ---------------------
  path                   An empty directory to install the environment to                                  \~/zato/quickstart1
  odb_type               ODB type, must be one of: \[\'mysql\', \'oracle\', \'postgresql\', \'sqlite\'\]   postgresql
  kvdb_host              Key/value DB host (Redis)                                                         localhost
  kvdb_port              Key/value DB port (Redis)                                                         6379
  \--odb_host            Host the ODB is running on                                                        localhost
  \--odb_port            Port the ODB is listening at                                                      5432
  \--odb_user            Username to connect to ODB with                                                   zato1
  \--odb_db_name         ODB database name                                                                 zatodb1
  \--postgresql_schema   PostgreSQL only: database schema to use                                           zato
  \--odb_password        ODB password, if any                                                              kf094z203mck2303
  \--kvdb_password       Key/value DB password (Redis), if any                                             s49344df2349ur4d
  \--cluster_name        Name to be given to the new cluster                                               testcluster1
  \--servers             Number of servers to be created                                                   2

Usage
=====

    $ zato quickstart create [-h] [--store-log] [--verbose] [--store-config]
        [--odb_host ODB_HOST] [--odb_port ODB_PORT]
        [--odb_user ODB_USER] [--odb_db_name ODB_DB_NAME]
        [--postgresql_schema POSTGRESQL_SCHEMA] [--odb_password ODB_PASSWORD]
        [--kvdb_password KVDB_PASSWORD] [--cluster_name CLUSTER_NAME]
        [--servers SERVERS]
        path odb_type kvdb_host kvdb_port

    $ zato quickstart create ~/esb/env3 sqlite localhost 6379 --verbose

    Key/value database password (will not be echoed):
    Enter the kvdb_password again (will not be echoed):
    [1/8] Certificate authority created
    [2/8] ODB schema created
    [3/8] ODB initial data created
    [4/8] server1 created
    [5/8] server2 created
    [6/8] Load-balancer created
    Superuser created successfully.
    [7/8] Web admin created
    [8/8] Management scripts created
    Quickstart cluster quickstart-890665 created
    Web admin user:[admin], password:[ohch-igor-tita-marc]
    Start the cluster by issuing the /home/zato/env/env3/zato-qs-start.sh command
    Visit https://zato.io/support for more information and support options
    $

    $ zato quickstart create ~/esb/qs-4 postgresql localhost 6379 --verbose \
        --odb_host localhost --odb_port 5432 --odb_user zato1 --odb_db_name zato1

    ODB database password (will not be echoed):
    Enter the odb_password again (will not be echoed):

    Key/value database password (will not be echoed):
    Enter the kvdb_password again (will not be echoed):

    [1/8] Certificate authority created
    [2/8] ODB schema created
    [3/8] ODB initial data created
    [4/8] server1 created
    [5/8] server2 created
    [6/8] Load-balancer created
    Superuser created successfully.
    [7/8] Web admin created
    [8/8] Management scripts created
    Quickstart cluster quickstart-555016 created
    Web admin user:[admin], password:[esnd-adiu-mpst-epom]
    Start the cluster by issuing the /home/zato/esb/qs-4/zato-qs-start.sh command
    Visit https://zato.io/support for more information and support options
    $

Changelog
=========

+---------+-----------------------------------------------------------+
| Version | Notes                                                     |
+=========+===========================================================+
| 2.0     | -   Rearranged parameters slightly - in a backwards       |
|         |     incompatible way - to make the command work with      |
|         |     SQLite.                                               |
|         | -   Added *\--servers* and *\--cluster_name* parameters   |
+---------+-----------------------------------------------------------+
| 1.0     | Added initially                                           |
+---------+-----------------------------------------------------------+

---
title: zato create scheduler
---

Creates a new scheduler intsance - all the directories needed
by a scheduler and sets it up so it is ready to join a cluster. The directory pointed
to by *path* must already exist and be empty. *cluster_name* must be a name of
a cluster previously created using the [zato create cluster\<./create-cluster\>] command.

The command *does not* make the scheduler start its tasks immediately.
An administrator still needs to [start the scheduler \<./start\>] explicitly.s

Command-specific parameters
===========================

+----------------------+----------------------+----------------------+
| Name                 | Description          | Example value        |
+======================+======================+======================+
| \--postgresql_schema | PostgreSQL only:     | zato                 |
|                      | database schema to   |                      |
|                      | use                  |                      |
+----------------------+----------------------+----------------------+
| \--odb_password      | ODB password         | 2jFZtsCVS1Scc        |
+----------------------+----------------------+----------------------+
| \--kvdb_password     | Key/value DB         | 54vGc3rBHqkyA        |
|                      | password (Redis), if |                      |
|                      | any                  |                      |
+----------------------+----------------------+----------------------+
| \--secret_key        | (Reserved for future | \-\--                |
| \--cluster_id        | use)                 |                      |
|                      | ID of the cluster    | 1                    |
|                      | this scheduler will  |                      |
|                      | join. If provided,   |                      |
|                      | it                   |                      |
|                      | will take precedence |                      |
|                      | over cluster_name.   |                      |
+----------------------+----------------------+----------------------+
| path                 | An empty directory   | \~/prod3/scheduler/  |
|                      | to install the       |                      |
|                      | scheduler to         |                      |
+----------------------+----------------------+----------------------+
| odb_type             | ODB type, must be    | postgresql           |
|                      | one of: \[\'mysql\', |                      |
|                      | \'postgresql\',      |                      |
|                      | \'sqlite\'\]         |                      |
+----------------------+----------------------+----------------------+
| odb_host             | Host the ODB is      | localhost            |
|                      | running on           |                      |
+----------------------+----------------------+----------------------+
| odb_port             | Port the ODB is      | 5432                 |
|                      | listening at         |                      |
+----------------------+----------------------+----------------------+
| odb_user             | Username to connect  | zato1                |
|                      | to ODB with          |                      |
+----------------------+----------------------+----------------------+
| odb_db_name          | ODB database name    | zatodb1              |
+----------------------+----------------------+----------------------+
| kvdb_host            | Key/value DB host    | localhost            |
|                      | (Redis)              |                      |
+----------------------+----------------------+----------------------+
| kvdb_port            | Key/value DB port    | 6379                 |
|                      | (Redis)              |                      |
+----------------------+----------------------+----------------------+
| pub_key_path         | Path to a            | \~/crypto/za         |
|                      | PEM-encoded          | to.scheduler.pub.pem |
|                      | scheduler\'s public  |                      |
|                      | key                  |                      |
+----------------------+----------------------+----------------------+
| priv_key_path        | Path to a            | \~/crypto/zat        |
|                      | PEM-encoded          | o.scheduler.priv.pem |
|                      | scheduler\'s private |                      |
|                      | key                  |                      |
+----------------------+----------------------+----------------------+
| cert_path            | Path to a            | \~/crypto/zat        |
|                      | PEM-encoded          | o.scheduler.cert.pem |
|                      | scheduler\'s         |                      |
|                      | certificate          |                      |
+----------------------+----------------------+----------------------+
| ca_certs_path        | Path to a            | \                    |
|                      | PEM-encoded list of  | ~/crypto/ca-cert.pem |
|                      | CA certificates the  |                      |
|                      | scheduler            |                      |
|                      | is to trust          |                      |
+----------------------+----------------------+----------------------+
| cluster_name         | Name of the cluster  | PROD3                |
|                      | this scheduler will  |                      |
|                      | join                 |                      |
+----------------------+----------------------+----------------------+

Usage
=====

    $ zato create scheduler [-h] [--store-log] [--verbose] [--store-config]
                             [--odb_host ODB_HOST] [--odb_port ODB_PORT]
                             [--odb_user ODB_USER] [--odb_db_name ODB_DB_NAME]
                             [--postgresql_schema POSTGRESQL_SCHEMA]
                             [--odb_password ODB_PASSWORD]
                             [--kvdb_password KVDB_PASSWORD]
                             [--cluster_id CLUSTER_ID]
                             [--secret_key SECRET_KEY]
                             path {mysql,postgresql,sqlite} kvdb_host
                             kvdb_port pub_key_path priv_key_path cert_path
                             ca_certs_path cluster_name

    $ zato create scheduler ~/prod3/scheduler/ postgresql localhost 5432 zato1 zatodb1
        localhost 6379
        ~/crypto/zato.scheduler.pub.pem
        ~/crypto/zato.scheduler.priv.pem
        ~/crypto/zato.scheduler.cert.pem
        ~/crypto/ca-cert.pem
        PROD3

    ODB database password (will not echo):
    Odb_password again (will not echo):

    Key/value database password (will not echo):
    Kvdb_password again (will not echo):
    OK
    $

Changelog
=========

  Version   Notes
  --------- -----------------
  3.0       Added initially

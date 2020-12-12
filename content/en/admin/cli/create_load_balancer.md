---
title: zato create load_balancer
---

Creates a [load-balancer\<../../architecture/load-balancer\>]. The directory the load-balancer will be created in
must already exist and be empty.

Command-specific parameters
===========================

+---------------+-------------------------+-------------------------+
| Name          | Description             | Example value           |
+===============+=========================+=========================+
| path          | Path to an empty        | >                       |
|               | directory the           |  \~/dev3/load-balancer/ |
|               | load-balancer will be   |                         |
|               | installed in            |                         |
+---------------+-------------------------+-------------------------+
| pub_key_path  | Path to a PEM-encoded   | \~/cry                  |
|               | load-balancer agent\'s  | pto/zato.lbdev3.pub.pem |
|               | public key              |                         |
+---------------+-------------------------+-------------------------+
| priv_key_path | Path to a PEM-encoded   | \~/cryp                 |
|               | load-balancer agent\'s  | to/zato.lbdev3.cert.pem |
|               | private key             |                         |
+---------------+-------------------------+-------------------------+
| cert_path     | Path to a PEM-encoded   | \~/cryp                 |
|               | load-balancer agent\'s  | to/zato.lbdev3.cert.pem |
|               | certificate             |                         |
+---------------+-------------------------+-------------------------+
| ca_certs_path | Path to a PEM-encoded   | \~/crypto/ca-cert.pem   |
|               | list of CA certificates |                         |
|               | the load-balancer agent |                         |
|               | is to trust             |                         |
+---------------+-------------------------+-------------------------+

Usage
=====

    $ zato create load_balancer [-h] [--store-log] [--verbose] [--store-config]
        path pub_key_path priv_key_path cert_path ca_certs_path

    $ zato create load_balancer ~/dev3/load-balancer/ 
        ~/crypto/zato.lbdev3.pub.pem
        ~/crypto/zato.lbdev3.priv.pem
        ~/crypto/zato.lbdev3.cert.pem
        ~/crypto/ca-cert.pem 
    OK
    $

Changelog
=========

  Version   Notes
  --------- -----------------
  1.0       Added initially

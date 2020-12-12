---
title: Then JSON Pointer \"{path}\" is a list \"{value}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then JSON Pointer "{path}" is a list "{value}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"

        When the URL is invoked

        Then JSON Pointer "/list" is a list "a,b,c"

Discussion
==========

(None)

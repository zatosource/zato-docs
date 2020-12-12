---
title: Then JSON Pointer \"{path}\" isn\'t empty
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then JSON Pointer "{path}" isn't empty

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"

        When the URL is invoked

        Then JSON Pointer "/action/msg" isn't empty

Discussion
==========

(None)

---
title: Then response is equal to \"{expected}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then response is equal to "{expected}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json2"
        Given format "JSON"

        When the URL is invoked

        Then response is equal to "{"a":"b"}"

Discussion
==========

(None)

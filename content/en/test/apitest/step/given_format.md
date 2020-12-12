---
title: Given format \"{format}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given format "{format}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"

        When the URL is invoked

        Then status is "200"

Discussion
==========

Format must be either JSON or XML.

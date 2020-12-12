---
title: Given address \"{address}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given address "{address}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"

        When the URL is invoked

        Then status is "200"

Discussion
==========

(None)

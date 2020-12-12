---
title: Given user agent is \"{value}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given user agent is "{value}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"
        Given user agent is "My Application"

        When the URL is invoked

        Then status is "200"

Discussion
==========

(None)

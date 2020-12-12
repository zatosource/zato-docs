---
title: Given JSON Pointer \"{path}\" in request is a list \"{value}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Given JSON Pointer "{path}" in request is a list "{value}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"
        Given request is "{}"
        Given JSON Pointer "/a" in request is a list "a,b,c,d"

        When the URL is invoked

        Then status is "200"

Discussion
==========

(None)

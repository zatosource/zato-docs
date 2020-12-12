---
title: Then JSON Pointer \"{path}\" isn\'t one of \"{value}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then JSON Pointer "{path}" isn't one of "{value}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"

        When the URL is invoked

        Then JSON Pointer "/action/msg" isn't one of "a,b,c,d,e"

Discussion
==========

(None)

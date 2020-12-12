---
title: Then JSON Pointer \"{path}\" is an integer \"{value}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then JSON Pointer "{path}" is an integer "{value}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"

        When the URL is invoked

        Then JSON Pointer "/action/code" is an integer "0"

Discussion
==========

(None)

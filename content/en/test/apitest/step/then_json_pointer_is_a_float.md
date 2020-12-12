---
title: Then JSON Pointer \"{path}\" is a float \"{value}\"
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then JSON Pointer "{path}" is a float "{value}"

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/json"
        Given format "JSON"

        When the URL is invoked

        Then JSON Pointer "/float" is a float "3.7"

Discussion
==========

(None)

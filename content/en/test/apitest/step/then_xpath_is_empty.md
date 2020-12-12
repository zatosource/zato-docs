---
title: Then XPath \"{xpath}\" is empty
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then XPath "{xpath}" is empty

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/xml2"
        Given format "XML"
        Given request is "<req><howdy>foo</howdy></req>"

        When the URL is invoked

        Then XPath "//empty" is empty

Discussion
==========

(None)

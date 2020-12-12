---
title: Then XPath \"{xpath}\" isn\'t one of \"{value}
---

Usage example
=============

    Feature: zato-apitest docs

    Scenario: Then XPath "{xpath}" isn't one of "{value}

        Given address "http://apitest-demo.zato.io"
        Given URL path "/demo/xml2"
        Given format "XML"
        Given request is "<req><howdy>foo</howdy></req>"

        When the URL is invoked

        Then XPath "//not-one-of" isn't one of "a,b,c"

Discussion
==========

(None)

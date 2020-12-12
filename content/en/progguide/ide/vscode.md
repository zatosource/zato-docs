---
title: Visual Studio Code
---

To enable hot-deployment from Visual Studio Code, ensure you have first
followed the configuration instructions in [index].

Configuration
=============

The [Zato for Visual Studio Code plug-in](https://marketplace.visualstudio.com/items?itemName=zatosource.ide-vscode)
available from the Visual Studio marketplace adds a default keybinding along
with a toolbar button enabling simplified hot-deployment to your development
cluster.

1.  Visit the Extensions Marketplace either [in your browser](https://marketplace.visualstudio.com/items?itemName=zatosource.ide-vscode), or within the application, by pressing *Ctrl+Shift+X* hot-key:

    ![image](../../gfx/progguide/ide-deploy/vscode_marketplace.jpg)

2.  After installation completes, visit the settings panel *Ctrl+,* to configure your cluster connection:

    ![image](../../gfx/progguide/ide-deploy/vscode_settings.jpg)

Automatic deployment
====================

Automatic deployment is triggered on every file save if a Python file contains a special deployment marker
within its first 100 lines of source code:

    # zato: ide-deploy=True

For instance:

    # zato: ide-deploy=True

    from zato.server.service import Service

    class MyService(Service):
        def handle(self):
            pass

![image](../../gfx/progguide/ide-deploy/vscode_ide_deploy_true.jpg)

Manual deployment
=================

While editing any Python module, you can deploy to the configured Zato cluster
by clicking the toolbar icon, or pressing the *Ctrl+Shift+L* hotkey:

![image](../../gfx/progguide/ide-deploy/vscode_hot_deploy.png)

Deployment Status
=================

Success is indicated through a status panel that appears following activation:

![image](../../gfx/progguide/ide-deploy/vscode_deployment_started.jpg)

Other IDEs
==========

-   [./pycharm]

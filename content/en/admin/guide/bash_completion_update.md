---
subtitle: Update process steps
title: Bash completion update
---

-   Download and replace /etc/bash_completion.d/zato:

``` {.sh}
host$ sudo wget -O /etc/bash_completion.d/zato \
        https://raw.githubusercontent.com/zatosource/zato-build/master/bash_completion/zato
```

You can logout and login to refresh the bash session or you can do the next step to reload Bash completion staying in the same session:

-   Reload Bash completion:

``` {.sh}
host$ source /etc/bash_completion.d/zato
```

That concludes the process, obtaining and updated version of Zato\'s Bash completion script.

zato-docs
=========

Documentation for https://zato.io/docs

Each major Zato release has its own subdirectory, for instance, 3.1 or 3.2.

To build HTML documentation (here, 3.2):

```
$ cd ~
$ git clone https://github.com/zatosource/zato-docs.git
$ cd ~/zato-docs/3.2/sphinx
$ make virtualenv
$ make html
```

Now the output HTML is in ```~/zato-docs/3.2/sphinx/_build/html/index.html```.

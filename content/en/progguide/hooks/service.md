---
title: Hooking into a service's lifecycle
---

While [handle \<progguide-write-service-handle\>] is the main method each
service needs to implement, hooks are methods of a service that can be optionally
overridden in order to execute additional code before or after several
defined points in a service\'s lifecycle.

Which methods can be implemented depends on how a service is invoked - some
methods are common to all access mechanisms while the rest of them is specific
only to jobs executed through the scheduler.

Any exceptions raised in [before_add_to_store \<progguide-write-service-before_add_to_store\>]
will mean a service won\'t be deployed. For all other hooks, if an exception is raised,
it will be caught by Zato, logged, and the next method will be called as though there was
no exception in the previous one.

You can use the [environ \<progguide-write-service-environ\>] dictionary to pass
data down from a hook to another.

Common methods {#progguide-service-hooks-common-methods}
==============

These methods can be overridden regardless of the means a service will be executed
with, no matter its channel, if any, or if it\'s invoked through the
[scheduler \<../../web-admin/scheduler/main\>]
or not.

  Method                                                                                    Notes
  ----------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------
  [before_add_to_store \<progguide-write-service-before_add_to_store\>] Stati   c method that will be executed by each worker when a
                                                                                            server starts up. A service will be deployed by that worker
                                                                                            only if the method returns True and this is the value
                                                                                            before_add_to_store returns by default.
  [after_add_to_store \<progguide-write-service-after_add_to_store\>] Stati     c method that will be executed by each worker right after a
                                                                                            service has been successfully deployed.
  [accept \<progguide-write-service-accept\>] If Fa                             lse, the service won\'t be executed at all. Defaults to True.
  [before_handle \<progguide-write-service-before_handle\>] Execu               ted right before a service\'s [handle \<progguide-write-service-handle\>]
                                                                                            will be called
  [after_handle \<progguide-write-service-after_handle\>] Execu                 ted right after a service\'s [handle \<progguide-write-service-handle\>]
                                                                                            has been called
  [finalize_handle \<progguide-write-service-finalize_handle\>] Execu           ted after Zato has finished additional bookkeeping such as storing service
                                                                                            statistics in [Redis \</architecture/redis\>] so that
                                                                                            [further \<progguide-write-service-processing_time\>]
                                                                                            [attributes \<progguide-write-service-processing_time_raw\>]
                                                                                            are available in finalize_handle - they can\'t be accessed in handle or after_handle

![image](/gfx/progguide/service-hooks-common.png){.align-center}

``` {.python}
from zato.server.service import Service

class MyService(Service):

    @staticmethod
    def before_add_to_store(logger):
        logger.info('Adding to store {}'.format(MyService.get_name()))

        # Don't forget to return True, otherwise the service won't be deployed
        return True

    @staticmethod
    def after_add_to_store(logger):
        logger.info('Added to store {}'.format(MyService.get_name()))

    def before_handle(self):
        self.logger.info('before_handle called')

    def handle(self):
        self.logger.info('handle called')

    def after_handle(self):
        self.logger.info('after_handle called')

    def finalize_handle(self):
        self.logger.info('finalize_handle called')
        self.logger.info('processing_time {} ms'.format(self.processing_time))
        self.logger.info('processing_time_raw {}'.format(self.processing_time_raw))
```

``` {.python}
INFO - Adding to store service-hooks.my-service
INFO - Added to store service-hooks.my-service
...
...
INFO - before_handle called
INFO - handle called
INFO - after_handle called
INFO - finalize_handle called
INFO - processing_time 0 ms
INFO - processing_time_raw 0:00:00.000537
```

Common and additional scheduler-specific methods
================================================

A scheduler-initiated service can access all the
[common methods \<progguide-service-hooks-common-methods\>]
and a set of supplementary ones, and even then, some will depend on the job\'s type.

  Method                                                                                                Notes
  ----------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------
  [before_add_to_store \<progguide-write-service-before_add_to_store\>] Docum               ented along with other [common methods \<progguide-service-hooks-common-methods\>]
  [after_add_to_store \<progguide-write-service-after_add_to_store\>] Docum                 ented along with other [common methods \<progguide-service-hooks-common-methods\>]
  [accept \<progguide-write-service-accept\>] Docum                                         ented along with other [common methods \<progguide-service-hooks-common-methods\>]
  [before_job \<progguide-write-service-before_job\>] Execu                                 ted before a service\'s [handle \<progguide-write-service-handle\>]
                                                                                                        will be called but only if the service has been triggered by the
                                                                                                        [scheduler \<../../web-admin/scheduler/main\>], regardless of the [job type \<progguide-write-service-job_type\>]
  [before_one_time_job \<progguide-write-service-before_one_time_job\>] Execu               ted before a service\'s [handle \<progguide-write-service-handle\>]
                                                                                                        will be called but only if the service has been triggered by the
                                                                                                        [scheduler \<../../web-admin/scheduler/main\>] and its
                                                                                                        [job_type \<progguide-write-service-job_type\>] is \'one_time\'
  [before_interval_based_job \<progguide-write-service-before_interval_based_job\>] 〃 wh   en [job_type \<progguide-write-service-job_type\>] is \'interval_based\'
  [before_cron_style_job \<progguide-write-service-before_cron_style_job\>] 〃 wh           en [job_type \<progguide-write-service-job_type\>] is \'cron_style\'
  [before_handle \<progguide-write-service-before_handle\>] Docum                           ented along with other [common methods \<progguide-service-hooks-common-methods\>]
  [after_handle \<progguide-write-service-after_handle\>] Docum                             ented along with other [common methods \<progguide-service-hooks-common-methods\>]
  [after_job \<progguide-write-service-after_job\>] Execu                                   ted after a service\'s [handle \<progguide-write-service-handle\>]
                                                                                                        has been called but only if the service has been triggered by the
                                                                                                        [scheduler \<../../web-admin/scheduler/main\>], regardless of the [job type \<progguide-write-service-job_type\>]
  [after_one_time_job \<progguide-write-service-after_one_time_job\>] Execu                 ted after a service\'s [handle \<progguide-write-service-handle\>]
                                                                                                        has been called but only if the service has been triggered by the
                                                                                                        [scheduler \<../../web-admin/scheduler/main\>] and its
                                                                                                        [job_type \<progguide-write-service-job_type\>] is \'one_time\'
  [after_interval_based_job \<progguide-write-service-after_interval_based_job\>] 〃 wh     en [job_type \<progguide-write-service-job_type\>] is \'interval_based\'
  [after_cron_style_job \<progguide-write-service-after_cron_style_job\>] 〃 wh             en [job_type \<progguide-write-service-job_type\>] is \'cron_style\'
  [finalize_handle \<progguide-write-service-finalize_handle\>] Docum                       ented along with other [common methods \<progguide-service-hooks-common-methods\>]

![image](/gfx/progguide/service-hooks-common-scheduler.png){.align-center}

``` {.python}
from zato.server.service import Service

class MyService(Service):

    @staticmethod
    def before_add_to_store(logger):
        logger.info('before_add_to_store called')

        # Don't forget to return True, otherwise the service won't be deployed
        return True

    @staticmethod
    def after_add_to_store(logger):
        logger.info('after_add_to_store called')

    def before_job(self):
        self.logger.info('before_job called')

    def before_one_time_job(self):
        raise NotImplementedError()

    def before_interval_based_job(self):
        self.logger.info('before_interval_based_job called')

    def before_cron_style_job(self):
        raise NotImplementedError()

    def before_handle(self):
        self.logger.info('before_handle called')

    def handle(self):
        self.logger.info('handle called')

    def after_handle(self):
        self.logger.info('after_handle called')

    def after_job(self):
        self.logger.info('after_job called')

    def after_one_time_job(self):
        raise NotImplementedError()

    def after_interval_based_job(self):
        self.logger.info('after_interval_based_job called')

    def after_cron_style_job(self):
        raise NotImplementedError()

    def finalize_handle(self):
        self.logger.info('finalize_handle called')
        self.logger.info('processing_time {} ms'.format(self.processing_time))
        self.logger.info('processing_time_raw {}'.format(self.processing_time_raw))
```

``` {.python}
INFO - Adding to store service-hooks.my-service
INFO - Added to store service-hooks.my-service
...
...
INFO - before_job called
INFO - before_interval_based_job called
INFO - before_handle called
INFO - handle called
INFO - after_handle called
INFO - after_job called
INFO - after_interval_based_job called
INFO - finalize_handle called
INFO - processing_time 1 ms
INFO - processing_time_raw 0:00:00.001397
```

Following-up on my post about [monitoring beanstalkd with Cacti](http://geeks.silentale.com/2009/12/08/monitoring-beanstalkd-with-cacti-creating-custom-cacti-templates/), here are the templates and script we're using at Silentale.
 
The code and templates are heavily inspired from Dustin's [beanstalk-tools](http://github.com/dustin/beanstalk-tools) and Baron Schwartz's [MySQL cacti templates](http://code.google.com/p/mysql-cacti-templates/)

Enjoy !

## install the statistics collection script

### ruby related requirements
* the script should work with ruby 1.8.X but hasn't been tested with 1.9
* You need to install the following gems:
  * trollop
  * dustin-beanstalk-client
* the xml templates are expecting to find the script in `<cacti_path>/scripts/beanstalk_get_queue_stats`

### Import the Cacti xml templates

* import the **data template** named `cacti_data_template_beanstalk_queue_statistics.xml`
* **graph template** for monitoring the amount of buried jobs in the queue: `cacti_graph_template_beanstalk_buried_jobs.xml`
* **graph template** for monitoring the total amount of jobs in the queue: `cacti_graph_template_beanstalk_total_jobs.xml`
* **graph template** for monitoring : ready,urgent,delayed and the number of workers in the same graph:        `cacti_graph_template_beanstalkd_queue_statistics_gt.xml` 

**note** at import time, our Cacti installation here insists on replacing braces with &amp;lt; and &amp;gt;, which prevents it from finding the script. Make sure the path is properly specified in the templates *before* creating data input methods and graphs, because changing them aftewards is quite tedious ...


# ELK installation for Apache Ignite
This repo contains ansible scripts to install ELK + filebeat&dstat in RedHat linux. Most intresting thing is logstash pipeline (elk-monitor/ansible/playbooks/configs/logstash/conf.d) where some Ruby magic translate text log messages into structured data.
## Intro
1) git clone
2) cd elk-monitor/ansible
3) see README.txt and playbooks dir
## Components
The main components of log collecting and analyzing system is:
* Filebeat - agent to send log messages from any log files to ELK server (work on all grid nodes)
* dstat - simple and temporary solytion, but it allow to monitor some OS level metrics (work on all grid nodes)
* elasticsearch - simple database with schema less documents and full text search feature (work on ELK node)
* kibana - web UI to select log
* logstash - parse logs from text messages to get some metrics (work on ELK node)


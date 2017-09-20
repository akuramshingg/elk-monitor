1) Download distibs to playbook/files (see README.txt in there)
2) Update inventory to your network
3) Setup ssh (ssh-copy-id root@<IP> to all servers in your grid & elk), may need generate new RSA key (ssh-keygen -t rsa)
4) Setup python in all servers (can be added into playbook/prepare if needed)
5) Run:
 ansible-playbook -i inventory -U root playbooks/prepare.yml        - install java
 ansible-playbook -i inventory -U root playbooks/filebeat.yml       - install filebeat to all grid servers
 ansible-playbook -i inventory -U root playbooks/elasticsearch.yml  - install elasticsearch to elk server
 ansible-playbook -i inventory -U root playbooks/kibana.yml         - install kibana to elk server
 ansible-playbook -i inventory -U root playbooks/logstash.yml       - install logstash to elk server
6) Enshure that logstash add index template into elasticsearch (start logstash after elasticsearch and find "Installing elasticsearch template to ..." in logstash log (/var/logstash/logstash.log), start kibana
7) Make service ports visible outside of LXC container, eg. for kibana
 iptables -t nat -A PREROUTING -p tcp -i <ifname> --dport 8080 -j DNAT --to-destination <lxcaddr>:8080
8) Start log shipping (put logs into log dir, so filebeat send it to logstash and logstash create index in elasticasearch)
9) Select index patern in kibana: open kibana UI in web browser (localhost:8080), go to Management->Index Patterns and select logstash-*
10) Import visualize configuration into kibana: open kibana UI in web browser (localhost:8080), go to Management->Saved Objects and Import playbooks/configs/kibana/export.json file
11) Import visualize configuration for metricbeats: run /usr/share/metricbeats/scripts/import_dashboards -file <path_to_dashboards> (on ELK server)
0) Use the force and update ansible scripts, not actual server configuration - be at light side of the force!







TODO:
add grid server name into filebeats config

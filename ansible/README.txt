1) Download distibs to playbook/files (see README.txt in there)
2) Update inventory to your network
3) Setup ssh (ssh-copy-id root@<IP> to all servers in your grid & elk)
4) Setup python in all servers (can be added into playbook/prepare if needed)
5) Run:
 ansible-playbook -i inventory -U root playbooks/prepare.yml        - install java
 ansible-playbook -i inventory -U root playbooks/filebeat.yml       - install filebeat to all grid servers
 ansible-playbook -i inventory -U root playbooks/logstash.yml       - install logstash to elk server
 ansible-playbook -i inventory -U root playbooks/elasticsearch.yml  - install elasticsearch to elk server
 ansible-playbook -i inventory -U root playbooks/kibana.yml         - install kibana to elk server
6) Use the force and update ansible scripts, not actual server configuration - be at light side of the force!






TODO:
add grid server name into filebeats config
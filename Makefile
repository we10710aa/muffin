
PRIMRY := primary
LIST_INSTANCE := $(shell limactl list primary --json  | jq ".name")

.PHONY: create start stop delete

create:
	limactl create vmenv/primary.yml --tty=false
	limactl start primary --tty=false

setup:
	ansible-playbook -i inventory/hosts.yaml setup.yaml

destroy:
	limactl stop primary --tty=false
	limactl delete primary  --tty=false

recreate:
	@if [ $(shell limactl list primary --json  | jq ".name") = "primary" ]; then \
		make destroy;\
		make create;\
		make setup;\
	fi
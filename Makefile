.PHONY: clean
.PHONY: deep-clean
.PHONY: update

clean:
	rm -f *.tfstate{,.backup}
	rm -f *.tfplan

deep-clean:
	rm -f *.tfstate
	rm -f *.tfstate.backup
	rm -f *.tfplan
	rm -rf .terraform
	rm -rf .terraform.lock.hcl
include ../Makefile.variable

dn-worker:
	docker build -t $(HUB_PREFIX)/$@ .
	docker push $(HUB_PREFIX)/$@

.PHONY: dn-worker
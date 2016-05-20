include ../Makefile.variable

dn-interlock:
	docker build -t $(HUB_PREFIX)/$@ .
	docker push $(HUB_PREFIX)/$@

.PHONY: dn-interlock
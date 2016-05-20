include ../Makefile.variable

dn-openresty:
	docker build -t $(HUB_PREFIX)/$@ .
	docker push $(HUB_PREFIX)/$@

.PHONY: dn-openresty
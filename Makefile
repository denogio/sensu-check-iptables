release:
	tar czf /tmp/sensu-check-iptables_${VERSION}_linux_amd64.tar.gz bin/ 
	sum=$$(sha512sum /tmp/sensu-check-iptables_${VERSION}_linux_amd64.tar.gz | cut -d ' ' -f 1); \
	f=$$(basename sensu-check-iptables_${VERSION}_linux_amd64.tar.gz); \
	echo $$sum $${f} > /tmp/sensu-scheck-iptables_${VERSION}_sha512_checksums.txt; \
	echo $$sum;

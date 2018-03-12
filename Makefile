publish:
	aws s3 cp --acl=public-read $(CURDIR)/install.sh "s3://build.mangoweb.org/4acc9c08.sh"
	aws s3 cp --acl=public-read $(CURDIR)/install.sh "s3://build.mangoweb.org/mango-ca8d860d50994f17186e/install.sh"
	aws s3 cp --acl=public-read $(CURDIR)/mango.sh "s3://build.mangoweb.org/mango-ca8d860d50994f17186e/mango.sh"

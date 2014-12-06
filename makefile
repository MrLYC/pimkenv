aptget = apt-get -y
pip = pip install -i http://pypi.douban.com/simple

source-list:
	cat ./source.list > /etc/apt/sources.list
	apt-get update

clean:
	rm ./* -rf
	git checkout -- .

python-dev:
	$(aptget) autoremove python
	$(aptget) install python-dev

vnc-server:
	$(aptget) install tightvncserver
	vncpasswd

vnc-auto-start:
	cp ./tightvncserver /etc/init.d/tightvncserver
	chmod 755 /etc/init.d/tightvncserver
	update-rc.d tightvncserver defaults

xrdp:
	$(aptget) install xrdp

seafile:
	$(aptget) install install python-simplejson python-imaging sqlite3
	mkdir -p /opt/seafile/installed/
	wget https://bitbucket.org/haiwen/seafile/downloads/seafile-server_3.1.6_pi.tar.gz -O /opt/seafile/
	cd /opt/seafile/ && \
	tar -xzf /opt/seafile/seafile-server_* && \
	mv /opt/seafile/seafile-server_* /opt/seafile/installed/
	cd /opt/seafile/seafile-server-* && \
	./setup-seafile.sh

seafile-run:
	cd /opt/seafile/seafile-server_* && \
	./seafile.sh start && \
	./seahub.sh start 1234

profile:
	cp ./lyc_profile.sh /etc/profile.d/
	chmod 777 /etc/profile.d/lyc_profile.sh

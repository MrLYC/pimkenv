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

vnc-start: tightvncserver
	tightvncserver -geometry 760x400 :1

PREFIX ?= /usr/local
APP = ssl-check

all:
	@echo Run \'make install\' to install $(APP).

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p $(APP) $(DESTDIR)$(PREFIX)/bin/$(APP)
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/$(APP)

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/$(APP)

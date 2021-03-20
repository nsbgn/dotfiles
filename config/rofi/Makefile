all: $(HOME)/.config/rofi

install:
	ln -s /usr/bin/rofi /usr/local/bin/dmenu

$(HOME)/.config/rofi: .
	mkdir -p $(@D)
	ln -s $(shell realpath $< --relative-to $(@D)) $@

$(HOME)/.config/nvim: .
	mkdir -p $(@D)
	ln -s $(shell realpath $< --relative-to $(@D)) $@

all: $(addprefix $(HOME)/,.bashrc .bash_aliases .profile .Xresources .xinitrc) $(HOME)/.config/user-dirs.dirs

$(HOME)/.%: %
	ln -s $(shell realpath $< --relative-to $(@D)) $@

.PHONY: all

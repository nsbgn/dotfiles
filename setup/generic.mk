# Generic makefile recipes

# Create a zipped archive
$(DEST)/%.zip: $(SRC)/%
	@-mkdir -p $(@D)
	zip -r9 $@ $^


# Create a zipped archive
$(DEST)/%.tar.gz: $(SRC)/%
	@-mkdir -p $(@D)
	tar -zcvf $@ $^

# Create gzipped archive
$(DEST)/%: $(DEST)/%.gz
	gzip --best --to-stdout < $< > $@

# Public GPG key
$(DEST)/public.gpg:
	gpg --export $(GPG_ID) > $@

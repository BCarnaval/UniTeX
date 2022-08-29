HIDE = @
VERBOSE = TRUE

.PHONY: classic article homework clean_all

# Classic template targets
classic:
	$(HIDE)$(MAKE) -C $(SOURCEDIR_C)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_C)

classic_targz:
	$(HIDE)$(MAKE) targz -C $(SOURCEDIR_C)

classic_zip:
	$(HIDE)$(MAKE) zip -C $(SOURCEDIR_C)

# Article template targets
article:
	$(HIDE)$(MAKE) -C $(SOURCEDIR_A)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_A)

article_targz:
	$(HIDE)$(MAKE) targz -C $(SOURCEDIR_A)

article_zip:
	$(HIDE)$(MAKE) zip -C $(SOURCEDIR_A)

# Homework template targets
homework:
	$(HIDE)$(MAKE) -C $(SOURCEDIR_H)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_H)

homework_targz:
	$(HIDE)$(MAKE) targz -C $(SOURCEDIR_H)

homework_zip:
	$(HIDE)$(MAKE) zip -C $(SOURCEDIR_H)

# Global targets
clean_all:
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_C)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_A)
	$(HIDE)$(MAKE) clean -C $(SOURCEDIR_H)


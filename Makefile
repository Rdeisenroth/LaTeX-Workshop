
OUT_DIR := build/
TOPTARGETS := clean all

# recursive slides helper
define compile_latex
	latexmk --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -lualatex "$(1)"
endef

define compile_latex_with_jobname_and_env
	$(3) latexmk --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -lualatex -jobname=$(2) "$(1)"
endef

define build_latex
	$(eval DIR := $(dir $(1)))
	$(eval FILE := $(notdir $(1)))
	@echo "Compiling $(FILE) in $(DIR)..."
	@cd $(DIR) && $(call compile_latex,$(FILE))
	@# copy PDF file to outdir
	@mkdir -p $(OUT_DIR)
	@mv $(basename $(1)).pdf $(OUT_DIR)/
	@echo
endef

define build_latex_with_jobname_and_env
	$(eval DIR := $(dir $(1)))
	$(eval FILE := $(notdir $(1)))
	@echo "Compiling $(FILE) in $(DIR)..."
	@cd $(DIR) && $(call compile_latex_with_jobname_and_env,$(FILE),$(2),$(3))
	@# copy PDF file to outdir
	@mkdir -p $(OUT_DIR)
	@mv $(2).pdf $(OUT_DIR)/
	@echo
endef

FILES := $(wildcard *.tex)

all:
	$(MAKE) clean
	$(MAKE) compileCode
	$(MAKE) compile

$(FILES:.tex=.tex.regular):
	$(eval FILE := $(patsubst %.tex.regular,%.tex,$@))
	$(call build_latex_with_jobname_and_env,$(FILE),$(patsubst %.tex,%,$(FILE)),)

$(FILES:.tex=.tex.darkmode):
	$(eval FILE := $(patsubst %.tex.darkmode,%.tex,$@))
	$(call build_latex_with_jobname_and_env,$(FILE),$(patsubst %.tex,%-darkmode,$(FILE)),DARK_MODE=1)

compileCode:
	@echo "Compiling code"
	$(MAKE) -C code

compile: $(FILES:.tex=.tex.regular) $(FILES:.tex=.tex.darkmode)
	@echo "PDFs can be found in $(OUT_DIR)"

clean:
	@echo "Cleaning..."
	@latexmk -C -f
	@rm -f options.cfg
	@rm -f *.pdf
	@rm -f *.aux
	@rm -f *.fdb_latexmk
	@rm -f *.fls
	@rm -f *.len
	@rm -f *.listing
	@rm -f *.log
	@rm -f *.out
	@rm -f *.synctex.gz
	@rm -f *.toc
	@rm -f *.nav
	@rm -f *.snm
	@rm -f *.vrb
	@rm -f *.bbl
	@rm -f *.blg
	@rm -f *.bak[0-9]*
	@rm -rf _minted-*
	@rm -f chapters/options.cfg
	@rm -f chapters/*.pdf
	@rm -f chapters/*.aux
	@rm -f chapters/*.fdb_latexmk
	@rm -f chapters/*.fls
	@rm -f chapters/*.len
	@rm -f chapters/*.listing
	@rm -f chapters/*.log
	@rm -f chapters/*.out
	@rm -f chapters/*.synctex.gz
	@rm -f chapters/*.toc
	@rm -f chapters/*.nav
	@rm -f chapters/*.snm
	@rm -f chapters/*.vrb
	@rm -f chapters/*.bbl
	@rm -f chapters/*.blg
	@rm -f chapters/*.bak[0-9]*
	@rm -rf chapters/_minted-*
	@make -C code clean

cleanBuild:
	@echo "Cleaning build..."
	@rm -rf build
	@make -C code cleanBuild

cleanAll: clean cleanBuild

all:
	$(MAKE) clean
	$(MAKE) compile

compile:
	@latexmk --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -lualatex *.tex

clean:
	@echo "Cleaning Code..."
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

cleanBuild:
	@rm -f *.pdf

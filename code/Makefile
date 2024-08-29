all:
	$(MAKE) compile

compile:
	@latexmk --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -lualatex *.tex

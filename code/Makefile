all: clean compile clean

compile:
	@latexmk --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -lualatex *.tex

clean:
	@echo "Cleaning Code..."
	@latexmk -C

cleanBuild:
	@rm -f *.pdf

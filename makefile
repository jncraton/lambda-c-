SRC = lambda

all: test $(SRC).html

$(SRC).html: $(SRC).pmd
	pweave --format=md2html $(SRC).pmd
	# Hack to remove padding from first line of code blocks
	sed -i -e "s/padding: 2px 4px//g" $(SRC).html

$(SRC).md: $(SRC).pmd
	pweave --format=pandoc $(SRC).pmd

tangled.py: $(SRC).pmd
	ptangle $(SRC).pmd
	mv $(SRC).py tangled.py

$(SRC).pdf: $(SRC).html
	chromium-browser --headless --print-to-pdf=$(SRC).pdf $(SRC).html
	
run: tangled.py
	python3 tangled.py

test: tangled.py
	cat testhead.py tangled.py > tangled-test.py
	
	python3 -m doctest tangled-test.py

clean:
	rm -f $(SRC).pdf $(SRC).md tangled.py tangled-test.py $(SRC).html
	rm -rf figures
	rm -rf __pycache__
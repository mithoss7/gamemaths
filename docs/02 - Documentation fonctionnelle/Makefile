PYTHON ?= python
BUILD  := build/assemble.py

.PHONY: doc1 doc2 clean

doc1:
	$(PYTHON) $(BUILD) doc1-contexte-objectifs

doc2:
	$(PYTHON) $(BUILD) doc2-specifications-fonctionnelles

clean:
	rm -rf doc1-contexte-objectifs/_build doc2-specifications-fonctionnelles/_build

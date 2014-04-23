all: result.html

## tagging (after train)

result.html: tag2html.exe tag.txt
	./tag2html.exe input.test.txt tag.txt > $@

tag.txt: icon.model test.crf
	crfsuite tag -m icon.model test.crf > tag.txt

test.crf : tagging.exe
	./$^ < input.test.txt > test.crf

## train

icon.model: train.crf
	crfsuite learn -m $@ $^

train.crf: train.exe input.train.txt
	./train.exe < input.train.txt > $@

%.exe: %.hs
	ghc -O3 $^ -o $@

clean:
	rm -f *.hi *.o *.exe *.model *.crf

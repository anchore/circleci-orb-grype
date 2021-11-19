.PHONY: clean all

all: build publish clean

build:
	circleci config pack src/ > orb.yml

publish:
	circleci orb publish ./orb.yml anchore/grype@dev:alpha --token ${TOKEN}

clean:
	rm orb.yml

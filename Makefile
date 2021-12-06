.PHONY: clean all

all: build validate publish clean

build:
	circleci config pack src/ > orb.yml

validate: build
	circleci orb validate orb.yml

publish:
	circleci orb publish ./orb.yml anchore/grype@dev:alpha --token ${TOKEN}

clean:
	rm orb.yml

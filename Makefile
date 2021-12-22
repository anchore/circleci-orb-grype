.PHONY: clean all

install-circleci-cli:
	brew install circleci

all: build validate publish clean

build:
	circleci config pack src/ > orb.yml

validate: build
	circleci orb validate orb.yml
	circleci config validate

publish:
	circleci orb publish ./orb.yml anchore/grype@dev:alpha --token ${CIRCLE_CI_TOKEN}

clean:
	rm orb.yml

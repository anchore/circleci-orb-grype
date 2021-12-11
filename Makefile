.PHONY: clean all

install-circleci-cli:
	brew install circleci

all: build validate publish clean

build:
	circleci config pack src/ > orb.yml

validate: build
	circleci config validate
	circleci orb validate orb.yml

publish:
	circleci orb publish ./orb.yml anchore/grype@dev:alpha --token ${CIRCLE_CI_TOKEN}

clean:
	rm orb.yml

build:
	docker build -t lemuelroberto/libbitcoin-explorer:debian-12 .

push:
	docker push lemuelroberto/libbitcoin-explorer:debian-12

run:
	docker run \
		--interactive \
		--rm \
		--tty \
		lemuelroberto/libbitcoin-explorer:debian-12 /usr/bin/bash

success:
	docker run \
		--interactive \
		--rm \
		--tty \
		lemuelroberto/libbitcoin-explorer:debian-12 \
		bx ek-to-ec \
		"my passphrase" \
		6PYXCdvtrs4NN1TjUYbGS5Sd2gjsVsDm7GttqERRWvRjWDsrhQfJeEHrg5

error:
	docker run \
		--interactive \
		--rm \
		--tty \
		lemuelroberto/libbitcoin-explorer:debian-12 \
		bx ek-to-ec \
		"i forgot" \
		6PYXCdvtrs4NN1TjUYbGS5Sd2gjsVsDm7GttqERRWvRjWDsrhQfJeEHrg5

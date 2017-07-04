#! /bin/bash -e

rm -r -f output
nikola build
nikola check -l -f
nikola deploy


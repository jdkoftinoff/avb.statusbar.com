#! /bin/bash -e

nikola build
nikola check -l -f
nikola deploy


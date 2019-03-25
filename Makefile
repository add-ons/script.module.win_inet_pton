addon_xml = addon.xml

# Collect information to build as sensible package name
name = $(shell xmllint --xpath 'string(/addon/@id)' $(addon_xml))
version = $(shell xmllint --xpath 'string(/addon/@version)' $(addon_xml))
git_hash = $(shell git rev-parse --short HEAD)

zip_name = $(name)-$(version)-$(git_hash).zip
exclude_files = .git/ .git/\* Makefile
exclude_paths = $(patsubst %,$(name)/%,$(exclude_files))

all: zip

zip:
	@echo -e "\e[1;37m=\e[1;34m Building new package\e[0m"
	rm -f ../$(zip_name)
	cd ..; zip -r $(zip_name) $(name) -x $(exclude_paths)
	@echo -e "\e[1;37m=\e[1;34m Successfully wrote package as: \e[1;37m../$(zip_name)\e[0m"

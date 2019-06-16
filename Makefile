###
# sass2scss
# Licensed under the MIT License
# Copyright (c) Marcel Greter
###

SASS2SCSS_VERSION := $(shell git describe --abbrev=4 --dirty --always --tags)

ifeq ($(OS),Windows_NT)
	MV ?= move
	CP ?= copy /Y
	RM ?= del /Q /F
else
	MV ?= mv -f
	CP ?= cp -f
	RM ?= rm -f
endif

$(CXX) ?= g++

all: sass2scss

CXXFLAGS = -std=c++98 -DSASS2SCSS_VERSION="\"$(SASS2SCSS_VERSION)\""

sass2scss.o: sass2scss.cpp
	$(CXX) $(CXXFLAGS) -Wall -c sass2scss.cpp

sass2scss: tool/sass2scss.cpp sass2scss.o
	$(CXX) $(CXXFLAGS) -Wall -o sass2scss -I. $^

clean:
ifeq ($(OS),Windows_NT)
	$(RM) sass2scss.o 2>NUL
	$(RM) sass2scss.exe 2>NUL
else
	$(RM) sass2scss.o
	$(RM) sass2scss
endif

options:
	# compiler is $(CXX)
	# flags are $(CXXFLAGS)
	# version is $(SASS2SCSS_VERSION)

.PHONY: all clean options

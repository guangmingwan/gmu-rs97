# 
# Gmu Music Player
#
# Copyright (c) 2006-2011 Johannes Heimansberg (wejp.k.vu)
#
# File: unknown.mk  Created: 060904
#
# Description: Makefile configuration (unknown default target)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; version 2 of
# the License. See the file COPYING in the Gmu's main directory
# for details.
#
UNAME_S := $(shell uname -s)

ifeq (0,$(STATIC))
# normal build
DECODERS_TO_BUILD?=decoders/vorbis.so decoders/flac.so decoders/wavpack.so decoders/mpg123.so decoders/mikmod.so decoders/speex.so
FRONTENDS_TO_BUILD?=frontends/sdl.so frontends/log.so
else
# static build
DECODERS_TO_BUILD=vorbis.o flac.o mpg123.o mikmod.o speex.o
FRONTENDS_TO_BUILD=sdl.o gmuhttp.o
PLUGIN_OBJECTFILES+=$(PLUGIN_FE_SDL_OBJECTFILES) $(PLUGIN_FE_HTTP_OBJECTFILES)
endif

CC?=gcc
CXX?=g++
STRIP?=strip

SDL_LIB=$(shell sdl-config --libs)
SDL_CFLAGS=$(shell sdl-config --cflags)
MIKMOD_LIB=$(shell libmikmod-config --libs)
MIKMOD_CFLAGS=$(shell libmikmod-config --cflags)

COPTS?=-O0 -fno-short-enums -g
CFLAGS=-I/usr/local/include -I/opt/local/include $(SDL_CFLAGS) -fsigned-char -D_REENTRANT -DUSE_MEMORY_H -std=c99
LFLAGS=-L/usr/local/lib -L/opt/local/lib/

ifeq ($(UNAME_S),Linux)
    LFLAGS +=  -Wl,-export-dynamic
endif
ifeq ($(UNAME_S),Darwin)
	LFLAGS +=  	 -rdynamic
endif

DISTFILES=$(COMMON_DISTBIN_FILES) gmuinput.unknown.conf gmu.sh

export MAIN_DIR = /home/grisha/Projects/oos_new_labs/proxy-grisha
export INCLUDE_PATH = $(MAIN_DIR)/src/include
export SOURCE = $(MAIN_DIR)/install

CC = gcc
CCFLAGS = -fpic -c -Wall -Wpointer-arith -Wendif-labels -Wmissing-format-attribute -Wimplicit-fallthrough=3 -Wcast-function-type -Wshadow=compatible-local -Wformat-security -fno-strict-aliasing -fwrapv -g -O2 -I$(INCLUDE_PATH)
LDFLAGS = -ldl -export-dynamic
LDFLAGS_DEBUG = -fsanitize=address,leak,undefined
ROOT = src/backend
BIN_NAME = proxy
OBJ = bg_worker.o boss_operations.o guc.o
MAIN_OBJ = main.o
LIBS_LINK = -lutils -loperations -lmemory -llogger -lstatic -ldynamic
LIBS = utils.a operations.a memory.a logger.so static.a dynamic.so

all:
	make clean_source_dir
	make create_source_dir
	make link
	make plugins
	echo "Done"

debug:
	make clean_source_dir
	make create_source_dir
	make link_debug
	make plugins
	echo "Done"

link: $(MAIN_OBJ) $(OBJ)
	$(CC) $(LDFLAGS) $^ -L$(SOURCE) $(LIBS_LINK) -Wl,-rpath=$(SOURCE) -o $(SOURCE)/$(BIN_NAME)

link_debug: $(MAIN_OBJ) $(OBJ)
	$(CC) $(LDFLAGS) $(LDFLAGS_DEBUG) $^ -L$(SOURCE) $(LIBS_LINK) -Wl,-rpath=$(SOURCE) -o $(SOURCE)/$(BIN_NAME)

plugins:
	make -f contrib/Makefile

include $(ROOT)/Makefile

create_source_dir:
	mkdir install
	mkdir install/contrib

clean_source_dir:
	rm -rf install

clean_obj:
	rm -rf *.o

clean: clean_source_dir clean_obj
	echo "Full clean"
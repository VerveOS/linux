savedcmd_scripts/kconfig/mnconf-common.o := clang -Wp,-MMD,scripts/kconfig/.mnconf-common.o.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11     -c -o scripts/kconfig/mnconf-common.o scripts/kconfig/mnconf-common.c

source_scripts/kconfig/mnconf-common.o := scripts/kconfig/mnconf-common.c

deps_scripts/kconfig/mnconf-common.o := \
  scripts/kconfig/expr.h \
  scripts/kconfig/list.h \
  scripts/kconfig/mnconf-common.h \

scripts/kconfig/mnconf-common.o: $(deps_scripts/kconfig/mnconf-common.o)

$(deps_scripts/kconfig/mnconf-common.o):

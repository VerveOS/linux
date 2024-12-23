#  Run this to configure kernel before building
#  ncurses package is required for this
#  Copyright (C) 2025 AnmiTali - VerveOS

ask_question() {
  while true; do
    echo "$1 (y/n):"
    read -r answer
    case "$answer" in
      y|Y) 
        return 0
        ;;
      n|N) 
        return 1
        ;;
      *) 
        echo "Please, type y or n."
        ;;
    esac
  done
}

clear
echo "Setting up environment..."
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

if ask_question "Do you want to use Clang (LLVM) for compiling?"; then
    export CC=clang
    export LD=ld.lld
    export AR=llvm-ar
    export NM=llvm-nm
    export OBJCOPY=llvm-objcopy
    export OBJDUMP=llvm-objdump
    export STRIP=llvm-strip
fi

if ask_question "Do you want to configure kernel?"; then
    make menuconfig
    if ask_question "Do you want to build kernel for now?"; then
        clear
        make -j$(nproc)
    fi
else
    echo "Without configuring kernel you can't continue."
fi

echo "Clearing environment..."
unset CC
unset LD
unset AR
unset NM
unset OBJCOPY
unset OBJDUMP
unset STRIP
unset ARCH
unset CROSS_COMPILE
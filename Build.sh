#!/bin/sh

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
export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=arm64

if ! command -v make >/dev/null; then
  echo "Error: 'make' is not installed. Please install it and try again."
  exit 1
fi

if ! command -v clang >/dev/null && ask_question "Do you want to use Clang (LLVM) for compiling?"; then
  echo "Error: Clang is not installed. Still using GCC."
else
  export KBUILD_BUILD_TIMESTAMP=''
  export CXX="ccache clang++"
  export CC="ccache clang"
  export LLVM_IAS=1
  export LLVM=1
fi

if ask_question "Do you want to configure the kernel?"; then
  if ! command -v dialog >/dev/null && ! command -v whiptail >/dev/null; then
    echo "Error: 'ncurses' package is required for menuconfig. Please install it and try again."
    exit 1
  fi

  make menuconfig || { echo "Kernel configuration failed!"; exit 1; }

  if ask_question "Do you want to build the kernel now?"; then
    clear
    echo "Building kernel..."
    make -j$(nproc) || { echo "Kernel build failed!"; exit 1; }
    echo "Kernel build complete!"
  fi
else
  echo "Without configuring the kernel, you can't continue. Exiting."
  exit 1
fi

# Clear environment variables
echo "Clearing environment..."
unset CROSS_COMPILE
unset LLVM_IAS
unset LLVM
unset ARCH
unset CC
unset CXX
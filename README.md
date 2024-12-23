# VerveOS Linux Kernel
Welcome to the repository of Linux kernel in VerveOS profile. This kernel is configured for mobile devices for installing this OS.
Building, configuring and flashing guides you can see below. You can see credits, license and maintainers files of Linux in official Linux's github repository.

## Preparing
To build a kernel (optionally with ramdisk) you need to install required tools on current system. Linux- or UNIX-based systems are recommended for this,
if you have Windows (NT) you should install WSL2 or MSYS2. You must have GCC or Clang/LLVM, cross compilation toolchain and any other packages (ccache and ncurses for configuring kernel).

## Building
It's recommended to use Clang/LLVM with optimizations for compiling kernel.<br>
You need to run special shell script for this, just write this command:
```sh
~~VerveOS~~/Scripts/BuildKernel.sh
<br>
```
This script will setup environment and build kernel.
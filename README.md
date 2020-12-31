AUR PKGBUILD for Groonga
===

## x86 and armv7h support

* swath

## x86, armv7h, and aarch64 support

* cutter (cutter-test_framework)
* groonga-gobject
* pgroonga
* groonga-normalizer-mysql

## x86 support only

* mariadb-with-mroonga
* groonga

## armv7h environment

* Arch Linux armv7h on Wandboard dual

## aarch64 environment

* Arch Linux aarch64 on PINE A64+ 2GB

## Reborned packages

* friso
* groonga-tokenizer-friso

## Experimental packages

* kytea

---

## Build environment

### prerequisites

* packer
* VirtualBox

### Usage

```
$ cd packer-arch
$ ./wrapacker --country JP
$ cd -
$ vagrant up
```

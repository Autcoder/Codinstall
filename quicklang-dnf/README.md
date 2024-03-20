# Quicklang

Quicklang is a Bash script that simplifies the installation of programming languages on your Linux system. It automates the process of checking for dependencies and installing the desired programming languages with just a few commands.

## Getting Started

**Download the script**
There are two ways two download the script:

- Go to the Releases and choose the latest compatible release for you package manager. This is recommended when you just want to use the script.
- If you want to change or fork the script to your liking, you can clone the Repository onto your system with following command:

```
git clone https://github.com/Autcoder/Auto-languages-installer.git
```

**Navigate to the Script Directory**
Open a terminal and navigate to the directory where the Quicklang script is located, or directly open the terminal from the directory in where the script is located

**Run the Script**
Execute the Quicklang script by typing the following command in the terminal:

```
bash ./quicklang-dnf.sh
```

### Usage

Quicklang will ask you what language you want to install. Just type the name and type enter.

- The script will automatically execute the commands to install the language.

- If dependencies are needed, it will automatically check if they are installed. If not, it will prompt you to install them. You can skip if you want, but it will stop the installation.

- When an installation using a tar.gz file (e.g. Smalltalk) is executed and finished, Quicklang will delete the tar.gz file automatically.

- If you want to install all, or just go through them like a list, type "install-all" and press enter

- If you want to install all the languages automatically, you can type "autoinstall-all" and press enter.
  !!! This will install every available language + dependencies (tar, make, curl, snap) automatically, so only do this when you are sure you want that!

- To see all the available languages, just type "showall" and press enter

To exit the script, type "exit" or "quit" and press Enter.

#### Supported Languages

Quicklang currently supports the installation of the following programming languages:

- Ada

* Assembly
* Brainfuck
* C
* C++
* C#
* Clojure
* D
* Dart (via Flutter)
* Delphi
* Elixir
* Erlang
* F#
* Flutter
* Fortran
* Go(lang)
* Haskell
* Java
* Jquery
* Julia
* Kotlin
* Lisp
* Lua
* Nim
* Nodejs
* OCaml
* Pascal
* Perl
* PHP
* PostrgreSql
* Prolog
* Python
* R
* Ruby
* Rust
* Scala
* Smalltalk
* Swift
* Typescript
* Zig

Be sure to sent feedback for the script. Feature suggestions/requests, bugs, just feedback, everything is welcome!

## Changelog

#### Version 1.1

- Fixed a bug that caused getting stuck in a infinite loop
- Added a function to show all the supported languages when typing "show-all"
- Added a function to autmatically install everything when typing "autoinstall-all"
- Automatically cleans up files after an installation using tar.gz files
- Minor performance improvements

#### Version 1.0

First Release of the Quicklang script for the dnf package manager.

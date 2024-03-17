# Quicklang

Quicklang is a Bash script that simplifies the installation of programming languages on your Linux system. It automates the process of checking for dependencies and installing the desired programming languages with just a few commands.

## Getting Started

**Download the script**\
There are two ways to download the script:

- Go to the Releases and choose the latest release compatible with your package manager (e.g. dnf, apt). This is recommended when you just want to use the script.
- If you want to change or fork the script to your liking, you can clone the Repository onto your system with following command:

```
git clone https://github.com/Autcoder/Auto-languages-installer.git
```

**Navigate to the Script Directory**\
Open a terminal and navigate to the directory where the Quicklang script is located, or directly open a terminal in that directory.

**Run the Script**\
Execute the Quicklang script by typing the following command in the terminal:

```
bash ./quicklang-dnf.sh
```

### Usage

- When you run the Quicklang script, it will automatically check for dependencies (tar, curl, and make) if needed for installation. If any of these dependencies are missing, the script will prompt you to install them.

- Quicklang will then execute the necessary commands to install the specified programming language on your system.

To exit the script, type "exit" or "quit" and press Enter.

#### Supported Languages

Quicklang currently supports the installation of the following programming languages:

- Ada
- Assembly
- Brainfuck
- C
- C++
- C#
- Clojure
- D
- Dart (via Flutter)
- Delphi
- Elixir
- Erlang
- F#
- Flutter
- Fortran
- Go(lang)
- Haskell
- Java
- Jquery
- Julia
- Kotlin
- Lisp
- Lua
- Nim
- Nodejs
- OCaml
- Pascal
- Perl
- PHP
- PostrgreSql
- Prolog
- Python
- R
- Ruby
- Rust
- Scala
- Smalltalk
- Swift
- Typescript
- Zig

Be sure to send feedback for the script. Feature suggestions/requests, bugs, just feedback, everything is welcome!

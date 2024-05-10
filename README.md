
# Codinstall

  

Codinstall is a script that simplifies the installation of programming languages on your system. It automates the process of checking for dependencies and installing the desired programming languages with only one command.

## Installation

**Download the script**\
There are two ways two download the script:
+ Go to the Releases and choose the latest compatible release for you package manager. This is recommended when you just want to use the script.
+ If you want to change or fork the script to your liking, you can clone the Repository onto your system with following command:
```
git clone https://github.com/Autcoder/Codinstall.git
```


## Usage
To use Codinstall there are two ways: Local Directory or Globally.

### Local
To use the script locally, follow these steps:
1. Install the script
2. Navigate to the directory where it is downloaded
3. Open directory in Terminal
4. Start the script with following command:
   ```
   ./codinstall <language1> <language2> ...
   ```
Put in as many languages as you want. It will go through them one by one.

### Globally
To use the script globally, follow these steps:
1. Install the script
2. Save it at a easy to reach directory (recommended)
3. Open the .bashrc file
   ```
   <editor(e.g. nvim)> ./bashrc
   ```
4. Add this line to your .bashrc file:
  ```
  alias codinstall='~/your_path_to_script/codinstall'
  ```
5. Replace "your_path_to_script" with your own path to where the script is located.
   Also replace "codinstall" with whatever name your installed script has.
   Make sure this file does not get moved, otherwise it wont find the script anymore!
6. (optional) Replace alias "codinstall" with whatever command you want to use when calling the script.


### Example calls
#### local command
  ```
  ./codinstall Julia Java go python 
  ```
#### Global command
  ```
  codinstall Julia Java go python
  ```


### Supported Languages

Codinstall currently supports the installation of the following programming languages:
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

Be sure to sent feedback for the script. Feature suggestions/requests, bugs, just feedback, everything is welcome!


## Changelog
#### Version 1.0
Rewritten Codinstall in Nim
- New way of Using
- Performance + User experience Improvements

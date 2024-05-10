#!/bin/bash

# Functions to check if dependencies are installed
check_tar() {
    echo "Checking if tar is installed..."
    if ! command -v tar &> /dev/null; then
        echo "Tar is not installed"
        while true; do
            read -p "Do you want to install tar? (y/n) " answer
            if [[ $answer =~ ^[Yy]$ ]]; then
                sudo dnf install -y tar
                echo "Tar installed successfully"
                return 0
                elif [[ $answer =~ ^[Nn]$ ]]; then
                echo "Skipping tar installation"
                return 1
            else
                echo "Invalid input. Please enter either 'y' or 'n'."
            fi
        done
    else
        echo "Tar is already installed"
        return 0
    fi
}

check_make() {
    echo "Checking if make is installed..."
    if ! command -v make &> /dev/null; then
        echo "Make is not installed"
        while true; do
            read -p "Do you want to install make? (y/n) " answer
            if [[ $answer =~ ^[Yy]$ ]]; then
                sudo dnf install -y make
                echo "Make installed successfully"
                return 0
                elif [[ $answer =~ ^[Nn]$ ]]; then
                echo "Skipping make installation"
                return 1
            else
                echo "Invalid input. Please enter either 'y' or 'n'."
            fi
        done
    else
        echo "Make is already installed"
        return 0
    fi
}

check_curl() {
    echo "Checking if curl is installed..."
    if ! command -v curl &> /dev/null; then
        echo "Curl is not installed"
        while true; do
            read -p "Do you want to install curl? (y/n) " answer
            if [[ $answer =~ ^[Yy]$ ]]; then
                sudo dnf install -y curl
                echo "Curl installed successfully"
                return 0
                elif [[ $answer =~ ^[Nn]$ ]]; then
                echo "Skipping Curl installation"
                return 1
            else
                echo "Invalid input. Please enter either 'y' or 'n'."
            fi
        done
    else
        echo "Curl is already installed"
        return 0
    fi
}

check_openjdk() {
    if ! command -v java &> /dev/null; then
        echo "Openjdk is not installed"
        while true; do
            read -p "Do you want to install Openjdk? [y/n] " -n 1 -r
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo dnf install -y java-latest-openjdk
                echo "Openjdk installed successfully"
                return 0
                elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "Skipping Openjdk installation"
                return 1
            else
                echo "Invalid input. Please enter either 'y' or 'n'."
            fi
        done
    else
        echo "Openjdk is already installed"
        return 0
    fi
}

check_snapd() {
    if ! command -v snap &> /dev/null; then
        echo "snapd is not installed"
        while true; do
            read -p "Do you want to install snapd? [y/n] " answer
            if [[ $answer =~ ^[Yy]$ ]]; then
                sudo dnf install -y snapd
                sudo ln -s /var/lib/snapd/snap /snap
                echo "snapd installed successfully"
                return 0
                elif [[ $answer =~ ^[Nn]$ ]]; then
                echo "Skipping snapd installation"
                return 1
            else
                echo "Invalid input. Please enter either 'y' or 'n'."
            fi
        done
    else
        echo "snapd is already installed"
        return 0
    fi
}

check_installation_success() {
    if [ $? -eq 0 ]; then
        echo "Installation successful"
        return 0
    else
        echo "Installation failed"
        return 1
    fi
}

install_smalltalk() {
    curl -O https://ftp.gnu.org/gnu/smalltalk/smalltalk-3.2.5.tar.xz
    tar xf smalltalk-3.2.5.tar.xz
    cd smalltalk-3.2.5/
    ./configure
    make
    sudo make install
    check_installation_success
    if [ $? -eq 0 ]; then
        sudo rm -rf smalltalk-3.2.5
        sudo rm smalltalk-3.2.5.tar.xz
    else
        echo "Smalltalk installation failed"
    fi
}

# Function to install everything
install_everything() {
    # Install Dependencies
    check_curl
    check_make
    check_tar
    check_openjdk
    check_snapd
    check_installation_success
    echo "Dependencies Installed"
    
    echo "Starting installation of everything"
    # Ask user if they are sure
    while true; do
        read -p "Are you sure you want to install everything? (y/n) " answer
        if [ "$answer" = "y" -o "$answer" = "Y" ]; then
            echo "Installing everything"
            break
            elif [ "$answer" = "n" -o "$answer" = "N" ]; then
            echo "Returning to main menu"
            return
        else
            echo "Invalid input"
        fi
    done
    
    sudo dnf install -y \
    gcc \
    gcc-c++ \
    clang \
    mono-devel \
    dotnet-sdk-7.0 \
    clojure \
    dub \
    fpc \
    erlang \
    elixir \
    gfortran \
    golang \
    haskell-platform \
    js-jquery \
    julia \
    kotlin \
    lua \
    opam \
    perl \
    php \
    R \
    ruby \
    rust \
    scala \
    swift \
    typescript \
    zig
    
    sudo snap install flutter --classic
    sudo snap install kotlin --classic
    sudo snap install swi-prolog
    
    install_smalltalk
    return 0
}

printLanguages() {
    languages=("Ada" "Assembly" "Brainfuck" "C and C++" "C#" "Clojure" "D" "Delphi" "Elixir" "Erlang" "F#" "Flutter" "Fortran" "Go(lang)" "Haskell" "Java" "JQuery" "Julia" "Kotlin" "Lisp" "Lua" "Nim" "Nodejs" "OCaml" "Pascal" "Perl" "PHP" "PostgreSql" "Prolog" "Python" "R" "Ruby" "Rust" "Scala" "Smalltalk" "Swift" "TypeScript" "Zig")
    sorted_languages=($(printf '%s\n' "${languages[@]}" | sort))
    for language in "${sorted_languages[@]}"; do
        printf "%s\n" "$language"
    done
}

while true; do
    # Ask the user what language to install
    echo ""
    read -p "What language do you want to install? " language
    echo ""
    
    # Install Ada
    if [ "$language" = "ada" -o "$language" = "Ada" -o "$language" = "gnat" -o "$language" = "Gnat" ]; then
        sudo dnf install fedora-gnat-project-common gprbuild gcc-gnat
        check_installation_success
        
        # Install Assembly
        elif [ "$language" = "assembly" -o "$language" = "Assembly" -o "$language" = "nasm" -o "$language" = "NASM" -o "%language" = "Nasm" ]; then
        sudo dnf install nasm
        check_installation_success
        
        # Install Brainfuck
        elif [ "$language" = "Brainfuck" -o "$language" = "brainfuck" ]; then
        sudo dnf install brainfuck
        check_installation_success
        
        # Install C
        elif [ "$language" = "C" -o "$language" = "c" ]; then
        while true; do
            read -p "Do you want to install GCC or Clang? [gcc/clang] " compiler
            if [ "$compiler" = "gcc" -o "$compiler" = "GCC" ]; then
                sudo dnf install gcc
                echo "GCC installed successfully"
                break
                elif [ "$compiler" = "clang" -o "$compiler" = "Clang" ]; then
                sudo dnf install clang
                echo "Clang installed successfully"
                break
            else
                echo "Invalid compiler choice"
            fi
        done
        
        # Install C++
        elif [ "$language" = "C++" -o "$language" = "c++" ]; then
        while true; do
            read -p "Do you want to install GCC or Clang? [gcc/clang] " compiler
            if [ "$compiler" = "gcc" -o "$compiler" = "GCC" ]; then
                sudo dnf install gcc-c++
                check_installation_success
                break
                elif [ "$compiler" = "clang" -o "$compiler" = "Clang" ]; then
                sudo dnf install clang
                check_installation_success
                break
            else
                echo "Invalid compiler choice"
            fi
        done
        
        # Install C#
        elif [ "$language" = "C#" -o "$language" = "c#" -o "$language" = "cs" -o "$language" = "CS" -o "$language" = "Csharp" -o "$language" = "CSharp" -o "$language" = "csharp" -o "$language" = "mono" -o "$language" = "Mono" -o "$language" = "netcore" -o "$language" = "Netcore" -o "$language" = "dotnet" -o "$language" = "Dotnet" ]; then
        while true; do
            read -p "Do you want to install mono or netcore? [mono/netcore] " runtime
            if [ "$runtime" = "mono" -o "$runtime" = "Mono" ]; then
                sudo dnf install mono-devel
                check_installation_success
                
                elif [ "$runtime" = "netcore" -o "$runtime" = "Netcore" ]; then
                read -p "Do you want to install version 6 or 7? [6/7] " version
                while true; do
                    if [ "$version" = "7" ]; then
                        sudo dnf install dotnet-sdk-7.0
                        check_installation_success
                        break
                        elif [ "$version" = "8" ]; then
                        sudo dnf install dotnet-sdk-8.0
                        check_installation_success
                        break
                    else
                        echo "Invalid version choice"
                    fi
                done
            fi
        done
        
        # Install Clojure
        elif [ "$language" = "Clojure" -o "$language" = "clojure" ]; then
        check_openjdk
        if [ $? -eq 0 ]; then
            sudo dnf install clojure
            check_installation_success
        else
            echo "Skipping Clojure installation"
        fi
        
        # Install D
        elif [ "$language" = "D" -o "$language" = "d" ]; then
        sudo dnf install gcc-gdc
        check_installation_success
        # Installing dub
        sudo dnf install dub
        check_installation_success
        
        elif [ "$language" = "Dart" -o "$language" = "dart" ]; then
        # Message Info
        echo "Dart is currently not supported"
        echo "I am working on adding Dart, but currently there is no other way than manually building the sdk"
        
        # Install Delphi
        elif [ "$language" = "Delphi" -o "$language" = "delphi" ]; then
        sudo dnf install fpc
        check_installation_success
        echo ""
        while true; do
            echo "Do you want to install Lazarus? [y/n] " ide
            if [ "$ide" = "y" -o "$ide" = "Y" ]; then
                sudo dnf install lazarus
                check_installation_success
                break
                elif [ "$ide" = "n" -o "$ide" = "N" ]; then
                echo "Skipping Lazarus installation"
                break
            else
                echo "Invalid choice"
            fi
        done
        
        # Install Elixir
        elif [ "$language" = "Elixir" -o "$language" = "elixir" ]; then
        sudo dnf install elixir
        check_installation_success
        
        # Install Erlang
        elif [ "$language" = "Erlang" -o "$language" = "erlang" ]; then
        sudo dnf install erlang
        check_installation_success
        
        # Install F#
        elif [ "$language" = "F#" -o "$language" = "f#" ]; then
        read -p "Do you want to install .Net Core 7 or 8? [7/8] " version
        while true; do
            if [ "$version" = "7" ]; then
                sudo dnf install dotnet-sdk-7.0
                check_installation_success
                break
                elif [ "$version" = "8" ]; then
                sudo dnf install dotnet-sdk-8.0
                check_installation_success
                break
            else
                echo "Invalid version choice"
            fi
        done
        
        # Install Flutter
        elif [ "$language" = "Flutter" -o "$language" = "flutter" ]; then
        echo "Checking if Snap is installed"
        check_snapd
        if [ $? -eq 0 ]; then
            sudo snap install flutter --classic
            check_installation_success
        else
            echo "Skipping Flutter installation"
        fi
        
        # Install Fortran
        elif [ "$language" = "Fortran" -o "$language" = "fortran" ]; then
        sudo dnf install gcc-gfortran
        check_installation_success
        
        # Install Go
        elif [ "$language" = "Go" -o "$language" = "go" -o "$language" = "Golang" -o "$language" = "golang" ]; then
        sudo dnf install golang
        check_installation_success
        
        # Install Haskell
        elif [ "$language" = "Haskell" -o "$language" = "haskell" ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
        
        # Install Java
        elif [ "$language" = "java" -o "$language" = "Java" -o "$language" = "openjdk" -o "$language" = "Openjdk" ]; then
        while true; do
            read -p "Do you want to install Openjdk or Openjdk-devel? [openjdk/openjdk-devel] " jdk
            if [ "$jdk" = "openjdk" -o "$jdk" = "Openjdk" ]; then
                # Install Openjdk
                sudo dnf install java-latest-openjdk
                check_installation_success
                break
                elif [ "$jdk" = "openjdk-devel" -o "$jdk" = "Openjdk-devel" ]; then
                sudo dnf install java-latest-openjdk-devel
                check_installation_success
                break
            else
                echo "Invalid choice"
            fi
        done
        
        # Install JQuery
        elif [ "$language" = "jQuery" -o "$language" = "JQuery" -o "$language" = "Jquery" -o "$language" = "jquery" ]; then
        sudo dnf install js-jquery
        check_installation_success
        
        # Install Kotlin
        elif [ "$language" = "Julia" -o "$language" = "julia" ]; then
        sudo dnf install julia
        check_installation_success
        
        # Install Kotlin
        elif [ "$language" = "Kotlin" -o "$language" = "kotlin" ]; then
        check_openjdk
        if [ $? -eq 0 ]; then
            check_snapd
            if [ $? -eq 0 ]; then
                sudo snap install kotlin
                check_installation_success
            else
                echo "Skipping Kotlin installation"
            fi
        else
            echo "Skipping Kotlin installation"
        fi
        
        #
        elif [ "$language" = "Lisp" -o "$language" = "lisp" ]; then
        sudo dnf install sbcl
        check_installation_success
        
        # Install Lua
        elif [ "$language" = "lua" -o "$language" = "Lua" ]; then
        sudo dnf install lua
        check_installation_success
        
        # Install Nim
        elif [ "$language" = "Nim" -o "$language" = "nim" ]; then
        curl https://nim-lang.org/choosenim/init.sh -sSf | sh
        echo ""
        echo "Complete the onscreen Instructions from the terminal"
        echo "After doing that you are ready to use nim"
        
        # Install NodeJS
        elif [ "$language" = "NodeJS" -o "$language" = "nodeJS" -o "$language" = "node" -o "$language" = "Node" ]; then
        sudo dnf install nodejs
        check_installation_success
        
        # Install OCaml
        elif [ "$language" = "OCaml" -o "$language" = "ocaml" -o "$language" = "Ocaml" -o "$language" = "oCaml" ]; then
        sudo dnf install opam
        check_installation_success
        
        # Install Pascal
        elif [ "$language" = "Pascal" -o "$language" = "pascal" ]; then
        sudo dnf install fpc
        check_installation_success
        
        # Install Perl
        elif [ "$language" = "Perl" -o "$language" = "perl" ]; then
        sudo dnf install perl
        check_installation_success
        
        # Install PHP
        elif [ "$language" = "PHP" -o "$language" = "php" ]; then
        sudo dnf install php
        check_installation_success
        
        # Install PostgreSQL
        elif [ "$language" = "PostgreSQL" -o "$language" = "postgresql" -o "$language" = "Postgresql" ]; then
        sudo dnf install postgresql postgresql-server
        check_installation_success
        
        # Install Prolog
        elif [ "$language" = "Prolog" -o "$language" = "prolog" ]; then
        check_snapd
        if [ $? -eq 0 ]; then
            sudo snap install swi-prolog
            check_installation_success
        else
            echo "Skipping Prolog installation"
        fi
        
        # Install Python
        elif [ "$language" = "Python" -o "$language" = "python" ]; then
        sudo dnf install python312
        check_installation_success
        
        # Install R
        elif [ "$language" = "R" -o "$language" = "r" ]; then
        sudo dnf install R
        check_installation_success
        
        # Install Ruby
        elif [ "$language" = "Ruby" -o "$language" = "ruby" ]; then
        while true; do
            read -p "Do you want to install ruby or ruby-devel? (ruby/ruby-devel) " ruby_or_ruby_devel
            if [ "$ruby_or_ruby_devel" = "ruby" -o "$ruby_or_ruby_devel" = "Ruby" ]; then
                sudo dnf install ruby
                check_installation_success
                break
                elif [ "$ruby_or_ruby_devel" = "ruby-devel" -o "$ruby_or_ruby_devel" = "Ruby-devel" ]; then
                sudo dnf install ruby-devel
                check_installation_success
                break
            else
                echo "Invalid input"
            fi
        done
        
        check_installation_success
        
        # Install Rust
        elif [ "$language" = "Rust" -o "$language" = "rust" ]; then
        check_curl
        if [ $? -eq 0 ]; then
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        else
            echo "Skipping Rust installation"
        fi
        check_installation_success
        
        # Install Scala
        elif [ "$language" = "Scala" -o "$language" = "scala" ]; then
        check_openjdk
        if [ $? -eq 0 ]; then
            check_curl
            if [ $? -eq 0 ]; then
                read -p "Do you want to install x86_64 scala or ARM64/aarch64 scala? [x86/ARM] " version
                while true; do
                    if [ "$version" = "x86" ]; then
                        curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup
                        check_installation_success
                        break
                        elif [ "$version" = "ARM" ]; then
                        curl -fL https://github.com/VirtusLab/coursier-m1/releases/latest/download/cs-aarch64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup
                        check_installation_success
                        break
                    fi
                done
            else
                echo "Skipping Scala installation"
            fi
        else
            echo "Skipping Scala installation"
        fi
        
        # Install Smalltalk
        elif [ "$language" = "Smalltalk" -o "$language" = "smalltalk" ]; then
        curl -O https://ftp.gnu.org/gnu/smalltalk/smalltalk-3.2.5.tar.xz
        tar xf smalltalk-3.2.5.tar.xz
        cd smalltalk-3.2.5/
        ./configure
        make
        sudo make install
        check_installation_success
        if [ $? -eq 0 ]; then
            cd ..
            sudo rm -r smalltalk-3.2.5
            sudo rm smalltalk-3.2.5.tar.xz
        else
            echo ""
        fi
        
        # Install Swift
        elif [[ $language == Swift* || $language == swift ]]; then
        sudo dnf install swift-lang
        check_installation_success
        
        # Install TypeScript
        elif [[ $language == TypeScript* || $language == typescript ]]; then
        sudo dnf install typescript
        check_installation_success
        
        # Install Zig
        elif [[ $language == Zig* || $language == zig ]]; then
        sudo dnf copr enable sentry/zig
        sudo dnf install zig
        check_installation_success
        
        # Install every single one
        elif [ "$language" = "install-all" ]; then
        install_everything
        check_installation_success
        
        elif [ "$language" = "autoinstall-all" ]; then
        read -p "Are you sure you want to autoinstall all languages? [y/n] " install
        if [[ $answer =~ ^[Yy]$ ]]; then
            sudo dnf install -y tar #tar
            sudo dnf install -y make #make
            sudo dnf install -y curl #curl
            sudo dnf install -y java-latest-openjdk-devel #java
            sudo dnf install -y fedora-gnat-project-common gprbuild gcc-gnat #ada
            sudo dnf install -y nasm #assembly
            sudo dnf install -y brainfuck #brainfuck
            sudo dnf install -y gcc #c
            sudo dnf install -y gcc-c++ #c++
            sudo dnf install -y clang #c/c++
            sudo dnf install -y mono-devel #c#
            sudo dnf install -y dotnet-sdk-8.0 #dotnet
            sudo dnf install -y clojure #clojure
            sudo dnf install -y dub #d
            sudo dnf install -y fpc #delphi, pascal
            sudo dnf install -y elixir #elixir
            sudo dnf install -y erlang #erlang
            sudo dnf install -y gfortran #fortran
            sudo dnf install -y golang #go
            sudo dnf install -y haskell-platform #haskell
            sudo dnf install -y js-jquery #jquery
            sudo dnf install -y julia #julia
            sudo dnf install -y sbcl #lisp
            sudo dnf install -y lua #lua
            sudo dnf install -y opam #ocaml
            sudo dnf install -y perl #perl
            sudo dnf install -y php #php
            sudo dnf install -y swi-prolog #prolog
            sudo dnf install -y python312 #python
            sudo dnf install -y R #r
            sudo dnf install -y ruby #ruby
            sudo dnf install -y rust cargo #rust
            sudo dnf install -y scala #scala
            sudo dnf install -y swift-lang #swift
            sudo dnf install -y typescript #typescript
            sudo dnf -y copr enable sentry/zig
            sudo dnf install -y zig #zig
            install_smalltalk
            sudo dnf install -y snapd #snap
            sudo ln -s /var/lib/snapd/snap /snap
            snap install -y flutter --classic #flutter
            snap install -y kotlin --classic #kotlin
            check_installation_success
            elif [[ $answer =~ ^[Nn]$ ]]; then
            echo "Returning to main menu"
        else
            echo "Invalid input"
        fi
        
        elif [ "$language" = "showall" ]; then
        printLanguages
        
        
        elif [ "$language" = "quit" -o "$language" = "Quit" -o "$language" = "exit" -o "$language" = "Exit" ]; then
        break
    else
        echo "Language not available or wrong input"
    fi
done

echo "Script finished"
echo "Thank you for using QuickLang"
echo ""
echo "Exiting script..."
exit 0

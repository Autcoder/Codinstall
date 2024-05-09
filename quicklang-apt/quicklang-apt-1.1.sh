#!/bin/bash

# Functions to check if dependencies are installed
check_tar() {
    echo "Checking if tar is installed..."
    if ! command -v tar &> /dev/null; then
        echo "Tar is not installed"
        while true; do
            read -p "Do you want to install tar? (y/n) " answer
            if [[ $answer =~ ^[Yy]$ ]]; then
                sudo apt install -y tar
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
                sudo apt install -y make
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
                sudo apt install -y curl
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
                sudo apt install -y java-latest-openjdk
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
                sudo apt install -y snapd
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

function check_dependencies {
    check_curl
    check_make
    check_openjdk
    check_snapd
    check_tar
}

function install_languages {
    sudo apt install -y gnat
    sudo apt install -y nasm
    sudo apt-get install -y libghc-brainfuck-dev
    sudo apt install -y gcc
    sudo apt install -y clang
    sudo apt-get install -y g++
    sudo apt install -y mono-devel
    sudo apt install -y dotnet-sdk-8.0
    sudo apt install -y clojure
    sudo apt install -y gcc-gdc
    sudo apt install -y dub
    sudo apt-get install -y dart
    sudo apt-get install -y fpc
    sudo apt-get install -y elixir
    sudo apt-get install -y erlang
    sudo snap install -y flutter --classic
    sudo apt install -y gfortran
    sudo apt install -y golang-go
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    sudo apt install -y libjs-jquery
    sudo apt install -y julia
    sudo snap install -y kotlin
    sudo apt-get install -y sbcl
    sudo apt install -y lua5.4
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh
    sudo apt-get install -y nodejs
    sudo apt install -y ocaml
    sudo apt-get install -y opam
    sudo apt-get install -y fp-compiler
    sudo apt install -y perl
    sudo apt install -y php libapache2-mod-php
    sudo apt install -y postgresql postgresql-contrib
    sudo apt-add-repository ppa:swi-prolog/stable
    sudo apt update
    sudo apt install -y swi-prolog
    sudo apt install -y python3.12 python3.12-venv
    sudo apt-get install r-base r-base-dev
    sudo apt install -y ruby-full
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    sudo apt-get -y install swift
    sudo apt install -y node-typescript
    install_scala
    install_smalltalk
    install_zig
}

install_scala() {
    check_openjdk
    if [ $? -eq 0 ]; then
        check_curl
        if [ $? -eq 0 ]; then
            read -p "Do you want to install x86_64 scala or ARM64/aarch64 scala? [x86/ARM/exit] " version
            while true; do
                if [ "$version" = "x86" ]; then
                    curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup
                    check_installation_success
                    break
                    elif [ "$version" = "ARM" ]; then
                    curl -fL https://github.com/VirtusLab/coursier-m1/releases/latest/download/cs-aarch64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup
                    check_installation_success
                    break
                    elif [ "$version" = "exit" ]; then
                    break
                else
                    echo "Invalid version choice"
                fi
            done
        else
            echo "Skipping Scala installation"
        fi
    else
        echo "Skipping Scala installation"
    fi
}

install_zig() {
    while true; do
        read -p "Do you want to install Zig from source or from a prebuilt package? [source/package/exit] " source
        # Install Zig from source
        if [ "$source" = "source" ]; then
            echo "Downloading Zig..."
            curl -o zig.tar.xz https://ziglang.org/download/0.9.0/zig-linux-x86_64-0.9.0.tar.xz
            if [ $? -eq 0 ]; then
                echo "Extracting Zig..."
                tar -xf zig.tar.xz
                sudo mv zig-linux-x86_64-0.9.0/zig /usr/local/bin/
                rm zig.tar.xz
                rm -rf zig-linux-x86_64-0.9.0
                echo "Zig has been installed successfully."
                check_installation_success
                break
            else
                echo "Failed to download Zig. Please try again."
            fi
            elif [ "$source" = "package" ]; then
            # Install Zig from package manager (snap)
            check_snapd
            if [ $? -eq 0 ]; then
                sudo snap install zig --beta --classic
                check_installation_success
                break
            else
                echo "Snapd is not installed. Please try again."
            fi
            elif [ "$source" = "exit" ]; then
            break
        else
            echo "Invalid choice. Please try again."
        fi
    done
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
        sudo apt install gnat
        check_installation_success
        
        # Install Assembly
        elif [ "$language" = "assembly" -o "$language" = "Assembly" -o "$language" = "nasm" -o "$language" = "NASM" -o "%language" = "Nasm" ]; then
        sudo apt install nasm
        check_installation_success
        
        # Install Brainfuck
        elif [ "$language" = "Brainfuck" -o "$language" = "brainfuck" ]; then
        sudo apt-get install libghc-brainfuck-dev
        check_installation_success
        
        # Install C
        elif [ "$language" = "C" -o "$language" = "c" ]; then
        while true; do
            read -p "Do you want to install GCC or Clang? [gcc/clang] " compiler
            if [ "$compiler" = "gcc" -o "$compiler" = "GCC" ]; then
                sudo apt install gcc
                echo "GCC installed successfully"
                break
                elif [ "$compiler" = "clang" -o "$compiler" = "Clang" ]; then
                sudo apt install clang
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
                sudo apt-get install g++
                check_installation_success
                break
                elif [ "$compiler" = "clang" -o "$compiler" = "Clang" ]; then
                sudo apt install clang
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
                sudo apt install mono-devel
                check_installation_success
                
                elif [ "$runtime" = "netcore" -o "$runtime" = "Netcore" ]; then
                read -p "Do you want to install version 7 or 8? [7/8] " version
                while true; do
                    if [ "$version" = "7" ]; then
                        sudo apt install dotnet-sdk-7.0
                        check_installation_success
                        break
                        elif [ "$version" = "8" ]; then
                        sudo apt install dotnet-sdk-8.0
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
            sudo apt install clojure
            check_installation_success
        else
            echo "Skipping Clojure installation"
        fi
        
        # Install D
        elif [ "$language" = "D" -o "$language" = "d" ]; then
        sudo apt install gcc-gdc
        check_installation_success
        # Installing dub
        sudo apt install dub
        check_installation_success
        
        # Install Dart
        elif [ "$language" = "Dart" -o "$language" = "dart" ]; then
        sudo apt-get install dart
        check_installation_success
        
        # Install Delphi
        elif [ "$language" = "Delphi" -o "$language" = "delphi" ]; then
        sudo apt-get install fpc
        check_installation_success
        echo ""
        while true; do
            echo "Do you want to install Lazarus? [y/n] " ide
            if [ "$ide" = "y" -o "$ide" = "Y" ]; then
                sudo apt install lazarus
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
        sudo apt-get install elixir
        check_installation_success
        
        # Install Erlang
        elif [ "$language" = "Erlang" -o "$language" = "erlang" ]; then
        sudo apt-get install erlang
        check_installation_success
        
        # Install F#
        elif [ "$language" = "F#" -o "$language" = "f#" ]; then
        read -p "Do you want to install version 7 or 8? [7/8/exit] " version
        while true; do
            if [ "$version" = "7" ]; then
                sudo apt install dotnet-sdk-7.0
                check_installation_success
                break
                elif [ "$version" = "8" ]; then
                sudo apt install dotnet-sdk-8.0
                check_installation_success
                break
                elif [ "$version" = "exit" ]; then
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
        sudo apt install gfortran
        check_installation_success
        
        # Install Go
        elif [ "$language" = "Go" -o "$language" = "go" -o "$language" = "Golang" -o "$language" = "golang" ]; then
        sudo apt install golang-go
        check_installation_success
        
        # Install Haskell
        elif [ "$language" = "Haskell" -o "$language" = "haskell" ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
        
        # Install Java
        elif [ "$language" = "java" -o "$language" = "Java" -o "$language" = "openjdk" -o "$language" = "Openjdk" ]; then
        while true; do
            read -p "Do you want to install Openjdk or Openjdk-jdk? [openjdk/openjdk-devel/exit] " jdk
            if [ "$jdk" = "openjdk" -o "$jdk" = "Openjdk" ]; then
                # Install Openjdk
                sudo apt install java-latest-openjdk
                check_installation_success
                break
                elif [ "$jdk" = "openjdk-devel" -o "$jdk" = "Openjdk-devel" ]; then
                sudo apt install openjdk-latest-jdk
                check_installation_success
                break
                elif [ "$jdk" = "exit" ]; then
                break
            else
                echo "Invalid choice"
            fi
        done
        
        # Install JQuery
        elif [ "$language" = "jQuery" -o "$language" = "JQuery" -o "$language" = "Jquery" -o "$language" = "jquery" ]; then
        sudo apt install libjs-jquery
        check_installation_success
        
        # Install Kotlin
        elif [ "$language" = "Julia" -o "$language" = "julia" ]; then
        sudo apt install julia
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
        sudo apt-get install sbcl
        check_installation_success
        
        # Install Lua
        elif [ "$language" = "lua" -o "$language" = "Lua" ]; then
        sudo apt install lua5.4
        check_installation_success
        
        # Install Nim
        elif [ "$language" = "Nim" -o "$language" = "nim" ]; then
        curl https://nim-lang.org/choosenim/init.sh -sSf | sh
        echo ""
        echo "Complete the onscreen Instructions from the terminal"
        echo "After doing that you are ready to use nim"
        
        # Install NodeJS
        elif [ "$language" = "NodeJS" -o "$language" = "nodeJS" -o "$language" = "node" -o "$language" = "Node" ]; then
        sudo apt-get install nodejs
        check_installation_success
        
        # Install OCaml
        elif [ "$language" = "OCaml" -o "$language" = "ocaml" -o "$language" = "Ocaml" -o "$language" = "oCaml" ]; then
        sudo apt install ocaml
        sudo apt-get install opam
        check_installation_success
        
        # Install Pascal
        elif [ "$language" = "Pascal" -o "$language" = "pascal" ]; then
        sudo apt-get install fp-compiler
        check_installation_success
        
        # Install Perl
        elif [ "$language" = "Perl" -o "$language" = "perl" ]; then
        sudo apt install perl
        check_installation_success
        
        # Install PHP
        elif [ "$language" = "PHP" -o "$language" = "php" ]; then
        sudo apt install php libapache2-mod-php
        check_installation_success
        
        # Install PostgreSQL
        elif [ "$language" = "PostgreSQL" -o "$language" = "postgresql" -o "$language" = "Postgresql" ]; then
        sudo apt install postgresql postgresql-contrib
        check_installation_success
        
        # Install Prolog
        elif [ "$language" = "Prolog" -o "$language" = "prolog" ]; then
        sudo apt-add-repository ppa:swi-prolog/stable
        sudo apt update
        sudo apt install swi-prolog
        check_installation_success
        
        # Install Python
        elif [ "$language" = "Python" -o "$language" = "python" ]; then
        sudo apt install python3.12 python3.12-venv
        check_installation_success
        
        # Install R
        elif [ "$language" = "R" -o "$language" = "r" ]; then
        sudo apt-get install r-base r-base-dev
        check_installation_success
        
        # Install Ruby
        elif [ "$language" = "Ruby" -o "$language" = "ruby" ]; then
        sudo apt install ruby-full
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
        install_scala
        
        # Install Smalltalk
        elif [ "$language" = "Smalltalk" -o "$language" = "smalltalk" ]; then
        install_smalltalk
        
        # Install Swift
        elif [[ $language == Swift* || $language == swift ]]; then
        sudo apt-get install swift
        check_installation_success
        
        # Install TypeScript
        elif [[ $language == TypeScript* || $language == typescript ]]; then
        sudo apt install node-typescript
        check_installation_success
        
        # Install Zig
        elif [[ $language == Zig* || $language == zig ]]; then
        install_zig
        
        # Install every single one
        elif [ "$language" = "install-all" ]; then
        install_everything
        check_installation_success
        
        # Autoinstall every single one
        elif [ "$language" = "autoinstall-all" ]; then
        read -p "Are you sure you want to autoinstall all languages? [y/n] " answer
        if [[ $answer =~ ^[Yy]$ ]]; then
            check_dependencies
            install_languages
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



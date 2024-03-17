#!/bin/bash


# Functions to check if dependencies are installed
check_tar() {
    echo "Checking if tar is installed..."
    if ! command tar --version &> /dev/null; then
        echo "Tar is not installed"
        read -p "Do you want to install tar? (y/n) " answer
        while true; do
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo dnf -y install tar
                echo "Tar installed successfully"
                return 0
                elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "Skipping tar installation"
                return 1
            else
                echo ""
            fi
        done
    else
        return 0
    fi
}

check_make() {
    echo "Checking if make is installed..."
    if ! command make -v &> /dev/null; then
        echo "Make is not installed"
        read -p "Do you want to install make? (y/n) " answer
        while true; do
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo dnf -y install make
                echo "Make installed successfully"
                return 0
                elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "Skipping make installation"
                return 1
            else
                echo ""
            fi
        done
    else
        return 0
    fi
}

check_curl() {
    echo "Checking if curl is installed..."
    if ! command curl --version &> /dev/null; then
        echo "Curl is not installed"
        read -p "Do you want to install curl? (y/n) " answer
        while true; do
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo dnf -y install curl
                echo "Curl installed successfully"
                return 0
                elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "Skipping Curl installation"
                return 1
            else
                echo ""
            fi
        done
    else
        return 0
    fi
}

check_openjdk() {
    if ! command java --version &> /dev/null; then
        echo "Openjdk is not installed"
        read -p "Do you want to install Openjdk? [y/n] " -n 1 -r
        echo
        while true; do
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo dnf install -y java-latest-openjdk
                echo "Openjdk installed successfully"
                return 0
                elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "Skipping Openjdk installation"
                return 1
            else
                echo ""
            fi
        done
    else
        return 0
    fi
}

check_snapd() {
    if ! command snap --version &> /dev/null; then
        echo "snapd is not installed"
        read -p "Do you want to install snapd? [y/n] " snapd_install
        while true; do
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo dnf install -y snapd
                sudo ln -s /var/lib/snapd/snap /snap
                echo "snapd installed successfully"
                return 0
                elif [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "Skipping snapd installation"
                return 1
            else
                echo ""
            fi
        done
    else
        return 0
    fi
}



# Function to install everything
install_everything() {
    # Install Dependencies
    sudo dnf install tar make curl java-latest-openjdk snapd
    echo "Dependencies Installed"
    
    echo "Starting installation of everything"
    # Ask user if they are sure
    read -p "Are you sure you want to install everything? (y/n) " answer
    if [ "$answer" = "y" -o "$answer" = "Y" ]; then
        echo "Installing everything"
    else
        return
    fi
    
    # Install Ada
    sudo dnf install fedora-gnat-project-common gprbuild gcc-gnat
    
    # Install Assembly
    sudo dnf install nasm
    
    # Install Basic
    sudo dnf install gnu-basic
    
    # Install Brainfuck
    sudo dnf install brainfuck
    
    # Install C and C++
    sudo dnf install gcc
    sudo dnf install gcc-c++
    sudo dnf install clang
    
    # Install C#
    sudo dnf install mono-devel
    sudo dnf install dotnet-sdk-7.0
    
    # Install Clojure
    sudo dnf install clojure
    
    # Install D
    sudo dnf install dub
    
    # Install Delphi
    sudo dnf install fpc
    
    # Install Elixir
    sudo dnf install elixir
    
    # Install Erlang
    sudo dnf install erlang
    
    # Install F#
    echo "Dotnet already installed"
    
    # Install Flutter
    sudo snap install flutter --classic
    
    # Install Fortran
    sudo dnf install gfortran
    
    # Install Go
    sudo dnf install golang
    
    # Install Haskell-Platform
    sudo dnf install haskell-platform
    
    # Install Java
    echo "Openjdk already installed"
    
    # Install JQuery
    sudo dnf install js-jquery
    
    # Install Julia
    sudo dnf install julia
    
    # Install Kotlin
    sudo snap install kotlin --classic
    
    # Install Lisp
    sudo dnf install sbcl
    
    # Install Lua
    sudo dnf install lua
    
    # Install OCaml
    sudo dnf install opam
    
    # Install Pascal
    sudo dnf install fpc
    
    # Install Perl
    sudo dnf install perl
    
    # Install PHP
    sudo dnf install php
    
    # Install Prolog
    sudo snap install swi-prolog
    
    # Install Python
    sudo dnf install python312
    
    # Install R
    sudo dnf install R
    
    # Install Ruby
    sudo dnf install ruby
    
    # Install Rust
    sudo dnf install rust cargo
    
    # Install Scala
    sudo dnf install scala
    
    # Install Smalltalk
    curl -O https://ftp.gnu.org/gnu/smalltalk/smalltalk-3.2.5.tar.xz
    tar xf smalltalk-3.2.5.tar.xz
    cd smalltalk-3.2.5/
    ./configure
    make
    sudo make install
    cd ..
    
    # Install Swift
    sudo dnf install swift-lang
    
    # Install TypeScript
    sudo dnf install typescript
    
    # Install Zig
    sudo dnf copr enable sentry/zig
    sudo dnf install zig
    
    return 0
    
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
        
        # Install Basic
        elif [ "$language" = "basic" -o "$language" = "Basic" -o "$language" = "bc" -o "$language" = "BC" ]; then
        sudo dnf install gnu-basic
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
                
                elif [ "$compiler" = "clang" -o "$compiler" = "Clang" ]; then
                sudo dnf install clang
                echo "Clang installed successfully"
                
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
                
                elif [ "$compiler" = "clang" -o "$compiler" = "Clang" ]; then
                sudo dnf install clang
                check_installation_success
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
                    if [ "$version" = "6" ]; then
                        sudo dnf install dotnet-sdk-6.0
                        check_installation_success
                        
                        elif [ "$version" = "7" ]; then
                        sudo dnf install dotnet-sdk-7.0
                        check_installation_success
                        
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
                
                elif [ "$ide" = "n" -o "$ide" = "N" ]; then
                echo "Skipping Lazarus installation"
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
        while true; do
            read -p "Do you want to install .Net Core 6 or 7? [6/7] " version
            if [ "$version" = "6" ]; then
                sudo dnf install dotnet-sdk-6.0
                check_installation_success
                
                elif [ "$version" = "7" ]; then
                sudo dnf install dotnet-sdk-7.0
                check_installation_success
                echo "F# installed successfully"
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
        
        # Install Groovy
        elif [ "$language" = "Haskell" -o "$language" = "haskell" ]; then
        while true; do
            read -p "Do you want to install stack or haskell-platform? [stack/haskell-platform] " stack
            if [ "$stack" = "stack" -o "$stack" = "Stack" ]; then
                # Installing Stack
                sudo dnf install stack
                check_installation_success
                # Installing ghc
                echo "Installing ghc"
                sudo dnf install ghc
                check_installation_success
                
                elif [ "$stack" = "haskell-platform" -o "$stack" = "Haskell-platform" ]; then
                sudo dnf install haskell-platform
                check_installation_success
            else
                echo "Invalid choice"
            fi
        done
        
        # Install Java
        elif [ "$language" = "java" -o "$language" = "Java" -o "$language" = "openjdk" -o "$language" = "Openjdk" ]; then
        while true; do
            read -p "Do you want to install Openjdk or Openjdk-devel? [openjdk/openjdk-devel] " jdk
            if [ "$jdk" = "openjdk" -o "$jdk" = "Openjdk" ]; then
                # Install Openjdk
                sudo dnf install java-latest-openjdk
                check_installation_success
                elif [ "$jdk" = "openjdk-devel" -o "$jdk" = "Openjdk-devel" ]; then
                sudo dnf install java-latest-openjdk-devel
                check_installation_success
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
        sudo dnf install ruby
        check_installation_success
        
        # Install Rust
        elif [ "$language" = "Rust" -o "$language" = "rust" ]; then
        sudo dnf install rust cargo
        check_installation_success
        
        # Install Scala
        elif [ "$language" = "Scala" -o "$language" = "scala" ]; then
        check_openjdk
        if [ $? -eq 0 ]; then
            sudo dnf install scala
            check_installation_success
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
        break
        
        
        elif [ "$language" = "quit" -o "$language" = "Quit" -o "$language" = "q" -o "$language" = "Q" -o "$language" = "exit" -o "$language" = "Exit" -o "$language" = "e" -o "$language" = "E" ]; then
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

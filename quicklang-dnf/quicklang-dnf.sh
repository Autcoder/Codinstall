#!/bin/bash


# Function to check if dependencies are installed
# Tar, make, curl
check_dependencies() {
    # Check if tar is installed
    echo "Checking if tar is installed..."
    if ! command tar --version &> /dev/null; then
        echo "tar is not installed"
        # Ask the user if they want to install tar
        read -p "Do you want to install tar? (y/n) " answer
        if [ "$answer" = "y" -o "$answer" = "Y" ]; then
            # Install tar
            sudo dnf install tar
            echo "tar installed successfully"
            echo ""
        else
            echo "Exiting script because of missing dependencies..."
            exit 1
        fi
    fi
    
    # Check if make is installed
    echo "Checking if make is installed..."
    if ! command make -v &> /dev/null; then
        echo "make is not installed"
        # Ask the user if they want to install make
        read -p "Do you want to install make? (y/n) " answer
        if [ "$answer" = "y" -o "$answer" = "Y" ]; then
            # Install make
            sudo dnf install make
            echo "make installed successfully"
            echo ""
        else
            echo "Exiting script because of missing dependencies..."
            exit 1
        fi
    fi
    
    # Check if curl is installed
    echo "Checking if curl is installed..."
    if ! command curl --version &> /dev/null; then
        echo "curl is not installed"
        # Ask the user if they want to install curl
        read -p "Do you want to install curl? (y/n) " answer
        if [ "$answer" = "y" -o "$answer" = "Y" ]; then
            # Install curl
            sudo dnf install curl
            echo "curl installed successfully"
            echo ""
        else
            echo "Exiting script because of missing dependencies..."
            exit 1
        fi
    fi
}

# Message before checking dependencies
echo "Checking dependencies..."
# Call the function
check_dependencies


while true; do
    # Ask the user what language to install
    echo ""
    read -p "What language do you want to install? " language
    echo ""
    
    
    if [ "$language" = "ada" -o "$language" = "Ada" -o "$language" = "gnat" -o "$language" = "Gnat" ]; then
        # Start installing Ada
        echo "Installing Ada"
        # Install Ada
        sudo dnf install fedora-gnat-project-common gprbuild gcc-gnat
        # Message after installing Ada
        echo "Ada installed successfully"
        
        
        elif [ "$language" = "assembly" -o "$language" = "Assembly" -o "$language" = "nasm" -o "$language" = "NASM" -o "%language" = "Nasm" ]; then
        # Start installing Assembly
        echo "Installing Assembly"
        # Install Assembly
        sudo dnf install nasm
        # Message after installing Assembly
        echo "Assembly installed successfully"
        
        
        elif [ "$language" = "basic" -o "$language" = "Basic" -o "$language" = "bc" -o "$language" = "BC" ]; then
        #Start installing Basic
        echo "Installing Basic"
        # Install Basic
        sudo dnf install gnu-basic
        # Message after installing Basic
        echo "Basic installed successfully"
        
        
        elif [ "$language" = "Brainfuck" -o "$language" = "brainfuck" ]; then
        # Start installing Brainfuck
        echo "Installing Brainfuck"
        # Install Brainfuck
        sudo dnf install brainfuck
        # Message after installing Brainfuck
        echo "Brainfuck installed successfully"
        
        
        elif [ "$language" = "C" -o "$language" = "c" ]; then
        # Start installing C
        echo "Installing C"
        # Ask the user if they want to install GCC or Clang
        read -p "Do you want to install GCC or Clang? [gcc/clang] " compiler
        if [ "$compiler" = "gcc" -o "$compiler" = "GCC" ]; then
            # Install GCC
            sudo dnf install gcc
            # Message after installing GCC
            echo "GCC installed successfully"
            
            elif [ "$compiler" = "clang" -o "$compiler" = "Clang" ]; then
            # Install Clang
            sudo dnf install clang
            # Message after installing Clang
            echo "Clang installed successfully"
            
        else
            echo "Invalid compiler choice"
        fi
        
        
        elif [ "$language" = "C++" -o "$language" = "c++" ]; then
        # Start installing C++
        echo "Installing C++"
        # Ask the user if they want to install GCC or Clang
        read -p "Do you want to install GCC or Clang? [gcc/clang] " compiler
        if [ "$compiler" = "gcc" -o "$compiler" = "GCC" ]; then
            # Install GCC
            sudo dnf install gcc-c++
            # Message after installing GCC
            echo "GCC installed successfully"
            
            elif [ "$compiler" = "clang" -o "$compiler" = "Clang" ]; then
            # Install Clang
            sudo dnf install clang
            # Message after installing Clang
            echo "Clang installed successfully"
        else
            echo "Invalid compiler choice"
        fi
        
        
        elif [ "$language" = "C#" -o "$language" = "c#" -o "$language" = "cs" -o "$language" = "CS" -o "$language" = "Csharp" -o "$language" = "CSharp" -o "$language" = "csharp" -o "$language" = "mono" -o "$language" = "Mono" -o "$language" = "netcore" -o "$language" = "Netcore" -o "$language" = "dotnet" -o "$language" = "Dotnet" ]; then
        # Start installing C#
        echo "Installing C#"
        #Ask the user if they want to install mono or netcore
        read -p "Do you want to install mono or netcore? [mono/netcore] " runtime
        if [ "$runtime" = "mono" -o "$runtime" = "Mono" ]; then
            # Install mono
            sudo dnf install mono-devel
            # Message after installing mono
            echo "Mono installed successfully"
            
            elif [ "$runtime" = "netcore" -o "$runtime" = "Netcore" ]; then
            # Ask user if they want to install version 6 or 7
            read -p "Do you want to install version 6 or 7? [6/7] " version
            if [ "$version" = "6" ]; then
                # Install netcore 6
                sudo dnf install dotnet-sdk-6.0
                # Message after installing netcore 6
                echo "Netcore 6 installed successfully"
                
                elif [ "$version" = "7" ]; then
                # Install netcore 7
                sudo dnf install dotnet-sdk-7.0
                # Message after installing netcore 7
                echo "Netcore 7 installed successfully"
                
            else
                echo "Invalid version choice"
            fi
        fi
        
        
        elif [ "$language" = "Clojure" -o "$language" = "clojure" ]; then
        # Start installing Closure
        echo "Installing Closure"
        # Check for Openjdk
        if ! command -v java &> /dev/null; then
            # Ask the user if they want to install Openjdk
            echo "Java/Openjdk is not installed"
            echo "It s needed to install Clojure"
            read -p "Do you want to install Openjdk? [y/n] " openjdk_install
            if [ "$openjdk_install" = "y" -o "$openjdk_install" = "Y" ]; then
                # Install Openjdk
                sudo dnf install openjdk
                # Message after installing Openjdk
                echo "Openjdk installed successfully"
                echo ""
                # Install Clojure
                sudo dnf install clojure
                # Message after installing Clojure
                echo "Clojure installed successfully"
            else
                echo "Skipping Openjdk and Clojure installation"
            fi
        else
            # Install Clojure
            sudo dnf install clojure
            # Message after installing Clojure
            echo "Clojure installed successfully"
        fi
        
        
        elif [ "$language" = "D" -o "$language" = "d" ]; then
        # Start installing D
        echo "Installing D"
        # Install D
        sudo dnf install gcc-gdc
        # Message after installing D
        echo "D installed successfully"
        # Start installing dub
        echo "Installing dub"
        # Installing dub
        sudo dnf install dub
        # Message after installing dub
        echo "dub installed successfully"
        
        
        elif [ "$language" = "Dart" -o "$language" = "dart" ]; then
        # Message Info
        echo "Dart is currently not supported"
        echo "I am working on adding Dart, but currently there is no other way than manually building the sdk"
        
        
        elif [ "$language" = "Delphi" -o "$language" = "delphi" ]; then
        # Start installing Delphi
        echo "Installing Delphi"
        # Install Delphi
        sudo dnf install fpc
        # Message after installing Delphi
        echo "Delphi installed successfully"
        echo ""
        echo "Do you want to install Lazarus? [y/n] " ide
        if [ "$ide" = "y" -o "$ide" = "Y" ]; then
            # Install Lazarus
            sudo dnf install lazarus
            # Message after installing Delphi IDE
            echo "Lazarus installed successfully"
        else
            echo "Skipping Lazarus installation"
        fi
        
        
        elif [ "$language" = "Elixir" -o "$language" = "elixir" ]; then
        # Start installing Elixir
        echo "Installing Elixir"
        # Install Elixir
        sudo dnf install elixir
        # Message after installing Elixir
        echo "Elixir installed successfully"
        
        
        elif [ "$language" = "Erlang" -o "$language" = "erlang" ]; then
        # Start installing Erlang
        echo "Installing Erlang"
        # Install Erlang
        sudo dnf install erlang
        # Message after installing Erlang
        echo "Erlang installed successfully"
        
        
        elif [ "$language" = "F#" -o "$language" = "f#" ]; then
        # Start installing F#
        echo "Installing F#"
        echo ""
        echo "Installing the dotnet sdk"
        # Ask if version 6 or 7 should be installed
        read -p "Do you want to install .Net Core 6 or 7? [6/7] " version
        if [ "$version" = "6" ]; then
            # Install .Net Core 6
            sudo dnf install dotnet-sdk-6.0
            # Message after installing .Net Core 6
            echo "Netcore 6 installed successfully"
            
            elif [ "$version" = "7" ]; then
            # Install .Net Core 7
            sudo dnf install dotnet-sdk-7.0
            # Message after installing .Net Core 7
            echo "Netcore 7 installed successfully"
            
        else
            echo "Invalid version choice"
        fi
        # Message after installing F#
        echo "F# installed successfully"
        
        
        elif [ "$language" = "Flutter" -o "$language" = "flutter" ]; then
        # Start installing Flutter
        echo "Checking if Snap is installed"
        # Check if Snap is installed
        if ! command snap version &> /dev/null; then
            # Ask the user if they want to install Snap
            echo "Snap is not installed"
            echo "It s needed to install Flutter"
            read -p "Do you want to install Snap? [y/n] " snap_install
            if [ "$snap_install" = "y" -o "$snap_install" = "Y" ]; then
                # Install Snap
                sudo dnf install snapd
                sudo ln -s /var/lib/snapd/snap /snap
                # Install Flutter
                sudo snap install flutter --classic
                # Message after installing Flutter
                echo "Flutter installed successfully"
            else
                echo "Skipping Snap installation"
            fi
        else
            # Install Flutter
            sudo snap install flutter --classic
            # Message after installing Flutter
            echo "Flutter installed successfully"
        fi
        
        
        elif [ "$language" = "Fortran" -o "$language" = "fortran" ]; then
        # Start installing Fortran
        echo "Installing Fortran"
        # Install Fortran
        sudo dnf install gcc-gfortran
        # Message after installing Fortran
        echo "Fortran installed successfully"
        
        
        elif [ "$language" = "Go" -o "$language" = "go" -o "$language" = "Golang" -o "$language" = "golang" ]; then
        # Start installing Go
        echo "Installing Go"
        # Install Go
        sudo dnf install golang
        # Message after installing Go
        echo "Go installed successfully"
        
        
        elif [ "$language" = "Haskell" -o "$language" = "haskell" ]; then
        # Start installing Haskell
        echo "Installing Haskell"
        # Asking user if they want to install stack or haskell-platform
        read -p "Do you want to install stack or haskell-platform? [stack/haskell-platform] " stack
        if [ "$stack" = "stack" -o "$stack" = "Stack" ]; then
            # Install stack
            sudo dnf install stack
            # Message after installing stack
            echo "stack installed successfully"
            # Installing ghc
            echo "Installing ghc"
            # Install ghc
            sudo dnf install ghc
            # Message after installing ghc
            echo "ghc installed successfully"
            elif [ "$stack" = "haskell-platform" -o "$stack" = "Haskell-platform" ]; then
            # Install haskell-platform
            sudo dnf install haskell-platform
            # Message after installing haskell-platform
            echo "Haskell-platform installed successfully"
        else
            echo "Invalid choice"
        fi
        
        
        elif [ "$language" = "java" -o "$language" = "Java" -o "$language" = "openjdk" -o "$language" = "Openjdk" ]; then
        # Start installing Java
        echo "Installing Java"
        # Ask user if they want to install Openjdk or Openjdk-devel
        read -p "Do you want to install Openjdk or Openjdk-devel? [openjdk/openjdk-devel] " jdk
        if [ "$jdk" = "openjdk" -o "$jdk" = "Openjdk" ]; then
            # Install Openjdk
            sudo dnf install java-latest-openjdk
            # Message after installing Openjdk
            echo "Openjdk installed successfully"
            elif [ "$jdk" = "openjdk-devel" -o "$jdk" = "Openjdk-devel" ]; then
            # Install Openjdk-devel
            sudo dnf install java-latest-openjdk-devel
            # Message after installing Openjdk-devel
            echo "Openjdk-devel installed successfully"
        else
            echo "Invalid choice"
        fi
        
        
        elif [ "$language" = "jQuery" -o "$language" = "JQuery" -o "$language" = "Jquery" -o "$language" = "jquery" ]; then
        # Start installing JQuery
        echo "Installing JQuery"
        # Install jQuery
        sudo dnf install js-jquery
        # Message after installing jQuery
        echo "JQuery installed successfully"
        
        
        elif [ "$language" = "Julia" -o "$language" = "julia" ]; then
        # Start installing Julia
        echo "Installing Julia"
        # Install Julia
        sudo dnf install julia
        # Message after installing Julia
        echo "Julia installed successfully"
        
        
        elif [ "$language" = "Kotlin" -o "$language" = "kotlin" ]; then
        # Start installing Kotlin
        echo "Installing Kotlin"
        # Check for Openjdk
        echo "Checking if Openjdk is installed"
        if ! command java -version &> /dev/null; then
            # Ask the user if they want to install Openjdk
            echo ""
            echo "Java/Openjdk is not installed"
            echo "It s needed to install Kotlin"
            read -p "Do you want to install Openjdk? [y/n] " openjdk_install
            if [ "$openjdk_install" = "y" -o "$openjdk_install" = "Y" ]; then
                # Start installing Openjdk
                echo "Installing Openjdk"
                # Install Openjdk
                sudo dnf install java-latest-openjdk
                # Message after installing Openjdk
                echo "Openjdk installed successfully"
                echo ""
                
                # Check if snapd is installed
                echo "Checking if snapd is installed"
                if ! command snap version &> /dev/null; then
                    # Ask the user if they want to install snap
                    echo "Snap is not installed"
                    read -p "Do you want to install snap? [y/n] " snap_install
                    if [ "$snap_install" = "y" -o "$snap_install" = "Y" ]; then
                        # Install snap
                        sudo dnf install snap
                        # Message after installing snap
                        echo "Snap installed successfully"
                        echo ""
                        
                        # Start install Kotlin
                        echo "Installing Kotlin"
                        # Install Kotlin
                        sudo snap install kotlin --classic
                        # Message after installing Kotlin
                        echo "Kotlin installed successfully"
                        echo ""
                    else
                        echo "Skipping snap installation"
                        echo "Cancelling Kotlin installation"
                    fi
                else
                    # Start install Kotlin
                    echo "Installing Kotlin"
                    # Install Kotlin
                    sudo snap install kotlin --classic
                    # Message after installing Kotlin
                    echo "Kotlin installed successfully"
                    echo ""
                fi
            else
                echo "Skipping Openjdk installation"
                echo "Cancelling Kotlin installation"
            fi
        else
            # Check if snapd is installed
            echo "Checking if snapd is installed"
            if ! command snap version &> /dev/null; then
                # Ask the user if they want to install snap
                echo "Snap is not installed"
                read -p "Do you want to install snap? [y/n] " snap_install
                if [ "$snap_install" = "y" -o "$snap_install" = "Y" ]; then
                    # Install snap
                    sudo dnf install snap
                    # Message after installing snap
                    echo "Snap installed successfully"
                    echo ""
                    
                    # Start install Kotlin
                    echo "Installing Kotlin"
                    # Install Kotlin
                    sudo snap install kotlin --classic
                    # Message after installing Kotlin
                    echo "Kotlin installed successfully"
                    echo ""
                else
                    echo "Skipping snap installation"
                    echo "Cancelling Kotlin installation"
                fi
            else
                # Start install Kotlin
                echo "Installing Kotlin"
                # Install Kotlin
                sudo snap install kotlin --classic
                # Message after installing Kotlin
                echo "Kotlin installed successfully"
                echo ""
            fi
        fi
        
        
        elif [ "$language" = "Lisp" -o "$language" = "lisp" ]; then
        # Start installing Lisp
        echo "Installing Lisp"
        # Install Lisp
        sudo dnf install sbcl
        # Message after installing Lisp
        echo "Lisp installed successfully"
        
        
        elif [ "$language" = "lua" -o "$language" = "Lua" ]; then
        # Start installing Lua
        echo "Installing Lua"
        # Install Lua
        sudo dnf install lua
        # Message after installing Lua
        echo "Lua installed successfully"
        
        
        #Malbolge
        
        
        elif [ "$language" = "Nim" -o "$language" = "nim" ]; then
        # Start installing Nim
        echo "Installing Nim"
        # Install Nim
        curl https://nim-lang.org/choosenim/init.sh -sSf | sh
        # Message after installing Nim
        echo ""
        echo "Complete the onscreen Instructions from the terminal"
        echo "After doing that you are ready to use nim"
        
        
        elif [ "$language" = "NodeJS" -o "$language" = "nodeJS" -o "$language" = "node" -o "$language" = "Node" ]; then
        # Start installing NodeJS
        echo "Installing NodeJS"
        # Install NodeJS
        sudo dnf install nodejs
        # Message after installing NodeJS
        echo "NodeJS installed successfully"
        
        
        elif [ "$language" = "OCaml" -o "$language" = "ocaml" -o "$language" = "Ocaml" -o "$language" = "oCaml" ]; then
        # Start installing OCaml
        echo "Installing OCaml"
        # Install OCaml
        sudo dnf install opam
        # Message after installing OCaml
        echo "OCaml installed successfully"
        
        
        elif [ "$language" = "Pascal" -o "$language" = "pascal" ]; then
        # Start installing Pascal
        echo "Installing Pascal"
        # Install Pascal
        sudo dnf install fpc
        # Message after installing Pascal
        echo "Pascal installed successfully"
        
        
        elif [ "$language" = "Perl" -o "$language" = "perl" ]; then
        # Start installing Perl
        echo "Installing Perl"
        # Install Perl
        sudo dnf install perl
        # Message after installing Perl
        echo "Perl installed successfully"
        
        
        elif [ "$language" = "PHP" -o "$language" = "php" ]; then
        # Start installing PHP
        echo "Installing PHP"
        # Install PHP
        sudo dnf install php
        # Message after installing PHP
        echo "PHP installed successfully"
        
        
        elif [ "$language" = "PostgreSQL" -o "$language" = "postgresql" -o "$language" = "Postgresql" ]; then
        # Start installing PostgreSQL
        echo "Installing PostgreSQL"
        # Install PostgreSQL
        sudo dnf install postgresql postgresql-server
        # Message after installing PostgreSQL
        echo "PostgreSQL installed successfully"
        
        
        elif [ "$language" = "Prolog" -o "$language" = "prolog" ]; then
        # Start installing Prolog
        echo "Installing Prolog"
        # Check is snap is installed
        if ! command snap version &> /dev/null; then
            # Ask the user if they want to install Snap
            echo "Snap is not installed"
            echo "It s needed to install Prolog"
            read -p "Do you want to install Snap? [y/n] " snap_install
            if [ "$snap_install" = "y" -o "$snap_install" = "Y" ]; then
                # Install Snap
                sudo dnf install snapd
                sudo ln -s /var/lib/snapd/snap /snap
                # Install Prolog
                sudo snap install swi-prolog
                # Message after installing Prolog
                echo "Prolog installed successfully"
            else
                echo "Skipping Snap installation"
            fi
        else
            # Install Prolog
            sudo snap install swi-prolog
            # Message after installing Prolog
            echo "Prolog installed successfully"
        fi
        
        
        elif [ "$language" = "Python" -o "$language" = "python" ]; then
        # Start installing Python
        echo "Installing Python"
        # Install Python
        curl https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tar.xz --output python.tar.xz
        tar xf python.tar.xz
        cd python/
        cd Python-3.12.2/
        ./configure
        make
        sudo make install
        # Message after installing Python
        echo "Python installed successfully"
        
        
        elif [ "$language" = "R" -o "$language" = "r" ]; then
        # Start installing R
        echo "Installing R"
        # Install R
        sudo dnf install R
        # Message after installing R
        echo "R installed successfully"
        
        
        elif [ "$language" = "Ruby" -o "$language" = "ruby" ]; then
        # Start installing Ruby
        echo "Installing Ruby"
        # Install Ruby
        sudo dnf install ruby
        # Message after installing Ruby
        echo "Ruby installed successfully"
        
        
        elif [ "$language" = "Rust" -o "$language" = "rust" ]; then
        # Start installing Rust
        echo "Installing Rust"
        # Install Rust
        sudo dnf install rust cargo
        # Message after installing Rust
        echo "Rust installed successfully"
        
        
        elif [ "$language" = "Scala" -o "$language" = "scala" ]; then
        # Start installing Scala
        echo "Installing Scala"
        # Check if Openjdk is installed
        if ! command java -version &> /dev/null; then
            # Ask the user if they want to install Openjdk
            echo "Openjdk is not installed"
            echo "It s needed to install Scala"
            read -p "Do you want to install Openjdk? [y/n] " openjdk_install
            if [ "$openjdk_install" = "y" -o "$openjdk_install" = "Y" ]; then
                # Install Openjdk
                sudo dnf install java-latest-openjdk
                # Message after installing Openjdk
                echo "Openjdk installed successfully"
                echo ""
                # Install Scala
                sudo dnf install scala
                # Message after installing Scala
                echo "Scala installed successfully"
            else
                echo "Skipping Openjdk installation"
            fi
        else
            # Install Scala
            sudo dnf install scala
            # Message after installing Scala
            echo "Scala installed successfully"
        fi
        
        
        elif [ "$language" = "Smalltalk" -o "$language" = "smalltalk" ]; then
        # Start installing Smalltalk
        echo "Installing Smalltalk"
        # Install Smalltalk
        curl -O https://ftp.gnu.org/gnu/smalltalk/smalltalk-3.2.5.tar.xz
        tar xf smalltalk-3.2.5.tar.xz
        cd smalltalk-3.2.5/
        ./configure
        make
        sudo make install
        # Message after installing Smalltalk
        echo "Smalltalk installed successfully"
        
        
        elif [ "$language" = "Swift" -o "$language" = "swift" ]; then
        # Start installing Swift
        echo "Installing Swift"
        # Install Swift
        sudo dnf install swift-lang
        # Message after installing Swift
        echo "Swift installed successfully"
        
        
        elif [ "$language" = "TypeScript" -o "$language" = "typescript" ]; then
        # Start installing TypeScript
        echo "Installing TypeScript"
        # Installing TypeScript
        sudo dnf install typescript
        # Message after installing TypeScript
        echo "TypeScript installed successfully"
        
        
        elif [ "$language" = "Zig" -o "$language" = "zig" ]; then
        # Start installing zig
        echo "Installing zig"
        # Installing zig
        sudo dnf copr enable sentry/zig
        sudo dnf install zig
        # Message after installing zig
        echo "zig installed successfully"
        
        
        elif [ "$language" = "quit" -o "$language" = "Quit" -o "$language" = "q" -o "$language" = "Q" -o "$language" = "exit" -o "$language" = "Exit" -o "$language" = "e" -o "$language" = "E" ]; then
        # Exit the script
        break
    else
        echo "Language not available or wrong input"
    fi
done

# End of script
echo "Script finished"
echo "Thank you for using QuickLang"
echo ""
echo "Exiting script..."
exit 0

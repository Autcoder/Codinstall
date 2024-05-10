import os
import strformat
import algorithm

# Dependency checking
proc dependencyInstalled*(dep: string): bool =
    var cmd = fmt"{dep} --version"
    let dependency = execShellCmd(cmd)
    if dependency == 0:
        return true
    if dependency != 0:
        if dep == "java":
            echo "Java is not installed. It is needed to install the language."
            echo "Do you want to install it? (y/n)"
            var answer = readLine(stdin)
            if answer == "y":
                discard execShellCmd("sudo dnf install java-latest-openjdk")
                return true
            else:
                return false
        elif dep == "snap":
            echo "Snap is not installed. It is needed to install the language."
            echo "Do you want to install it? (y/n)"
            var answer = readLine(stdin)
            if answer == "y":
                discard execShellCmd("sudo dnf install snapd")
                discard execShellCmd("sudo ln -s /var/lib/snapd/snap /snap")
                return true
            else:
                return false
        else:
            echo "Dependency not found: ", dep, ". It is needed to install the language."
            echo "Do you want to install it? (y/n)"
            var answer = readLine(stdin)
            if answer == "y":
                let cmd = fmt"sudo dnf install {dep}"
                discard execShellCmd(cmd)
                return true
            else:
                return false

proc checkInstallationSuccess*(integer:int) =
    if integer == 0:
        echo "Installation successful."
    else:
        echo "Installation failed."


# Installations
proc installAda() =
    checkInstallationSuccess(execShellCmd("sudo dnf install fedora-gnat-project-common gprbuild gcc-gnat"))

proc installAssembly() =
    checkInstallationSuccess(execShellCmd("sudo dnf install nasm"))

proc installBrainfuck() =
    checkInstallationSuccess(execShellCmd("sudo dnf install brainfuck"))

proc installGcc() =
    checkInstallationSuccess(execShellCmd("sudo dnf install gcc"))

proc installClang() =
    checkInstallationSuccess(execShellCmd("sudo dnf install clang"))

proc installMonoDevel() =
    checkInstallationSuccess(execShellCmd("sudo dnf install mono-devel"))

proc installDotnet(option:int) =
    checkInstallationSuccess(execShellCmd(fmt"sudo dnf install dotnet-sdk-{option}.0"))

proc installClojure() =
    if dependencyInstalled("java") == true:
        checkInstallationSuccess(execShellCmd("sudo dnf install clojure"))
    else:
        echo "Clojure failed to install because of missing dependency: java"

proc installD() =
    checkInstallationSuccess(execShellCmd("sudo dnf install dmd"))

proc installFPC() =
    checkInstallationSuccess(execShellCmd("sudo dnf install fpc"))

proc installElixir() =
    checkInstallationSuccess(execShellCmd("sudo dnf install elixir"))

proc installErlang() =
    checkInstallationSuccess(execShellCmd("sudo dnf install erlang"))

proc installFortran() =
    checkInstallationSuccess(execShellCmd("sudo dnf install gfortran"))

proc installGolang() =
    checkInstallationSuccess(execShellCmd("sudo dnf install golang"))

proc installHaskell() =
    checkInstallationSuccess(execShellCmd("curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"))

proc installJava(option:string) =
    if option == "jdk":
        checkInstallationSuccess(execShellCmd("sudo dnf install java-latest-openjdk"))
    elif option == "devel":
        checkInstallationSuccess(execShellCmd("sudo dnf install java-latest-openjdk-devel"))

proc installJQuery() =
    checkInstallationSuccess(execShellCmd("sudo dnf install jquery"))

proc installJulia() =
    checkInstallationSuccess(execShellCmd("sudo dnf install julia"))

proc installLisp() =
    checkInstallationSuccess(execShellCmd("sudo dnf install sbcl"))

proc installLua() =
    checkInstallationSuccess(execShellCmd("sudo dnf install lua"))

proc installNim() =
    checkInstallationSuccess(execShellCmd("curl https://nim-lang.org/choosenim/init.sh -sSf | sh"))

proc installNodejs() =
    checkInstallationSuccess(execShellCmd("sudo dnf install nodejs"))

proc installOCaml() =
    checkInstallationSuccess(execShellCmd("sudo dnf install opam"))

proc installPerl() =
    checkInstallationSuccess(execShellCmd("sudo dnf install perl"))

proc installPostgreSql() =
    checkInstallationSuccess(execShellCmd("sudo dnf install postgresql postgresql-server postgresql-contrib"))

proc installPHP() =
    checkInstallationSuccess(execShellCmd("sudo dnf install php"))

proc installProlog() =
    checkInstallationSuccess(execShellCmd("sudo dnf install swi-prolog"))

proc installPython() =
    checkInstallationSuccess(execShellCmd("sudo dnf install python3"))

proc installR() =
    checkInstallationSuccess(execShellCmd("sudo dnf install R"))

proc installRuby(option:string) =
    if option == "ruby":
        checkInstallationSuccess(execShellCmd("sudo dnf install ruby"))
    elif option == "devel":
        checkInstallationSuccess(execShellCmd("sudo dnf install ruby-devel"))

proc installRust() =
    checkInstallationSuccess(execShellCmd("sudo dnf install rust cargo"))

proc installScala(option:string) =
    var Curlisinstalled = dependencyInstalled("curl")
    if Curlisinstalled:
        if option == "x86":
            checkInstallationSuccess(execShellCmd("curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup"))
        elif option == "ARM":
            checkInstallationSuccess(execShellCmd("curl -fL https://github.com/VirtusLab/coursier-m1/releases/latest/download/cs-aarch64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup"))

proc installSmalltalk() =
    var CurlInstalled = dependencyInstalled("curl")
    var TarInstalled = dependencyInstalled("tar")
    var MakeInstalled = dependencyInstalled("make")
    let cmd = fmt"""
    curl -O https://ftp.gnu.org/gnu/smalltalk/smalltalk-3.2.5.tar.xz
    tar xf smalltalk-3.2.5.tar.xz
    cd smalltalk-3.2.5/
    ./configure
    make
    sudo make install
    """
    if CurlInstalled and TarInstalled and MakeInstalled:
        checkInstallationSuccess(execShellCmd(cmd))
    else:
        echo "Smalltalk failed to install because of missing dependency: curl, tar, make"

proc installSwift() =
    checkInstallationSuccess(execShellCmd("sudo dnf install swift-lang"))

proc installTypeScript() =
    checkInstallationSuccess(execShellCmd("sudo dnf install typescript"))

proc installZig() =
    discard execShellCmd("copr enable sentry/zig")
    checkInstallationSuccess(execShellCmd("sudo dnf install zig"))

proc installSnapPackage(packageName: string) =
    if dependencyInstalled("snap") == true:
        if packageName == "Kotlin":
            checkInstallationSuccess(execShellCmd("sudo snap install kotlin --classic"))
        elif packageName == "Flutter":
            checkInstallationSuccess(execShellCmd("sudo snap install flutter --classic"))
    else:
        return

proc printLanguages*() =
    const languages = @[
        "Ada", "Assembly", "Brainfuck", "C and C++", "C#", "Clojure", "D", "Delphi",
        "Elixir", "Erlang", "F#", "Flutter", "Fortran", "Go(lang)", "Haskell",
        "Java", "JQuery", "Julia", "Kotlin", "Lisp", "Lua", "Nim", "Nodejs",
        "OCaml", "Pascal", "Perl", "PHP", "PostgreSql", "Prolog", "Python", "R",
        "Ruby", "Rust", "Scala", "Smalltalk", "Swift", "TypeScript", "Zig"
    ].sorted
    for language in sorted(languages):
        echo language

proc installationProcess() =
    while true:
        echo "To exit, type exit or to see the list of languages, type showall"
        echo "What language do you want install?"
        var lang = readLine(stdin)

        if lang == "exit":
            break
        elif lang == "showall":
            printLanguages()
        
        if lang == "Ada" or lang == "ada":
            installAda()
        elif lang == "Assembly" or lang == "assembly":
            installAssembly()
        elif lang == "Brainfuck" or lang == "brainfuck":
            installBrainfuck()
        elif lang == "C" or lang == "c" or lang == "c++" or lang == "C++":
            echo "Do you want to install gcc or clang? [gcc/clang]"
            var option = readLine(stdin)
            if option == "gcc":
                installGCC()
            elif option == "clang":
                installClang()
            else:
                echo "Invalid option"
        elif lang == "C#" or lang == "c#" or lang == "Csharp" or lang == "CSharp":
            echo "Do you want to install mono or dotnet? [mono/dotnet]"
            var option = readLine(stdin)
            if option == "mono":
                installMonoDevel()
            elif option == "dotnet":
                echo "Which version do you want to install? [6/8]"
                var version = readLine(stdin)
                if version == "6":
                    installDotnet(6)
                elif version == "8":
                    installDotnet(8)
                else:
                    echo "Invalid option"
        elif lang == "Clojure" or lang == "clojure":
            installClojure()
        elif lang == "D" or lang == "d":
            installD()
        elif lang == "Delphi" or lang == "delphi":
            installFPC()
        elif lang == "Elixir" or lang == "elixir":
            installElixir()
        elif lang == "Erlang" or lang == "erlang":
            installErlang()
        elif lang == "F#" or lang == "f#" or lang == "fsharp" or lang == "FSharp":
            echo "Which version of Dotnet do you want to install? [6/8]"
            var version = readLine(stdin)
            if version == "6":
                installDotnet(6)
            elif version == "8":
                installDotnet(8)
            else:
                echo "Invalid option"
        elif lang == "Flutter" or lang == "flutter":
            installSnapPackage("Flutter")
        elif lang == "Fortran" or lang == "fortran":
            installFortran()
        elif lang == "Golang" or lang == "golang" or lang == "Go" or lang == "go":
            installGolang()
        elif lang == "Haskell" or lang == "haskell":
            installHaskell()
        elif lang == "Java" or lang == "java"  or lang == "openjdk" or lang == "Openjdk":
            echo "Do you want to install opdnjdk or openjdk-devel? [jdk/devel]"
            var option = readLine(stdin)
            if option == "jdk":
                installJava("jdk")
            elif option == "devel":
                installJava("devel")
            else:
                echo "Invalid option"
        elif lang == "JQuery" or lang == "jquery":
            installJQuery()
        elif lang == "Julia" or lang == "julia":
            installJulia()
        elif lang == "Kotlin" or lang == "kotlin":
            installSnapPackage("Kotlin")
        elif lang == "Lisp" or lang == "lisp":
            installLisp()
        elif lang == "Lua" or lang == "lua":
            installLua()
        elif lang == "Nim" or lang == "nim":
            installNim()
        elif lang == "Nodejs" or lang == "nodejs":
            installNodejs()
        elif lang == "OCaml" or lang == "ocaml":
            installOCaml()
        elif lang == "Pascal" or lang == "pascal":
            installFPC()
        elif lang == "Perl" or lang == "perl":
            installPerl()
        elif lang == "PHP" or lang == "php":
            installPHP()
        elif lang == "PostgreSql" or lang == "postgresql" or lang == "Postgresql":
            installPostgreSql()
        elif lang == "Prolog" or lang == "prolog":
            installProlog()
        elif lang == "Python" or lang == "python":
            installPython()
        elif lang == "R" or lang == "r":
            installR()
        elif lang == "Ruby" or lang == "ruby":
            installRuby("ruby")
        elif lang == "Rust" or lang == "rust":
            installRust()
        elif lang == "Scala" or lang == "scala":
            installScala("x86")
        elif lang == "Smalltalk" or lang == "smalltalk":
            installSmalltalk()
        elif lang == "Swift" or lang == "swift":
            installSwift()
        elif lang == "TypeScript" or lang == "typescript":
            installTypeScript()
        elif lang == "Zig" or lang == "zig":
            installZig()
        else:
            echo "Language not found"

installationProcess()
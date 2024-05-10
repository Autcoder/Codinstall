import std/os
import strformat
import algorithm
import strutils

# Dependency checking
proc dependencyInstalled*(dep: string): bool =
    var debinstall: string
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
                debinstall = dep
                case debinstall
                of "java":
                    discard execShellCmd("sudo dnf install java-latest-openjdk")
                    return true
                of "snap":
                    discard execShellCmd("sudo dnf install snapd")
                    discard execShellCmd("sudo ln -s /var/lib/snapd/snap /snap")
                    return true
                of "tar", "make", "curl":
                    let cmd = fmt"sudo dnf install {dep}"
                    discard execShellCmd(cmd)
                    return true
                else:
                    echo "Dependency not found."
            else:
                echo "Skipping dependency installation."
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

proc installationProcess(lang:string) =
    if lang == "exit":
        quit(0)
    elif lang == "showall":
        printLanguages()
        return
    
    case lang
    of "Ada", "ada":
        installAda()
    of "Assembly", "assembly":
        installAssembly()
    of "Brainfuck", "brainfuck":
        installBrainfuck()
    of "C", "c", "c++", "C++":
        echo "Do you want to install gcc or clang? [gcc/clang]"
        var option = readLine(stdin)
        case option
        of "gcc":
            installGCC()
        of "clang":
            installClang()
        else:
            echo "Invalid option, please choose between gcc and clang"
    of "C#", "c#", "Csharp", "CSharp":
        echo "Do you want to install mono or dotnet? [mono/dotnet]"
        var option = readLine(stdin)
        case option
        of "mono":
            installMonoDevel()
        of "dotnet":
            echo "Which version do you want to install? [6/8]"
            var version = readLine(stdin)
            case version
            of "6":
                installDotnet(6)
            of "8":
                installDotnet(8)
            else:
                echo "Invalid option, please choose between 6 and 8"
        else:
            echo "Invalid option, please choose between mono and dotnet"
    of "Clojure", "clojure":
        installClojure()
    of "D", "d":
        installD()
    of "Delphi", "delphi":
        installFPC()
    of "Elixir", "elixir":
        installElixir()
    of "Erlang", "erlang":
        installErlang()
    of "F#", "f#", "fsharp", "FSharp":
        echo "Which version of Dotnet do you want to install? [6/8]"
        var version = readLine(stdin)
        case version
        of "6":
            installDotnet(6)
        of "8":
            installDotnet(8)
        else:
            echo "Invalid option, please choose between 6 and 8"
    of "Flutter", "flutter":
        installSnapPackage("Flutter")
    of "Fortran", "fortran":
        installFortran()
    of "Golang", "golang", "Go", "go":
        installGolang()
    of "Haskell", "haskell":
        installHaskell()
    of "Java", "java", "openjdk", "Openjdk":
        echo "Do you want to install opdnjdk or openjdk-devel? [jdk/devel]"
        var option = readLine(stdin)
        case option
        of "jdk":
            installJava("jdk")
        of "devel":
            installJava("devel")
        else:
            echo "Invalid option, please choose between jdk and devel"
    of "JQuery", "jquery":
        installJQuery()
    of "Julia", "julia":
        installJulia()
    of "Kotlin", "kotlin":
        installSnapPackage("Kotlin")
    of "Lisp", "lisp":
        installLisp()
    of "Lua", "lua":
        installLua()
    of "Nim", "nim":
        installNim()
    of "Nodejs", "nodejs":
        installNodejs()
    of "OCaml", "ocaml":
        installOCaml()
    of "Pascal", "pascal":
        installFPC()
    of "Perl", "perl":
        installPerl()
    of "PHP", "php":
        installPHP()
    of "PostgreSql", "postgresql", "Postgresql":
        installPostgreSql()
    of "Prolog", "prolog":
        installProlog()
    of "Python", "python":
        installPython()
    of "R", "r":
        installR()
    of "Ruby", "ruby":
        installRuby("ruby")
    of "Rust", "rust":
        installRust()
    of "Scala", "scala":
        installScala("x86")
    of "Smalltalk", "smalltalk":
        installSmalltalk()
    of "Swift", "swift":
        installSwift()
    of "TypeScript", "typescript":
        installTypeScript()
    of "Zig", "zig":
        installZig()
    else:
        echo fmt"Language {lang} not found"

let cmdlineArgs = commandLineParams()

const minArgsRequired = 2
if cmdlineArgs.len < minArgsRequired:
    echo "Usage: quicklang <language1> <language2> ..."
    quit(1)

for lang in cmdlineArgs:
    if lang.len == 0 or lang.isEmptyOrWhitespace:
        echo "Error: Language name cannot be empty or whitespace: ", lang
        raise newException(IOError, "Invalid language name")

    echo "\n" & fmt"Installing {lang}..."
    installationProcess(lang)
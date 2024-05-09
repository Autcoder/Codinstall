import os

proc check_tar(): bool =
    echo "Checking if tar is installed..."
    if execShellCmd("tar --version") != 0:
        echo "Tar is not installed"
        return false
    else:
        echo "Tar is already installed"
        return true

proc check_make(): bool =
    echo "Checking if make is installed..."
    if execShellCmd("make --version") != 0:
        echo "Make is not installed"
        return false
    else:
        echo "Make is already installed"
        return true

proc check_curl(): bool =
    echo "Checking if curl is installed..."
    if execShellCmd("curl --version") != 0:
        echo "Curl is not installed"
        return false
    else:
        echo "Curl is already installed"
        return true

proc check_openjdk(): bool =
    echo "Checking if Java is installed..."
    if execShellCmd("java --version") != 0:
        echo "Java is not installed"
        return false
    else:
        echo "Java is already installed"
        return true

proc check_snap(): bool =
    echo "Checking if snap is installed..."
    if execShellCmd("snap --version") != 0:
        echo "Snap is not installed"
        return false
    else:
        echo "Snap is already installed"
        return true

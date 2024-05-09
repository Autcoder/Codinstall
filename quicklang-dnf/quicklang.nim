import os

proc check_tar(): bool =
    echo "Checking if tar is installed..."
    if execShellCmd("tar --version") != 0:
        echo "Tar is not installed"
        return false
    else:
        echo "Tar is already installed"
        return true

var installed = check_tar()

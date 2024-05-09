import os
import strformat

proc dependencyInstalled*(dep: string): bool =
    let cmd = fmt"{dep} --version"
    execShellCmd(cmd) == 0

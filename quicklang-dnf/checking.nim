import os
import strformat

proc dependencyInstalled*(dep: string): bool =
    let cmd = fmt"{dep} --version"
    execShellCmd(cmd) == 0

var isTarInstalled = dependencyInstalled("tar")
var isMakeInstalled = dependencyInstalled("make")
var isCurlInstalled = dependencyInstalled("curl")
var isJavaInstalled = dependencyInstalled("java")
var isSnapInstalled = dependencyInstalled("snap")

echo fmt"Tar: {isTarInstalled}"
echo fmt"Make: {isMakeInstalled}"
echo fmt"Curl: {isCurlInstalled}"
echo fmt"Java: {isJavaInstalled}"
echo fmt"Snap: {isSnapInstalled}"
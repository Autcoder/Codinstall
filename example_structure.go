package main

import (
	"fmt"
	"strings"
)

func getInstallCommand(language, manager, version string, commands map[string]string) (string, error) {
	commandTemplate, exists := commands[manager]
	if !exists {
		return "", fmt.Errorf("no command template found for %s with %s", language, manager)
	}
	command := strings.Replace(commandTemplate, "{{version}}", version, 1)
	return command, nil
}

func main() {
	// Example language and package manager data
	pythonCommands := map[string]string{
		"apt":  "sudo apt install python{{version}}",
		"yum":  "sudo yum install python{{version}}",
		"dnf":  "sudo dnf install python{{version}}",
		"brew": "brew install python@{{version}}",
	}

	language := "Python"
	packageManager := "dnf"
	version := "3.12"

	command, err := getInstallCommand(language, packageManager, version, pythonCommands)
	if err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Println("Install Command:", command)
	}
}

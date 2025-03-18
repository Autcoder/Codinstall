package executer

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

// Structures to load JSON command data.
type CommandData struct {
	Languages map[string]LanguageData `json:"languages"`
}

type LanguageData struct {
	Dependencies    []string                        `json:"dependencies"`
	PackageManagers map[string]PackageManagerConfig `json:"package_managers"`
}

type PackageManagerConfig struct {
	Versions       []interface{} `json:"versions"`
	InstallName    string        `json:"install_name"`
	InstallCommand string        `json:"install_command"`
}

var commandTemplates = map[string]string{
	"apt":  "sudo apt install",
	"yum":  "sudo yum install",
	"brew": "brew install",
	// Add more package managers as needed
}

func RunInstall(language, version string, customizations map[string]string, packageManager string) error {
	// Read the command_data.json file
	data, err := os.ReadFile("/Users/flenski/Documents/Coding/Codinstall/command_data.json")
	if err != nil {
		return err
	}

	var cmdData CommandData
	err = json.Unmarshal(data, &cmdData)
	if err != nil {
		return err
	}

	// Lookup language and package manager configuration
	langData, found := cmdData.Languages[language]
	if !found {
		return fmt.Errorf("language %s not found", language)
	}

	pmConfig, found := langData.PackageManagers[packageManager]
	if !found {
		return fmt.Errorf("package manager %s not found for language %s", packageManager, language)
	}

	installName := pmConfig.InstallName
	if strings.Contains(installName, "{{version}}") {
		installName = strings.ReplaceAll(installName, "{{version}}", version)
	}

	baseCmd, found := commandTemplates[packageManager]
	if !found {
		return fmt.Errorf("no command template for package manager %s", packageManager)
	}

	// Construct full installation command and run it
	cmdStr := fmt.Sprintf("%s %s", baseCmd, installName)
	fmt.Printf("Running command: %s\n", cmdStr)

	cmd := exec.Command("bash", "-c", cmdStr)
	output, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("failed to run command: %s, output: %s", err, string(output))
	}

	fmt.Printf("Output: %s\n", string(output))
	return nil
}

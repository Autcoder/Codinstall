package executer

import (
	"fmt"
	"log"
	"os/exec"
	"strings"

	"codinstall/config"
)

var commandTemplates = map[string]string{
	"apt":    "sudo apt install",
	"yum":    "sudo yum install",
	"brew":   "brew install",
	"dnf":    "sudo dnf install",
	"pacman": "sudo pacman -S",
	"zypper": "sudo zypper install",
	"choco":  "choco install",
	// Add more package managers as needed.
}

func RunInstall(language, version string, customizations map[string]string, packageManager string) error {
	cfg, err := config.LoadConfig()
	if err != nil {
		log.Printf("Error loading configuration: %v", err)
		return err
	}

	langConfig, found := cfg.Languages[language]
	if !found {
		return fmt.Errorf("language %s not found in configuration", language)
	}

	pmCfg, found := langConfig.PackageManagers[packageManager]
	if !found {
		return fmt.Errorf("package manager %s not found for language %s", packageManager, language)
	}

	installName := pmCfg.InstallName
	if strings.Contains(installName, "{{version}}") {
		installName = strings.ReplaceAll(installName, "{{version}}", version)
	}

	baseCmd, found := commandTemplates[packageManager]
	if !found {
		return fmt.Errorf("no command template for package manager %s", packageManager)
	}

	cmdStr := fmt.Sprintf("%s %s", baseCmd, installName)
	log.Printf("Executing install command: %s", cmdStr)
	cmd := exec.Command("bash", "-c", cmdStr)
	output, err := cmd.CombinedOutput()
	if err != nil {
		log.Printf("Command failed: %v, output: %s", err, string(output))
		return fmt.Errorf("failed to run command: %v", err)
	}
	log.Printf("Command succeeded, output: %s", string(output))
	return nil
}

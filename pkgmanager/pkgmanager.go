package pkgmanager

import (
	"errors"
	"fmt"
	"os/exec"
)

func DetectPackageManager(preferred string) (string, error) {
	// Check user-specified preference first
	if preferred != "" {
		fmt.Println("Checking for preferred package manager:", preferred)
		if _, err := exec.LookPath(preferred); err == nil {
			return preferred, nil
		}
		fmt.Println("Preferred package manager not found")
		// Log error and continue with default detection
	}
	managers := []string{"apt", "dnf", "pacman", "brew", "choco", "winget", "yum", "zypper"}
	for _, mgr := range managers {
		if _, err := exec.LookPath(mgr); err == nil {
			return mgr, nil
		}
	}
	return "", errors.New("no compatible package manager found")
}

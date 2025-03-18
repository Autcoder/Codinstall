package pkgmanager

import (
	"errors"
	"os/exec"
)

func DetectPackageManager() (string, error) {
	managers := []string{"apt", "dnf", "pacman", "brew", "choco", "winget", "yum", "zypper"}
	for _, mgr := range managers {
		if _, err := exec.LookPath(mgr); err == nil {
			return mgr, nil
		}
	}
	return "", errors.New("no compatible package manager found")
}

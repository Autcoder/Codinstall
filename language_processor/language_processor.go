package language_processor

import (
	"fmt"
	"strconv"

	"codinstall/config"
)

type LanguageInfo struct {
	Language       string
	PackageManager string
	Version        string
	Customizations map[string]string
}

// promptVersionSelection isolates the interactive version prompt.
func promptVersionSelection(versions []string) (string, error) {
	fmt.Println("Available versions:")
	for i, v := range versions {
		fmt.Printf("%d: %s\n", i+1, v)
	}
	var input string
	fmt.Print("Enter the version you want (exact version or index number): ")
	_, err := fmt.Scan(&input)
	if err != nil {
		return "", fmt.Errorf("failed to read version choice: %v", err)
	}
	// First try for an exact match.
	for _, v := range versions {
		if v == input {
			return v, nil
		}
	}
	// Try parsing as an index.
	index, err := strconv.Atoi(input)
	if err != nil || index < 1 || index > len(versions) {
		return "", fmt.Errorf("invalid version choice: %v", input)
	}
	return versions[index-1], nil
}

// ValidateLanguage confirms the language is supported and selects a version.
func ValidateLanguage(language, packageManager, providedVersion string) (LanguageInfo, error) {
	if language == "" {
		return LanguageInfo{}, fmt.Errorf("language cannot be empty")
	}

	cfg, err := config.LoadConfig()
	if err != nil {
		return LanguageInfo{}, err
	}

	if cfg.Languages == nil {
		return LanguageInfo{}, fmt.Errorf("invalid configuration: languages not found")
	}

	langConfig, ok := cfg.Languages[language]
	if !ok {
		return LanguageInfo{}, fmt.Errorf("language '%s' is not supported", language)
	}

	pmData, ok := langConfig.PackageManagers[packageManager]

	if !ok {
		return LanguageInfo{}, fmt.Errorf("package manager '%s' is not supported for language '%s'", packageManager, language)
	}

	// Extract available versions.
	var versions []string
	for _, v := range pmData.Versions {
		switch s := v.(type) {
		case string:
			versions = append(versions, s)
		default:
			versions = append(versions, fmt.Sprintf("%v", s))
		}
	}

	// Non-interactive mode: use providedVersion if available.
	if providedVersion != "" {
		for _, v := range versions {
			if v == providedVersion {
				return LanguageInfo{
					Language:       language,
					PackageManager: packageManager,
					Version:        v,
					Customizations: make(map[string]string),
				}, nil
			}
		}
		index, err := strconv.Atoi(providedVersion)
		if err == nil && index >= 1 && index <= len(versions) {
			return LanguageInfo{
				Language:       language,
				PackageManager: packageManager,
				Version:        versions[index-1],
				Customizations: make(map[string]string),
			}, nil
		}
		return LanguageInfo{}, fmt.Errorf("provided version '%s' is not valid", providedVersion)
	}

	// Interactive prompt for version selection.
	choice, err := promptVersionSelection(versions)
	if err != nil {
		return LanguageInfo{}, err
	}
	return LanguageInfo{
		Language:       language,
		PackageManager: packageManager,
		Version:        choice,
		Customizations: make(map[string]string),
	}, nil
}

package language_processor

import (
	"encoding/json"
	"fmt"
	"os"
	"strconv"
)

func ReadCommandData(filename string) (map[string]any, error) {
	data, err := os.ReadFile(filename)
	if err != nil {
		return nil, err
	}

	var result map[string]interface{}
	err = json.Unmarshal(data, &result)
	if err != nil {
		return nil, err
	}

	return result, nil
}

type LanguageInfo struct {
	Language       string
	PackageManager string
	Version        string
	Customizations map[string]string
}

// Now accepts providedVersion; if non-empty it will be used non-interactively.
func ValidateLanguage(language, packageManager, providedVersion string) (LanguageInfo, error) {
	if language == "" {
		return LanguageInfo{}, fmt.Errorf("language cannot be empty")
	}

	data, err := ReadCommandData("/Users/flenski/Documents/Coding/Codinstall/command_data.json")
	if err != nil {
		return LanguageInfo{}, err
	}

	langs, ok := data["languages"].(map[string]any)
	if !ok {
		return LanguageInfo{}, fmt.Errorf("invalid format for languages in JSON")
	}

	langData, ok := langs[language].(map[string]any)
	if !ok || langData == nil {
		return LanguageInfo{}, fmt.Errorf("language '%s' is not supported", language)
	}
	pmMap, ok := langData["package_managers"].(map[string]any)
	if !ok || pmMap == nil {
		return LanguageInfo{}, fmt.Errorf("package managers for language '%s' not found", language)
	}

	if _, ok = pmMap[packageManager]; !ok {
		return LanguageInfo{}, fmt.Errorf("package manager '%s' is not supported for language '%s'", packageManager, language)
	}

	verData, ok := pmMap[packageManager].(map[string]any)
	if !ok || verData == nil {
		return LanguageInfo{}, fmt.Errorf("invalid format for package manager data")
	}
	versionsInterface, ok := verData["versions"].([]any)
	if !ok || len(versionsInterface) == 0 {
		return LanguageInfo{}, fmt.Errorf("no versions available for language '%s' with package manager '%s'", language, packageManager)
	}
	var versions []string
	for _, v := range versionsInterface {
		if versionStr, ok := v.(string); ok {
			versions = append(versions, versionStr)
		} else {
			versions = append(versions, fmt.Sprintf("%v", v))
		}
	}

	// Use providedVersion if non-empty
	if providedVersion != "" {
		// Check for an exact match first
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
		// If not an exact match, try interpreting as 1-based index
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

	// Interactive prompt if no version is provided
	fmt.Println("Available versions:")
	for i, v := range versions {
		fmt.Printf("%d: %s\n", i+1, v)
	}
	var input string
	fmt.Print("Enter the version you want (exact version or index number): ")
	_, err = fmt.Scan(&input)
	if err != nil {
		return LanguageInfo{}, fmt.Errorf("failed to read version choice: %v", err)
	}
	for _, v := range versions {
		if v == input {
			return LanguageInfo{
				Language:       language,
				PackageManager: packageManager,
				Version:        v,
				Customizations: make(map[string]string),
			}, nil
		}
	}
	index, err := strconv.Atoi(input)
	if err != nil || index < 1 || index > len(versions) {
		return LanguageInfo{}, fmt.Errorf("invalid version choice: %v", input)
	}
	return LanguageInfo{
		Language:       language,
		PackageManager: packageManager,
		Version:        versions[index-1],
		Customizations: make(map[string]string),
	}, nil
}

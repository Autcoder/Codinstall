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

func ValidateLanguage(language string, packageManager string) (LanguageInfo, error) {
	if language == "" {
		return LanguageInfo{}, fmt.Errorf("language cannot be empty")
	}

	// Load command_data.json
	data, err := ReadCommandData("/Users/flenski/Documents/Coding/Codinstall/command_data.json")
	if err != nil {
		return LanguageInfo{}, err
	}

	// Check if language is supported
	langs, ok := data["languages"].(map[string]any)
	if !ok {
		return LanguageInfo{}, fmt.Errorf("invalid format for languages in JSON")
	}
	languagesList := make([]string, 0, len(langs))
	for lang := range langs {
		languagesList = append(languagesList, lang)
	}

	// Check for the specific language and its package_managers
	langData, ok := langs[language].(map[string]any)
	if !ok || langData == nil {
		return LanguageInfo{}, fmt.Errorf("language '%s' is not supported", language)
	}
	pmMap, ok := langData["package_managers"].(map[string]any)
	if !ok || pmMap == nil {
		return LanguageInfo{}, fmt.Errorf("package managers for language '%s' not found", language)
	}
	packageManagersList := make([]string, 0, len(pmMap))
	for pm := range pmMap {
		packageManagersList = append(packageManagersList, pm)
	}

	// Check if package manager is supported
	_, ok = pmMap[packageManager]
	if !ok {
		return LanguageInfo{}, fmt.Errorf("package manager '%s' is not supported for language '%s'", packageManager, language)
	} else {
		fmt.Println("Package manager is supported")
	}

	// List all Versions for the language in that package manager and let user choose one
	versionData, ok := pmMap[packageManager].(map[string]any)
	if !ok || versionData == nil {
		return LanguageInfo{}, fmt.Errorf("invalid format for package manager data")
	}
	versionsInterface, ok := versionData["versions"].([]interface{})
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
	fmt.Println("Available versions:")
	for i, v := range versions {
		fmt.Printf("%d: %s\n", i+1, v)
	}

	// Read input as a string
	var input string
	fmt.Print("Enter the version you want (exact version or index number): ")
	_, err = fmt.Scan(&input)
	if err != nil {
		return LanguageInfo{}, fmt.Errorf("failed to read version choice: %v", err)
	}

	// Check if input exactly matches one of the versions
	for _, v := range versions {
		if v == input {
			fmt.Println("Chosen version:", v)
			return LanguageInfo{
				Language:       language,
				PackageManager: packageManager,
				Version:        v,
			}, nil
		}
	}

	// If no exact match, try parsing input as 1-based index
	index, err := strconv.Atoi(input)
	if err != nil || index < 1 || index > len(versions) {
		return LanguageInfo{}, fmt.Errorf("invalid version choice: %v", input)
	}
	chosenVersion := versions[index-1]
	fmt.Println("Chosen version:", chosenVersion)

	return LanguageInfo{
		Language:       language,
		PackageManager: packageManager,
		Version:        chosenVersion,
	}, nil
}

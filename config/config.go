package config

import (
	"encoding/json"
	"os"
)

type Config struct {
	Languages map[string]LanguageConfig `json:"languages"`
}

type LanguageConfig struct {
	Dependencies    []string                        `json:"dependencies"`
	PackageManagers map[string]PackageManagerConfig `json:"package_managers"`
}

type PackageManagerConfig struct {
	Versions       []interface{} `json:"versions"`
	InstallName    string        `json:"install_name"`
	InstallCommand string        `json:"install_command,omitempty"`
}

var cachedConfig *Config

// LoadConfig reads the unified configuration from config/config.json.
func LoadConfig() (*Config, error) {
	if cachedConfig != nil {
		return cachedConfig, nil
	}
	data, err := os.ReadFile("./config/command_data.json")
	if err != nil {
		return nil, err
	}
	var cfg Config
	err = json.Unmarshal(data, &cfg)
	if err != nil {
		return nil, err
	}
	cachedConfig = &cfg
	return cachedConfig, nil
}

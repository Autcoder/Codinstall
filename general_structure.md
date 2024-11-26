# General Structure of Codinstall

This project provides a modular system for installing programming languages across various package managers. It’s divided into separate modules, each responsible for a distinct part of the process. Below is an overview of each module, key functions, and how they interact.

---

## 1. `codinstall.go` - Main Entry Point

This file is the entry point for the project, handling command-line arguments and orchestrating the installation process.

**Functions and Purpose**:

- **`main()`**: Initializes the application, parses command-line arguments, and calls other modules.
- **`parseArguments()`**: Processes the arguments provided by the user (e.g., `language`, `version`, flags).
- **`runInstallation(language string, version string, flags map[string]string)`**:
  - Main function that triggers the installation process for the specified language and version.
  - Calls functions in `pkgmanager`, `language_processor`, and `executer` to detect the package manager, validate language data, and run the command.

**Notes**:

- This file does not contain actual installation commands but instead coordinates the flow of the installation process.
- It relies on the output from `pkgmanager` to choose the package manager, `language_processor` to validate language and version info, and `executer` to construct and execute the command.

---

## 2. `pkgmanager/` - Package Manager Detection

This module is responsible for detecting the system’s available package managers and managing user preferences.

**Functions and Purpose**:

- **`DetectPackageManager() (string, error)`**:
  - Detects the system’s default package manager (e.g., `apt`, `yum`, `brew`) by checking for availability in the environment.
  - Returns the detected or user-preferred package manager based on arguments provided in `codinstall.go`.
- **`IsPackageManagerAvailable(manager string) bool`**:
  - Helper function that verifies if a specified package manager is available on the system.
- **`SelectPackageManager(preference string) (string, error)`**:
  - Allows users to specify a package manager preference using a `--prefer` flag. If unavailable, defaults to the system-detected package manager.

**Notes**:

- Outputs the selected package manager to `executer`.
- Handles multiple package managers, helping ensure compatibility on different systems.

---

## 3. `language_processor/` - Language Data Processing

This module loads and processes language data from the `language_data.json` configuration file. It checks if the specified language and version are valid and manages customization options.

**Functions and Purpose**:

- **`loadLanguageData() (*LanguageData, error)`**:
  - Loads and parses `language_data.json` to create a structured data format.
  - Provides `language_processor` and `executer` with access to valid languages, versions, and package managers.
- **`ValidateLanguage(language string) (LanguageInfo, error)`**:
  - Verifies that the requested language is supported, returning details (like versions) or an error if unsupported.
- **`ValidateVersion(language LanguageInfo, version string) (string, error)`**:
  - Confirms the availability of a specific version for the chosen language; defaults to the latest if none specified.
- **`ProcessCustomizations(language string, flags map[string]string) (map[string]string, error)`**:
  - Checks if the language requires or allows customizations, like architecture (e.g., x86 or ARM), and processes any relevant flags.

**Notes**:

- Ensures that all language data is correctly parsed and validated before passing it to `executer`.
- `language_processor` focuses on **retrieving and validating language data**, while `executer` uses this information for installation.

---

## 4. `executer/` - Command Execution and Installation

The `executer` module is responsible for constructing and running installation commands based on the chosen language, package manager, version, and any customizations.
It also stores the different install command templates for each package manager.

**Functions and Purpose**:

- **`RunInstall(language string, version string, customizations map[string]string, packageManager string) error`**:
  - Core function that initiates the installation command.
  - Takes information from `language_processor` and `pkgmanager` to create the final command, e.g., `sudo apt install python3.10`.
- **`ConstructCommand(languageInfo LanguageInfo, packageManager string, version string, customizations map[string]string) (string, error)`**:
  - Assembles the command string based on the selected language, package manager, version, and any customizations.
  - Supports variations in syntax (e.g., using `g++` for `C++`) based on templates defined in `language_data.json`.
- **`ExecuteCommand(command string) error`**:
  - Executes the constructed command using Go’s `exec.Command`, displaying output and error messages.
  - Logs success or failure and provides feedback to the user.
- **`VerifyInstallation(language string) bool`** (optional):
  - Checks if the installation was successful by verifying if the language binary is in the system path.

**Command Templates**:
Dictionsary of command templates for each package manager:

```go
package executer

// commandTemplates is a map that associates package managers with their install command templates.
var commandTemplates = map[string]string{
 "apt":  "sudo apt install",
 "yum":  "sudo yum install",
 "brew": "brew install",
 // Add more package managers as needed
}
```

**Notes**:

- `executer` is the only module responsible for actually running commands.
- Uses templates to manage command variations, allowing easy customization across package managers.

---

## 5. `language_data.json` - Configuration File

This JSON file contains data on supported languages, including available versions, customization options, and compatible package managers.

**Example Structure**:

```json
{
  "languages": {
    "Python": {
      "versions": ["3.9", "3.10", "3.11"],
      "available_package_managers": ["apt", "yum", "brew"],
      "install_names": {
        "apt": "python{{version}}",
        "yum": "python{{version}}",
        "dnf": "python{{version}}",
        "brew": "python@{{version}}"
      }
    },
    "C++": {
      "versions": ["11", "14", "17", "20"],
      "available_package_managers": ["apt", "yum", "brew"],
      "install_names": {
        "apt": "g++-{{version}}",
        "yum": "gcc-c++",
        "dnf": "gcc-c++-{{version}}",
        "brew": "gcc@{{version}}"
      }
    },
    "Scala": {
      "versions": ["2.13", "3.0"],
      "available_package_managers": ["apt", "brew"],
      "install_names": {
        "apt": "scala-{{version}}",
        "brew": "scala@{{version}}"
      },
      "customizations": {
        "arch": ["x86", "ARM"]
      }
    }
  }
}
```

**Notes**:

- This file is the **source of truth** for language information, versioning, and installation commands.
- Adding or updating languages, package managers, or customizations is as simple as modifying this file.

---

### Summary of Interaction

1. **`codinstall.go`**: Parses arguments and initiates installation.
2. **`pkgmanager/`**: Detects the system’s package manager.
3. **`language_processor/`**: Loads language data and validates user input.
4. **`executer/`**: Builds and executes installation commands.
5. **`language_data.json`**: Stores all configurable language and version data.

This modular approach makes it easy to extend functionality, support new languages, or add more package managers by updating individual components or the JSON file, minimizing the need for code changes across the project.

If you want to contribute to this project, please follow this general structure and naming conventions to ensure consistency and maintainability. Happy coding!

---

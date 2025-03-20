package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"strings"

	"codinstall/executer"
	"codinstall/language_processor"
	"codinstall/pkgmanager"
)

func main() {
	helpFlag := flag.Bool("help", false, "Display usage information")
	// Re-introduce a global version flag so that it works when placed before a language.
	versionFlag := flag.String("version", "", "Specify version non-interactively for the first language")
	preferFlag := flag.String("prefer", "", "Specify package manager preference")
	flag.Parse()

	if *helpFlag {
		fmt.Println("Usage: codinstall [options] <language> [--version=...] <language> [--version=...] ...")
		fmt.Println("Options:")
		fmt.Println("  -help                Display this help message")
		fmt.Println("  -prefer              Specify package manager preference (e.g., brew, apt)")
		fmt.Println("  -version=<version>   Specify version non-interactively for the first language")
		// fmt.Println("  --version=<version>  Specify version for the following language")
		os.Exit(0)
	}

	args := flag.Args()
	if len(args) == 0 {
		fmt.Println("No arguments provided")
		fmt.Println("Example: codinstall -version=3.13 python")
		os.Exit(1)
	}

	mgr, err := pkgmanager.DetectPackageManager(*preferFlag)
	if err != nil {
		log.Println("Error detecting package manager:", err)
		os.Exit(1)
	}

	// Start with the global version flag value.
	currentVersion := *versionFlag
	for i := range args {
		arg := args[i]
		if strings.HasPrefix(arg, "-version=") {
			currentVersion = strings.TrimPrefix(arg, "-version=")
			continue
		}
		// Treat arg as a language
		lang := strings.ToLower(arg)
		log.Printf("Installing %s...", lang)
		langInfo, err := language_processor.ValidateLanguage(lang, mgr, currentVersion)
		currentVersion = "" // Reset after use, so additional languages won't use previous version.
		if err != nil {
			log.Println("Error:", err)
			continue
		}
		err = executer.RunInstall(lang, langInfo.Version, langInfo.Customizations, mgr)
		if err != nil {
			log.Println("Installation error:", err)
		}
	}
}

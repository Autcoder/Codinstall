package main

import (
	"flag"
	"fmt"
	"os"
	"strings"

	"codinstall/executer"
	"codinstall/language_processor"
	"codinstall/pkgmanager"
)

func main() {

	// Parse the arguments from the cli command
	flag.Parse()
	args := flag.Args()
	if len(args) == 0 {
		fmt.Println("No arguments provided")
		fmt.Println("Example usage: codinstall <language1> <language2> ...")
		fmt.Println("\nFor more information, run 'codinstall --help'")
		os.Exit(1)
	}

	// For each language, validate and run install process
	for _, lang := range args {
		lang = strings.ToLower(lang)
		fmt.Printf("Installing %s...\n", lang)
		pm, err := pkgmanager.DetectPackageManager()
		if err != nil {
			fmt.Println("Error:", err)
			continue
		}
		langInfo, err := language_processor.ValidateLanguage(lang, pm)
		if err != nil {
			fmt.Println("Error:", err)
			continue
		}

		err = executer.RunInstall(lang, langInfo.Version, langInfo.Customizations, pm)
		if err != nil {
			fmt.Println("Installation error:", err)
		}
	}
}

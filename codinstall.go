package main

import (
	"flag"
	"fmt"
	"os"
)

/*
"codinstall/executer"           // Import the executer package
"codinstall/language_processor" // Import the language_processor package
"codinstall/pkgmanager"         // Import the pkgmanager package
*/

func main() {

	// Parse the arguments from the cli command
	flag.Parse()
	args := flag.Args()
	if len(args) > 0 {
		for _, arg := range args {
			fmt.Println(arg)
		}
	} else {
		fmt.Println("No arguments provided") // TODO: Automatically display help command
		os.Exit(1)
	}

	// Run the installation process
	// err := executer.RunInstall(language, version, customizations, packageManager)
	// if err != nil {
	// 	fmt.Println("Error:", err)
	// 	os.Exit(1)
	// }

}

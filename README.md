# monifactory2crafty

This is the script, that will re-pack standart [Monifactory](https://github.com/ThePansmith/Monifactory)-server ZIP into correct, ready-to-import into Crafty4 ZIP archive.

> [!WARNING]
> This script is not officially supported by Monifactory's author. Use it at your own risk.

> [!CAUTION]
> Currently only PowerShell script tested. `sh` need to be rewritten.

## Usage

Put necessary files into `files-to-add`'s subfolders, then run

```PowerShell
.\install-forge.ps1 <path-to-forge-installer-jar> <path-to-monifactory-zip>
```

it will output `.zip` file with the postfix `-crafty` in the same folder.

World is accepted in ZIP format. If you are exporting save from singleplayer mode, this folder is named like `Monifactory/saves/<world>` and should be archived.
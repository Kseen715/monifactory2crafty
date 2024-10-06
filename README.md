# monifactory2crafty

This is the script, that will re-pack standart [Monifactory](https://github.com/ThePansmith/Monifactory)-server ZIP into correct, ready-to-import into Crafty4 ZIP archive.

> [!WARNING]
> This script is not officially supported by Monifactory's author. Use it at your own risk.

> [!CAUTION]
> Currently only PowerShell script tested. `sh` need to be rewritten.

## Usage

> [!NOTE]
> Forge 1.20.1 requires Java 17 minimal, so you need to install it on your server.

> [!CAUTION]
> By running the command below, you agree to the [Minecraft EULA](https://account.mojang.com/documents/minecraft_eula).

Put necessary files into `files-to-add`'s subfolders, then run

```PowerShell
.\install-forge.ps1 <path-to-forge-installer-jar> <path-to-monifactory-zip>
```

it will output `.zip` file with the postfix `-crafty` in the same folder.

World is accepted in ZIP format. If you are exporting save from singleplayer mode, this folder is named like `Monifactory/saves/<world>` and should be archived.

## Import

To import this world into Crafty4, you need to use `import ZIP`. As this pack uses "chonker" forge, I suggets to use [this](https://wiki.craftycontrol.com/en/4/docs/Getting%20Started#forge-1-18-or-1-19) guide to correctly install Forge on Crafty4.

After the re-packing file `crafty4-table.txt` should be created. It contains all the necessary information for the steps of the guide.

I use 6G of RAM for the server, but you can change it. 

> [!TIP]
> Do not go below 4G, as it may cause server to crash. And also its better to have less than one RAM stick capacity, as it may cause server to statter (lag) a bit.

## Notes

Files in `file-stash` are not used in the script and are just for reference. 
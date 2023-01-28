# System Platform
Windows 11

## Syslink
`mklink [[/D] | [/H] | [/J]] <link> <target>`

`/D`: Creates a directory symbolic link. By default, this command creates a file symbolic link.

Create syslink using `mklink` within `Command Prompt` (cmd.exe) not `PowerShell`, because `mklink` is not a standalone executable, it's built-in to the Command Prompt.

Remember run `Command Prompt` as administrator, or you'll get `Access is denied` error.

- Neovim `0.8.2`

    `mklink /D C:\Users\[username]\AppData\Local\nvim [local_repo_path]\dotfiles\Neovim\nvim`

    **Attention** Before execuate this command, be sure that `nvim` folder (or file if you syslink a file) *DOES NOT EXIST* in `$env:LOCALAPPDATA` (that is `C:\Users\[username]\AppData\Local`), it will link `nvim` folder into `$env:LOCALAPPDATA`, in other words, folder `nvim` will be created in `$env:LOCALAPPDATA`. If not, after execuation, there will be an error: *Cannot create a file when that file already exists*.

-  PowerShell `7.3.1`

    `mklink C:\Users\[username]\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 [local_repo_path]\dotfiles\PowerShell\Microsoft.PowerShell_profile.ps1`

## Neovim
Neovim config

## PowerShell
Windows Terminal PowerShell config

The config file (Microsoft.PowerShell_profile.ps1) path of PowerShell 5 is located in `C:\Users\[username]\Documents\WindowsPowerShell`，different from PowerShell 7.

echo '$env:http_proxy="http://127.0.0.1:7890"'
echo '$env:https_proxy="http://127.0.0.1:7890"'

# Import-Module oh-my-posh
# Set-PoshPrompt -Theme pure
oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/pure.omp.json | Invoke-Expression

# Import-Module ZLocation; Add-Content -Value "`r`n`r`nImport-Module ZLocation`r`n" -Encoding utf8 -Path $PROFILE.CurrentUserAllHosts
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }

$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Tab键会出现自动补全菜单
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# 上下方向键箭头，搜索历史中进行自动补全
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module posh-git # git的自动补全

Invoke-Expression (& { (lua "C:/Program Files/z.lua-1.8.16/z.lua" --init powershell) -join "`n" })

# Remove-Item alias:curl

function get-gitstatus {
  git status
}
Set-Alias -Name gst -Value get-gitstatus

function get-gitdiff {
  git diff
}
Set-Alias -Name gd -Value get-gitdiff

function get-gitpush {
  git push
}
Set-Alias -Name ggpush -Value get-gitpush

function get-gitcheckout {
  & git checkout $args
}
Set-Alias -Name gco -Value get-gitcheckout

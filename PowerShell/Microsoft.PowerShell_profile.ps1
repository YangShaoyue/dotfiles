echo '$env:http_proxy="http://127.0.0.1:7890"'
echo '$env:https_proxy="http://127.0.0.1:7890"'

# Import-Module oh-my-posh
# Set-PoshPrompt -Theme pure
oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/pure.omp.json | Invoke-Expression

Import-Module ZLocation; Add-Content -Value "`r`n`r`nImport-Module ZLocation`r`n" -Encoding utf8 -Path $PROFILE.CurrentUserAllHosts
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }

# Tab键会出现自动补全菜单
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# 上下方向键箭头，搜索历史中进行自动补全
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module posh-git # git的自动补全

# Remove-Item alias:curl

function get-gitstatus() {
  git status
}
function get-gitdiff() {
  git diff
}
function get-gitpush() {
  git push
}
Set-Alias -Name gst -Value get-gitstatus
Set-Alias -Name gd -Value get-gitdiff
Set-Alias -Name ggpush -Value get-gitpush

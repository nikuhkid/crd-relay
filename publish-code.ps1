param(
  [Parameter(Mandatory=$true)]
  [string]$Code
)

$ErrorActionPreference = 'Stop'
$Repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$Payload = [ordered]@{
  code = $Code
  updated = (Get-Date).ToUniversalTime().ToString('o')
} | ConvertTo-Json -Compress
Set-Content -LiteralPath (Join-Path $Repo 'code.json') -Encoding UTF8 -Value $Payload

git -C $Repo add code.json
git -C $Repo commit -m "Publish CRD code"
git -C $Repo push origin main

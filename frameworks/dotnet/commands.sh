# -------------------------------------------------

# Install dotnet on Powershell
Invoke-WebRequest https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -Channel 8.0 -InstallDir "$env:USERPROFILE\dotnet"
[Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";$env:USERPROFILE\dotnet", [EnvironmentVariableTarget]::User)
dotnet --version
Remove-Item .\dotnet-install.ps1

# -------------------------------------------------

dotnet restore
dotnet build
dotnet publish -c Release -o out
dotnet <api.dll>

# -------------------------------------------------

#pre requirements
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

$javaUrl = "https://download.oracle.com/java/17/archive/jdk-17.0.6_windows-x64_bin.msi"
$pythonUrl = "https://www.python.org/ftp/python/3.4.4/python-3.4.4.amd64.msi"


$javaInstallerPath = "$env:TEMP\jdk-17.0.6_windows-x64_bin.ms"
$pythonInstallerPath = "$env:TEMP\python-3.4.4-amd64.msi"

python -m venv "$env:TEMP\venv"
"$env:TEMP\venv\Scripts\activate.bat"


Write-Host "Baixando Java..."
Invoke-WebRequest -Uri $javaUrl -OutFile $javaInstallerPath

Write-Host "Instalando Java..."
Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList "/i $javaInstallerPath /quiet"

Write-Host "Baixando Python..."
Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstallerPath

Write-Host "Instalando Python..."
Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList "/i $pythonInstallerPath /quiet InstallAllUsers=1 Include_pip=1"

C:\Python34\python.exe -m pip install nvidia-nvml-dev-cu12

"$env:TEMP\venv\Scripts\deactivate.bat"


Remove-Item $javaInstallerPath
Remove-Item $pythonInstallerPath
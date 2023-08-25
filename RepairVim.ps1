$7ZipUrl = "https://github.com/Anschluss-zeit/vim-config/raw/main/7z2301-x64.exe"
$7ZipInstallerPath = "$env:TEMP\7z_installer.exe"
$7ZipPath = "C:\Program Files\7-Zip"
echo "正在修复 7Zip"
Invoke-WebRequest -Uri $7ZipUrl -OutFile $7ZipInstallerPath
Start-Process -Wait -FilePath $7ZipInstallerPath -ArgumentList "/S"
Remove-Item $7ZipInstallerPath

$existingPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
$newPaths = $7ZipPath
$newPath = $newPaths -join ';'
$newPath = $newPath + ';' + $existingPath
[System.Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)

$VimInstallerUrl = "https://github.com/vim/vim-win32-installer/releases/download/v9.0.0000/gvim_9.0.0000_x86_signed.exe"
$VimInstallerPath = "$env:TEMP\vim_installer.exe"
$VimInstallDir = "D:\Vim"

echo "正在修复 Vim90"

$GitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.1/Git-2.42.0-64-bit.exe"
$GitInstallerPath = "$env:TEMP\git_installer.exe"
$GitInstallDir = "D:\Git"

echo "正在修复 Git v2.42.0"

echo "安装Vim-Plug，添加配置文件"
$VimPlugPath = "$env:USERPROFILE\vimfiles\autoload\plug.vim"
$VimrcPath = "$env:USERPROFILE\_vimrc"
$VimPlugUri = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
$VimrcUri = "https://raw.githubusercontent.com/Anschluss-zeit/vim-config/main/.vimrc"
New-Item -ItemType Directory -Force -Path $env:USERPROFILE\vimfiles\autoload
Invoke-WebRequest -Uri $VimPlugUri -OutFile $VimPlugPath
Invoke-WebRequest -Uri $VimrcUri -OutFile $VimrcPath

echo "修复Path环境变量"
$existingPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
$newPaths = "$VimInstallDir\vim90", "$GitInstallDir\bin", "$MingwInstallDir\mingw64\bin"
$newPath = $newPaths -join ';'
$newPath = $newPath + ';' + $existingPath
[System.Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)

Read-Host -Prompt "脚本执行完毕，按下回车键以继续..."
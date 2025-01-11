param (
    [string]$selectedMatch  # 用于接收指定的版本
)

$ErrorActionPreference = "Stop"

# 如果没有传入版本，则获取可选版本并弹出选择界面
if (-not $selectedMatch) {
    Write-Output "获取可选择的版本..."
    $url = "https://github.com/lsby/portable-nodejs/releases/expanded_assets/nodejs"
    $response = Invoke-WebRequest -Uri $url
    $htmlContent = $response.Content
    $pattern = 'node-(.*?)-win-x64.zip'
    $matches = [regex]::Matches($htmlContent, $pattern)
    $uniqueMatches = @{}
    foreach ($match in $matches) {
        $uniqueMatches[$match.Value] = $true
    }

    # 弹出选择界面
    $selectedMatch = $uniqueMatches.Keys | Out-GridView -Title "Select a match" -OutputMode Single

    # 如果用户没有选择任何版本，退出脚本
    if ([string]::IsNullOrEmpty($selectedMatch)) {
        Write-Output "用户没有选择任何版本, 脚本将退出..."
        exit
    }
}

Write-Output "用户选择了: $selectedMatch"

# 下载
Write-Output "开始下载..."
$downloadUrl = "https://github.com/lsby/portable-nodejs/releases/download/nodejs/$selectedMatch"
$localFileName = "lsby-portable-nodejs.zip"
Invoke-WebRequest -Uri $downloadUrl -OutFile $localFileName
Write-Output "下载完成..."

# 解压缩
Write-Output "开始解压..."
$extractedFolder = [System.IO.Path]::GetFileNameWithoutExtension($localFileName)
Expand-Archive -Path $localFileName -DestinationPath $extractedFolder -Force
Write-Output "解压完成..."

# 删除压缩包
Write-Output "删除原始压缩包..."
Remove-Item -Path $localFileName -Force -ErrorAction SilentlyContinue

# 调整结构
Write-Output "调整结构..."
$folderName = $selectedMatch -replace '\.zip$', ''
$nodeFolder = Join-Path $extractedFolder $folderName
Move-Item -Path $nodeFolder\* -Destination $extractedFolder -Force
Remove-Item -Path $nodeFolder -Force -Recurse

# 创建进入环境文件
$scriptContent = @"
@echo off
start cmd /k "set PATH=%CD%\lsby-portable-nodejs;%PATH%"
"@
$scriptPath = $PWD.Path
$scriptFilePath = Join-Path $scriptPath "lsby-portable-nodejs-进入nodejs环境.cmd"
[System.IO.File]::WriteAllLines($scriptFilePath, $scriptContent)

Write-Output "完成"

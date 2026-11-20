$ErrorActionPreference = "Stop"

$TaskName = "Sabou025HourlyCapture"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$CaptureScript = Join-Path $ScriptDir "capture.py"
$PythonExe = (Get-Command python).Source
$PythonW = Join-Path (Split-Path $PythonExe) "pythonw.exe"
if (-not (Test-Path $PythonW)) {
    $PythonW = $PythonExe
}

$Action = New-ScheduledTaskAction `
    -Execute $PythonW `
    -Argument "`"$CaptureScript`"" `
    -WorkingDirectory $ScriptDir

$Trigger = New-ScheduledTaskTrigger `
    -Once `
    -At (Get-Date "00:00") `
    -RepetitionInterval (New-TimeSpan -Hours 1)

$Settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable

Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $Action `
    -Trigger $Trigger `
    -Settings $Settings `
    -Description "1時間毎に sabou_025 ライブカメラ画像を保存するタスク" `
    -Force | Out-Null

Write-Host "タスクスケジューラに登録しました: $TaskName (毎時00分に実行)"

@echo off
chcp 65001 > nul
python "%~dp0capture.py"
if %errorlevel% neq 0 (
  echo 取得に失敗しました。capture.log を確認してください。
  pause
) else (
  echo 画像を保存しました。
)

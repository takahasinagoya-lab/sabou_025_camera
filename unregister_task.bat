@echo off
chcp 65001 > nul
schtasks /delete /tn "Sabou025HourlyCapture" /f
pause

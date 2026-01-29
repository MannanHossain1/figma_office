# Script to fix Gradle lock issue
# Run this script as Administrator if needed

Write-Host "Attempting to fix Gradle lock issue..." -ForegroundColor Yellow

$gradleFolder = "$env:USERPROFILE\.gradle\wrapper\dists\gradle-8.14-all"

# Step 1: Stop any Java/Gradle processes
Write-Host "`nStep 1: Stopping Java/Gradle processes..." -ForegroundColor Cyan
Get-Process | Where-Object {$_.ProcessName -like "*java*" -or $_.ProcessName -like "*gradle*"} | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Step 2: Try to remove the locked folder (using long path support for Windows)
Write-Host "`nStep 2: Attempting to remove Gradle distribution folder..." -ForegroundColor Cyan
if (Test-Path $gradleFolder) {
    try {
        # Try with long path prefix to handle Windows 260 character limit
        $longPathFolder = "\\?\$gradleFolder"
        Remove-Item -Path $longPathFolder -Recurse -Force -ErrorAction Stop
        Write-Host "Successfully removed Gradle folder!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to remove folder automatically. Error: $_" -ForegroundColor Red
        Write-Host "`nManual steps required:" -ForegroundColor Yellow
        Write-Host "1. Close ALL programs (IDEs, terminals, browsers, etc.)" -ForegroundColor White
        Write-Host "2. Open File Explorer and navigate to: $gradleFolder" -ForegroundColor White
        Write-Host "3. Try to delete the folder manually" -ForegroundColor White
        Write-Host "4. If still locked, restart your computer and try again" -ForegroundColor White
        Write-Host "`nAlternatively, you can use Process Explorer to find what's locking the file:" -ForegroundColor Yellow
        Write-Host "   Download from: https://learn.microsoft.com/en-us/sysinternals/downloads/process-explorer" -ForegroundColor White
    }
} else {
    Write-Host "Gradle folder does not exist - issue may already be resolved!" -ForegroundColor Green
}

# Step 3: Clean Flutter build
Write-Host "`nStep 3: Cleaning Flutter build..." -ForegroundColor Cyan
Set-Location $PSScriptRoot
flutter clean

Write-Host "`nDone! Try running your app again." -ForegroundColor Green

$repoDir = "C:\Users\cs.lee.ADVANTECH\Documents\ClaudeCodeProjects\my-first-web-static-app"
$logFile = "$repoDir\auto-push.log"
$files   = @("NPI_AI_Process_Map.html", "NPI_AI_Process_Map_3D.html")

Set-Location $repoDir

$changed = @()
foreach ($f in $files) {
    $s = & git status --porcelain $f 2>&1
    if ($s) { $changed += $f }
}

$ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

if ($changed.Count -eq 0) {
    Add-Content $logFile "[$ts] No changes detected."
    exit 0
}

$date = Get-Date -Format "yyyy-MM-dd"
foreach ($f in $changed) { & git add $f }

$msg = "chore: update $($changed -join ', ') [$date]"
& git commit -m $msg
& git push origin main

Add-Content $logFile "[$ts] Pushed: $($changed -join ', ')"

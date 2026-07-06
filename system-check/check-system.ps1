<#
    Checks whether Java, Apache JMeter, and Git are installed and available on PATH.
    Prints OK/MISSING status for each, with install guidance for anything missing.
#>

$checks = @(
    @{ Name = "Java";   Command = "java";   VersionArg = "-version";  Note = "Install a JDK 11+ from https://adoptium.net and ensure 'java' is on PATH." },
    @{ Name = "JMeter"; Command = "jmeter"; VersionArg = "--version"; Note = "Download JMeter from https://jmeter.apache.org/download_jmeter.cgi and add its /bin folder to PATH." },
    @{ Name = "Git";    Command = "git";    VersionArg = "--version"; Note = "Install Git from https://git-scm.com/downloads and ensure 'git' is on PATH." }
)

$allOk = $true
$logLines = @("System check run at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')", "----------------------------------------")

foreach ($check in $checks) {
    $cmd = Get-Command $check.Command -ErrorAction SilentlyContinue
    if ($cmd) {
        $version = (& $check.Command $check.VersionArg 2>&1 | Select-Object -First 1)
        $line1 = "[OK]      $($check.Name): found at $($cmd.Source)"
        $line2 = "          Version: $version"
        Write-Host $line1
        Write-Host $line2
        $logLines += $line1, $line2
    } else {
        $allOk = $false
        $line1 = "[MISSING] $($check.Name): not found on PATH"
        $line2 = "          Action needed: $($check.Note)"
        Write-Host $line1
        Write-Host $line2
        $logLines += $line1, $line2
    }
}

$logLines += "----------------------------------------"
$summary = if ($allOk) {
    "All required tools are installed. Ready to run the test plans in this repo."
} else {
    "One or more required tools are missing. Install the items marked MISSING before running the test plans."
}
Write-Host ""
Write-Host $summary
$logLines += $summary

$logFile = Join-Path $PSScriptRoot "check-system.log"
$logLines | Out-File -FilePath $logFile -Encoding utf8
Write-Host ""
Write-Host "Log written to: $logFile"
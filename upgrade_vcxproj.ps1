$ver = "v142"
$line = "    <PlatformToolset>" + $ver + "</PlatformToolset>"

foreach ($path in Get-ChildItem -Recurse -Name -Filter *.vcxproj) {
    $lines = Get-Content -Path $path

    if ($lines -Match "PlatformToolset") {
        # replace any existing platform toolset lines
        $lines = $lines -Replace "    <PlatformToolset>.*$", $line
    } else {
        # add in platform toolset line
        $cfg = "</ConfigurationType>"
        $new = $cfg + "`r`n" + $line
        $lines = $lines -Replace $cfg, $new
    }

    Set-Content -Path $path -Value $lines
}


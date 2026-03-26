$targetVmSize = 'Standard_B2pts_v2'
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$dataDirectory = Join-Path $scriptDirectory 'data'
$resultPath = Join-Path $scriptDirectory 'result.json'

$regionsWithVmSize = foreach ($file in Get-ChildItem -Path $dataDirectory -Filter '*.json' -File) {
    $vmSizes = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    if ($vmSizes | Where-Object { $_.Name -eq $targetVmSize }) {
        $file.BaseName
    }
}

$regionsWithVmSize | ConvertTo-Json | Set-Content -Path $resultPath

﻿function Mount-PSRegistryPath {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MountPoint
    Parameter description

    .PARAMETER FilePath
    Parameter description

    .EXAMPLE
    Mount-PSRegistryPath -MountPoint 'HKEY_USERS\.DEFAULT_USER111' -FilePath 'C:\Users\Default\NTUSER.DAT'

    .NOTES
    General notes
    #>
    [alias('Mount-RegistryPath')]
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)][string] $MountPoint,
        [Parameter(Mandatory)][string] $FilePath
    )

    $pinfo = [System.Diagnostics.ProcessStartInfo]::new()
    $pinfo.FileName = "reg.exe"
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = " load $MountPoint $FilePath"
    $pinfo.CreateNoWindow = $true
    $pinfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    $p = [System.Diagnostics.Process]::new()
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null
    $p.WaitForExit()
    $Output = $p.StandardOutput.ReadToEnd()
    $Errors = $p.StandardError.ReadToEnd()
    if ($Errors) {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            throw $Errors
        } else {
            Write-Warning -Message "Mount-PSRegistryPath - Couldn't mount $MountPoint. $Errors"
        }
    } else {
        if ($Output -like "*operation completed*") {
            if (-not $Suppress) {
                return $true
            }
        }
    }
    if (-not $Suppress) {
        return $false
    }
}

<#
function Mount-PSRegistryPath {
    [alias('Mount-RegistryPath')]
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)][string] $MountPoint,
        [Parameter(Mandatory)][string] $FilePath
    )

    # $pinfo = [System.Diagnostics.ProcessStartInfo]::new()
    # $pinfo.FileName = "reg.exe"
    # $pinfo.RedirectStandardError = $true
    # $pinfo.RedirectStandardOutput = $true
    # $pinfo.UseShellExecute = $false
    # $pinfo.Arguments = " load $MountPoint $FilePath"
    # $pinfo.CreateNoWindow = $true
    # $pinfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    # $p = [System.Diagnostics.Process]::new()
    # $p.StartInfo = $pinfo
    # $p.Start() | Out-Null
    # $p.WaitForExit()
    # $Output = $p.StandardOutput.ReadToEnd()
    # $Errors = $p.StandardError.ReadToEnd()
    $p = reg load $MountPoint $FilePath 2>&1
    #$Errors  , $Output = $p.Where({ $_ -is [System.Management.Automation.ErrorRecord] }, 'Split')
    if ($p -is [Array] -and $p[0] -is [System.Management.Automation.ErrorRecord] -or $p -is [System.Management.Automation.ErrorRecord]) {
        $Errors = $p | ForEach-Object { $_.ToString().Replace('System.Management.Automation.RemoteException', '') }
    } else {
        $Output = $p
    }
    if ($Errors) {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            throw $Errors
        } else {
            Write-Warning -Message "Mount-PSRegistryPath - Couldn't mount $MountPoint. $Errors"
        }
    } else {
        if ($Output -like "*operation completed*") {
            if (-not $Suppress) {
                return $true
            }
        }
    }
    if (-not $Suppress) {
        return $false
    }
}
#>
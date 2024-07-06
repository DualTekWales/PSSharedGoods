function Get-ComputerWindowsUpdates {
    <#
    .SYNOPSIS
    Retrieves information about Windows updates installed on specified computers.

    .DESCRIPTION
    This function retrieves details about Windows updates installed on one or more computers specified by the ComputerName parameter.

    .PARAMETER ComputerName
    Specifies the name of the computer(s) to retrieve Windows update information for.

    .EXAMPLE
    Get-ComputerWindowsUpdates -ComputerName "EVOWIN", "AD1"
    Retrieves Windows update information for computers named "EVOWIN" and "AD1".

    .NOTES
    This function uses the Get-HotFix cmdlet to gather information about Windows updates.
    #>
    [CmdletBinding()]
    param(
        [string[]] $ComputerName = $Env:COMPUTERNAME
    )
    foreach ($Computer in $ComputerName) {
        try {
            $Data = Get-HotFix -ComputerName $Computer
            $Output = foreach ($Update in $Data) {
                [PSCustomObject] @{
                    ComputerName = $Computer
                    InstalledOn  = $Update.InstalledOn
                    Description  = $Update.Description
                    KB           = $Update.HotFixId
                    InstalledBy  = $Update.InstalledBy
                    Caption      = $Update.Caption
                }
            }
            $Output | Sort-Object -Descending InstalledOn
        } catch {
            Write-Warning -Message "Get-ComputerWindowsUpdates - No data for computer $($Computer). Failed with errror: $($_.Exception.Message)"
        }
    }
}
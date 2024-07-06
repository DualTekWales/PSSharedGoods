﻿function Get-ComputerNetwork {
    <#
    .SYNOPSIS
    Retrieves network information for specified computers.

    .DESCRIPTION
    This function retrieves network information for the specified computers, including details about network cards, firewall profiles, and connectivity status.

    .PARAMETER ComputerName
    Specifies the name of the computer(s) for which to retrieve network information.

    .PARAMETER NetworkFirewallOnly
    Indicates whether to retrieve only firewall information for the specified computers.

    .PARAMETER NetworkFirewallSummaryOnly
    Indicates whether to retrieve a summary of firewall information for the specified computers.

    .EXAMPLE
    Get-ComputerNetworkCard -ComputerName AD1, AD2, AD3

    Output

    Name          NetworkCardName             NetworkCardIndex     FirewallProfile FirewallStatus IPv4Connectivity IPv6Connectivity Caption Description ElementName DefaultInboundAction DefaultOutboundAction AllowInboundRules AllowLocalFirewallRules AllowLocalIPsecRules AllowUserApps AllowUserPorts AllowUnicastResponseToMulticast NotifyOnListen EnableStealthModeForIPsec LogFileName                                           LogMaxSizeKilobytes LogAllowed LogBlo
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        cked
    ----          ---------------             ----------------     --------------- -------------- ---------------- ---------------- ------- ----------- ----------- -------------------- --------------------- ----------------- ----------------------- -------------------- ------------- -------------- ------------------------------- -------------- ------------------------- -----------                                           ------------------- ---------- ------
    ad.evotec.xyz vEthernet (External Switch)               13 DomainAuthenticated           True         Internet        NoTraffic                                        NotConfigured         NotConfigured     NotConfigured           NotConfigured        NotConfigured NotConfigured  NotConfigured                   NotConfigured           True             NotConfigured %systemroot%\system32\LogFiles\Firewall\pfirewall.log                4096      False  False
    Network  2    Ethernet 2                                 2             Private           True         Internet        NoTraffic                                                Block                 Allow     NotConfigured           NotConfigured        NotConfigured NotConfigured  NotConfigured                   NotConfigured          False             NotConfigured %systemroot%\system32\LogFiles\Firewall\pfirewall.log                4096      False  False
    Network       Ethernet                                   2             Private           True     LocalNetwork        NoTraffic                                        NotConfigured         NotConfigured     NotConfigured           NotConfigured        NotConfigured NotConfigured  NotConfigured                   NotConfigured          False             NotConfigured %systemroot%\system32\LogFiles\Firewall\pfirewall.log                4096      False  False
    ad.evotec.xyz Ethernet 5                                 3 DomainAuthenticated          False         Internet        NoTraffic                                        NotConfigured         NotConfigured     NotConfigured           NotConfigured        NotConfigured NotConfigured  NotConfigured                   NotConfigured          False             NotConfigured %systemroot%\system32\LogFiles\Firewall\pfirewall.log                4096      False  False
    Network 2     Ethernet 4                                12             Private          False     LocalNetwork        NoTraffic                                        NotConfigured         NotConfigured     NotConfigured           NotConfigured        NotConfigured NotConfigured  NotConfigured                   NotConfigured          False             NotConfigured %systemroot%\system32\LogFiles\Firewall\pfirewall.log                4096      False  False

    .EXAMPLE
    Get-ComputerNetworkCard -ComputerName EVOWIN -NetworkFirewallOnly

    PSComputerName Profile Enabled DefaultInboundAction DefaultOutboundAction AllowInboundRules AllowLocalFirewallRules AllowLocalIPsecRules AllowUserApps AllowUserPorts AllowUnicastResponseToMulticast NotifyOnListen EnableStealthModeForIPsec LogMaxSizeKilobytes LogAllowed LogBlocked    LogIgnored Caption Description ElementName InstanceID                      DisabledInterfaceAliases LogFileName                                           Name    CimClass
    -------------- ------- ------- -------------------- --------------------- ----------------- ----------------------- -------------------- ------------- -------------- ------------------------------- -------------- ------------------------- ------------------- ---------- ----------    ---------- ------- ----------- ----------- ----------                      ------------------------ -----------                                           ----    --------
    EVOWIN         Domain     True        NotConfigured         NotConfigured     NotConfigured           NotConfigured        NotConfigured NotConfigured  NotConfigured                   NotConfigured           True             NotConfigured                4096      False      False NotConfigured                                 MSFT|FW|FirewallProfile|Domain  {NotConfigured}          %systemroot%\system32\LogFiles\Firewall\pfirewall.log Domain  root/stand...
    EVOWIN         Private    True        NotConfigured         NotConfigured     NotConfigured           NotConfigured        NotConfigured NotConfigured  NotConfigured                   NotConfigured           True             NotConfigured                4096      False      False NotConfigured                                 MSFT|FW|FirewallProfile|Private {NotConfigured}          %systemroot%\system32\LogFiles\Firewall\pfirewall.log Private root/stand...
    EVOWIN         Public     True        NotConfigured         NotConfigured     NotConfigured           NotConfigured        NotConfigured NotConfigured  NotConfigured                   NotConfigured           True             NotConfigured                4096      False      False NotConfigured                                 MSFT|FW|FirewallProfile|Public  {NotConfigured}          %systemroot%\system32\LogFiles\Firewall\pfirewall.log Public  root/stand...

    .NOTES
    General notes
    #>
    [alias('Get-ComputerNetworkCard')]
    [CmdletBinding()]
    param(
        [string[]] $ComputerName = $Env:COMPUTERNAME,
        [switch] $NetworkFirewallOnly,
        [switch] $NetworkFirewallSummaryOnly,
        [alias('Joiner')][string] $Splitter
    )
    [Array] $CollectionComputers = $ComputerName.Where( { $_ -eq $Env:COMPUTERNAME }, 'Split')

    $Firewall = @{ }
    $NetworkFirewall = @(
        if ($CollectionComputers[0].Count -gt 0) {
            $Firewall[$Env:COMPUTERNAME] = @{ }
            $Output = Get-NetFirewallProfile
            foreach ($_ in $Output) {
                Add-Member -InputObject $_ -Name 'PSComputerName' -Value $Env:COMPUTERNAME -Type NoteProperty -Force
                $_
                if ($_.Name -eq 'Domain') {
                    $Firewall[$Env:COMPUTERNAME]['DomainAuthenticated'] = $_
                } else {
                    $Firewall[$Env:COMPUTERNAME][$($_.Name)] = $_
                }
            }

        }
        if ($CollectionComputers[1].Count -gt 0) {
            foreach ($_ in $CollectionComputers[1]) {
                $Firewall[$_] = @{ }
            }
            $Output = Get-NetFirewallProfile -CimSession $CollectionComputers[1]
            foreach ($_ in $Output) {
                if ($_.Name -eq 'Domain') {
                    $Firewall[$_.PSComputerName]['DomainAuthenticated'] = $_
                    #  $Firewall[$_.PSComputerName]["DomainAuthenticatedEverything"] = $_
                } else {
                    $Firewall[$_.PSComputerName][$($_.Name)] = $_
                    #$Firewall[$_.PSComputerName]["$($_.Name)Everything"] = $_
                }

            }
        }
    )
    if ($NetworkFirewallOnly) {
        return $NetworkFirewall
    }
    if ($NetworkFirewallSummaryOnly) {
        <#
        Name                           Value
        ----                           -----
        AD1                            {Private, DomainAuthenticated, Public}
        DC1                            {Private, DomainAuthenticated, Public}
        AD2                            {Private, DomainAuthenticated, Public}
        EVOWIN                         {Private, DomainAuthenticated, Public}
        AD3                            {Private, DomainAuthenticated, Public}

        Where $T['EvoWin']['Private']

        Name                            : Private
        Enabled                         : True
        DefaultInboundAction            : NotConfigured
        DefaultOutboundAction           : NotConfigured
        AllowInboundRules               : NotConfigured
        AllowLocalFirewallRules         : NotConfigured
        AllowLocalIPsecRules            : NotConfigured
        AllowUserApps                   : NotConfigured
        AllowUserPorts                  : NotConfigured
        AllowUnicastResponseToMulticast : NotConfigured
        NotifyOnListen                  : True
        EnableStealthModeForIPsec       : NotConfigured
        LogFileName                     : %systemroot%\system32\LogFiles\Firewall\pfirewall.log
        LogMaxSizeKilobytes             : 4096
        LogAllowed                      : False
        LogBlocked                      : False
        LogIgnored                      : NotConfigured
        DisabledInterfaceAliases        : {NotConfigured}

        #>
        return $Firewall
    }
    $NetworkCards = @(
        if ($CollectionComputers[0].Count -gt 0) {
            $Output = Get-NetConnectionProfile
            foreach ($_ in $Output) {
                Add-Member -InputObject $_ -Name 'PSComputerName' -Value $Env:COMPUTERNAME -Type NoteProperty -Force
                $_

            }
        }
        if ($CollectionComputers[1].Count -gt 0) {
            Get-NetConnectionProfile -CimSession $CollectionComputers[1]
        }
    )
    foreach ($_ in $NetworkCards) {

        $NetworkCardsConfiguration = Get-CimData -ComputerName $ComputerName -Class 'Win32_NetworkAdapterConfiguration'
        $CurrentCard = foreach ($Configuration in $NetworkCardsConfiguration) {
            if ($_.PSComputerName -eq $Configuration.PSComputerName) {
                if ($Configuration.InterfaceIndex -eq $_.InterfaceIndex) {
                    $Configuration
                }
            }
        }

        $NetbiosTCPIP = @{
            '0' = 'Default'
            '1' = 'Enabled'
            '2' = 'Disabled'
        }

        [PSCustomObject] @{
            Name                            = $_.Name
            NetworkCardName                 = $_.InterfaceAlias
            NetworkCardIndex                = $_.InterfaceIndex
            FirewallProfile                 = $_.NetworkCategory
            FirewallStatus                  = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].'Enabled'

            IPAddress                       = $CurrentCard.IPAddress
            IPGateway                       = $CurrentCard.DefaultIPGateway
            IPSubnet                        = $CurrentCard.IPSubnet
            IPv4Connectivity                = $_.IPv4Connectivity
            IPv6Connectivity                = $_.IPv6Connectivity
            DNSServerSearchOrder            = $CurrentCard.DNSServerSearchOrder
            DNSDomainSuffixSearchOrder      = $CurrentCard.DNSDomainSuffixSearchOrder
            FullDNSRegistrationEnabled      = $CurrentCard.FullDNSRegistrationEnabled
            DHCPEnabled                     = $CurrentCard.DHCPEnabled
            DHCPServer                      = $CurrentCard.DHCPServer
            DHCPLeaseObtained               = $CurrentCard.DHCPLeaseObtained
            NetBIOSOverTCPIP                = $NetBiosTCPIP["$($CurrentCard.TcpipNetbiosOptions)"]
            Caption                         = $_.Caption
            Description                     = $_.Description
            ElementName                     = $_.ElementName
            # Firewall based fields
            DefaultInboundAction            = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].DefaultInboundAction
            DefaultOutboundAction           = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].DefaultOutboundAction
            AllowInboundRules               = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].AllowInboundRules
            AllowLocalFirewallRules         = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].AllowLocalFirewallRules
            AllowLocalIPsecRules            = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].AllowLocalIPsecRules
            AllowUserApps                   = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].AllowUserApps
            AllowUserPorts                  = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].AllowUserPorts
            AllowUnicastResponseToMulticast = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].AllowUnicastResponseToMulticast
            NotifyOnListen                  = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].NotifyOnListen
            EnableStealthModeForIPsec       = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].EnableStealthModeForIPsec
            LogFileName                     = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].LogFileName
            LogMaxSizeKilobytes             = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].LogMaxSizeKilobytes
            LogAllowed                      = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].LogAllowed
            LogBlocked                      = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].LogBlocked
            LogIgnored                      = $Firewall[$_.PSComputerName]["$($_.NetworkCategory)"].LogIgnored
            ComputerName                    = $_.PSComputerName
        }
    }
}

#Get-ComputerNetwork -ComputerName AD1, AD2 | Format-Table -a *
#Get-CimData -ComputerName AD1 -Class 'Win32_NetworkAdapterConfiguration'
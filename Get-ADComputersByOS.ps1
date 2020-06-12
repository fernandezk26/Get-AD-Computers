#$win7Computers = Get-ADComputer -Filter {OperatingSystem -like "*Windows 7*"} ` -Properties Name, DNSHostName, OperatingSystem, `

$win8Computers = Get-ADComputer -Filter {OperatingSystem -like "*Windows 8*"} ` -Properties Name, DNSHostName, OperatingSystem, `

        OperatingSystemServicePack, OperatingSystemVersion, PasswordLastSet, `

        whenCreated, whenChanged, LastLogonTimestamp, nTSecurityDescriptor, `

        DistinguishedName |

    Where-Object {$_.whenChanged -gt $((Get-Date).AddDays(-30))} |

    Select-Object Name, DNSHostName, OperatingSystem, `

        OperatingSystemServicePack, OperatingSystemVersion, PasswordLastSet, `

        whenCreated, whenChanged, `

        @{name='LastLogonTimestampDT';`

          Expression={[datetime]::FromFileTimeUTC($_.LastLogonTimestamp)}}, `

        @{name='Owner';`

          Expression={$_.nTSecurityDescriptor.Owner}}, `

        DistinguishedName

        $win8Computers | Export-Csv -Path C:\scripts\computers.csv
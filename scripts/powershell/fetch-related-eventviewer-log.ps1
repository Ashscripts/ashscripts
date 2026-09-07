Get-WinEvent -FilterHashtable @{
    LogName = 'Application'
    Id      = 1000
} -MaxEvents 10 |
Select-Object `
    TimeCreated,
    @{Name='Application';Expression={
        if ($_.Message -match 'Faulting application name:\s*([^,]+)') {$matches[1]}
    }},
    @{Name='FaultModule';Expression={
        if ($_.Message -match 'Faulting module name:\s*([^,]+)') {$matches[1]}
    }}
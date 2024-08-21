# Import the Azure AD module
Import-Module AzureAD

# Connect to Azure AD
Connect-AzureAD

# Initialize an array to store device information
$deviceInfo = @()

# Get all Azure AD devices
$devices = Get-AzureADDevice -All $true -Include @("operatingSystem", "operatingSystemVersion", "isManaged")

# Loop through each device
foreach ($device in $devices) {
    # Check if the device name starts with "DV"
    if ($device.DisplayName -like "DV*") {
        # Get the owner of the device
        $owner = Get-AzureADDeviceRegisteredOwner -ObjectId $device.ObjectId

        # Add device information to the array
        $deviceInfo += [PSCustomObject]@{
            DeviceName = $device.DisplayName
            Enabled = $device.AccountEnabled
            OS = $device.OperatingSystem
            Version = $device.OperatingSystemVersion
            TypeOfAssociation = $device.DeviceTrustType
            Owner = $owner.UserPrincipalName
            MDM = $device.IsManaged
            Compliance = $device.IsCompliant
            Registered = $device.ApproximateLastLogonTimestamp
            LastActivity = $device.ApproximateLastLogonTimestamp
        }
    }
}

# Format the table for viewing
$deviceInfo | Format-Table -AutoSize

# Export the result to a CSV file
$deviceInfo | Export-Csv -Path "DVDevices.csv" -NoTypeInformation
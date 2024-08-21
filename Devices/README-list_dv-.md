# Scripts
Added script to retrieve and export Azure AD device information for devices with names starting with 'DV'

This script connects to Azure AD, retrieves a list of all devices, and then filters the list to only include devices with names starting with 'DV'. For each of these devices, it retrieves additional information such as the owner, operating system, and compliance status. The script then exports this information to a CSV file named 'DVDevices.csv'."

The prefix and wildcard must be used/changed in a way that suits best to your needs.
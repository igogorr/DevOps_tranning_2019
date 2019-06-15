function ipv4Addresses {
param(
[parameter(mandatory=$true, HelpMessage = "Enter IP Address")]
[ipaddress]
[string]
$ip1,

[parameter(mandatory=$true, HelpMessage = "Enter IPsubnet mask")]
[ipaddress]
[string]
$mask1,

[parameter(mandatory=$true, HelpMessage = "Enter IP Address")]
[ipaddress]
[string]
$ip2,

[parameter(mandatory=$true, HelpMessage = "Enter IPsubnet mask")]
[ipaddress]
[string]
$mask2
)
$networkID1 = [ipaddress]($ip1.Address -band $mask1.Address)

$networkID2 = [ipaddress]($ip2.Address -band $mask2.Address)

    if ($networkID1.Address -eq $networkID2.Address){
        Write-Output "Addresses $ip1, $ip2 in one subnet"
    }
    else{
        Write-Output "Addresses $ip1, $ip2 in different subnets"
    }
}

ipv4Addresses -ip1 192.168.1.1 -mask1 255.255.255.252 -ip2 192.168.1.2 -mask2 255.255.255.252

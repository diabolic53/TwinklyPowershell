Param (
[string]$TwinklyIP = "192.168.1.X",
  [string]$PowerStatus =$null,
  [string]$dimming =$null,
  [string]$SetStatus =$null,
  [string]$SetStatusBrightness =$null
)


$wtoken = Invoke-WebRequest http://$TwinklyIP/xled/v1/login  -method Post -Body  '{"challenge": "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8="}'
$token=  $wtoken.Content | Convertfrom-Json
#$token.authentication_token
$challange = $token.'challenge-response'
$verify= Invoke-WebRequest http://$TwinklyIP/xled/v1/verify -method post -Headers  @{ 'X-Auth-Token' = $token.authentication_token} -Body '{"challenge-response": $challange}'

if ($PowerStatus -notlike $null ){
if ($PowerStatus -match "off"){
Invoke-WebRequest http://$TwinklyIP/xled/v1/led/mode  -method post -Headers  @{ 'X-Auth-Token' = $token.authentication_token}  -Body '{"mode":"off"}'
}
Else {If ($PowerStatus -match "on")
{
Invoke-WebRequest http://$TwinklyIP/xled/v1/led/mode -method post -Headers  @{ 'X-Auth-Token' = $token.authentication_token}  -Body '{"mode":"movie"}'
}

}}else {}



if ($dimming -notlike $null ){
$body = "{"+'"value"'+':'+$Dimming+','+'"type": "A", "Mode": "enabled" '+"}"
$dimm= Invoke-WebRequest http://$TwinklyIP/xled/v1/led/out/brightness -method post -Headers  @{'ContentType' = 'application/json; charset=utf-8'; 'X-Auth-Token' = $token.authentication_token}  -Body $body

}else {}
if ($SetStatusBrightness -notlike $null){
$brightnessraw= Invoke-WebRequest http://$TwinklyIP/xled/v1/led/out/brightness -method get -Headers  @{'ContentType' = 'application/json; charset=utf-8'; 'X-Auth-Token' = $token.authentication_token}
$brightness =  $brightnessraw| ConvertFrom-Json
$bright = $brightness.value |Out-String
write-host  -OutVariable $brigh
}

if ($SetStatus -notlike $null){
$statusraw=Invoke-WebRequest http://$TwinklyIP/xled/v1/led/mode  -method get -Headers  @{ 'X-Auth-Token' = $token.authentication_token}
$status= $statusraw | ConvertFrom-Json
If ($status.mode -eq "movie"   ) {$stat = "On" 
write-host $stat}}

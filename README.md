# TwinklyPowershell

Small Powershell script that allows you to modify the state of your twinkly lights for anyone who wants to include into their home automation framework.

usage : download file 

powershell ./twinkly.ps1 -PowerStatus  on/off 

powershell ./twinkly.ps1 -dimming %  ( ex -dimming 50 for 50% dimming) 

Please replace the IP with the ip set on your Twinkly lights and don't forget to set a dhcp reservation so the IP doesn't change. 

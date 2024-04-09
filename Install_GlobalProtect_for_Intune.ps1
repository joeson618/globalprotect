#设置GlobalProtect Portal地址，按需修改
$PortalAddress = '"xxxxx.gp.prismaaccess.cn"'

#设置GlobalProtect连接方式，注意这里不是pre-logon
$CONNECTMETHOD = '"user-logon"'

#设置GP初始化登录后的默认浏览器，如果是SAML方式，建议设置；如果是AD,可以忽略；
$DEFAULTBROWSER = '"yes"'

$MSISwitches = ' /q /norestart'

#预先下载好GlobalProtect安装包，按需命名
$MSIFileName = 'GlobalProtect64.msi'

$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Path
$agrument = "/i " + $ScriptPath + "\" + $MSIFileName + $MSISwitches + " DEFAULTBROWSER=$DEFAULTBROWSER CONNECTMETHOD=$CONNECTMETHOD PORTAL=$PortalAddress"

#安装GlobalProtect,建议检查注册表是否下发成功
$InstallProcess = Start-Process -FilePath "msiexec" -ArgumentList ($agrument) -Wait

#注册使能PLAP，建议检查注册表是否下发成功
Start-Process -FilePath "$env:ProgramFiles\Palo Alto Networks\GlobalProtect\PanGPS.exe" -ArgumentList "-registerplap" -Wait
Write-Host ("Installation completed, exiting with last return code (" + $InstallProcess.ExitCode + ")")
Exit $InstallProcess.ExitCode





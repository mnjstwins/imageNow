<# #############################################################################
# NAME: SA_LoadMonitor.ps1
# 
# AUTHOR:  Gregg Jenczyk, UMass (UITS)
# DATE:  2014/08/19
# EMAIL: gjenczyk@umassp.edu
# 
# COMMENT:  This will kick off the SA_LoadMonitor.js script.  It will run every
#           ...20 minutes(?) between 6:00 PM and 1:00 AM (7 hours)
#
# VERSION HISTORY
# 1.0 2014.04.18 Initial Version.
#
# TO ADD:
# 
# USEFUL SNIPPETS:
# "$(Get-Date) " | Out-File -Append $runLog
# #############################################################################>

#-- INCLUDES --#
. "\\boisnas215c1.umasscs.net\diimages67tst\script\PowerShell\sendmail.ps1"

#-- CONFIG --#

$localRoot = "D:\"
$root = "\\boisnas215c1.umasscs.net\diimages67tst\"
$env = ([environment]::MachineName).Substring(2)
$env = $env -replace "W.*",""
$logDate = $(get-date -format 'yyyyMMdd')

#- LOGGING -#
$runLog = "${root}log\running_log-scriptName.log"
$scriptLog = "${root}log\ScriptName_${logDate}.log"

#-- MAIN --#
"$(get-date) - Starting ScriptName Script" | Out-File $runLog -Append

D:\inserver6\bin64\intool --cmd run-iscript --file ${root}script\SA_LoadMonitor.js

<#
Use this if you want to be notified when the script finishes running

sendmail -t "gjenczyk@umassp.edu" -s "[DI ${env} Notice] ScriptName.ps1 has finished running" -m ${message}
#>

$error[0] | Out-File $runLog -Append
"$(get-date) - Finishing ScriptName Script" | Out-File $runLog -Append
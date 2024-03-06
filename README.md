# powershell-script-for-zbx-mssql

This is a follow up on abakaldins Template: https://github.com/zabbix/community-templates/tree/main/Databases/Microsoft_SQL_Server/template_app_ms_sql_database_discovery_(lld)/6.0

first you need to place the .ps1 on the MSSQL server you intend to monitor
I have put it in the zabbix agent folder, in my case
```
C:\Program Files\Zabbix Agent\zabbix_agentd.d
````
The you need to create a new file mssql.conf in the same directory. 
in this file use specify the UserParameter like this: 

```
UserParameter=windowsdb.discovery,powershell -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\zabbix_agentd.d\Untitled2.ps1"
```
After this you need change the agent conf to include conf files from that folder. 
Go to the Include option and then insert this: 
```
Include=C:\Program Files\Zabbix Agent\zabbix_agentd.d\*.conf
```

Now you need to create a Global expression:
Administration -> General -> Regular Expressions

Create new:
name: 	MS SQL System DBs
Expression:  	^(master|model|msdb|ReportServer|ReportServerTempDB|tempdb)$
Expression Type: Result is FALSE


On the host create a Macro: {$INSTANCE01} -> and set it to the instance name. In my case SQLServer
Now add the template to the host, then restart the agent.

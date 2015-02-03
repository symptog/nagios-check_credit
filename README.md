# nagios-check_credit
Nagios/Icinga Plugin - Check Prepaid Credit using SMSTools3

Based on http://smstools3.kekekasvi.com/topic.php?id=320

SMSTools Installation (german):
* https://www.thomas-krenn.com/de/wiki/SMS_Server_Tools
* https://www.thomas-krenn.com/de/wiki/SMS_Benachrichtigungen_mit_Icinga

Attention: not tested for multiple devices in smsd.conf!

## Install

Append to `/etc/smsd.conf` in the device section
```
[GSM1]
...
regular_run_cmd = AT+CUSD=1,"*100#"
regular_run_interval = 43200
regular_run_statfile = /var/log/smstools/smsd_stats/GSM1.balance
```

Copy `check_balance` to your Nagios/Icinga Plugins

Append to Nagios/Icinga Commandfile
```
define command{
        command_name    check_credit
        command_line    $USER1$/check_balance -d GSM1 -w 2.0 -c 1.0 -currency EUR -s /etc/smsd.conf
}
```

all parameters are optional

## Help

```
usage: check_balance [-h] [--verbose] [-c CRITICAL] [-w WARNING] [-s SMSCONF]
                     [-d DEVICE] [-currency CURRENCY]

Prepaid balance check for Nagios

optional arguments:
  -h, --help          show this help message and exit
  --verbose           verbose flag
  -c CRITICAL         Critical value eg. 1.0
  -w WARNING          Warning value eg 2.0
  -s SMSCONF          SMSTools3 Config Path eg. /etc/smsd.conf
  -d DEVICE           Device eg. GSM1
  -currency CURRENCY  Currency eg. EUR
```

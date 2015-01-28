# nagios-check_credit
Nagios/Icinga Plugin - Check Prepaid Credit using SMSTools3

Based on http://smstools3.kekekasvi.com/topic.php?id=320

Attention: not tested for multiple devices in smsd.conf!

## Install

Copy `GMS1.sh`
```
cp GSM1.sh /opt/sms/regular_run/GSM1.sh
chown -R smsd:smsd /opt/sms
```

Append to `/etc/smsd.conf`
```
regular_run = /opt/sms/regular_run/GSM1.sh
regular_run_interval = 43200
regular_run_post_run = /opt/sms/regular_run/GSM1.sh
regular_run_cmdfile = /opt/sms/regular_run/GSM1.cmdfile
regular_run_statfile = /opt/sms/regular_run/GSM1.statfile
```

Copy `check_credit` to your Nagios/Icinga Plugins

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
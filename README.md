# check_watchptTemp_winmod
Small modification to http://codeplasma.com/nagios-plugins/cost-effective-temperature-monitoring-with-nagios-how-to/

This is a windows Perl script to be used with a Digi Watchport sensor to read and format data about temperature, ready for use with Nagios http://www.digi.com/products/usb-and-serial-connectivity/usb-sensors/watchportsensors

It's modified form the original to no longer require an external config file, and will now instead take the com port as an optional argument in addition to low temp warning and low temp critical

Dependencies: Win32::SerialPort;

Usage:
    perl check_watchptTemp_winmod.pl -w <high warning temp> -c <high critical temp> -wm <low warning temp> -cm <low critical temp>  Optional: [-Com <ComPort>] Default: COM3

Default output is in Celsius, small edit explained in code required to change to Farenheit

For usage/implementation with nagios please refer to the blog post above, although it is slighlty dated and soem of it is deprecated so i will include what the nsclient config changes should look like now

You basically need to add the possibility to run external commands and a path to the file like so into your nsclient.ini with arguments. Then you can invoke the check_temp command with check_nrpe form nagios

    [/modules]
    CheckExternalScripts = enabled
    [/settings/external scripts/scripts]
    check_temp = C:\perl64\bin\perl.exe "C:\Program Files\NSClient++\scripts\check_watchptTemp_winmod.pl" -w 22 -c 25 -wm 18 -cm 10

Tested with Nsclient++ Version 0.4.1.105-x64

# check_watchptTemp_winmod
Small modification to http://codeplasma.com/nagios-plugins/cost-effective-temperature-monitoring-with-nagios-how-to/

This is a windows Perl script to be used with a Digi Watchport sensor to read and format data about temperature, ready for use with Nagios http://www.digi.com/products/usb-and-serial-connectivity/usb-sensors/watchportsensors

It's modified form the original to no longer require an external config file, and will now instead take the com port as an optional argument in addition to low temp warning and low temp critical

Dependencies: Win32::SerialPort;

Usage: perl check_watchptTemp_winmod.pl -w <high warning temp> -c <high critical temp> -wm <low warning temp> -cm <low critical temp> Optional: [-Com <ComPort>] Default: COM3

For usage/implementation with nagios please refer to the blog post above

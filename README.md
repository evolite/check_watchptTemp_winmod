# check_watchptTemp_winmod
Small modification to http://codeplasma.com/nagios-plugins/cost-effective-temperature-monitoring-with-nagios-how-to/

This is a windows Perl script to be used with a Digi Wtachport/t sensor to feed data to Nagios about temperature

Usage: \n perl check_watchptTemp_winmod.pl -w <high warning temp> -c <high critical temp> -wm <low warning temp> -cm <low critical temp> Optional: [-Com <ComPort> Default: COM3]

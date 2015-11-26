#! perl

#	check_watchptTemp_winmod.pl
# 	Copyright 2009,2011 Julius Schlosburg 
#   Modified 2015 https://github.com/evolite
#
#	This script gets the temperature from a Digi Watchport Temperature Sensor.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use Win32::SerialPort;
use Getopt::Long;
my $argw;
my $argc;
my $argwm;
my $argcm;
my $argCom;
my $argh = 0;

#get limited options set
GetOptions(
	"w=i" => \$argw,
	"c=i" => \$argc,
	"wm=i" => \$argwm,
	"cm=i" => \$argcm,
	"com=s" => \$argCom,
	"h|help" => \$argh
);
my $exitcode = 3;
my $minwarning = $argwm;
my $mincritical = $argcm;
my $warning = $argw;
my $critical = $argc;
my $comPort = $argCom;

if ($comPort eq ""){
	$comPort = "COM3";
}
if ($warning == "" || $critical == "" || $argh){
	print "Usage: \n perl check_watchptTemp_winmod.pl -w <high warning temp> -c <high critical temp> -wm <low warning temp> -cm <low critical temp> Optional: [-Com <ComPort> Default: COM3]  ";
	exit;
}
my $state = 2;

#get temp
my $temp = getTemp();

if ($temp > $warning || $temp < $minwarning){
	$state++;
}
elsif ($temp < $warning || $temp > $minwarning){
		$state--;
}
if ($temp > $critical || $temp < $mincritical){
	$state++;
}
elsif ($temp < $critical || $temp > $mincritical){
		$state--;
}

if ($state eq 0){
	print "OK: Temp is good at $temp";
	$exitcode = '0';
}
elsif ($state  < 3){
		print "WARNING: Temp is at $temp";
		$exitcode = '1';
}
elsif ($state eq 4)	{
		print "CRITICAL: Temp is at $temp";
		$exitcode = '2';
}
#Performance data:
print "|temp=$temp;$warning;$critical;0;100";
exit $exitcode;
	
#######################SUBS################################################

sub getTemp	{
	
	#Create Serial port object
	  my $ob = new Win32::SerialPort ($comPort)
       || die "Can't open $comPort: $^E\n";    # $quiet is optional

  $ob->user_msg("ON");
  $ob->databits(8);
  $ob->baudrate(9600);
  $ob->parity("none");
  $ob->stopbits(1);
  $ob->handshake("rts");
  $ob->buffers(4096, 4096);
	# Send TC/TF Command to watchport, comment out the one you don't want.
	# $ob->write("TF\r"); # Tells watchport to return temp in F
	$ob->write("TC\r"); # Tells watchport to return temp in C
	$ob->read_interval(100);
	my ($count, $tempRead) = $ob->read(20);
	if ($tempRead =~ /.*?([\d]+.[\d]+)/){
		$tempRead = $1;
	}
	undef $ob;
	return $tempRead;
}

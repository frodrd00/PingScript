#!/usr/bin/perl

use strict;
use warnings;
use Net::Ping;

my $file_name=$ARGV[0];
my $line;
my @host_array;

open(FILE,"$file_name") || die "No se puede acceder al archivo de ips" ;
@host_array=<FILE>;
close(FILE);
my $p = Net::Ping->new("icmp");

foreach my $host(@host_array)
{
	if($p->ping($host, 0.25))
	{
		chomp($host);
		print "$host is alive.\n";
	}
	else
	{
		chomp($host);
		print "$host not reachable.\n";
	}
 sleep(1);
}

$p->close();
close (FILE);

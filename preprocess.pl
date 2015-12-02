foreach $line ( <STDIN> ) {
	chomp( $line );
    process_line ( $line );
}

sub process_line {
	$data = $_[0];
	
	$data =~ s/\#.*//;
	$to = 'to';
	@prefix = ();
#    print "b $data\n";
    my @values = split(' ', $data);
    foreach my $val (@values) {
#    	print "$val\n";
#       delete commentary
		if ( $val =~ /^\$/ ) {
#       		print "prefix $val\n";
       		$val =~ s/\$//;
       		push ( @prefix, $val );
       	}
		else {
       		if ( $val =~ /^%/ ) {
	       		$val =~ s/%//;
       			foreach my $prefix ( @prefix ) {
       			    if ( $prefix eq "ver" ) {
	       				next;
					}       			    	
       				print ("$prefix$to$val \n");
       			}
       		}
			else {
	       		# plain ausgeben
				print ("$val\n");
				# anwenden der Präfixe
				foreach my $prefix ( @prefix ) {
					print ("$prefix$val\n");
				}
			}
		}
	}
}

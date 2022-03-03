use strict;
use warnings;

open(IN, "./1AD5.pdb");

my $counter = 0;
my @pointOfOrigin;
my %amino;

while(<IN>)
{
	if(substr($_, 0,4) eq "ATOM")
	{
		my @items = split(/\s+/, $_);


		if ($items[2] eq "CA")  
		{
			if($items[5] == 100)
			{
				$pointOfOrigin[0] = $items[6];
				$pointOfOrigin[1] = $items[7];
				$pointOfOrigin[2] = $items[8];		
			}

			my $ref = \@items;
			$amino{$items[5]} = $ref;
		}	
	}
}
close(IN);


foreach my $key(keys %amino)
{

	print $key;
	if( sqrt((($pointOfOrigin[0]-$amino{$key}[6])**2+($pointOfOrigin[1]-$amino{$key}[7])**2+($pointOfOrigin[2]-$amino{$key}[8])**2)) <= 20)
	{
		$counter++;
		foreach(@{$amino{$key}})
		{
			print$_." ";
		}
		print"\n";
	}
}

print"There are $counter residues within 20 anstrongs of the point of origin.\n";

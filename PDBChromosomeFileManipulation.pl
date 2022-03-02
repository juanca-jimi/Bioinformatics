use strict;
use warnings;
use List::Util 'minstr';

#part 1
#
#this code passes a chromosome file as the argument such as  "$(<human_chromosomes_length.txt)"

my @idAndLength = split(" ", $ARGV[0]);
my $arrLength = @idAndLength;
my %chromosomeLength;

my $i;
for(my $i = 0; $i < $arrLength; $i++)
{
	$chromosomeLength{"$idAndLength[$i]"} = $idAndLength[$i+1];
	$i++;
}


my $amountOfChromosomes = 0;
my $sumOfChromosomeLength = 0;
my $first_key = minstr(keys %chromosomeLength);
my $minChr = $first_key;
my $key;
foreach $key (keys %chromosomeLength)
{
	if ($chromosomeLength{"chrX"} < $chromosomeLength{$key})
	{	print("$key is greater that chrX\n");}
	$sumOfChromosomeLength += $chromosomeLength{$key};
	if ($chromosomeLength{$key} < $chromosomeLength{$minChr})
	{	$minChr = $key;}
	$amountOfChromosomes++;
}
print"The shortest length chromosome is $minChr\n";
print"The average chromosome length is ".($sumOfChromosomeLength/$amountOfChromosomes)."\n";


#part 2
#
#this code can use any .pdb file such as "<./test.pdb" in the repository


open(IN, $ARGV[1]) or "File does not exists.\n";

my $counter = 0;
my %coordinates;
my %amino;
my $proteinSequence = "";

my %amino=();
$amino{"ALA"} = 'A'; $amino{"CYS"} = 'C'; $amino{"ASP"} =
'D'; $amino{"GLU"} = 'E';
$amino{"PHE"} = 'F'; $amino{"GLY"} = 'G'; $amino{"HIS"} =
'H'; $amino{"ILE"} = 'I';
$amino{"LYS"} = 'K'; $amino{"LEU"} = 'L'; $amino{"MET"} =
'M'; $amino{"ASN"} = 'N';
$amino{"PRO"} = 'P'; $amino{"GLN"} = 'Q'; $amino{"ARG"} =
'R'; $amino{"SER"} = 'S';
$amino{"THR"} = 'T'; $amino{"VAL"} = 'V'; $amino{"TRP"} =
'W'; $amino{"TYR"} = 'Y';

while(<IN>)
{
	if(substr($_, 0, 4) eq "ATOM")
	{
		my @items = split(/\s+/, $_);

		if ($items[2] eq "CA")
		{
			$counter++;
			
			$proteinSequence .= $amino{$items[3]}; 
			my $residueSequenceNumber = $items[4];
			#part 3
			
			if($residueSequenceNumber >=20 && $residueSequenceNumber <=30)
			{
				print$_;
			}
			
			#part 4		
			my @xyz;

			$xyz[1] = $items[6];
			$xyz[2] = $items[7];
			$xyz[0] = $items[5];
			
			$coordinates{$residueSequenceNumber} = \@xyz;
		}
	}
}

close(IN);

#part 1

print("The amount of residues in the .pdb file is $counter.\n");

#part 2

print $proteinSequence."\n";


#part 4
#
#

foreach $key(sort {$a <=> $b} keys %coordinates)
{
	printf("%-5s %-9s %-9s %-9s\n", $key, $coordinates{$key}[0], $coordinates{$key}[1], $coordinates{$key}[2]);
}






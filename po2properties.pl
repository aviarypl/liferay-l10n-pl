#!/usr/bin/perl

$PONAME=$ARGV[0];
$wasmsgid = 0;
$fuzzy = 0;


open INPUTF, "< $PONAME"  or die "Can't open file '$PONAME'";

while (<INPUTF>)
{
    $line = $_;
    if ( $line =~ /^\#, fuzzy/) {
	$fuzzy = 1;
    }
    elsif ( $line =~ /^msgid/) 
    {
		#property
		$line =~ /\"(.*)\"/;
		$property = $1;
		if ( $property )
		{
			$wasmsgid = 1;
		}
    }
    elsif ( $wasmsgid == 1 && ($line =~ /^msgstr/)  )
    {
		# wez tlumaczenie z cudzyslowow
		$line =~ /\"(.*)\"/;
		$trans = $1;
		
		if ( $trans && $fuzzy != 1 ) 
		{
		    system "echo \"$property=$trans\"";
		}
		else 
		{
		    #fuzzy i untranslated - bierzemy z oryginału
		    system "grep -e \"^$property=\" properties/Language_en.properties\n";
		}
		$wasmsgid = 0;
		$fuzzy = 0;
	}
    else
    {
		$wasmsgid = 0;
    }
}

close INPUTF;


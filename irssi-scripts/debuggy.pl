#!/usr/bin/perl -w
#
# [2004-08-10, 22.15-00.46] written by Zrajm C Akfohg, originally as part of
# other script
#
# [2004-08-15, 00.48-04.04] improved
#
use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

sub dump_hash(\%;$) {                          #
    my ($hashref, $indent) = @_;               #   get args
    $indent = 4 unless $indent;                #   default intent size
    my $keylen = ( sort { $b <=> $a }          #   get length of longest
        map { length } keys %$hashref )[0];    #     key value
    my @output = ();                           #
    foreach my $key (sort keys %$hashref) {    #   for each hash key
        local $_ = $$hashref{$key};            #

        my $reftype = "";
        /(?<==)([A-Z]+)/ and                   #   get reference type
            $reftype = $1;                      #
        my $value;
        if ($reftype eq 'HASH') {
            $value = dump_hash($_, $indent+4);
#        } elsif ($reftype eq 'SCALAR') {
#            $value = dump_scalar($_);
        } elsif (/^-?([0-9]*\.)?[0-9]+$/) {
            $value = $_;
        } else {
            $value = "'".$_."'";
        }

        push @output, (' ' x $indent) .        #
            sprintf("%-${keylen}s", $key).     #
            ' => ' . $value;                   #
    }
    return "{ #$hashref\n" .                   #
        join(",\n", @output) .                 #
        ' }';                                  #
}



sub dump_var(\$;$) {                              # [2004-08-15]
    my ($varref, $indent) = @_;                    #   get args

    $indent = 4 unless $indent;                    #   default intent size
    $$varref =~ /(?<==)([A-Z]+)/;                  #   get reference type
    my $reftype = $1;                              #

    my @output = ();
    push @output, "»»$varref««";

    if ($reftype eq 'HASH') {
        dump_hash(%$$varref);
    } else {
        print "# \$varname is of unknown reftype $reftype\n\n";
    }


}


Irssi::command_bind 'dumpstate', sub {
    my ($args, $server, $target) = @_;
    my $window = Irssi::active_win();                 # get active window

    open(OUT, ">", "$ENV{HOME}/irssidump.txt") or die;
    select OUT;

    print '$server = ' . dump_var($server) . "\n\n";
    print '$target = ' . dump_var($target) . "\n";

    select;
    close OUT;
};


# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## # $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;
BEGIN {
    # to handle systems with no installed Test module
    # we include the t dir (where a copy of Test.pm is located)
    # as a fallback
    eval { require Test::More; };
    if( $@ ) {
        use lib 't/lib';
    }
    use Test::More;
    plan tests => 27;
    use_ok 'Bio::Phenotype::OMIM::OMIMentryAllelicVariant';
}

my $av = Bio::Phenotype::OMIM::OMIMentryAllelicVariant->new( -number               => ".0001",
                                                             -title                => "ALCOHOL INTOLERANCE",
                                                             -symbol               => "ALDH2*2",
                                                             -description          => "The ALDH2*2-encoded ...",
                                                             -aa_ori               => "GLU",
                                                             -aa_mut               => "LYS",
                                                             -position             => 487,
                                                             -additional_mutations => "IVS4DS, G-A, +1" );  

isa_ok( $av, "Bio::Phenotype::OMIM::OMIMentryAllelicVariant" );

ok( $av->to_string() );

is( $av->number(), ".0001" );
is( $av->title(), "ALCOHOL INTOLERANCE" );
is( $av->symbol(), "ALDH2*2" );
is( $av->description(), "The ALDH2*2-encoded ..." );
is( $av->aa_ori(), "GLU" );
is( $av->aa_mut(), "LYS" );
is( $av->position(), 487 );
is( $av->additional_mutations(), "IVS4DS, G-A, +1" );

$av->init();

is( $av->number(), "" );
is( $av->title(), "" );
is( $av->symbol(), "" );
is( $av->description(), "" );
is( $av->aa_ori(), "" );
is( $av->aa_mut(), "" );
is( $av->position(), "" );
is( $av->additional_mutations(), "" );

is( $av->number( "A" ), "A" );
is( $av->title( "B" ), "B" );
is( $av->symbol( "C" ), "C" );
is( $av->description( "D" ), "D" );
is( $av->aa_ori( "E" ), "E" );
is( $av->aa_mut( "F" ), "F" );
is( $av->position( "G" ), "G" );
is( $av->additional_mutations( "H" ), "H" );




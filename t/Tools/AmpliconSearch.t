BEGIN {     
    use lib '.';
    use Bio::Root::Test;

    test_begin(-tests => 18);

    use_ok 'Bio::Tools::AmpliconSearch';
    use_ok 'Bio::PrimarySeq';
}





my ($search, $amplicon);

ok $search = Bio::Tools::AmpliconSearch->new();
isa_ok $search, 'Bio::Tools::AmpliconSearch';

my $seq = Bio::PrimarySeq->new(
   -seq => 'AAACTTAAAGGAATTGACGGaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaGTACACACCGCCCGT',
);

my $forward = Bio::PrimarySeq->new(
   -seq => 'AAACTTAAAGGAATTGACGG',
);

my $reverse = Bio::PrimarySeq->new(
   -seq => 'GTACACACCGCCCGT',
);




ok $search = Bio::Tools::AmpliconSearch->new(
   -template       => $seq,
   -forward_primer => $forward,
);
is $search->get_forward_primer->seq, 'AAACTTAAAGGAATTGACGG';
is $search->get_reverse_primer, undef;
is $search->get_template->seq, 'AAACTTAAAGGAATTGACGGaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaGTACACACCGCCCGT';


ok $search = Bio::Tools::AmpliconSearch->new(
   -template       => $seq,
   -forward_primer => $forward,
   -reverse_primer => $reverse,
);
is $search->get_forward_primer->seq, 'AAACTTAAAGGAATTGACGG';
is $search->get_reverse_primer->seq, 'GTACACACCGCCCGT';
is $search->get_template->seq, 'AAACTTAAAGGAATTGACGGaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaGTACACACCGCCCGT';




ok $search = Bio::Tools::AmpliconSearch->new(
   -template    => $seq,
   -primer_file => test_input_file('forward_reverse_primers.fa'),
);
is $search->get_forward_primer->seq, 'AAACTYAAAKGAATTGRCGG';
is $search->get_reverse_primer->seq, 'ACGGGCGGTGTGTRC';
is $search->get_template->seq, 'AAACTTAAAGGAATTGACGGaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaGTACACACCGCCCGT';

ok $amplicon = $search->next_amplicon;
isa_ok $amplicon, 'Bio::SeqFeature::Amplicon';



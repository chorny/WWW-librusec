
use lib 'lib1';
use lib 'lib';
use File::Slurp;
use WWW::librusec;
use YAML;
my $obj=read_file('ru1.htm', binmode => ':utf8');
#my $obj=URI->new('http://lib.rus.ec/new/ru');
my $res=WWW::librusec::scrape_news($obj);
open my $out,'>','out.yml';
print $out Dump($res);
foreach my $e (@{ $res->{dates} }) {
  next unless keys %$e;
  my @a=@{$e->{genres}};
  print $e->{date},"\n";
}

#(c) Alexandr Ciornii 2010, Artistic/GPL/public domain

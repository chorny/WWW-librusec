package WWW::librusec;
use 5.010;
use strict;
use warnings;

use Web::Scraper;
use URI;

sub scrape_news {
  my $obj=shift;
  #open my $d,'>','dump.txt';
  my $scraper = scraper {
      process q{//body/div[@id='page']/div[@id='container']/div[@id='main-wrapper']/div[@id='main']/form[2]/table/tr/td},
       "dates[]"
        =>
        scraper {
          #print $d "scraper by date\n";
          process 'h4', 'date'=>'TEXT';
          split_by 'p.genre', 'genre_list[]' => scraper {
             #my $tree = $_[0];
             #print $d " split by genre\n";
             #print $d " working on ",$tree->starttag,"\n";
             #process q{a.genre}, "genres[]" => {title => 'TEXT'};
             process q{a.genre}, "genres[]" => 'TEXT';

             split_by 'div#z0', 'book_list[]' => scraper {
               #my $tree = $_[0];
               #$tree->dump($d);
               #print $d "  split by book\n";
               #print $d "  working on ",$tree->starttag,"\n";
               process 'a', 'book_links[]' => { r => '@href', title => 'TEXT' };
             };
          };
        };

  };
  my $res = $scraper->scrape($obj);
  return $res;
}

sub process_new_data {
}

1

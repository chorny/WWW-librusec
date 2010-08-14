package WWW::librusec;
use 5.010;
use strict;
use warnings;

use Web::Scraper;
use URI;

sub scrape_news {
  my $obj=shift;
  open my $d,'>','dump.txt';
  my $scraper = scraper {
      process q{//body/div[@id='page']/div[@id='container']/div[@id='main-wrapper']/div[@id='main']/form[2]/table/tr/td},
       "dates[]"
        =>
        scraper {
          print $d "scraper by date\n";
          process '//h4', 'date'=>'TEXT';
          split_by 'p.genre', 'genre_list[]' => scraper {
             my $tree = $_[0];
             print $d " split by genre\n";
             print $d " working on ",$tree->starttag,"\n";
             #process q{a.genre}, "genres[]" => {title => 'TEXT'};
             process q{a.genre}, "genres[]" => 'TEXT';
             #result 'genres_list';

             split_by 'div#z0', 'book_list[]' => scraper {
               my $tree = $_[0];
               $tree->dump($d);
               print $d "  split by book\n";
               print $d "  working on ",$tree->starttag,"\n";
               process 'a', 'book_links[]' => { r => '@href', title => 'TEXT' };
                #process q{//div[@id='z0']}, "genres[]" => scraper {
               #process q{//a[@class=genre]/h9}, "genres_list[]" => 'TEXT';
               #q{/html/body[@id='second']/div[@id='page']/div[@id='container']/div[@id='main-wrapper']/div[@id='main']/form[2]/table[1]/tbody/tr/td/div[1]/a[1]}
              # process "//div/a[1]", name => 'TEXT';
             };
          };
          #result 'date'=>'genre_list';
        };

  };
  my $res = $scraper->scrape($obj);
  return $res;
}

1

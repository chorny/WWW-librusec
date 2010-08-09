package WWW::librusec;
use 5.010;
use strict;
use warnings;

use Web::Scraper;
use URI;

sub scrape_news {
  my $obj=shift;
  my $scraper = scraper {
      process q{//body/div[@id='page']/div[@id='container']/div[@id='main-wrapper']/div[@id='main']/form[2]/table/tr/td},
       "dates[]"
        =>
        scraper {
          process '//h4', 'date'=>'TEXT';
          process q{//div[@id='z0']/..}, "genres[]" => scraper {
            #process q{//a[@class=genre]/h9}, "genres_list[]" => 'TEXT';
            process q{a.genre h9}, "genres_list[]" => 'TEXT';
            #q{/html/body[@id='second']/div[@id='page']/div[@id='container']/div[@id='main-wrapper']/div[@id='main']/form[2]/table[1]/tbody/tr/td/div[1]/a[1]}
            process "//div/a[1]", name => 'TEXT';
          };
        };

  };
  my $res = $scraper->scrape($obj);
  return $res;
}

1

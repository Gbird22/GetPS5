#!/usr/bin/perl -w

use strict;
use warnings;

use Data::Dumper;

# add your store data here
my $ps_data = { 
        best_buy => {
            store_url => 'https://www.bestbuy.com/site/playstation-5/ps5-consoles/pcmcat1587395025973.c?id=pcmcat1587395025973',
            storage_file => 'bestbuy.html',
            ps_verify => 'Sony - PlayStation 5 Digital Edition Console',
            out_flag => 'Sold Out', 
            out_count => 48, 
        }, 
        target => {
            store_url => 'https://www.target.com/c/playstation-5-video-games/-/N-hj96d?lnk=snav_rd_playstation_5',
            storage_file => 'target.html',
            ps_verify => 'PS5 Digital Edition',
            out_flag => 'Consoles will be viewable', 
            out_count => 4, 
        }, 
};

get_ps5();


sub get_ps5 {

    # this should run for about a week running every five minutes
    for (1..2100) {
        # get the stock data
        my $stock = get_stock();

        #print Dumper $stock;
        check_stock($stock);

        sleep(300);
    }
}


sub check_stock {
    my ($stock_data) = @_;

    foreach my $store(keys %$ps_data) {
        my $current_time = localtime;
        if ( $ps_data->{$store}->{'out_count'} == $stock_data->{$store}->{'out_count'} ) {
            print Dumper "Stock was still out on $current_time";
            print Dumper $stock_data;
        } else {
            if ($stock_data->{$store}->{'out_count'} > 0 ) {
                for (my $i=0; $i <= 50000000; $i++) {
                    print $i . chr(7) . "\n";
                }

                open (STOCKFILE, ">$current_time.txt");
                print STOCKFILE "Stock was found" . "\n"  . Dumper $stock_data;
                close STOCKFILE;
            }
        }
    }

}


sub get_stock  {

    my $results;

    foreach my $store_key (keys %{$ps_data}) {

        # get the store data
        my $store = $ps_data->{$store_key};
        my $storage_file = $store->{'storage_file'};
        my $store_url = $store->{'store_url'};
        
        # get the data and give it time to download
        system("curl -A  \'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0' \"$store_url\" > $storage_file ");
        sleep(20);

        #get the file read into a variable
        my $filename = $store->{'storage_file'};
        local $/ = undef;
        open (FILE, "$filename");
        my $data_file = <FILE>;

        # check to make sure you're on the right page and that it's sold out
        my $verify_ps_string = $store->{'ps_verify'};
        my $verify_out_string = $store->{'out_flag'};

        my @cnt;
        $results->{$store_key}->{'verified'} = @cnt = $data_file =~ m/$verify_ps_string/g;
        $results->{$store_key}->{'out_count'} = @cnt = $data_file =~ m/$verify_out_string/g;

    }

    return $results;

}


    


1;





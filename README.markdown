### instapaper.pl - irssi script for posting articles to instapaper.com

![instapaper_screenshot][instapaper_screenshot]

### Usage

		/script load instapaper.pl
		/set instapaper_username <USERNAME>
		/set instapaper_password <PASSWORD> (optional if you have a password)
		/instapaper <URL>

### Requirements

You must have the following installed:

1. LWP (libwww)
2. Crypt-SSLeay or IO-Socket-SSL

install these from CPAN:

		cpan>install LWP
		cpan>install Crypt::SSLeay

### Author

instapaper.pl is written by Blake Smith <blakesmith0@gmail.com>

[instapaper_screenshot]: http://github.com/blakesmith/instapaper.pl/raw/master/media/instapaper.png "instapaper.pl screenshot"

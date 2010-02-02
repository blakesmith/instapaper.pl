# QUICKSTART:
#
# /script load instapaper.pl
# /set instapaper_username <USERNAME>
# /set instapaper_password <PASSWORD> (optional if you have a password)
# /instapaper <URL>
#
# And that's it!
#

use strict;
use LWP::UserAgent;
use HTTP::Request::Common qw(POST);
use Irssi;
use Irssi::Irc;
use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI   = (
    authors     => 'Blake Smith',
    contact     => 'blakesmith0@gmail.com',
    name        => 'instapaper',
    description => 'Post urls to your instapaper.com account',
    license     => 'GNU GPL v2',
    url         => 'http://github.com/blakesmith/instapaper.pl',
);

my $add_location = "https://www.instapaper.com/api/add";
my $ua = new LWP::UserAgent;

sub cmd_instapaper {
  my ($data, $server, $window) = @_;

  my $username = Irssi::settings_get_str("instapaper_username");
  my $password = Irssi::settings_get_str("instapaper_password");

  unless ($username) {
    window_echo("Please set a username with /set instapaper_username <USERNAME>"
       . " and an optional password with /set instapaper_password <PASSWORD>");
    return;
  }

  my $req = POST $add_location,
              [ 
                username => $username, 
                password => $password,
                url => $data,
                'auto-title' => 1
              ];
  my $response = $ua->request($req);

  window_echo(echo_response($response));
}


sub echo_response {
  my ($response) = @_;

  my $code = $response->code;
  if ($code == 201) { return "Url saved!" }
  elsif ($code == 400) { return "Bad request" }
  elsif ($code == 403) { return "Invalid username or password, please set the instapaper_username and (optional) instapaper_password fields" }
  elsif ($code == 500) { return "Server returned an error" }
}

sub window_echo {
  my ($message) = @_;
  my $window = Irssi::active_win();
  if ($window) {
    $window->print($message);
  }
  else {
    Irssi::print($message);
  }
}

Irssi::settings_add_str("instapaper", "instapaper_username", undef );
Irssi::settings_add_str("instapaper", "instapaper_password", undef );
Irssi::command_bind("instapaper", "cmd_instapaper" );

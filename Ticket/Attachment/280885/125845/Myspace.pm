######################################################################
# WWW::Myspace.pm
# Sccsid:  %Z%  %M%  %I%  Delta: %G%
# $Id: Myspace.pm 302 2006-12-21 00:14:59Z grantg $
######################################################################
# Copyright (c) 2005 Grant Grueninger, Commercial Systems Corp.
#
# Description:
# Module to log into myspace.com

######################################################################
# Setup

# Declare our package.
package WWW::Myspace;
use WWW::Myspace::MyBase -Base;

# *** If you're not familiar with Spiffy, read its docs. To save you
# confusion, one of its features is to add "my $self = shift;" to
# each method definition, so when you see that missing, that's why. ***

# Debugging? (Yes=1, No=0)
our $DEBUG=1;

######################################################################
# Libraries we use

use Carp;
use Contextual::Return;
use Locale::SubCountry;
use WWW::Mechanize;
use File::Spec::Functions;
use Time::Local;
use Data::Dumper;

=head1 NAME

WWW::Myspace - Access MySpace.com profile information from Perl

=head1 VERSION

Version 0.60

=cut

our $VERSION = '0.61';

=head1 WARNING

WARNING - DO NOT USE THIS MODULE FOR MASS MESSAGING OR COMMENTING.

Myspace will cripple or disable your account:

Older accounts:

Messages will appear in your Sent folder but not in the receiver's
inbox, although they'll be able to see it if they're paging through from
another message.
The receiver will get a "New Comments" notification and be able to see
your comment, but it won't appear on the profile page.

Newer accounts:

If you created your myspace account in or after June 2006 (approximately),
and you use a "bot" (including this module) to send messages, your message
sending ability will be disabled and your account may be deleted. This
is due to security features myspace has implemented to prevent spam
abuse by people using multiple accounts.

=head1 SYNOPSIS

WWW::Myspace.pm provides methods to access your myspace.com
account and functions automatically. It provides a simple interface
for scripts to log in, access lists of friends, scan user's profiles,
retreive profile data, send messages, and post comments.

    use WWW::Myspace;
    my $myspace = WWW::Myspace->new ($account, $password);
        OR
    my $myspace = new WWW::Myspace; # Prompts for email and password
    unless ( $myspace->logged_in ) { die "Login failed: " . $myspace->error }
    
    my ( @friends ) = $myspace->get_friends();

This module is designed to help you automate and
centralize redundant tasks so that you can better handle keeping in
personal touch with numerous friends or fans, or coordinate fan
communications among multiple band members. This module operates well
within MySpace's security measures. If you're looking for a spambot,
this ain't it.

WWW::Myspace works by interacting with the site through a UserAgent
object, using HTTP::Request::Form to process forms. Since by nature
web sites are dynamic, if you find that some interaction with the
site breaks, check for a new version of this module (or if you
go source diving, submit a patch). You can run "cpan -i WWW::Myspace"
as a cron job or before running your scripts, if appropriate, to
make sure you have the latest version.

=cut

# Since WWW::Myspace reads and reacts to a web site which by nature
# may change, we define much of the basics up here where it's
# easy to see and change.

# What's the base URL for the site.
our $BASE_URL="http://www.myspace.com/";

# Where should we store files? (cookies, cache dir). We use, and untaint,
# the user's home dir for the default.
our $HOME_DIR= "";
if ( defined $ENV{'HOME'} ) {
    $HOME_DIR = "$ENV{'HOME'}";
    
    if ( $HOME_DIR =~ /^([\-A-Za-z0-9_ \/\.@\+\\:]*)$/ ) {
        $HOME_DIR = $1;
    } else {
        croak "Invalid characters in $ENV{HOME}.";
    }
}

# What's the URL for the user's Home page?
our $HOME_PAGE="http://home.myspace.com/index.cfm?fuseaction=user";

# What regexp should we look for to verify that we're logged in?
# This is checked against the home page when we log in.
our $VERIFY_HOME_PAGE = qr/Hello,.*My Mail.*You have.*friends/si;

# What's the URL to the Browse page?
our $BROWSE_PAGE = 'http://browseusers.myspace.com/browse/Browse.aspx';

# What should we look for to see if there's a link to a friend's page?
our $FRIEND_REGEXP = qr/fuseaction=user\.viewprofile\&friendID=/io;

# After posting a comment we look for text on the following page to
# tell us if the post was successful. What RE should we look for
# that we'll only see if the post was successful (this is currently
# the user's profile page, so we look for text that'll be near the top of
# the page).
our $VERIFY_COMMENT_POST='<span class="nametext">[^\<]*<\/span>.*View '.
    '(More Pics|My:)'; 
$VERIFY_COMMENT_POST = qr/$VERIFY_COMMENT_POST/o;  # /o flag ok here since we do once

# After loading a person's profile page, we look for this RE to
# verify that we actually got the page.
our $VERIFY_GET_PROFILE = qr/<span class="nametext">[^\<]*<\/span>/o;

# On the page following posting a comment, what should we look for
# to indicate that the user requires comments to be approved?
# (This is only checked after VERIFY_COMMENT_POST has been checked).
our $COMMENT_APPROVAL_MSG="This user requires all comments to be approved '.
    'before being posted";
$COMMENT_APPROVAL_MSG = qr/$COMMENT_APPROVAL_MSG/o;

# What string should we look for if we're trying to post a comment to
# someone who isn't our friend?
our $NOT_FRIEND_ERROR="Error: You must be someone\'s friend to make '.
    'comments about them\.";

# What should we look for to see if we are being asked for a CAPTCHA code?
# We'll extract the URL to return from the area in parenthesis.
our $CAPTCHA='<img.*?src="(http:\/\/security.myspace.com\/CAPTCHA\/'.
    'CAPTCHA\.aspx\?SecurityToken=[^"]+)"';
our $CAPTCHAi = qr/$CAPTCHA/io;   # ok, we will store both ways
our $CAPTCHAs = qr/$CAPTCHA/o;  
#$CAPTCHA = $CAPTCHAi;             # use case insensitive for now

# What's the URL to the comment form? We'll append the user's friend ID to
# the end of this string.
our $VIEW_COMMENT_FORM="http://comments.myspace.com/index.cfm?'.
    'fuseaction=user&circuitaction=viewProfile_commentForm&friendID=";

# What's the URL to view a user's profile? We'll append the friendID to the
# end of this string.
our $VIEW_PROFILE_URL="http://profile.myspace.com/index.cfm?".
    "fuseaction=user.viewprofile&friendID=";

# Mail Inbox URL
# What's the URL to read a page from our inbox?
our $MAIL_INBOX_URL="http://messaging.myspace.com/index.cfm?".
    "fuseaction=mail.inbox&page=";

# What's the URL to read a message if we know the messageID?
our $READ_MESSAGE_URL='http://messaging.myspace.com/index.cfm?'.
    'fuseaction=mail.readmessage&messageID=';

# What's the URL to send mail to a user? We'll append the friendID to the
# end if this string too.
our $SEND_MESSAGE_FORM="http://messaging.myspace.com/index.cfm?'.
    'fuseaction=mail.message&friendID=";

# What regexp should we look for after sending a message that tells
# us the message was sent?
our $VERIFY_MESSAGE_SENT = qr/Your Message Has Been Sent\!/o;

# If a person's profile is set to "private" we'll get an error when we
# pull up the form to mail them. What regexp do we read to identify that
# page?
our $MAIL_PRIVATE_ERROR = "You can't send a message to [^<]* ?because '.
    'you must be [^<]*'s ?friend";

# If a person has set an away message, what regexp should we look for?
our $MAIL_AWAY_ERROR = "You can't send a message to [^<]* ?because '.
    '[^<]* ?has set [^<]* ?status to away";

# What RE shows up if a friendID is invalid?
our $INVALID_ID = '<b>Invalid Friend ID\.\s*<br>\s*This user has either cancelled their '.
    'membership,? or their account has been deleted\.';

# What regexp should we look for for Myspace's frequent "technical error"
# messages?
# This lists regexps to look for on pages that indicate we've got a temporary
# error instead of a successful load or post. If the page matches one of these,
# it will be retried up to the maximum number of attempts set in this module
# (currently 5 for POSTs, 20 for GETs).
# Note: Page content is stripped
# of extra whitespace before checking, so make sure any spaces you have here
# are single spaces, not multiple, nor tabs, nor returns.
our @ERROR_REGEXPS = (

    "Sorry! an unexpected error has occurred\. <br> <br> ".
        "This error has been forwarded to MySpace's technical group\.",

    '<b>This user\'s profile has been temporarily '.
    'disabled for special maintenance.<br>'.
    
    'This profile is undergoing routine maintenance. '.
    'We apologize for the inconvenience!',

# Removed: Conflicts with "exceeded usage" message
#   'An Error has occurred!!.*'.
#   'An error has occurred (while )?trying to send this message.',
    
    'We\'re doing some maintenance on the mail for certain users\. '.
    'You can take this opportunity to leave your friend a swell comment '.
    'while we work on it\. :\)',
    
    '<H3>Error Occurred While Processing Request<\/H3>',

);
@ERROR_REGEXPS = map qr/$_/i, @ERROR_REGEXPS;

# If we exceed our daily mail usage, what regexp would we see?
# (Note: they've misspelled usage, so the ? is in case they fix it.)
our $EXCEED_USAGE = qr/User has exceeded their daily use?age/io;
#our $EXCEED_USAGE = "User has exceeded their daily useage\.";

# What RE should we look for to tell if we're on the "You must be logged
# in to do that!" page? XXX - CONFIRM THIS!
our $NOT_LOGGED_IN = 'You Must Be Logged-In to do That!.*?<input.*?'.
    'name="email"';
$NOT_LOGGED_IN = qr/$NOT_LOGGED_IN/iso;

# Where do we post friend requests?
our $FRIEND_REQUEST_POST = "http://mail.myspace.com/index.cfm?'.
    'fuseaction=mail.processFriendRequests";

# What's the URL for a friend request button (to send a friend request)?
our $ADD_FRIEND_URL = 'http://collect.myspace.com/index.cfm?'.
            'fuseaction=invite.addfriend_verify&'.
            'friendID=';

######################################################################
# Methods

# (These "sub" lines make section dividers in BBedit's function menu.
# I'm sure there's a better way, so don't go "learning" anything from me
# here. :)
sub ____SET_OPTIONS__LOG_IN____ {}

=head1 SET OPTIONS / LOG IN

The new method takes the following options, all of which are optional.
See the accessor methods below for defaults.  Any option can be passed
in a hash or hashref to the "new" method, and retreived or set using the
appropriate accessor method below.

 account_name => 'myaccount',
 password => 'mypass',
 cache_dir => '/path/to/dir',
 cache_file => 'filename', # $cache_dir/$cache_file
 auto_login => 1  # 1 or 0, default is 1.
 human => 1  # Go slow.  Saves bandwidth.

=cut

# Options they can pass via hash or hashref.
const default_options => {
    account_name => 0,
    password => 0,
    cache_dir => 0,  # Default set by field method below
    cache_file => 0, # Default set by field method below
    auto_login => 0, # Default set by field method below
    human => 0,      # Default set by field method below
};

# Options they can pass by position.
# Just "new( 'joe@myspace.com', 'mypass' )".
const positional_parameters => [ 'account_name', 'password' ];

=head1 OPTION ACCESSORS

These methods can be used to set/retreive the respective option's value.
They're also up top here to document the option, which can be passed
directly to the "new" method.

=head2 account_name

Sets or returns the account name (email address) under which you're logged in.
Note that the account name is retreived from the user or from your program
depending on how you called the "new" method. You'll probably only use this
accessor method to get account_name.

EXAMPLE

The following would prompt the user for their login information, then print
out the account name:

    use WWW::Myspace;
    my $myspace = new WWW::Myspace;
    
    print $myspace->account_name;

    $myspace->account_name( 'other_account@myspace.com' );
    $myspace->password( 'other_accounts_password' );
    $myspace->site_login;

WARNING: If you do change account_name, make sure you change password and
call site_login.  Changing account_name doesn't (currently) log you
out, nor does it clear "password".  If you change this and don't log in
under the new account, it'll just have the wrong value, which will probably
be ignored, but who knows.

=cut

field 'account_name';

=head2 password

Sets or returns the password you used, or will use, to log in. See the
warning under "account_name" above - same applies here.

=cut

field 'password';

=head2 cache_dir

WWW::Myspace stores the last account/password used in a cache file
for convenience if the user's entering it. Other modules store other
cache data as well.

cache_dir sets or returns the directory in which we should store cache
data. Defaults to $ENV{'HOME'}/.www-myspace.

If using this from a CGI script, you will need to provide the
account and password in the "new" method call, or call "new" with
"auto_login => 0" so cache_dir will not be used.

=cut

field cache_dir => catfile( "$HOME_DIR", '.www-myspace' );

=head2 cache_file

Sets or returns the name of the file into which the login
cache data is stored. Defaults to login_cache.

If using this from a CGI script, you will need to provide the
account and password in the "new" method call, so cache_file will
not be used.

=cut

field cache_file => 'login_cache';

=head2 auto_login

Really only useful as an option passed to the "new" method when
creating a new WWW::Myspace object.

 # Don't log in, just create a new object
 my $myspace = new WWW::Myspace( auto_login => 0 );
 
Defaults to 1 for backwards compatibility.

=cut

field 'auto_login' => 1;

=head2 human

When set to a true value (which is the default), adds delays to
make the module act more like a human.  This is both to offset
"faux security" measures, and to conserve bandwidth.  If you're
dumb enough to try to use multiple accounts to spam users who don't
want to hear what you have to say, you should turn this off
because it'll make your spamming go faster.

=cut

field 'human' => 1;

#---------------------------------------------------------------------
# new method
# If we're passed an account and possibly a password, we store them.
# Otherwise, we check the login cache file, and if we still
# don't have them, we ask the user.

=head2 new( $account, $password )

=head2 new( )

If called without the optional account and password, the new method
looks in a user-specific preferences file in the user's home
directory for the last-used account and password. It prompts
for the username and password with which to log in, providing
the last-used data (from the preferences file) as defaults.

Once the account and password have been retreived, the new method
automatically invokes the "site_login" method and returns a new
WWW::Myspace object reference. The new object already contains the
content of the user's "home" page, the user's friend ID, and
a UserAgent object used internally as the "browser" that is used
by all methods in the WWW::Myspace class.

Myspace.pm is now a subclass of WWW::Myspace::MyBase (I couldn't resist,
sorry), which basically just means you can call new in many ways:

    EXAMPLES
        use WWW::Myspace;
        
        # Prompt for username and password
        my $myspace = new WWW::Myspace;
        
        # Pass just username and password
        my $myspace = new WWW::Myspace( 'my@email.com', 'mypass' );
        
        # Pass options as a hashref
        my $myspace = new WWW::Myspace( {
            account_name => 'my@email.com',
            password => 'mypass',
            cache_file => 'passcache',
        } );
        
        # Hash
        my $myspace = new WWW::Myspace(
            account_name => 'my@email.com',
            password => 'mypass',
            cache_file => 'passcache',
            auto_login => 0,
        );

        # Print my friend ID
        print $myspace->my_friend_id;
        
        # Print the contents of the home page
        print $myspace->current_page->content;
        
        # Print all my friends with a link to their profile.
        @friend_ids = $myspace->get_friends;
        foreach $id ( @friend_ids ) {
            print 'http://profile.myspace.com/index.cfm?'.
                'fuseaction=user.viewprofile&friendID='.
                ${id}."\n";
        }

        # How many friends do we have? (Note: we don't include Tom
        # because he's everybody's friend and we don't want to be
        # bugging him with comments and such).
        print @friend_ids . " friends (not incl Tom)\n";

=cut

sub _old_new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless ($self, $class);
    if ( @_ ) { $self->{account_name} = shift }
    if ( @_ ) { $self->{password} = shift }
    unless ( $self->{account_name} ) {
        # Get account/password from the user
        $self->_get_acct();
    }
    
    # And for convenience, log in
    $self->_site_login();

    return $self;
}

sub new() {
    # Call the MyBase new method (it's ok to feel special about it).
    my $self = super;

    # Log in if requested
    if ( $self->auto_login ) {
    
        # Prompt for username/password if we don't have them yet.
        # (should this be moved to site_login?)
        $self->_get_acct unless $self->account_name;

        $self->site_login;
    
    } else {

        $self->logout; # Why?  Resets variables and gets Mech object.
    
    }

    return $self;
}

#---------------------------------------------------------------------
# site_login()
# Log into myspace with the stored account login name, password, and
# URL (probably "http://www.myspace.com/")

=head2 site_login

Logs into the myspace account identified by the "account_name" and
"password" options.  You don't need to call this right now,
because "new" does it for you.  BUT I PLAN TO CHANGE THAT.  You don't
need to be logged in to access certain functions, so it's semi-silly
to make you log in the second you call "new".  Plus, it's not good
practice to have "new" require stuff. Bad me.

If you call the new method with "auto_login => 0", you'll need to
call this method if you want to log in.

It's also called automatically if the _check_login method finds that
you've been mysteriously logged out, for example if Myspace.com were
written in Cold Fusion running on Windows.

If the login gets a "you must be logged-in" page when you first try to
log in, $myspace->error will be set to an error message that says to
check the username and password.

Once login is successful for a given username/password combination,
the object "remembers" that the username/password
is valid, and if it encounters a "you must be logged-in" page, it will
try up to 20 times to re-login.  Clever, huh?

=cut

sub site_login {

    # Reset everything (oddly, this also happens to create a new browser
    # object).
    $self->logout;

    croak "site_login called but account_name isn't set" unless
        ( $self->account_name );
    croak "site_login called but password isn't set" unless ( $self->password );

    # Now log in
    $self->_try_login;
    return if $self->error;

    # We probably have an ad or somesuch (started 1/7/2006)
    # so explicitly request our Home.
    $self->follow_to( $HOME_PAGE );

    # Verify we're logged in
    if ( $self->current_page->content =~ $VERIFY_HOME_PAGE ) {
        $self->logged_in( 1 );
    } else {
        $self->logged_in( 0 );
        unless ( $self->error ) {
            $self->error( "Login Failed. Couldn't verify load of home page." )
        }
        return;
    }

    # Initialize basic account/login-specific settings after login
    $self->_init_account;

}

# _try_login
# You call this as $self->_try_login.  Attempts to log in using
# the set account_name and password. It gets and submits the login form,
# then checks for a valid submission and for a "you must be logged-in"
# page.
# If called with a number as an argument, tries that many times to
# submit the form.  It calls itself recursively.
sub _try_login {

    # Set the recursive tries counter.
    my ( $tries_left ) = @_;
    if ( $tries_left ) { $tries_left--;  return if ( $tries_left ) < 1; }
    $tries_left = 20 unless defined $tries_left;

    # Submit the login form
    my $submitted = $self->submit_form( "$BASE_URL", 1, "",
                    { 'email' => $self->account_name,
                      'password' => $self->password
                    }
                  );

    # Check for success
    if ( $submitted ) {
#        ( $DEBUG ) && print $self->current_page->content;

        # Check for invalid login page, which means we either have
        # an invalid login/password, or myspace is messing up again.
        unless ( $self->_check_login ) {
            # Fail unless we already know this account/password is good, in
            # which case we'll just beat the door down until we can get in
            # or the maximum number of attempts has been reached.
            if ( $self->_account_verified ) {
                $self->_try_login( $tries_left );
            } else {
                $self->error( "Login Failed.  Got 'You Must Be Logged-In' page ".
                    "when logging in.\nCheck username and password." );
                return;
            }
        }
    } else {
        return;
#        croak $self->error;
    }

}

# _account_verified
# Returns true if we've verified that the current account and password
# are valid (by successfully logging in with them)
sub _account_verified {

    ( ( $self->{_account_verified}->{ $self->account_name } ) &&
      ( $self->password = $self->{_account_verified}->{ $self->account_name } )
    )

}

# _init_account
# Initialize basic account/login-specific settings after login
sub _init_account {
    
    # Get our friend ID from our profile page (which happens to
    # be the page we go to after logging in).
    $self->_get_friend_id( $self->current_page );

    # If for some reason we couldn't set this, fail login.
    unless ( $self->my_friend_id ) { $self->logged_in(0) ; return }
    
    # Set the user_name and friend_count fields.
    $self->user_name( $self->current_page );
    $self->friend_count( $self->current_page );
    
    # Cache whether or not we're a band.
    $self->is_band;

    # Note that we've verified this account/password
    $self->{_account_verified}->{ $self->account_name } = $self->password;

}

=head2 mech_params
 
Pass this parameters you wish the WWW::Mechanize object to use, 
inside a hash reference. for example:

  $myspace->mech_params({
	  onerror => undef,
          agent => 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)'
	  stack_depth => 1,
	  quiet => 1,
   });

See the docs for WWW::Mechanize for more information. You should
really know what you are doing before using this feature.

=cut

field mech_params => undef;

sub _new_mech {

    my %default_mech_params = (
			       onerror => undef,
			       agent => 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)',
			       stack_depth => 1,
			       quiet => 1,
			      );

    my $new_p = $self->mech_params();
    if (defined($new_p)) {
      if (ref($new_p) eq "HASH") {
	while (my ($k,$v) = each %$new_p) {
	  $default_mech_params{$k} = $v;
	}
      } else {
	warn "Please pass mech_params() a HASH reference. Thanks!\n";
      }
    }

    # Set up our web browser (WWW::Mechanize object)
    $self->mech( new WWW::Mechanize( %default_mech_params ) );

    # We need to follow redirects for POST too.
    push @{ $self->mech->requests_redirectable }, 'POST';

}

=head2 logout

Clears the current web browsing object and resets any login-specific
internal values.  Currently this drops and creates a new WWW::Mechanize
object.  This may change in the future to actually clicking "logout"
or something.

=cut

sub logout {

    # If you change this to just log out instead of making a new Mech
    # object, be sure you change site_login too.
    $self->_new_mech;
    
    # Clear anything login-specific
    $self->{user_name} = undef;
    $self->{is_band} = undef;
    $self->{my_friend_id} = undef;
    $self->logged_in(0);
    $self->error(0);
    $self->{page_cache} = undef;

    # Do NOT clear options that are set by the user!
#   $self->{account_name} = undef;
#   $self->{password} = undef;

}

=head2 get_login_form

This handy little convenience method returns a string of
HTML code that is a login form pre-filled with the account_name
and password.  I use it in a little "Dashboard" script I wrote
that displays the notifications and a Login button.

 use WWW::Myspace;
 use CGI qw/:standard/;;
 my $myspace = new WWW::Myspace;
 
 # Display a login form
 print header,
     start_html('Is it worth logging in?'),
     $myspace->get_login_form,
     end_html;

=cut

sub get_login_form {
	
	my $x = '<form action="http://login.myspace.com/index.cfm?'.
	    'fuseaction=login.process" method="post" name="theForm" '.
	    'id="theForm">' .
		'<input type=hidden name="email" value="' . $self->account_name .
		'">' .
		'<input type=hidden name="password" value="' . $self->password . '">' .
		'<input type=submit name="ctl00$Main$SplashDisplay$login$loginbutton" '.
		'value="LOGIN">'.
		'</form>';
		
	return $x;
	
}

#---------------------------------------------------------------------
# Value return methods
# These methods return internal data that is of use to outsiders

sub ____CHECK_STATUS____ {}

=head1 CHECK STATUS

=head2 logged_in

Returns true if login was successful. When you call the new method
of WWW::Myspace, the class logs in using the username and password you
provided (or that it prompted for).  It then retreives your "home"
page (the one you see when you click the "Home" button on myspace.com,
and checks it against an RE.  If the page matches the RE, logged_in is
set to a true value. Otherwise it's set to a false value.

 Notes:
 - This method is only set on login. If you're logged out somehow,
   this method won't tell you that (yet - I may add that later).
 - The internal login method calls this method to set the value.
   You can (currently) call logged_in with a value, and it'll set
   it, but that would be stupid, and it might not work later
   anyway, so don't.

 Examples:

 my $myspace = new WWW::Myspace;
 unless ( $myspace->logged_in ) {
    die "Login failed\n";
 }
 
 # This will try forever to log in
 my $myspace;

 do {
    $myspace = new WWW::Myspace( $username, $password );
 } until ( $myspace->logged_in );

=cut

field logged_in => 0;

=head2 error

This value is set by some methods to return an error message.
If there's no error, it returns a false value, so you can do this:

 $myspace->get_profile( 12345 );
 if ( $myspace->error ) {
     warn $myspace->error . "\n";
 } else {
     # Do stuff
 }

=cut

field 'error' => 0;

=head2 current_page

Returns a reference to an HTTP::Response object that contains the last page
retreived by the WWW::Myspace object. All methods (i.e. get_page, post_comment,
get_profile, etc) set this value.

EXAMPLE

The following will print the content of the user's profile page:

    use WWW::Myspace;
    my $myspace = new WWW::Myspace;
    
    print $myspace->current_page->content;

=cut

sub current_page {

    return $self->{current_page};

}

=head2 mech

The internal WWW::Mechanize object.  Use at your own risk: I don't
promose this method will stay here or work the same in the future.
The internal methods used to access Myspace are subject to change at
any time, including using something different than WWW::Mechanize.

=cut

field 'mech';

sub ____GET_INFO____ {}

=head1 GET INFO

=head2 get_notifications

Returns a hash of status codes and printable indicators
for "New" indicators ("New Messages!", "New Comments!", etc).
Note that you probably want to call this right after logging
in, as if you use any of the "read" methods, Myspace will
reset that indicator.  For example, if you use "inbox",
Myspace will think you looked at your mail.

 Codes returned are:
 NC  => New Comments!
 NM  => New Messages!
 NFR => New Friend Requests!
 NIC => New Image Comments!
 EV  => New Event Invitation!
 BC  => New Blog Comments!
 BP  => New Blog Posts!

 # Print all notifications
 use WWW::Myspace;
 my $myspace = new WWW::Myspace( $account, $password );
 
 my $notifiers = $myspace->get_notifications;
 
 foreach $code ( keys( %notifiers ) ) {
    print $notifiers{ $code };
 }

 # CGI script to display notifications and a Login button
 # to click if it's worth logging in (be sure you provide the
 # account and password ;-):

 use CGI qw/:standard/;
 use WWW::Myspace;
 my $myspace = new WWW::Myspace( $account, $password );
 
 print header,
     start_html('Is it worth logging in?');
 
 my ( %notifiers ) = $myspace->get_notifications;
 
 foreach $code ( keys( %notifiers ) ) {
     print $notifiers{ $code }, br;
 }

 print p, $myspace->get_login_form, p,
     end_html;

=cut

my $stats_ref =
    {
        'NC' => { 'search' => { css => '<div id="indicatorComments" '.
                                  'class="show indicator">',
                                db => 'New Comments!',
                              },
                  'display' => 'New Comments!'
                },
        'NM' => { 'search' => { css => '<div id="indicatorMail" '.
                                  'class="show indicator">',
                                db => 'New Messages!'
                              },
                  'display' => 'New Messages!'
                },
        'NFR' => { 'search' => { css => '<div id="indicatorFriendRequest" '.
                                  'class="show indicator">',
                                 db => 'New Friend Requests!',
                               },
                  'display' => 'New Friend Requests!'
                },
        'NIC' => { 'search' => { css => '<div id="indicatorImageComments" '.
                                  'class="show indicator">',
                                 db => 'New Image Comments!',
                               },
                  'display' => 'New Image Comments!'
                },
        'EV' => { 'search' => { css => '<div id="indicatorEvents" '.
                                  'class="show indicator">',
                                 db => 'New Event Invitation!',
                               },
                  'display' => 'New Event Invitation!'
                },
        'BC' => { 'search' => { css => '<div id="indicatorBlogComments" '.
                                  'class="show indicator">',
                                 db => 'New Blog Comments!',
                               },
                  'display' => 'New Blog Comments!'
                },
        'BP' => { 'search' => { css => '<div id="indicatorBlogs" '.
                                 'class="show indicator">',
                                 db => 'New Blog Posts!',
                               },
                  'display' => 'New Blog Posts!'
                }
    };

sub get_notifications {
	
	$self->_go_home;
			
	my %data = ();
	
	my $page = $self->current_page->content;
	$page =~ s/[ \t\n\r]+/ /g; # (Eliminate extra whitespace)
	
	# Myspace uses two techniques for displaying this data, and they
	# keep switching back and forth. Figure out which one they're doing
	# this week...
	my $dt;
	if ( $page =~ /<div id="indicatorComments" class="/ ) {
		$dt = "css";
	} else {
		$dt = "db";
	}
	
	foreach my $stat_type ( keys( %$stats_ref ) ) {
		my $re = $stats_ref->{"$stat_type"}->{'search'}->{"$dt"};
		if ( $page =~ /$re/i ) {
			$data{"$stat_type"} = $stats_ref->{"$stat_type"}->{'display'}
		}
	}
	
	# Number of friends
	$data{"friends"} = "You have " . $self->friend_count . " friends";
	
	# Return the data
	return %data;

}

=head2 my_friend_id

Returns the friendID of the user you're logged in as.
Croaks if you're not logged in.

EXAMPLE

    print $myspace->my_friend_id;

=cut

sub my_friend_id {

    $self->_die_unless_logged_in( 'my_friend_id' );
    
    return $self->{my_friend_id};
}

=head2 is_band( [friend_id] )

Returns true if friend_id is a band profile.  If friend_id isn't passed,
returns true if the account you're logged in under is a band account.
If it can't get the profile page it returns -1 and you can check
$myspace->error for the reason (returns a printable message).
This is used by send_friend_request to not send friend requests to
people who don't accept them from bands, as myspace passively accepts
the friend request without displaying an error, but doesn't add the friend
request.

 EXAMPLE
 
 $myspace->is_band( $friend_id );

 if ( $myspace->error ) {
     die $myspace->error . "\n";
 } else {
     print "They're a band, go listen to them!\n";
 }

IMPORTANT: You can NOT assume that a profile is a personal profile if
is_band is false.  It could be a film profile or some future type of
profile.  There is currently no test for a personal or film profile.

=cut

sub is_band {
    my ( $friend_id ) = @_;
    
    # If they gave a friend_id, we load the profile and look at it.
    # If not, we return, or set, our internal is_band variable.
    if ( defined $friend_id ) {
        # Get the profile page
        my $res = $self->get_profile( $friend_id );
        unless ( $self->error ) {
            # Scan the page for band-specific RE (the music player plug-in).
            if ( $res->content =~ /oas_ad\("www\.myspace\.com\/bandprofile,/io ) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return -1;
        }
    } else {
        # Check for the "upcoming shows" header. This might very well
        # appear on other types of profiles (i.e. comedy), but it
        # distinguishes performers from personal profiles pretty well.
        # Note that this requires is_band to be called for the first time
        # just after loading the login profile page. site_login calls
        # this method to take care of that problem.
        unless ( defined $self->{is_band} ) {
            if ( $self->current_page->content =~ /<h*?>\s*Upcoming Shows\s*<\/h/io ) {
                $self->{is_band} = 1;
            } else {
                $self->{is_band} = 0;
            }
        }

        return $self->{is_band};
        
    }

}

=head2 user_name

Returns the profile name of the logged in account. This is the
name that shows up at the top of your profile page above your picture.
This is NOT the account name.

Normally you'll only retreive the value with this method. When logging
in, the internal login method calls this routine with the contents
of the profile page and this method extracts the user_name from the
page code. You can, if you really need to, call user_name with the
contents of a page to have it extract the user_name from it. This
may not be supported in the future, so it's not recommended.

=cut

sub user_name {

    # Otherwise if they gave us a home page, get user's name.
    if ( @_ ) {
        my ( $homepage ) = @_;
        my $page_source = $homepage->content;
        if ( $page_source =~ /<h4 +class="heading">\s*Hello,(\s|&nbsp;)+(.*)\!\s*<\/h4>/o ) {
#           my $line = $1;
#           $line =~ s/\+/ /g;
#           $line =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
            $self->{user_name} = $2;
        }
    }
    
    return $self->{user_name};

}

=head2 friend_user_name( [friend_id] )

Returns the profile name of the friend specified by friend_id.
This is the name that shows up at the top of their profile page
above their picture. 

If no friend_id is specified, this method scans the current page
so you can do:

 $myspace->get_profile( $friend_id );
 print $myspace->friend_user_name;

(Note, DON'T go using this to sign comments
because most users use funky names and it'll just look cheesy.
If you really want to personalize things, write a table mapping
friend IDs to first names - you'll have to enter them yourself).

=cut

sub friend_user_name {

    my $page;
    
    if ( @_ ) {
        $page = $self->get_profile( @_ );
    } else {
        $page = $self->current_page;
    }

    if ( $page->content =~ /<span class="nametext">(.*?)<\/span>/o ) {
        my $line = $1;
#        $line =~ s/\+/ /g;
#        $line =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
        return $line;
    } else {
        return "";
    }
}

=head2 friend_url( [friend_id] )

Returns the custom URL of friend_id's profile page. If they haven't
specified one, it returns an empty string.

 Example:
 
 foreach my $friend_id ( $myspace->get_friends ) {
     my $url = $myspace->friend_url( $friend_id );
     if ( $url ) {
         print 'Friend's custom URL: http://www.myspace.com/' .
         $myspace->friend_url( $friend_id );
     } else {
         print 'Friend doesn't have a custom URL. Use: '.
         'http://www.myspace.com/' . $friend_id;
     }
 }

If no friend_id is specified, this method scans the current page
so you can do:

 $myspace->get_profile( $friend_id );
 print $myspace->friend_url;

=cut

sub friend_url {

    my $page;
    
    if ( @_ ) {
        $page = $self->get_profile( @_ );
    } else {
        $page = $self->current_page;
    }

    if ( $page->content =~ /\<title\>[\s]*www.myspace\.com\/([\S]*)[\s]*\<\/title\>/o ) {
        return $1;
    } else {
        return "";
    }
}

=head2 friend_id ( friend_url )

Returns the friend_id corresponding to a given custom URL.
(This is basically the reverse of friend_url).

 # Print the friendID of Amber G: myspace.com/iamamberg
 print $myspace->friend_id("iamamberg");

 > 37033247

If no friend_url is specified, this method scans the current page
so you can do:

 $myspace->get_profile( $friend_id );
 print $myspace->friend_url;

=cut

sub friend_id { 

	my ($friend_url) = @_;
    my $page;

    if ( $friend_url ) {
        # If they gave a full URL chop off all but the last part.
    	$friend_url =~ s/^.*\///;
    	
    	#Get page corresponding to the given custom URL
        $page = $self->get_page( $BASE_URL.$friend_url );

    } else {
        $page = $self->current_page;
    }

	#Look for a RE that's near the top of the page that contains friendid
	if ($page->content =~ /fuseaction=user.viewPicture&amp;friendID=([0-9]+)/o ) {
		return $1;
	}
	else {
		return "";
	}
	
}

=head2 friend_count

Returns the logged in user's friend count as displayed on the
profile page ("You have NN friends").

Note that due to one of WWW::Myspace's many bugs, this count may not
be equal to the count of friends returned by get_friends.

Like the user_name method, friend_count is called by the internal
login method with the contents of the user's profile page, from
which it extracts the friend count using a regexp on the
"You have NN friends" string. If you need to, you can do so
also, but again this might not be supported in the future so do so
at your own risk.

=cut

sub friend_count {

    # If they gave us a page, set friend_count.
    if ( @_ ) {
        my ( $homepage ) = @_;
        my $page_source = $homepage->content;

        if ( $page_source =~ /You have(\s|&nbsp;|<span>)*(<a [^>]+>)?([0-9]+)(<\/a>)?(<\/span>|\s|&nbsp;)*friends/o ) {
            $self->{friend_count} = $3;
        }
    }
    
    return $self->{friend_count};

}

=head2 last_login( [friend_id] )

Returns the last login date from the specified profile in Perl "time"
format.

If no friend_id is specified, this method scans the current page
so you can do:

 $myspace->get_profile( $friend_id );
 ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
    localtime( $myspace->last_login );
 
 # or
 
 if ( $myspace->last_login( $friend_id ) < today - 3600 * 60 ) {
    print "They haven't logged in in 60 days!"
 }

=cut

sub last_login {

    my ( $page, $time );
    
    if ( @_ ) {
        $page = $self->get_profile( @_ );
    } else {
        $page = $self->current_page;
    }

    if ( $page->content =~ /Last Login:(\s|&nbsp;)+([0-9]+)\/([0-9]+)\/([0-9]+)\s*<br>/o ) {
        # Convert to Perl's time format.
        eval { $time="" ; $time = timelocal( 0, 0, 0, $3, $2 - 1, $4 ); };
        # Return it.
        return $time;
    } else {
        return "";
    }
}

#---------------------------------------------------------------------
# get_profile( $friend_id )
# Return the friend's profile page as an HTTP::Response object

=head2 get_profile( $friend_id )

Gets the profile identified by $friend_id.

Returns a reference to a HTTP::Response object that contains the
profile page for $friend_id.

    The following displays the HTML source code of the friend's
    profile identified by "$friend_id":

    my $res = $myspace->get_profile( $friend_id );

    print $res->content;

=cut

sub get_profile {

    my ( $friend_id ) = @_;

    return $self->get_page( "${VIEW_PROFILE_URL}${friend_id}",
        $VERIFY_GET_PROFILE );

}

=head2 get_comments( $friend_id )

Returns a list of hashrefs, like "inbox", of all comments
left for the profile indicated by $friend_id.

 Each list element contains:
 { 
   sender => $friend_id, # friendID of the person who sent the comment
   date => $date_time,   # As formatted on MySpace
   comment => $string    # HTML of the comment.
 }

Comments are returned in the order in which they appear on myspace
(currently most recent first).

Dies if called when not logged in.

=cut

sub get_comments {

    my ( $friend_id ) = @_;

    $self->_die_unless_logged_in( 'get_comments' );

    my $page="";
    my $page_no = 0;
    my @comments = ();
    my ( $key, $numless );
    my %lpd = (
        '01fuseaction' => '',
        '02friendID' => '',
        '03page' => 0,
        '04finalpage' => '',
        '05prevPage' => '',
        '06PREVPageLASTONERETURENED' => '',
        '07PREVPageFirstONERETURENED' => '',
        '08Mytoken' => ''
       );

    # Loop until we get an empty page or there isn't a "next" link.
    while ( 1 ) {

        # Get the page
        my $url="http://comments.myspace.com/index.cfm?";
        if ( $page_no ) {
            $lpd{'03page'}=$page_no;
            foreach $key ( sort( keys( %lpd ) ) ) {
                $numless = $key; $numless =~ s/^..//;
                $url .= "&${numless}=". $lpd{ $key };
            }
        } else {
            $url .= "fuseaction=user.viewComments&friendID=". $friend_id;
        }

#        warn "Getting $url\n";
        $page = $self->get_page( $url );

        # Get the message data.

#        warn "Getting comments from page $page_no\n";
        push @comments, $self->_get_comments_from_page( $page->content );

#        warn $page->content;
        last unless ( $self->_next_button( $page->content ) );
        
        # Next!
        $page_no++;
        # Read the page data and remember it.
        foreach $key ( keys( %lpd ) ) {
            $numless=$key ; $numless =~ s/^..//;
            $page->content =~ /<\s*input\s+type="?hidden"?\s+name="?${numless}"?\s+value="?([^">]*)"?\s*>/i;
            $lpd{ $key } = $1;
        }
        
    }

    return \@comments;

    
}

# Take a page, return a list of comment data
sub _get_comments_from_page {

    my ( $page ) = @_;
    my @comments = ();

    # Get to the comments section to avoid mis-reads
    if ( $page !~ m/Add Comment<\/a>/gs ) {
        $self->error("Comment section not found on page");
        return undef;
    }

    # Read the comment data and push it into our array.
    while ( $page =~
#            s/.*?UserID=([^;]+);.*?<span class="blacktext10">\s*([^<]+)\s*<\/span>\s*<br>\s*<br>\s*(.*?)<\/td>\s*<\/tr>//smo ) {
            s/.*?UserID=([0-9]+).*?<span class="blacktext10">\s*([^<]+)\s*<\/span>\s*<br>\s*<br>\s*(.*?)<\/td>\s*<\/tr>//smo ) {
        push @comments, { sender => $1, date => $2, comment => $3 }
    }
    
    return @comments;
}

sub ____EDIT_ACCOUNT____ {}

=head1 EDIT ACCOUNT

=head2 get_photo_ids( %options )

Each of your profile's photos is stored using a unique ID number.

This method returns a list of the IDS of the photos in your profile's photo section.

The only valid option at this time is:

 friend_id => $friend_id

Defaults to your friendID.

Croaks if called when not logged in and no photo_id was passed.

=cut

sub get_photo_ids {

    my ( %options ) = @_;

    $self->_die_unless_logged_in( 'get_photo_ids' ) unless $options{'friend_id'};

    my $friend_id = $options{'friend_id'} ? $options{'friend_id'} : $self->my_friend_id;

    $self->get_page("http://viewmorepics.myspace.com/index.cfm?" .
                    "fuseaction=user.viewPicture&friendID=" . $friend_id ) or return undef;

    my $last_id = -1;
    my @photo_ids = ();
    my $page = $self->current_page->content;
    while ( $page =~ s/^.*?imageID=([0-9]+)[^0-9]//iso ) {
        unless ( $1 == $last_id ) {
            push( @photo_ids, $1 );
            $last_id = $1;
        }
    }

    return ( @photo_ids );

}

=head2 set_default_photo( photo_id => $photo_id )

Sets your profile's default photo to the photo_id specified.

 Example:  Set your default photo to a random photo.

 use WWW::Myspace 0.60;
 my $myspace = new WWW::Myspace;
 
 my @ids = $myspace->get_photo_ids;
 $myspace->set_default_photo( $ids[ int( rand( @ids ) ) ] );

=cut

sub set_default_photo {

    my ( %options ) = @_;

    $self->_die_unless_logged_in( 'set_default_photo' );

    $self->_go_home or return undef;

#    warn "Going to Edit photos page\n";
    $self->follow_link( text_regex => qr/Edit Photos/io ) or return undef;

    # The photo should be on form 2 or later (search form and photo privacy form come
    # before the first picture).
#    warn "Getting form number\n";
    my $form_no = $self->_get_photo_form_no( $options{'photo_id'} ) or return undef;
#    warn "Found photo in form number $form_no\n";

    # We index from form 0 in submit_form.
    $self->submit_form( {
        form_no => $form_no,
        button => 'setDefault',
    } );

}

sub _get_photo_form_no {

    my ( $photo_id ) = @_;
    
    my ( @forms ) = $self->mech->forms;
    
    my $form_no = 0;
    foreach my $f ( @forms ) {
        if ( $f->find_input( 'imageID' ) ) {
            return $form_no if ( $f->value( 'imageID' ) == $photo_id );
        }
        $form_no++;
    }

    $self->error( "No photo with ID $photo_id found on Edit Photos page" );
    return undef;
}

sub ____FIND_PEOPLE____ {}

=head1 FIND PEOPLE

=head2 browse

Call browse with a hashref of your search criteria and it
returns a list of friendIDs that match your criteria.

This is a complex form. Don't trust the defaults you see in your web browser.
Easiest thing to do is paste this into your script and change the
values you want. (This example script looks up the specified criteria
and dumps a list of friendIDs in YAML).

 use WWW::Myspace;
 use YAML;
 
 my $myspace = new WWW::Myspace( human => 0, auto_login => 0 );
 
  my @friends = $myspace->browse( {
    'ctl00$Main$Scope' => 'scopeFullNetwork', # or 'scopeMyFriends'
    
    'ctl00$Main$Gender' => 'genderWomen', # or 'genderMen', 'genderBoth'
    'ctl00$Main$minAge' => 18,
    'ctl00$Main$maxAge' => 35,

    # Marital Status
    'ctl00$Main$statusSingle' => 'on',
    'ctl00$Main$statusInRelationship' => 'off',
    'ctl00$Main$statusSwinger' => 'off',
    'ctl00$Main$statusMarried' => 'off',
    'ctl00$Main$statusDivorced' => 'off',

    # Here for
    'ctl00$Main$motiveDating' => 'on',
    'ctl00$Main$motiveNetworking' => 'off',
    'ctl00$Main$motiveRelationships' => 'on',
    
    # Location (there are MANY country values. Check the browse page
    # source (see below)).
    'ctl00$Main$country' => 'US',
    'ctl00$Main$zipRadius' => 20,
    'ctl00$Main$zipCode' => 91604,
    'ctl00$Main$region' => 'Any',

    # Photos
    'ctl00$Main$showHasPhotoOnly' => 'on',
    'ctl00$Main$showNamePhotoOnly' => 'on', # Leave this on for speed.

    # Ethnicity
    'ctl00$Main$asian' => 'on',
    'ctl00$Main$white' => 'on',
    'ctl00$Main$black' => 'off',
    'ctl00$Main$eastIndian' => 'off',
    'ctl00$Main$latino' => 'off',
    'ctl00$Main$midEastern' => 'off',
    'ctl00$Main$nativeAmer' => 'off',
    'ctl00$Main$ethnOther' => 'off',
    'ctl00$Main$pacIslander' => 'off',

    # Body Type
    'ctl00$Main$slimSlender' => 'on',
    'ctl00$Main$average' => 'off',
    'ctl00$Main$moreToLove' => 'off',

    'ctl00$Main$athletic' => 'on',
    'ctl00$Main$littleExtra' => 'off',
    'ctl00$Main$bodyBuilder' => 'off',

    # Height
    'ctl00$Main$Height' => 'heightBetween', # or 'heightNoPreference'
    'ctl00$Main$minFoot' => 5,
    'ctl00$Main$minInch' => 0,
    'ctl00$Main$maxFoot' => 6,
    'ctl00$Main$maxInch' => 0,
    
    # Background & Lifestyle
    'ctl00$Main$Smoker' => 'smokerBoth', # or 'smokerNo', 'smokerYes'
    'ctl00$Main$Drinker' => 'drinkerBoth', # or 'drinkerNo', 'drinkerYes'

    'ctl00$Main$straight' => 'on',
    'ctl00$Main$bi' => 'on',
    'ctl00$Main$gay' => 'off',
    'ctl00$Main$notSure' => 'off',

    # Education (note: all off means no preference)
    'ctl00$Main$highSchool' => 'off',
    'ctl00$Main$inCollege' => 'off',
    'ctl00$Main$gradSchool' => 'off',
    'ctl00$Main$someCollege' => 'off',
    'ctl00$Main$collegeGrad' => 'off',
    'ctl00$Main$postGrad' => 'off',

    # Religion
    'ctl00$Main$religion' => 'NoPreference',
     # Possible Values Are:
     # NoPreference
     # Agnostic
     # Atheist
     # Buddhist
     # Catholic
     # ChristianOther
     # Hindu
     # Jewish
     # Mormon
     # Muslim
     # Other
     # Protestant
     # Scientologist
     # Taoist
     # Wiccan

    # Income
    'ctl00$Main$income' => 'NoPreference',
     # Possible Values Are:
     # NoPreference
     # LessThan30000
     # From30000To45000
     # From45000To60000
     # From60000To75000
     # From75000To100000
     # From100000To150000
     # From150000To250000
     # From250000ToHigher

    # Children
    'ctl00$Main$children' => 'NoPreference',
     # Possible Values Are:
     # NoPreference
     # IDontWantKids
     # Someday
     # Undecided
     # LoveKidsButNotForMe
     # Proud parent

    # Sort By (last login is good to weed out dead accounts)
    'ctl00$Main$SortBy' => 'sortByLastLogin',
     # Possible Values Are:
     # sortByLastLogin
     # sortByNewToMySpace
     # sortByDistance

    } );
    
 print Dump( @friends );

I'm not sure how I'm going to make the criteria passing easier.
I'm also concerned about your script breaking if they change the
browse form variable names. So maybe I'll add a mapping later.

The values above are current, and you can copy/paste that code, change
the values, and browse away.

If you need to look at values (i.e. something's not working or you need
to change "Location" fields):

Go to the browse page:

 http://browseusers.myspace.com/browse/Browse.aspx

Switch to Advanced mode and enter your search criteria.

View Source in your web browser and find "<form".  The second form should
be named "aspnetForm".

Look through the input tags on the form (hint: find "<input"),
entering name and value pairs as above for your search criteria.
Many/most of them are in the example above, but myspace does weird things
like differentiate checkboxes solely by their name instead of name and
value (i.e. you'd expect multiple inputs with
name="ct100$Main$SexualPreference" , and value="straight",
value="bi", etc, but instead there are inputs with
name="ct100$Main$straight" and name="ct100$Main$bi" and no value attribute
at all).

Note: to "check" a checkbox with no "value" attribute, use 'on' to turn
it on, 'off' to turn it off.  If you don't specify a field/checkbox in in
your search criteria, you'll get the default value, which is hard to
determine with this weird form (and is quite possibly NOT the default value
you'll see if you open the page in your web browser).

=cut

sub browse {

    my ( $criteria ) = @_;
    my @friends = ();

    # Safety check
    croak 'Criteria must be a hash reference\n' unless ref $criteria;

    my $re = "Browse Users";

    # Switch to advanced view
    $self->submit_form( {
        page => $BROWSE_PAGE,
        form_name => 'aspnetForm',
        no_click => 1,
        fields_ref => {
                            '__EVENTTARGET' => 'ctl00$Main$advancedView',
                        },
        re1 => $re,
        re2 => $re,
    } ) or return;

    # Enter the search criteria and click Update
    $self->submit_form( {
        form_name => 'aspnetForm',
        action => $self->_browse_action( 'Update' ),
        fields_ref => { %{$criteria}, '__EVENTTARGET' => 'ctl00$Main$update' },
        re1 => $re,
        re2 => $re,
    } ) or return;
    
#    $self->mech->form_name( "aspnetForm" )->dump;

    # Loop through the resulting pages getting friendIDs.
    my $page = 1;
    until ( ( $self->error ) ||
              ( ! $self->_next_button )
            ) {
        
        # Get the friends from the current page
        push @friends, $self->get_friends_on_page( $self->current_page->content );
        
        # Click "Next"
        $page++;
        $self->_browse_next( $page, $re );
        warn "Page: $page, friends: " . @friends . "\n";
    }

    # Sort and remove duplicates
    my %friends = ();
    foreach my $id ( @friends ) {
        $friends{ $id } = 1;
    }

    return ( sort( keys( %friends ) ) );
}

=head2 _browse_next( $page )

The browse form's Next button calls a JavaScript function that sets
"action" and "page" in the browse form and "clicks" submit.  So we
do the same here.  Called by browse to simulate clicking "next".

=cut

sub _browse_next {

    my ( $page, $re ) = @_;

    # Get the javascript-set action for the next button post
    my $action = $self->_browse_action( "GotoPage" );
    return 0 unless $action;
    
    # Submit the form.
    my $submitted = $self->submit_form( {
        'form_name' => "aspnetForm",
        'action' => $action,
        'no_click' => 1,
        'fields_ref' => { page => $page },
        're1' => $re,
        're2' => $re,
#       'base' => "http://browseusers.myspace.com/",
    } );

    return $submitted;

}

=head2 _browse_action( $function_name )

Gets the action set by the specificied function on the Browse page.

=cut

sub _browse_action {

    my ( $function ) = @_;

    # Look for the action (we need MyToken)
    $self->current_page->content =~
        /function ${function}.*?theForm\.action = "Browse\.aspx(\?MyToken=[^"]+)"/is;

#   my $action = "http://browseusers.myspace.com/browse" . $1;
    my $args = $1;

    unless ( $args ) {
        $self->error("Couldn't find Javascript GotoPage function to set action");
        return "";
    }
    
    my $action = "http://browseusers.myspace.com/browse/Browse.aspx" . $args;
    return $action;

}

=head2 cool_new_people( $country_code )

This method provides you with a list of "cool new people".
Currently Myspace saves the "cool new people" data
to a JavaScript file which is named something like this: 

http://viewmorepics.myspace.com/js/coolNewPeople_us.js

Since these files are named using country codes, you'll need to provide
the ISO 3166-1 two letter code country code for the list you'd like to
get.  For example,

 $myspace->cool_new_people( 'US' )

When called in a list context, this function returns the friend ids of
the cool folks:

 my @friend_ids = $myspace->cool_new_people( 'US' );

If you treat the return value as a hash reference, you'll get a hash
keyed on friend ids.  The values consist of hash references containing
the urls of the friend thumbnails (thumb_url) as well as their display
names (friend_user_name).  There will probably be about 200 keys
returned in the hash.


 my $cool = $myspace->cool_new_people('US');
 my %cool_new_people = %{$cool};

 %cool_new_people = {
 
 ...
 
     'friend_id' => {
         'thumb_url'         => 'url_to_jpg_here',
         'friend_user_name'  => 'friend display name here'
     },
 
 ...
 
 }

So far, we know of 4 country-specific cool new people lists: AU, CA,
UK/GB and US  Submitting any of these values to the function should
return valid friend ids.  If you want to check for other countries for
which cool people lists may exist, you can do something like this:

 use Locale::SubCountry;

 my $world         = new Locale::SubCountry::World;
 my %countries     = $world->code_full_name_hash();  
 my @country_codes = sort keys %countries;

 foreach my $country_code ( @country_codes ) {
     my %cool_people = $myspace->cool_new_people($country_code);
     if (%cool_people) {
         print "$country_code $countries{$country_code} has cool folks\n";
     }
     else {
        print "****** $country_code\n";
     }
 }
                        
=cut

sub cool_new_people {

    my $country_code    = shift;
    my $country_code_uc = "\U$country_code";
    my %cool_people     = ( );
    
    $self->error(0);  # Lets the calling script check for error being true.
    
    # special case for UK
    if ($country_code_uc  eq 'UK') {
        $country_code_uc = 'GB';
    }
    
    # get a list of valid country codes
    my $world = new Locale::SubCountry::World;
    my %countries = $world->code_full_name_hash();  
    
    if (exists $countries{$country_code_uc}) {

        my $country_code_lc = "\L$country_code";
        my $javascript_url =
            'http://viewmorepics.myspace.com/js/coolNewPeople_'.
            $country_code_lc.'.js';
        
        #my $res = $self->get_page( $javascript_url );
        
        # get_page helps circumvent myspace errors by checking for
        # errors and trying many times. If you DON'T want to do that
        # (and maybe you don't for this), then you'd do this instead:
        
        my $res = $self->{mech}->get( $javascript_url );

        unless ($res->is_success) {
        
            if ($res->code == 404) {
           
                # Do this instead of warning - lets the scripter have more control.
                $self->error("Unable to find cool new friends for $country_code_uc ($countries{$country_code_uc})");
                # warn "Unable to find cool new friends for $country_code_uc ($countries{$country_code_uc})";
            }
            else {
                
                $self->error( $res->status_line . " $javascript_url\n" );
                return 0;
                
                # don't die in modules, scripters will be mad. :)
                # die $mech->response->status_line, "$javascript_url\n";
            }
        }
        
        my $html = $res->content;
        my @lines = split(/\n/, $html);

        foreach my $line (@lines) {

            if ($line =~ /new coolNewPerson\('(.*?)', '(\d*?)', '(http.*?)'/) {
                $cool_people{$2} = { friend_user_name => $1, thumb_url => $3 };
            }
        }
    }
    
    else {
        
        $self->error( qq[You supplied: $country_code  You must supply a valid 2 character country code. For example cool_new_people('US')] );
        
        # Note: if the script is providing the value and it's bad, you can "croak".
        # If the user is providing the value and we're supposed to validate it,
        # set error and return a false value (or some indication of failure).
        # Note that they can: "if ( $myspace->error ) { ... }" also.
        # But you want to make sure the return value doesn't blow up their
        # script (and this shouldn't in this case).
        return 0;
        
        #die qq[You supplied: $country_code  You must supply a valid 2 character country code. For example cool_new_people('US')];
    }
    
    return 
        LIST   { keys %cool_people }
        HASHREF   { \%cool_people }
    ;
}

#---------------------------------------------------------------------
# get_friends();
# Return, as an array of friend IDs, all of our friends.
# For each friend page, grep for the "view profile" links, which
# contain the friend IDs.
# Accepts a source and source_id. 
# source can be:
# - inbox: read friendIDs from user's mail inbox
# - group: Read friendIDs from the group specified by source_id
# - profile: Read friendIDs from the profile specified by source_id
# - nothing: Reads friendIDs from the logged-in user's profile.
# The last option is identical to calling get_friends with "profile" and
# the friendID of the logged-in user, except that get_friends will
# croak if not logged in (because it can't get the friend_id).
# To the outside world, these options don't exist - they're passed
# by convenience methods.
#
# Options:
# start_page - not implemented yet
# end_page: Stop on this page
# max_count: Stop after retreiving this many friends.
#            May retreive slightly more than max_count.

=head2 get_friends( %options )

NOTE: As of version 0.59, "source => inbox" has been removed due to
a formatting change in Myspace.com.  Use the "friends_who_emailed"
method instead.

Returns, as a list of friendIDs, all of your friends. It does not include
Tom, because he's everybody's friend and when you're debugging your band
central CGI page it's probably best to limit your mistakes to
actual friends.

 # Simplest form - gets your friends.
 @friends = $myspace->get_friends;
 
 # Advanced form
 @friends = $myspace->(
    source => 'group',  # 'profile', 'group', 'inbox', or ''
    id => $group_id,    # friendID or groupID as appropriate
    end_page => $end_page,  # Stop on this page. All pages if not included.
    max_count => 300,   # Number of friends to return
    exclude => \%exclude_hash,  # Don't include these friendIDs
 );

Accepts the following options:

 source:    "profile" or "group"
            If not specified, gets your friends.
            profile: Get friends from the profile specified by the "id" option.
            group: Get the friends from the group specified by the "id" option.
 id:        The friendID or groupID (depending on "source").
            "id" is only needed for "profile" or "group".
            (See the "friends_in_group" method for more info).
 end_page:  Stop on this page.
            $myspace->get_friends( end_page => 5 );
            If not specified, gets all pages.
            See note below about interaction with other options.
 max_count: Return this many friendIDs.
            $myspace->get_friends( max_count => 300 );
            Stops searching and returns when max_count is reached.
            (See note below).
 exclude:   Exclude these friends, passed as a HASHREF
            containing friendIDs as its keys.
            If the "value" side of the pair is a true value,
            the friendID will be excluded.
            $myspace->get_friends( exclude => { 12345 => 1 };
            $myspace->get_friends( exclude => \%exclude_friends );
            
            You can also pass a reference to an array for convenience,
            but it will be turned into a hash, so it's a bit slower.
            $myspace->get_friends( exclude => [ 12345, 123456 ] );
            $myspace->get_friends( exclude => \@exclude_list );

Combine max_count and exclude for handy functionality:
 # This gets 300 friends, excluding those in the %exclude_friends
 # hash.
 $myspace->get_friends( source => 'group',
                        id => $group_id,
                        exclude => \%exclude_friends,
                        max_count => 300
                      );

If you specify max_count and end_page, get_friends will stop when it
hits the earliest condition that matches.

max_count may return up to 40 more friends than you specify.  This
is because it reads each friend page, and returns when it's gathered
max_count or more friends (and there are 40 per page).

As of version 0.37, get_friends is context sensitive and returns
additional information about each friend if called in a hashref context.
Currently the only information is the page number on which the friend
was found. This is handy if, say, you have a lot of friends and you want
to add one to your top 8 but you don't know what page they're on.

 # Find a friend lost in your friends list
 $lost_friend=12345;
 $friends = $myspace->get_friends;
 print "Found friend $lost_friend on page " .
    $friends->{"$lost_friend"}->{page_no} . "!\n";

Myspace trivia: The friends on friends lists are sorted by friendID.

Croaks if called with no arguments (i.e. to get your friends) and you're not
logged in.

=cut

# This is a rough draft of a re-write of get_friends that "correctly"
# handles paging through the friends pages the same way a browser does.
# Current issues are:
# - "source" handling is sloppy. This should really be separate methods.
# - Doesn't handle exclusions.
# - No real error checking.
#
# This method accepts the following options:
# source => "", "profile", "group"
# id => friend_id or group_id
# 
sub _get_friends {

    my ( %options ) = @_;
    my ( @friends ) = ();

    my $page_no = 1;

    # This should be split into "get_my_friends", "get_profile_friends",
    # and "get_group_friends".
    if ( $options{'source'} eq 'group' ) {
        $self->get_page( 'http://groups.myspace.com/index.cfm?'.
            'fuseaction=groups.viewMembers&groupID=' . $options{id}
        );
        $options{start_page} && $options{start_page}--;
        $options{end_page} && $options{end_page}--;
        $page_no--;
    } elsif ( $options{'source'} eq 'profile' ) {
        $self->get_profile( $options{id} );
        $self->follow_link( text_regex => qr/view all of .* friends/io );
    } else {
        $self->_go_home;
        $self->follow_link(
            text_regex => qr/view all of my friends/io,
            re => 'View All Friends',
        );
    }
    return undef if $self->error;

    # This should be "_get_friends", called by the above methods.
    while (1) {
        push ( @friends, $self->get_friends_on_page )
            unless ( $options{start_page} &&
                     ( $page_no < $options{start_page} )
                   );

        last unless $self->_next_button or
            ( $options{end_page} && ( $page_no >= $options{end_page} ) );

        $page_no++;
        $self->submit( {
            form => 'PageForm',
            no_click => 1,
            re2 => 'View All Friends',
            fields_ref => { page => $page_no },
        } );

    }

    return ( @friends );
}

sub get_friends {

    my ( %options ) = @_;

    my ( $source, $source_id );
    if ( $options{'source'} ) { $source = $options{'source'} }
    if ( $options{'id'} ) { $source_id = $options{'id'} }
    $source = "" unless defined $source;

    # Check for backwards compatability
    if ( $source eq 'inbox' ) {
        warn 'source => inbox is deprecated.  Please use '.
             "friends_who_emailed method.\n";
        return $self->friends_who_emailed;
     }

    # Can't get "our" friends if we're not logged in.
    unless ( $source ) {
        $self->_die_unless_logged_in( 'get_friends' );
    }

    # Profiles' friend lists start at page 1, the rest start at 0. 
    my $page=0; $page++ if ( ( $source eq "" ) || ( $source eq "profile" ) );

    # Initialize
    my $friends_page="";
    my %friend_ids = ();
    my @friends_on_page = ();
    my ( $id );
    my %myexclude = ();
    my $finished = 0;

    # Fix exclusions if they gave us an array.
    if ( ref $options{'exclude'} eq "ARRAY" ) {
        foreach $id ( @{ $options{'exclude'} } ) {
            $myexclude{ $id }++;
        }
        $options{'exclude'} = \%myexclude;
    }

    # Loop until we get an empty page or there isn't a "next" link.
    while ( 1 ) {

        # Get the page
        $friends_page = $self->_get_friend_page( $page, $source, $source_id );
        if ( $self->error ) {
            warn "get_friends failed on page $page: " . $self->error . "\n";
            last;
        }

        # Grep the friend IDs out
        @friends_on_page = $self->get_friends_on_page( $friends_page->content );
        ( $DEBUG ) && print "Done with page $page. ". scalar @friends_on_page ." FRIENDS\n";

        # If it's our, or another's profile, warn if there are too few friends.
        if ( ( $source =~ /^(profile)?$/o ) &&
             ( $self->{_friend_count} > 40 ) &&
             ( $self->_next_button( $friends_page->content ) ) &&
             ( @friends_on_page < 30 )
           ) {
            warn "Got only " . @friends_on_page . " friends on page $page.\n";
        }

        # Validate and add them to the list
        # (for inbox, removes duplicates)
        foreach $id ( @friends_on_page ) {
            unless ( $options{'exclude'}->{ $id } ) {
                # We shouldn't have a duplicate friendID, so error if
                # we do (usually indicates a myspace change that's
                # breaking our URL).
                if ( ( $source ne 'inbox' ) && $friend_ids{"$id"} ) {
                    $self->error("Duplicate friend_id $id found on page $page");
                    last;
                } else {
                    # Store the page we found it on.
                    $friend_ids{"$id"}={ 'page_no' => $page };
                    # Profiles start at page 1, inbox and group at page 0
                    # (but appear to the user as page 1), so add the offset
                    # for them if the source is not a profile.
                    $friend_ids{"$id"}->{page_no}++ unless ( ( $source eq "" ) ||
                                    ( $source eq "profile" ) );
                }
            }
        }

        # See if we're finished or need to stop:
        # If there's an error
        last if ( $self->error );
        # Of there's no next button
        $finished = 1 unless ( $self->_next_button( $friends_page->content ) );
        # If we've gotten as many pages as they want
        $finished = 1 if ( ( $options{'end_page'} ) &&
                           ( $page >= $options{'end_page'} )
                         );
        # If we've gotten as many friendIDs as they want
        $finished = 1
            if ( ( $options{'max_count'} ) &&
                 ( keys( %friend_ids ) >= $options{'max_count'} )
               );
        # If we're debugging and we've gotten more than 5 pages.
        $finished = 1 if ( ( $page > 5 ) && ( $DEBUG ) );
        # If we got a page with no friendIDs on it (and we're not done for
        # some other reason).
        unless ( @friends_on_page ) {
            $self->error("Page $page had no friends");
            last;
        }

        # Next!
        $self->{_last_friend_page} = $page;
        $page++;
        
    }

    # Returning an incomplete list of our friends can be dangerous
    # since it's used to do exclusions. Unless we finished early on purpose,
    # do a safety check. We see if the friend count is within 10% of the
    # number of friends returned (no, myspace's friend counter is never
    # actually right.....)
    
    if ( (! $finished ) &&
         ( ! $self->error ) &&
         ( ( $source eq "" ) || ( $source eq "profile" ) ) &&
         ( $self->{_friend_count} )
       ) {
        my $myspace_friend_count = $self->{_friend_count};
        my @friends = keys( %friend_ids );
        my $friend_count = @friends;
        if ( $options{'exclude'} ) {   # Add any excluded friends back in
            $friend_count += keys( %{ $options{'exclude'} } )
        }
        my $error_allowed = $myspace_friend_count * .10;
        my $error_offset = abs ( $myspace_friend_count - $friend_count );
        if ( $error_allowed < 10 ) { $error_allowed = 10 };
        
        if ( $error_offset > $error_allowed ) {
            warn "WARNING: get_friends returned $friend_count friends, ".
            "but should have returned around " . $myspace_friend_count . ".";
        }
        
        # If we stopped before the last page, throw an error
        if ( $page < $self->{_friend_pages} ) {
            $self->error( "get_friends stopped before reaching last page, ".
                          "friend list is incomplete" );
        }
    }

    # If the source is a user's profile, delete the user's friendID from
    # the returned list.
    if ( ( defined $source ) && ( $source eq 'profile' ) ) {
        delete $friend_ids{$source_id};
    }

    # Return the list
    if ( $DEBUG ) {
        my @friends = keys( %friend_ids );
        print "get_friends got " . @friends . " friends\n";
    }
#print Dumper(\%friend_ids);
    
    # Return our findings
    return 
        LIST { sort( keys( %friend_ids ) ) }
        SCALAR { \%friend_ids }
        HASHREF { \%friend_ids }
    ;

}

#---------------------------------------------------------------------
# friends_from_profile( friend_id );

=head2 friends_from_profile( %options )

Returns a list of the friends of the profile(s) specified by the "id" option.
id can be a friendID or a reference to an array of friendIDs.
If passed a list of friend IDs, scans each profile and returns a sorted,
unique list of friendIDs.  Yes, that means if you pass 5 friendIDs and
they have friends in common, you'll only get each friendID once.
You're welcome.

Also accepts the same options as the get_friends method
(end_page, max_count, etc).

 Examples:
 
 # Band 12345 and 54366 sound like us, get their friends list
 @similar_bands_friends=
   $myspace->friends_from_profile( id => [ 12345, 54366 ] );

 # Get the first 500 friends from profile 12345
 @friends = $myspace->friends_from_profile(
                id => 12345,
                max_count => 500
            );

 # A further example:
 # Before you do anything with these ids, make sure you don't already
 # have them as friends (uses the "exclude" option in get_friends,
 # which is very efficient as friends are excluded as they're read
 # instead of afterwards):
 my @current_friends = $myspace->get_friends;
 die $self->error if $self->error;
 my @potential_friends = $myspace->friends_from_profile(
    id => [ 12345, 54366 ],
    exclude => \@current_friends
 );

=cut

sub friends_from_profile {

    my ( @profiles ) = @_;
    my ( %options );
    
    # Check for old format ( @friend_ids ) or new ( id => \@friend_ids )
    if ( $profiles[0] =~ /^[0-9]+$/o ) {
        %options = ( id => \@profiles );
    } else {
        ( %options ) = ( @profiles );
    }
    my @friends = ();
    my $id;
    my %friend_ids = ();

    # Get the profiles.  Take an arrayref or a single number
    if ( ref $options{'id'} ) {
        ( @profiles ) = ( @{ $options{'id'} } );
    } else {
        ( @profiles ) = ( $options{'id'} );
    }

    # Delete the id and source options.
    delete $options{'id'};
    delete $options{'source'} if ( $options{'source'} );
    
    # Get the friendIDs
    foreach $id ( @profiles ) {
        push ( @friends,
               $self->get_friends(
                   source => 'profile',
                   id => $id,
                   %options )
             );
        last if ( $self->error );
    }

    # Sort and return (also removes duplicates from multiple profiles)
    foreach $id ( @friends ) {
        $friend_ids{"$id"}=1;
    }
    
    return ( sort( keys( %friend_ids ) ) );
}

#---------------------------------------------------------------------

=head2 friends_in_group( group_id );

Convenience method: Same as calling
"get_friends( source => 'group', id => $group_id )".

Returns a list of the friend IDs of all people in the
group identified by group_id. Tom is disincluded as in get_friends
(because the same routine is used to get the friendIDs).


Example:

 my @hilary_fans = $myspace->friends_in_group( 100011592 );
 
 @hilary_fans now contains the friendID of everyone in the HIlary
 Duff Fan Club group (group ID 100011592 ).
 
To get the group ID, go to the group page in WWW::Myspace and look at
the URL:
http://groups.myspace.com/index.cfm?fuseaction=groups.viewMembers&GroupID=100011592&adTopicId=&page=3
 
The group ID is the number after "GroupID=".

=cut

sub friends_in_group {

    # If they didn't give us a group, return nothing. Could
    # be argued that we should croak here.
    return () unless ( @_ );

    # Return the friends.
    return $self->get_friends( source => 'group', id => $_[0] );

}

#---------------------------------------------------------------------
# friends_who_emailed();
# Return a list of friends with mail in the inbox.

=head2 friends_who_emailed

Convenience method.  Reads messages from "inbox" method and returns
a list of senders.

This used to be the same as calling "get_friends( source => 'inbox' )",
but Myspace changed the way the inbox paging wored and it was more
practical to read from the inbox method. Changed in 0.59.

Returns, as a list of friend IDs, all friends with messages
in your inbox (mail). Note that this only tells you who you have mail from,
not how many messages, nor does it contain any method to link to those
messages. Use "inbox" for that.

This method is primarily designed to aid in auto-responding programs
that want to not contact (comment or email) people who have sent
messages so someone can attend to them personally.  Frankly, it was
written before "inbox" and may be deprecated in the future.
Croaks if you're not logged in.

    @friends = $myspace->friends_who_emailed;

=cut

sub friends_who_emailed {

    $self->_die_unless_logged_in( 'friends_who_emailed' );
    my %senders = ();

    my $messages = $self->inbox;
    
    # Store the senders
    foreach my $message ( @{$messages} ) {
        $senders{ $message->{sender} }++;
    }
    
    return ( sort( keys( %senders ) ) );

}

=head2 search_music

Search for bands using the search music form.

Takes a hashref containing field => value pairs that are passed directly
to submit_form to set the search criteria.

 http://musicsearch.myspace.com/index.cfm?fuseaction=music.search

The easiest way I've found to get your values is to fill them in on the
search form, click "Update", then look at the page source.  Scroll to
the botton where "PageForm" is and you'll see the values you selected.
Put the pertinent ones (i.e. things you changed) into your script.
Note that the field *names* are different, so just take the values,
and use the names as described below.

Any value the form can take (present or
future) can be passed, so in theory you could write a CGI front-end also
that just had the form, posted the values to itself, then used those
values to call this method (i.e. do what I suggested above automatically).

Here are the currently available form labels/values (looking at the form
helps):

 genreID: See the form for values

 search_term:
    0: Band Name
    1: Band Bio
    2: Band Members
    3: Influences
    4: Sounds like

 keywords: text field. Use it if you're searching by band name, etc.

 Country: Labeled "Location" in the form. See the form source for values.

 localType: The radio buttons. Set to:
   countryState: To search by Country / State
   distanceZip: To search by distance and zip code.

 if localType is "countryState", set this:
   state: State code (like the post office uses, thankfully. See form code
          if you have any questions).

 If localType is "distanceZip", set these:
   zip: The 5-digit zip code.
   distance: Distance from zip code [0|5|10|20|50|100|500]. 0="Any" and is the
             default.

 OrderBy: [ 5 = Plays | 4 = Friends |3 = New | 2 = Alphabetical ]
          Default is 2.

IMPORTANT: Results are currently sorted by friendID regardless of the
OrderBy setting.

For those who care about details, here's how the Search Music page works:

There are three forms on the page, the generic
"search" form in the nav bar, a second form called "myForm" that is
the user-modified update form, and a third form called "PageForm" that
is actually used to pass the values.  PageForm is updated with the values
after "update" is clicked in myForm. Clicking "Next" just sets
(using JavaScript in Myspace) the page value in PageForm and submits PageForm.
Oddly enough, PageForm ends up being a "GET", so you could theoretically
just loop through using URLs.  But we don't, we fill in the form like a
browser would.

=cut

# And now this is compiled only once, not potentially 4 times. This would be
# a good candidate to put at the top? 
our $page_verify_re = 
  qr/Music.*?&raquo;.*?Search Results.*<\/html>/o;

sub search_music {

    my ( $sc ) = @_;
    
    # Page verification RE
    my $re = $page_verify_re;
                   
    # First fill in the search form with their criteria.
    $self->submit_form( {
        page =>
            'http://musicsearch.myspace.com/index.cfm?fuseaction=music.search',
        form_no => 1,
        fields_ref => $sc,
        re1 => $re,
        re2 => $re,
#        base => 'http://musicsearch.myspace.com/'
    } );

    return undef if $self->error;

    # Get the friends
    my $page_no = 0;
    my %friends = ();
    do {

        # Get the friends on this page
        foreach my $id ( $self->get_friends_on_page ) {
            $friends{ "$id" } = { 'page_no' => $page_no+1 };
        }
        
        # Click "Next".
        $page_no++;
        print "Getting page " . $page_no . "\n";
        $self->submit_form( {
            'form_name' => 'PageForm',
            no_click => 1,
            'fields_ref' => { page => $page_no },
            're1' => $re,
            're2' => $re,
#            base => 'http://musicsearch.myspace.com/',
        } );

    } until ( ( $self->error ) || ( ! $self->_next_button ) );


     # Clean up and return
     return 
        LIST { sort( keys( %friends ) ) }
        HASHREF { \%friends }
     ;
}

sub ____CONTACT_PEOPLE____ {}

=head1 CONTACT PEOPLE

These methods interact with other users.

=cut

#---------------------------------------------------------------------

=head2 post_comment( $friend_id, $message )

Post $message as a comment for the friend identified by $friend_id.
The routine confirms success or failure by reading the resulting
page. It returns a status string as follows:

 P   =>  Passed! Verification string received.
 PA  =>  Passed, requires approval.
 FF  =>  Failed, you must be someone's friend to post a comment about them.
 FN  =>  Failed, network error (couldn't get the page, etc).
 FC  =>  Failed, CAPTCHA response requested.
 FI  =>  Failed, Invalid friendID.
 FL  =>  Failed, Add Comment link not found on profile page.
 F   =>  Failed, verification string not found on page after posting.

Warning: It is possible for the status code to return a false
"Failed" if the form post is successful but the resulting page fails
to load.

If called in scalar context, it returns the status code.  If called in
list context, returns the status code and the description (bug note:
FC and FN return only the status code regardless of context).

EXAMPLE:
    use WWW::Myspace;
    my $myspace = new WWW::Myspace;

    foreach $id ( $myspace->friends_who_emailed ) {
        $status = $myspace->post_comment( $id, "Thanks for the message!" )
    }

    # Get a printable status (and print it)
    ( $status, $desc ) = $myspace->post_comment(
        $id, "Thanks for being my friend!"
    );
    print "Status of post: $desc\n";

post_comment loads $friend_id's profile page, clicks the "Add Comment"
link, fills in, posts, and confirms a comment. If $friend_id is a
non-true value (i.e. "0" or ''), post_comment will search for and click
an "Add Comment" link on the last page loaded.  This lets you do
this without double-loading the profile page wasting time and bandwidth:

 $myspace->get_profile( $friend_id );
 if ( $myspace->current_page->content =~ /something special/ ) {
     $myspace->post_comment( 0, "Your page is special!" );
 }

If called when you're not logged in, post_comment croaks to make you
look stupid.

See also the WWW::Myspace::Comment module that installs with the
distribution.

=cut

sub post_comment {

    my ( $friend_id, $message, $captcha_response ) = @_;
    my $status = ""; # Our return status
    my ($submitted, $attempts, $link);

    $self->_die_unless_logged_in( 'post_comment' );
    
    # Check data
    croak "Must pass friend_id and message to post_comment" unless
        ( ( $friend_id ) && ( $message ) );

    my %status_codes = (

        P   =>  'Passed! Verification string received.',
        PA  =>  'Passed, requires approval.',
        FF  =>  'Failed, you must be someone\'s friend to post a comment about them.',
        FN  =>  'Failed, network error (couldn\'t get the page, etc).',
        FC  =>  'Failed, CAPTCHA response requested.',
        FI  =>  'Failed, Invalid FriendID.',
        FL  =>  'Failed, Add Comment link not found on profile page.',
        F   =>  'Failed, verification string not found on page after posting.',

    );

    unless ( $captcha_response ) {
        # Convert newlines (\n) into socket-ready CRLF ASCII characters.
        # This also takes care of possible literal "\n"s that come
        # from command-line arguments.
        $message =~ s/(\n|\\n)/\015\012/gos;
        
        # If we have a friendID, load the profile
        if ( $friend_id ) {
            $self->get_profile( $friend_id );
            return "FN" if $self->error;
        }

        # Submit the comment to $friend_id's page
        $link = $self->mech->find_link(
                                text_regex => qr/^add\s+comment$/io );
        return "FL" unless $link;

        ( $DEBUG ) && print "Getting comment form..\n";
        # JL2006 POST EXAM
        $submitted = 
            $self->submit_form( {
                     page => $link->url,
                     follow => 1,
                     form_no => 1,
                     fields_ref => {
                        'ctl00$Main$postComment$commentTextBox' => "$message"
                     },
                     re1 => 'ctl00\$Main\$postComment\$commentTextBox'.
                            ".*<\/form|(${CAPTCHA})|(${NOT_FRIEND_ERROR})|".
                            "($INVALID_ID)",
                     re2 => 'ctl00\$Main\$postComment\$ConfirmPostButton.*<\/form'
            } );
        
        # If we posted ok, confirm the comment
        if ( $submitted ) {
        
            # See if there's a CAPTCHA response required, if so,
            # fail appropriately.
            if ( $self->current_page->content =~ $CAPTCHAi ) {
                $self->captcha( "$1" );
                return "FC";
            }
            
            # Otherwise, confirm it.
            ( $DEBUG ) && print "Confirming comment...\n";
            $submitted = $self->submit_form( '', 1, "",
                    {} );
        } else {
            $self->error( 'First submit failed in post_comment with error: '.
                $self->error );
        }

    } else {
        # Post the confirmation
        $submitted = $self->submit_form( '', 1, '',
            { 'CAPTCHAResponse' => $captcha_response } );
    }

    # Get the resulting page and clean it up (strip whitespace)
    my $page = $self->current_page->content;
    $page =~ s/[ \t\n\r]+/ /g;

    # Set the status code to return.
    if ( $page =~ $NOT_FRIEND_ERROR ) {
        $status="FF";
    } elsif ( $page =~ /$INVALID_ID/i ) {
        $status="FI";
    } elsif (! $submitted ) {
        $status="FN";
    } elsif ( $page =~ $VERIFY_COMMENT_POST ) {
        $status="P";
    } elsif ( $page =~ $COMMENT_APPROVAL_MSG ) {
        $status = "PA";
    } else {
        $status="F";
    }

    return (
        LIST { $status, $status_codes{$status} }
        SCALAR  { $status }
    );
}

=head2 captcha

If post_comment returns "FC", the "captcha" method will return
the URL to the CAPTCHA image that contains the text that the
user must enter to post the comment.

 Psuedo-code example of how you can use this in a CGI script:

 my $response = $myspace->post_comment( 12345, 'This is a message' );
 if ( $response eq 'FC' ) {
    # Get and display the image
    print '<form>\n'.
      "<img src='" . $myspace->captcha . "'>\n".
      '<input type=text name=\'CAPTCHAResponse\'>' .
      '<input type=submit>' .
      '</form>';
 }

 # Post the comment
 $myspace->post_comment( 12345, 'This is a message', $captcha_response );

 (Use in a CGI script is currently problematic since you'll lose the
 Myspace object. I'll try to write a better example later. You could
 try doing a YAML Dump and Load of the $myspace object...)

=cut

field 'captcha';

#---------------------------------------------------------------------
# comment_friends( $message, $attr )
# Posts a comment to all of our friends. $attr is a hash reference
# containing selection criteria.
# Example:
# $myspace->comment_friends( "Merry Christmas!", { 'ignore_dup' => 'Y' } );
# (Note: we don't handle the filtering here yet)

=head2 comment_friends( $message )

=head2 comment_friends( $message, { 'ignore_dup' => 1 } )

This convenience method sends the message in $message to
all of your friends. (Since you can only comment friends, it
sends the comment to everyone you can).

By default it will scan the user's profile page for a previous comment
(by searching for your profile URL on the page, which also detects
you if you're in their top 8 or otherwise linked to from their page).

If called in the second form, it forgoes this duplicate checking
(ignores duplicates), and posts anyway.

Note that you'll probably want to use the WWW::Myspace::Comment module
as if the process is interrupted (which is likely), this
routine doesn't offer a way to recover. 
The WWW::Myspace::Comment module logs where comments have been left, scans for
previous comments we've left on the user's page, and can stop after a
specified number of posts to avoid triggering security measures. It can also
be re-run without leaving duplicate comments.

Of course, if you just want to whip off a quick comment to a few (less than
50) friends, this method's for you.

EXAMPLE:
    A simple script to leave a comment saying "Merry Christmas"
    to everyone on your friends list:

    use WWW::Myspace;
    my $myspace = new WWW::Myspace;
    $myspace->comment_friends( "Merry Christmas!" );

=cut

sub comment_friends {

    my ( $message, $attr ) = @_;

    my $status = "";
    my $friend_id;
    
    # Get friends
    my @friends=$self->get_friends;
    
    # Loop and post
    foreach $friend_id ( @friends ) {
        # If we can ignore duplicates or we haven't commented them already,
        # post the comment.
        if ( ( $attr->{'ignore_dup'} ) ||
            (! $self->already_commented( $friend_id ) ) )  {
            
            $status = $self->post_comment( $friend_id, $message );
        }
    }

}

#---------------------------------------------------------------------
# already_commented( $friend_id );
# Return true if we've previously left a comment for this person.

=head2 already_commented

Returns true if there is a link to our profile on "$friend_id"'s page.
(If we've left a comment, there'll be a link).

Note that if you're friends with this person and they have another link
to your profile on their page, this will return true, even though
you may not have left a comment.

EXAMPLE

  my WWW::Myspace;
  my $myspace = new WWW::Myspace;
  
  foreach $friend_id ( $myspace->get_friends ) {
      unless ( $myspace->already_commented( $friend_id ) ) {
        $myspace->post_comment(
            $friend_id,
            "Hi, I haven't commented you before!"
        )
      }
  }

already_commented croaks if called when you're not logged in.

=cut

sub already_commented {

    my ( $friend_id ) = @_;

    $self->_die_unless_logged_in( 'already_commented' );

    # Get the page
    my $page = $self->get_profile( $friend_id )->content;

    # If we got an error, return a false true (but error is set)
    return 1 if $self->error;

    # If $self->my_friend_id isn't set for some reason, this'll return
    # a false "true", so set error.
    if ( $self->my_friend_id ) {
        $self->error(0)
    } else {
        $self->error( "my_friend_id is not set!" )
    }

    # Set up our regular expression. We're looking for the link code
    my $fr_id = $self->my_friend_id;

    # If the link's on their page, return true, otherwise return false. 
    if ( $page =~ /${FRIEND_REGEXP}$fr_id/ ) {
        return 1
    } else {
        return 0;
    }

}

=head2 inbox

Returns a reference to an array of hash references that contain data
about the messages in your Myspace message inbox. The hashes contain:

 sender (friendID)
 status (Read, Unread, Sent, Replied)
 message_id (The unique ID of the message)
 subject (The subject of the message)

The messages are returned IN ORDER with the newest first to oldest last
(that is, the same order in which they'd appear if you were looking through
your inbox).

I'm sure reading that first line made you as dizzy as it made me typing it.
I think this says it all much more clearly:

 EXAMPLE
 
 # This script displays the contents of your inbox.
 use WWW::Myspace;

 $myspace = new WWW::Myspace;
 
 print "Getting inbox...\n";
 my $messages = $myspace->inbox;

 # Display data for each message 
 foreach $message ( @{$messages} ) {
   print "Sender: " . $message->{sender} . "\n";
   print "Status: " . $message->{status} . "\n";
   print "messageID: " . $message->{message_id} . "\n";
   print "Subject: " . $message->{subject} . "\n\n";
 }

(This script is in the sample_scripts directory, named "get_inbox").

"inbox" croaks if called when you're not logged in.

=cut

sub inbox {

    my $page="";
    my $page_no = 0;
    my @messages = ();

    $self->_die_unless_logged_in( 'inbox' );

    # Go home
    $self->_go_home;
    return () if $self->error;

    # Get the first page
    $page = $self->follow_to(
                $self->mech->find_link(
                    url_regex => qr/fuseaction=mail\.inbox/i
                )->url, 'Mail Center.*Inbox'
            ) or return ();

    # Loop until we get an empty page or there isn't a "next" link.
    while ( 1 ) {

        ( $DEBUG ) && print "inbox reading page $page_no\n";
        # Get the message data.
        push @messages, $self->_get_messages_from_page;

       last unless ( $self->_next_button );
#       last unless ( $page->content =~ /">Next( |&nbsp;)\&gt;/io );
        
        # Next!
        $self->submit_form( {
            form_name => 'aspnetForm',
            fields_ref => {
                '__EVENTTARGET' =>
                'ctl00$cpMain$messageList$pagingNavigation1$NextLinkButton',
            },
            no_click => 1,
        } );
        $page_no++;
        
    }

    return \@messages;

}

# Return a list of message data from the current page
sub _get_messages_from_page {

    my $page = $self->current_page->content;
    my @messages = ();
    while ( $page =~
            s/.*?UserID=([^;]+);.*?(Unread|Read|Sent|Replied).*?messageID=([^&]+)&.*?>([^<]+)<//som ) {
        push @messages,
             { sender => $1, status => $2, message_id => $3, subject => $4 }
    }
    
    return @messages;
}

=head2 read_message( message_id )

Returns a hashref containing the message identified by message_id.

 my $message_ref = $myspace->read_message( 123456 );
 
 print 'From: ' . $message_ref->{'from'} . .'\n' . # Friend ID of sender
       'Date: ' . $message_ref->{'date'} . .'\n' . # Date (as formatted on Myspace)
       'Subject: ' . $message_ref->{'subject'} .'\n' .
       'Body: ' . $message_ref->{'body'} . '\n';   # Message body

Croaks if you're not logged in.

=cut

sub read_message {

    my ( $message_id ) = @_;

    $self->_die_unless_logged_in( 'read_message' );

    my %message = ();
    my $res = $self->get_page( 'http://messaging.myspace.com/index.cfm?'.
            'fuseaction=mail.readmessage&userID='.$self->my_friend_id.
            '&type=inbox&messageID='.$message_id.'&fed=True',
            'read mail.*body:|Mail Center.*Inbox');
    return \%message if $self->error;

    # If we were passed a bad message ID, we'll have the inbox again
    if ( $res->content !~ /read mail.*Body:/smio ) {
        warn "Invalid Message ID\n";
        return \%message;
    }

    # Include the messageID in the hash
    $message{'message_id'} = $message_id;

    # Now we have to yank data out of a messy page.
    my $page = $res->content;
    $page =~ s/[ \t\n\r]+/ /go; # Strip whitespace

    # From:
    $page =~ /From:.*?friendID=([0-9]+)[^0-9]/io;
    $message{'from'} = $1;

    # Date:
#   $page =~ /Date:.*?> ?([^<]+) ?</o;
#   $page =~ /(Date:.*?> [^<]+ <)/o;
    $page =~ /Date:.*?<span.*?>\s+([^<]+)\s?</o;
    $message{'date'} = $1;
    
    # Subject:
    if ( $page =~ />Subject:<.*?<td>([^ <][^<]+)<\/td>/o ) {
        $message{'subject'} = $1;
    }
 
    # Body:
#   $res->content =~ /<span class="blacktextnb10">.*^(.*)^                          <br><br><br>/sm;
    $res->content =~ /<th>Body:.*?<td>(.*)\s+<br \/><br \/><br \/>/smo;
    $message{'body'} = $1;
    
    # Clean up newlines
    $message{'body'} =~ s/[\n\r]/\n/go;

    # Gotta clean white space before and after the body
    $message{'body'} =~ s/^\s*//so;  # Before
    $message{'body'} =~ s/\s*$//so;  # After

    # And they have these BR tags at the beginning of each line...
    $message{'body'} =~ s/^[ \t]*<br \/>[ \t]*//mog;
    
    return \%message;
}


#---------------------------------------------------------------------

=head2 reply_message( $message_id, $reply_message )

Warning: This is a new, un-tested method.  If you're reading this, it
means I had to release a new version for some reason before I got to
complete the testing and documentation of this method. It "should" work
fine.  Let me know if it does or not.

Reply to message $message_id using the text in the string
$reply_message.

Returns a status code:
 
  P: Posted. Verified by HTTP response code and reading a regexp
    from the resulting page saying the message was sent.
 FC: Failed. A CAPTCHA response was requested.
 FF: Failed. The person's profile is set to private. You must
     be their friend to message them.
 FA: Failed. The person has set their status to "away".
 FE: Failed. The account has exceeded its daily usage.
 FN: Failed. The POST returned an unsuccessful HTTP response code.
 F:  Failed. Post went through, but we didn't see the regexp on the
    resulting page (message may or may not have been sent).


 Example:
 my $status = $myspace->reply_message( 1234567, "Thanks for emailing me!" );

If you're not logged in? Croaks.

=cut

sub reply_message {

    my ( $id, $reply ) = @_;
    my ( $submitted, $message, $reply_message, $page );

    $self->_die_unless_logged_in( 'reply_message' );

    # Fill in the message (this is lazy...)
    $message = $self->read_message( $id );
    $reply_message = $reply . $message;

    # Convert newlines (\n) into socket-ready CRLF ASCII characters.
    # This also takes care of possible literal "\n"s that come
    # from command-line arguments.
    # (Note that \n does seem to work, but this "should" be safer, especially
    # against myspace changes and platform differences).
    $reply_message =~ s/(\n|\\n)/\015\012/gos;
    
    # First load the message and click "Reply" (first button - it has no
    # name so this'll break if they change the button order).
    $submitted = $self->submit_form( {
        page => 'http://messaging.myspace.com/index.cfm?'.
            'fuseaction=mail.readmessage&userID='.$self->my_friend_id.
            '&type=inbox&messageID='.$message.'&fed=True',
        form_no => 1,
        re1 => "Read Mail"
    } );

    # See if we can mail or if there's an error.
    if ( $submitted ) {
        $page = $self->current_page->content;
        $page =~ s/[ \t\n\r]+/ /go;
        if ( $page =~ /${MAIL_PRIVATE_ERROR}/i ) {
            return "FF";
        } elsif ( $page =~ /${MAIL_AWAY_ERROR}/i ) {
            return "FA";
        }
    } else {
        return "FN";
    }
    
    # Post the reply
    $submitted = $self->submit_form( '', 1, '',
        { 'ctl00$ctl00$Main$Main$sendMessageControl$bodyTextBox' =>
          $reply_message
        }
    );

    # Verify and return the appropriate code.
    $page = $self->current_page->content;
    $page =~ s/[ \t\n\r]+/ /g;

    # Return the result
    if (! $submitted ) {
        return "FN";
    } elsif ( $page =~ $VERIFY_MESSAGE_SENT ) {
        return "P";
    } elsif ( $page =~ $EXCEED_USAGE ) {
        return "FE";
    } elsif ( $page =~ $CAPTCHAi ) {
        return "FC";
    } else {
        return "F";
    }

#   my ( $url, $form_no, $button, $fields_ref, $regexp1, $regexp2, $base_url ) = @_;

}


#---------------------------------------------------------------------

=head2 send_message( $friend_id, $subject, $message, $add_friend_button )

=head2 send_message( %options )

 Options are friend_id, subject, message, atf.

 Example:
 $status = $myspace->send_message(
     friend_id => 12345,
     subject => 'Hi there',
     message => 'This is the bestest message ever!',
     atf => 0,
     skip_re => 'i hate everyone', # Skip negative people
 );

The %options hash is the "correct" method of passing arguments as of
version 0.53.  The parameter based method is here for backwards-compatibility.

send_message sends a message to the user identified by "friend_id".
If "atf" is a true value, HTML code for a "View My Profile" link will
be added at the end of the message. (This was an Add To Friends button
until Myspace started munging that code).
If "skip_re" is defined, friend_id's profile will be matched against
the RE.  Whitespace will be compressed and the match will NOT be
case-sensitive.

 So you can do this:
 skip_re => 'i hate everyone!* ?(<br>)?'
 
 And it will match:
 I Hate EVERYONE!!!!
 I hate everyone<br>
 I Hate EvEryone!!! <BR>
 etc.

If "friend_id" is an untrue value (i.e. 0 or ''),
send_message will look for a Send Message button (identified by
a "fuseaction=mail.message" URL if you're curious) on the current page.
This lets you do this efficiently:

 # Send a message only if the profile has "fancy regex" on their page
 $myspace->get_profile( $friend_id );
 if ( $myspace->current_page =~ /fancy regex/ ) {
    $myspace->send_message(
        subject => "Hello",
        message => "I'm messaging you"
    );
 }

 $status = $myspace->send_message(
     friend_id => 6221,
     subject => 'Hi Tom!',
     message => 'Just saying hi!',
     atf => 0
 );

 if ( $status eq "P" ) { print "Sent!\n" } else { print "Oops\n" }

 Returns a status code:

 P   =>  Passed! Verification string received.
 FF  =>  Failed, profile set to private. You must be their
         friend to message them.
 FN  =>  Failed, network error (couldn't get the page, etc).
 FA  =>  Failed, this person's status is set to "away".
 FS  =>  Failed, skipped. Profile doesn't match RE.
 FE  =>  Failed, you have exceeded your daily usage.
 FC  =>  Failed, CAPTCHA response requested.
 FI  =>  Failed, Invalid friend ID.
 F   =>  Failed, verification string not found on page after posting.

If called in list context, returns the status code and text description.

 ( $status, $desc ) = $myspace->send_message( $friend_id, $subject, $message );
 print $desc . "\n";

See also WWW::Myspace::Message, which installs along with the
distribution.

(Croaks if called when you're not logged in).

=cut

sub send_message {

    # Backwards compatibility
    my ( %options ) = ();
    if ( $_[0] =~ /^[0-9]+$/o ) {
        my ( $friend_id, $subject, $message, $atf ) = @_;
        %options = (
            friend_id => $friend_id,
            subject => $subject,
            message => $message,
            atf => $atf
        );
    } else {
        ( %options ) = @_;
    }

    my ( $submitted, $res, $page, $status );

    $self->_die_unless_logged_in( 'send_message' );

    my %status_codes = (

        P   =>  'Passed! Verification string received.',
        FF  =>  'Failed, profile set to private. You must be their '.
                'friend to message them.',
        FN  =>  'Failed, network error (couldn\'t get the page, etc).',
        FA  =>  'Failed, this person\s status is set to "away".',
        FS  =>  'Failed, skipped. Profile doesn\'t match RE.',
        FE  =>  'Failed, you have exceeded your daily usage.',
        FC  =>  'Failed, CAPTCHA response requested.',
        FI  =>  'Failed, Invalid FriendID.',
        FL  =>  'Failed, can\'t find Send Message link on profile page.',
        F   =>  'Failed, verification string not found on page after posting.',

    );

    # Add the button if they wanted it.
    if ( ( defined $options{'atf'} ) && ( $options{'atf'} ) ) {
        $options{'message'} .= '<p><a href="http://profile.myspace.com/index.cfm?'.
            'fuseaction=user.viewprofile&'.
            'friendID=';
        if ( $options{'atf'} > 1 ) {
            $options{'message'} .= $options{'atf'};
        } else {
            $options{'message'} .= $self->my_friend_id;
        }
#        $options{'message'} .= '"><img src="http://i.myspace.com'.
#            '/site/images/addFriendIcon.gif" alt="Add as friend"></a>\n';
        $options{'message'} .= '">View My Profile</a>\n';
    }

    # If we were given a friend ID, get the profile
    if ( $options{'friend_id'} ) {
        $res = $self->get_profile( $options{'friend_id'} );
        ( $DEBUG ) && print "Got profile:\n" . $res->content . "\n";
        
        if ( $options{'skip_re'} ) {
            $page =~ $res->content;
            $page =~ s/[ \t\n\r]+/ /go;
            if ( $options{'skip_re'} =~ /$options{'skip_re'}/i ) {
                return "FS";
            }
        }

    }

    # Try to get the message form
    $res = $self->mech->find_link(
            url_abs_regex => qr/fuseaction=mail\.message/io
    );
    ( $DEBUG ) && print "Found Send Message link: " . $res->url . "\n";
    
    if ( $res ) {
        $res = $self->follow_to( $res->url,
        'Mail\s+Center.*Send\s+a\s+Message|'.$MAIL_PRIVATE_ERROR.'|'.
        $MAIL_AWAY_ERROR.'|'.$INVALID_ID );
    } else {
        return "FL"
    }

    # Check for network error
    if ( $self->error ) {
        return "FN";
    }

    # Check for known messages that say we can't send it.
    $page = $res->content;
    $page =~ s/[ \t\n\r]+/ /go;
    if ( $page =~ /$MAIL_PRIVATE_ERROR/i ) {
        return "FF";
    } elsif ( $page =~ /$MAIL_AWAY_ERROR/i ) {
        return "FA";
    } elsif ( $page =~ /$INVALID_ID/i ) {
        return "FI";
    } elsif ( $page =~ $CAPTCHAi ) {
        return "FC";
    }

    # Convert newlines (\n) into socket-ready CRLF ASCII characters.
    # This also takes care of possible literal "\n"s that come
    # from command-line arguments.
    # (Note that \n does seem to work, but this "should" be safer, especially
    # against myspace changes and platform differences).
    $options{'message'} =~ s/(\n|\\n)/\015\012/gso;
    
    # Submit the message
    if ( $page =~ /ctl00\$ctl00\$Main\$Main\$sendMessageControl\$subjectTextBox/ ) {
        # New mail form...
        $submitted = $self->submit_form( '', 1, "",
            { 'ctl00$ctl00$Main$Main$sendMessageControl$subjectTextBox' =>
                "$options{'subject'}",
              'ctl00$ctl00$Main$Main$sendMessageControl$bodyTextBox' =>
                "$options{'message'}"
            }
        );
    } else {
        # Old mail form... Seriously, don't get me started...
        $submitted = $self->submit_form( '',
                        1, "",
                        { 'subject' => "$options{'subject'}",
                          'mailbody' => "$options{'message'}"
                        }
                      );
    }

    
    $page = $self->current_page->content;
    $page =~ s/[ \t\n\r]+/ /g;

    # Return the result
    if (! $submitted ) {
        $status = "FN";
    } elsif ( $page =~ $CAPTCHAi ) {
        $status = "FC";  # They keep changing which page this appears on.
    } elsif ( $page =~ $VERIFY_MESSAGE_SENT ) {
        $status = "P";
    } elsif ( $page =~ $EXCEED_USAGE ) {
        $status = "FE";
    } else {
        $status = "F";
    }
    
    return (
        LIST { $status, $status_codes{$status} }
        SCALAR  { $status }
    );
}

=head2 delete_message( @message_ids )

Deletes the message(s) identified by @message_ids. Takes a list
of messageIDs or of hashrefs with a message_id subcomponent (such
as one gets from the "inbox" method).  Croaks if called when not
logged in.

Deletes all messages in a single post.  Returns true if it worked,
false if not, and sets the "error" method to the error encountered.

Example:

 # Delete message 12345
 $myspace->delete_message( 12345 );

 # File myspace mail where it belongs.
 $all_messages = $myspace->inbox;
 
 $myspace->delete_message( @{ $messages } );     

=cut

sub delete_message {

    my ( @message_ids ) = @_;

    my ( $form, $tree, $f, $res, $id );
    my $pass=1;

    warn "delete_message disabled because Myspace's Delete button doesn't work\n";
    return 0;
    $self->_die_unless_logged_in( 'delete_message' );

    foreach my $message ( @message_ids ) {
        
        # Get the message and click "delete"
        $self->submit_form( {
            page => 'http://messaging.myspace.com/index.cfm?'.
            'fuseaction=mail.readmessage&userID='.$self->my_friend_id.
            '&type=inbox&messageID='.$message.'&fed=True',
            form_name => 'aspnetForm',
            button => 'ctl00$ctl00$Main$Main$ReadMessage1$DeleteButton',
#           no_click => 1,
#            action => '',
            re1 => 'Mail\s+Center.*?Read\s+Mail'
        } ) or $pass = 0;

    }
    
    return $pass;

}

#---------------------------------------------------------------------

=head2 approve_friend_requests( [ "message" ] )

Looks for any new friend requests and approves them.
Returns a list of friendIDs that were approved.
If "message" is given, it will be posted as a comment to the
new friends. If called when you're not logged in, approve_friend_requests
will croak.

If approve_friend_requests runs into a CAPTCHA response when posting
comments, it will set $myspace->captcha to the URL of the CAPTCHA
image.  If no CAPTCHA was encountered, $myspace->captcha will be 0.
So you can say:

 if ( $myspace->captcha ) { print "oh no!\n" }

approve_friend_requests will approve all friends whether or not it can
comment them as it approves first, then comments the list of approved
friends.

 EXAMPLES

  # Approve any friend requests
  @friends_added = $myspace->approve_friend_requests;

  # Print the number of friends added and their friend IDs.
  print "Added " . @friends_added . " friends: @friends_added.";

  # Approve new frieds and leave them a thank you comment.
  @friends_added = $myspace->approve_friend_requests(
    "Thanks for adding me!\n\n- Your nww friend" );

Run it as a cron job. :)

Note that "\n" is properly handled if you pass it literally also (i.e.
from the command line). That is if you write this "approve_friends"
script:

 #!/usr/bin/perl -w
 # usage: approve_friends [ "message" ]
 
 use WWW::Myspace;
 my $myspace = new WWW::Myspace;
 
 $myspace->approve_friend_requests( @ARGV );
 
 And run it as:
 
 approve_friends "Thanks for adding me\!\!\n\n- Me"
 
You'll get newlines and not "\n" in the message. There, I even gave
you your script.

=cut

sub approve_friend_requests
{

    my @guids = ();
    my @friends = ();
    my %friends = ();  # Not a typo. See below.
    my ( $page, $id );
    my ( $message ) = @_;

    $self->_die_unless_logged_in( 'approve_friend_requests' );

    # Go Home
    $self->_go_home;
    return 0 if $self->error;

    # Click the friend requests link
    $self->follow_to(
        $self->mech->find_link(
            url_regex => qr/fuseaction=mail\.friendRequests/io
        )->url,
        'Friend Request Manager'
    );
    return 0 if $self->error;

    # As long as there are friend requests on the page,
    # select all of them and click "Approve Selected Friends"
    my $f;
    while ( @guids = $self->_get_friend_requests ) {
        
        # Get the friendIDs from the page
        @friends = ( @friends, $self->get_friends_on_page );

        # Check the checkboxes and submit the form
        $self->submit_form( {
            form_name => 'aspnetForm',
            button_name => 'ctl00$ctl00$Main$Main$incomingRequests$ApproveSelectedRequestsButton',
            fields_ref => {
                'ctl00$ctl00$Main$Main$incomingRequests$requestRepeater$ctl00$selectRequest' =>
                \@guids },
            re2 => qr/Friend Request Manager/o
        } );

    }

    # Clean up friends (there -could- be duplicates in some circumstances)
    my $captcha=0;
    $self->captcha( 0 ); # Reset captcha so they can check it.
    foreach $id ( @friends ) {
        $friends{"$id"}++;
        # If we're to post a message, and this isn't a duplicate,
        # post a comment to this new friend.
        if ( ( $message ) && ( $friends{"$id"} == 1 ) && ( ! $captcha )) {
            if ( $self->post_comment( $id, $message ) eq "FC" ) {
                $captcha=1;
            }
        }
    }
    
    # Return the list of friends
    return keys( %friends );

}

#---------------------------------------------------------------------
# _get_friend_requests()
# Returns a list of friend requests from the Friend Requests page

sub _get_friend_requests
{
    my $page = $self->current_page->content;

    my %guids = ();
    my $line = "";

    # Get the GUID codes from it.   
    while ( $page =~ s/ctl00\$ctl00\$Main\$Main\$incomingRequests\$requestRepeater\$ctl00\$selectRequest.*? value="(.*?)"//im ) {
        $guids{"$1"}++;
    }
    
    return keys( %guids );
}

##---------------------------------------------------------------------
## _post_friend_requests( $form )
## Post the filled in friend approval form.
#
#sub _post_friend_requests
#{
#
#    my ( $f ) = @_;
#
#    $self->submit_form( {
#        form => $f,
#        button => 'ctl00$ctl00$Main$Main$incomingRequests$ApproveSelectedRequestsButton',
#        re2 => 'Friend Request Manager',
#        'die' => 1
#    } );
#
#}

#---------------------------------------------------------------------
# send_friend_request

=head2 send_friend_request( $friend_id )

IMPORTANT: THIS METHOD'S BEHAVIOR HAS CHANGED SINCE VERSION 0.25!

Sorry, I hate to break backwards-compatibility, but to keep this
method in line with the rest, I had to. The changes are:
1) It takes only one friend, it will DIE if you give it more
   (mainly to let you know that #2 has changed so your scripts don't
   think they're succeeding when they're not).
2) It no longer returns pass/fail, it returns a status code like
   post_comment.

Send a friend request to the friend identified by $friend_id.  Croaks if
not logged in.

This is the same as going to their profile page and clicking
the "add as friend" button and confirming that you want to add them.

Returns a status code and a human-readable error message:

 FF: Failed, this person is already your friend.
 FN: Failed, network error (couldn't get the page, etc).
 FP: Failed, you already have a pending friend request for this person
 FC: Failed, CAPTCHA response requested.
 P:  Passed! Verification string received.
 F: Failed, verification string not found on page after posting.

After send_friend_request posts a friend request, it searches for
various Regular Expressions on the resulting page and sets the
status code accordingly. The "F" response is of particular interest
because it means that the request went through fine, but none of
the known failure messages were received, but the verification
message wasn't seen either.  This means it -might- have gone through,
but probably not.  Of course, worst case here is you try again.


 EXAMPLES
 
 # Send a friend request and get the response
 my $status = $myspace->send_friend_request( 12345 );
 
 # Send a friend request and print the result
 my ( $status, $desc ) = $myspace->send_friend_request( 12345 );
 print "Received code $status: $desc\n";
 
 # Send a friend request and check for some status responses.
 my $status = $myspace->send_friend_request( 12345 );
 if ( $status =~ /^P/ ) {
    print "Friend request sent\n";
 } else {
    if ( $status eq 'FF' ) {
        print "This person is already your friend\n";
    } elsif ( $status eq 'FC' ) {
        print "Received CAPTCHA image request\n";
    }
 }

 # Send a bunch of friend requests
 my @posted = ();
 my @failed = ();
 foreach my $friend ( @friends ) {
   print "Posting to $friend: ";
   my $status = $myspace->send_friend_request( $friend )
   
   if ( $status =~ /^P/ ) {
       print "Succeeded\n";
       push ( @posted, $friend );
   } else {
       print "Failed with code $status\n";
       push ( @failed, $friend );
   }
   
   # Stop if we got a CAPTCHA request.
   last if $status eq 'FC';
 }
 # Do what you want with @posted and @failed.
 
Also see the WWW::Myspace::FriendAdder module, which adds multiple
friends and lets you enter CAPTCHA codes.

=cut

sub send_friend_request {

    # We had to break backwards compatibilty, so enforce it.
    if ( @_ > 1 ) {
        die 'send_friend_request has been changed. Must use '.
            'send_friend_requests to send to multiple friends.\n'.
            'Also now returns status code instead of true/false.\n'.
            'perldoc WWW::Myspace for info.';
    }

    my ( $friend_id ) = @_;

    $self->_die_unless_logged_in( 'send_friend_request' );

    my %status_codes = (

        FF  =>  'Failed, this person is already your friend.',
        FN  =>  'Failed, network error (couldn\'t get the page, etc).',
        FP  =>  'Failed, you already have a pending friend request for this person',
        FB  =>  'Failed, this person does not accept friend requests from bands.',
        FA  =>  'Failed, this person requires an email address or last name to add them',
        FC  =>  'Failed, CAPTCHA response requested.',
        P   =>  'Passed! Verification string received.',
        F   =>  'Failed, verification string not found on page after posting.',

    );

    my $return_code = undef;
    my $page;

    # Get the form
    my $res = $self->get_page( $ADD_FRIEND_URL . $friend_id );

    # Check for network failure
    if ( $self->error ) {
        $return_code='FN';
    }

    # Strip the page for comparisons
    $page = $self->current_page->content;
    $page =~ s/[ \t\n\r]+/ /go;

    # Check for "doesn't accept band"
    if ( ( $self->is_band ) && ( $page =~
            /does not accept add requests from bands/io ) ) {
        $return_code = 'FB';
    }

    # Check for "last name or email" required
    elsif ( $page =~ /only accepts add requests from people he\/she knows/o ) {
        $return_code = 'FA';
    }
    
    # Check for CAPTCHA
    elsif ( $page =~ /CAPTCHA/o ) {
        $return_code = 'FC';
    }

    # Check for "already your friend"
    elsif ( $page =~ /already your friend/io ) {
        $return_code = 'FF';
    }

    # Check for pending friend request
    elsif ( $page =~ /pending friend request/io ) {
        $return_code = 'FP';
    }

    # Now see if we have a button to click.
    # MUST BE LAST.
    # (This probably could return a different code, but it means we don't
    # have a button and we don't know why).
    # XXX You may want to loop this entire statement, because currently:
    # - get_page gets a page, checking for any known error messages.
    # - this if statement checks for known errors we might receive
    # - This final statement makes sure we have a button to click so
    #   we don't bomb in "submit_form".
    # - BUT, if we get an error page get_page doesn't know (i.e. they
    #   change an error message or something), we probbaly
    #   want to retry this page.
    # You might want to change this whole section to:
    # do { $res = $self->get_page ... ;
    # $attempts++; } until ( ( $attempts > 20 ) || ( $page =~ /<input type="submit" ...) );
    elsif ( $page !~ /<input\s+type="submit"\s+value="Add to Friends"[^>]*>/io ) {
        $return_code ='F';
        warn "No Add to Friends button on form!\n";
    }
    
    unless ( $return_code ) {
        # Post the add request form
        $res = $self->submit_form(
            $self->current_page, 1, '', {} );
    
        # Check response
        unless ( $res ) {
            $return_code = 'FN';
        }
        
        # Unless we already have a return code, check for REs on the page
        # to see what we got.
        unless ( $return_code ) {
    
            $page = $self->current_page->content;
            $page =~ s/[ \t\n\r]+/ /go;
    
            # Check for success
            if ( $page =~ /An email has been sent to the user/io ) {
                $return_code = 'P';
            }
    
        }   
    }

    # If we still don't have a return code, something went wrong
    unless ($return_code) {
        warn "No return code\n";
        $return_code = 'F';
    }
 
    return (
        LIST { $return_code, $status_codes{$return_code} }
        SCALAR  { $return_code }
    );
}

=head2 send_friend_requests( @friend_ids )

Send friend requests to multiple friends. Stops if it hits a
CAPTCHA request. Doesn't currently give any indication of
which requests succeeded or failed. Use the code example
above for that. Croaks if you're not logged in.

=cut

sub send_friend_requests {

    $self->_die_unless_logged_in( 'send_friend_requests' );

    foreach my $id ( @_ ) {
        last if $self->send_friend_request( $id ) eq 'FC';      
    }

}

=head2 add_to_friends

Convenience method - same as send_friend_request. This method's here
because the button on Myspace's site that the method emulates
is usually labeled "Add to Friends".

=cut

sub add_to_friends {
    $self->send_friend_request( @_ );
}

=head2 add_as_friend

Convenience method - same as send_friend_request. This method's here
Solely for backwards compatibility. Use add_to_friends or
send_friend_request in new code.

=cut

sub add_as_friend {
    $self->send_friend_request( @_ );
}

#---------------------------------------------------------------------
# delete_friend

=head2 delete_friend( @friend_ids )

Deletes the list of friend_ids passed from your list of friends.

 $myspace->delete_friend( 12345, 151133 );

Returns true if it posted ok, false if it didn't.  Croaks if you're
not logged in.

=cut

sub delete_friend {

    my ( @del_friends ) = @_;

    my ( $form, $tree, $f, $res, $id );
    # my $pass=1;  

    $self->_die_unless_logged_in( 'delete_friend' );

    # Get our home page.
    $self->_go_home;
    return 0 if $self->error;

    # Get the edit friends page
    $self->follow_to(
        $self->mech->find_link(
            url_regex => qr/fuseaction=user\.editfriends/i
       )->url
    );
    return 0 if $self->error;
    
    # Select the edit form and get the hash field
    $self->mech->form_name( 'friendsDelete' );
    my $hash_value = $self->mech->value( 'hash' );
    my $mytoken = $self->mech->value( 'Mytoken' );

    # Create our delete form
    $form =
        '<form action="index.cfm?fuseaction=user.deleteFriend&page=0" '.
        'method="post">';

    $form .= '<input type="hidden" name="hash" value="'.
        $hash_value . '">';

    $form .= '<input type="hidden" name="Mytoken" value="'.
        $mytoken . '">';

    foreach $id ( @del_friends ) {

        $form .= '<input type="checkbox" name="delFriendID" value="'
            . $id . '">';

    }

    $form .= '<input type="image" border="0" name="deleteAll" '.
        'http://x.myspace.com/src="images/btn_deleteselected.gif" '.
        'width="129" height="20">'.
        '</form>';

    # Turn it into an HTML::Form object
    $f = HTML::Form->parse( $form, 'http://collect.myspace.com/' );

    # Check the checkboxes
    foreach my $input ( $f->find_input( 'delFriendID' ) ) {
        $input->check;
    }

    # Submit the form
    my $attempt = 0; my $max_attempts = 25;
    my $request = $f->click( 'deleteAll' );
    $request->header( 'Referer' => $self->current_page->request->uri );
    do {
        $res = $self->mech->request( $request );
        $attempt++;
	$self->_traceme("Delete friend submit attempt $attempt",$res);
    } until ( ( $self->_page_ok( $res ) ) || ( $attempt > $max_attempts ) );

    # I felt guilty adding a variable even for readability so I removed $pass :)
    #unless ( $attempt <= $max_attempts) {
    #    $pass=0;
    #}

    $self->{current_page} = $res;

    return ($attempt <= $max_attempts);

}

=head2 send_event_invitation( $event_id, [ @friend_ids ] )

Send an event invitation to each friend in @friend_ids.  You need
to add the event in Myspace first, then run a script that calls
this method feeding it the event ID, which you can get from the URL of
the page that lets you invite friends.  If no friend IDs are passed,
send_event_invitation calls the get_friends method and sends to all
of your friends.

The method returns a reference to 2 arrays, "passed", and "failed".
Because it wil probably take a long time to run, it also prints a
running report of the friends its inviting with "Passed" or "Failed":

 Inviting 12345: Passed
 Inviting 12346: Failed

Known issue: If you already have people in your invitation list and
this method attempts to add those friends again, it will cause substantial
delays (up to a minute or two per friend ID).  This is because submit_form
will receive an error message and will retry the post 5 times for each
friend.

 Example:
 
 my ( $passed, $failed ) =
     $myspace->send_event_invitation( $event_id, @friend_ids );
 die $myspace->error if $myspace->error;
 
 print "Sent to:\n";
 foreach $id ( @{ $passed } ) {
     print $id . "\n";
 }
 
 print "Failed to send to:\n";
  foreach $id ( @{ $failed } ) {
     print $id . "\n";
 }

See also the send_event_invitations sample script in the sample_scripts
directory included with this distribution.

=cut

sub send_event_invitation {

    my ( $event_id, @friend_ids ) = @_;

    $self->_die_unless_logged_in( 'send_event_invitation' );

    # Default to all our friends
    unless ( @friend_ids ) { @friend_ids = $self->get_friends }

    # Get the page
    my $res = $self->get_page(
        "http://events.myspace.com/index.cfm?fuseaction=events.invitees&eventID=".
        $event_id );
    return( [], \@friend_ids ) if $self->error;

    # For each friendID, fill in the form and submit it.  Hey, this is
    # their idea, not mine...
    my @passed = ();
    my @failed = ();
    foreach my $id ( @friend_ids ) {
        print "Inviting $id: ";
        if ( $self->submit_form( {
                page => $res,
                form_name => 'createEvent',
                fields_ref => { 'hiddenFriends', $id }
            } ) ) {
            push( @passed, $id );
            print "Passed\n";
        } else {
            push( @failed, $id );
            print "Failed\n";
        }

    }

    return ( \@passed, \@failed );

}

=head2 send_group_invitation( $event_id, [ @friend_ids ] )

Send a group invitation to each friend in @friend_ids.  You need
to add the group in Myspace first, then run a script that calls
this method feeding it the group ID, which you can get from the URL of
the group's page.  If no friend IDs are passed,
send_event_invitation calls the get_friends method and sends to all
of your friends.

The method returns a reference to 2 arrays, "passed", and "failed".
Because it wil probably take a long time to run, it also prints a
running report of the friends its inviting with "Passed" or "Failed":

 Inviting 12345: Passed
 Inviting 12346: Failed

 Example:
 
 my ( $passed, $failed ) =
     $myspace->send_group_invitation( $event_id, @friend_ids );
 die $myspace->error if $myspace->error;
 
 print "Sent to:\n";
 foreach $id ( @{ $passed } ) {
     print $id . "\n";
 }
 
 print "Failed to send to:\n";
  foreach $id ( @{ $failed } ) {
     print $id . "\n";
 }

See also the send_group_invitations sample script in the sample_scripts
directory included with this distribution.

Croaks if called when not logged in.

=cut

sub send_group_invitation {

    my ( $group_id, @friend_ids ) = @_;

    $self->_die_unless_logged_in( 'send_group_invitation' );

    # Default to all our friends
    unless ( @friend_ids ) { @friend_ids = $self->get_friends }

    # Get the page if we don't already have it.
    my $res;
    if ( $self->{_group_info}->{$group_id} ) {
        $res = $self->{_group_info}->{$group_id}->{invite_page};
    } else {
        $res = $self->get_page(
            'http://groups.myspace.com/index.cfm?'.
            'fuseaction=groups.groupInvite&groupID='.
            $group_id );
        return( [], \@friend_ids ) if $self->error;
        # Store res in case they're looping for us.
        $self->{_group_info}->{$group_id}->{invite_page} = $res;
    }

    # For each friendID, fill in the form and submit it.  Hey, this is
    # their idea, not mine...
    my @passed = ();
    my @failed = ();
    foreach my $id ( @friend_ids ) {
        print "Inviting $id: ";
        if ( $self->submit_form( {
                page => $res,
                form_name => 'inviteForm',
                fields_ref => { 'hiddenFriends', $id }
            } ) ) {
            push( @passed, $id );
            print "Passed\n";
        } else {
            push( @failed, $id );
            print "Failed\n";
        }

    }

    return ( \@passed, \@failed );

}

=head2 post_bulletin( %options )

Post a builletin to your friends.

 use WWW::Myspace;
 
 my $myspace = new WWW::Myspace;

 $myspace->post_bulletin(
     subject => $subject,
     message => $message
 );

Croaks if called when not logged in.

=cut

sub post_bulletin {

    my %options = @_;

    $self->_die_unless_logged_in( 'post_bulletin' );

    # Go home
    $self->_go_home;
    return 0 if $self->error;
#    warn "Got home page" . "\n" if $options{'testing'};
    
    # Click "post bulletin"
    my $link = $self->mech->find_link(
                            text_regex => qr/^post\s+bulletin$/io );

    unless ( $link ) {
        $self->error("Post Bulletin link not found on home page");
        return 0;
    }
#    warn "Found Post Bulletin link: ".$link->url . "\n" if $options{'testing'};

    # Fill in and submit the form
    my $submitted = $self->submit_form( {
        page => $link->url,
        follow => 1,
        form_name => 'bulletinForm',
        fields_ref => {
            subject => $options{'subject'},
            body => $options{'message'},
        },
        re1 => 'name="bulletinForm"',
        re2 => 'Confirm\s+Bulletin',
    } );

    return 0 unless $submitted;

    # And now confirm it (unless we're testing).
    unless ( $options{'testing'} ) {
#        warn "Submitting Confirmation screen";
        $submitted = $self->submit_form( {
            form_name => 'bulletinForm'
        } );
    }

    return $submitted;

}

=head2 post_blog( %options )

Post a blog entry.

 $myspace->post_blog(
     subject => $subject,
     body    => $body
 ) or die $myspace->error;

You can also use "message" instead of "body".

Currently only Subject and Message fields are supported.  Mood, Category, Music,
etc will be left at their default settings.

Returns undef and sets $myspace->error if there's an error.

Croaks if called when not logged in.

=cut

sub post_blog {

    my ( %options ) = @_;
    
    # They can pass "message" or "body".
    if ( $options{message} ) { $options{body} = $options{message} }

    # Check for requirements.
    croak "No body passed to post_blog" unless $options{body};
    croak "No subject passed to post_blog" unless $options{subject};
    $self->_die_unless_logged_in( 'post_blog' );

    # Get the blog editor page directly.  Going via links tries to load the
    # advanced editor, which doesn't help much.
    ( $DEBUG ) && warn "Getting blog editor page\n";
    $self->get_page( 'http://blog.myspace.com/index.cfm?fuseaction=blog.create&editor=false',
                     'Go To Advanced Editor'
                   ) or return undef;
    
    # Get Mytoken
    $self->current_page->content =~ /Mytoken=([A-Za-z0-9\-]+)/;
    my $token = $1;

    # Fill and in post the blog
    ( $DEBUG ) && warn "Submitting initial blog form\n";
    $self->submit_form( {
        form_no => 1,
        fields_ref => {
            subject => $options{subject},
            body => $options{body},
        },
        # They use JavaScript to reset the action of the form...
        action => 'http://blog.myspace.com/index.cfm?fuseaction=blog.previewBlog&Mytoken='.
                  $token,
        no_click => 1,
        re2 => 'Confirm Blog Posting'
    } ) or return undef;

    # Post the confirmation, unless we're in test mode.
    ( $DEBUG ) && warn "Posting blog confirmation\n";
    unless ( $options{testing} ) {
        $self->submit_form( {
            form_no => 1,
            action => 'http://blog.myspace.com/index.cfm?fuseaction=blog.processCreate',
            no_click => 1,
        } ) or return undef;
    }

    ( $DEBUG ) && warn "Returning Successful\n";
    return 1;

}

#---------------------------------------------------------------------
# get_friend_name( $friend_id )
# Return the first name of $friend_id, if we have it.

#sub get_friend_name {
#
#   my $self = shift;
#   
#   my ( $friend_id ) = @_;
#
#   # Just select and return :)
#   my $first_mame = $self->{dbh}->selectrow_arrayref("select first_name from friends where friendid=${friend_id}");
#   
#   return $first_name;
#
#}

#---------------------------------------------------------------------

sub ____CORE_INTERNAL_METHODS____ {}

=head1 CORE INTERNAL METHODS

These are methods used internally to maintain or handle basic
stuff (page retreival, error handling, cache file handling, etc)
that you probably won't need to use (and probably shouldn't use unless
you're submitting a code patch :).

=head2 trace_func
 
You may pass this a code reference. If you do, it will be called 
on EACH successful HTML page retreived this module. The arguments
passed to this code reference are:

  $trace_func->($where, $page)
 
where $where is a descriptive but curt string explaining where this page was
gotten and $page is a reference to the actual HTML. Clever Perl programmers
can use caller() (perldoc -f caller) to find out where in the code that
this page was accessed.

=cut

field trace_func => undef;

sub _traceme {
  my ($where,$page) = @_;

  my $t = $self->trace_func(); 
  return unless (defined($t) && ref($t) eq "CODE");
  $t->($where,$page);
}

=head2 get_page( $url, [ $regexp ] )

get_page returns a referece to a HTTP::Response object that contains
the web page specified by $url. If it can't get the page, returns undef and
sets $myspace->error.

Use this method if you need to get a page that's not available
via some other method. You could include the URL to a picture
page for example then search that page for friendIDs using
get_friends_on_page.

get_page will try up to 20 times until it gets the page, with a 2-second
delay between attempts. It checks for invalid HTTP response codes,
and known Myspace error pages. If called with the optional regexp,
it will consider the page an error unless the page content matches
the regexp. This is designed to get past network problems and such.



EXAMPLE

    The following displays the HTML source of MySpace.com's home
    page.
    my $res=get_page( "http://www.myspace.com/" );
    
    print $res->content;

=cut

sub get_page {

    my ( $url, $regexp, $follow ) = @_;

    # Reset error
    $self->error( 0 );

    ( $DEBUG ) && print "Getting URL: $url\n";

    # Try to get the page 20 times.
    my $attempt = 0; my $max_attempts = 20;
    my $res;
    my %headers = ();
    if ( $follow ) {
        %headers = ( 'Referer' => $self->{current_page}->request->uri )
    }

    do {
        # Try to get the page
#        unless ( $res = $self->_read_cache( $url ) )
                $res = $self->mech->get("$url", %headers);
#        }
        $attempt++;
        $self->_traceme("Attempt $attempt",$res);

    } until ( ( $self->_page_ok( $res, $regexp ) ) || ( $attempt >= $max_attempts ) );

    # We both set "current_page" and return the value.
#    $self->_cache_page( $url, $res ) unless $self->error;
    $self->{current_page} = $res;
    sleep ( int( rand( 5 ) ) + 6 ) if $self->human;
    if ( $self->error ) {
        return undef;
    } else {
        return ( $res );
    }

}

=head2 follow_to( $url, $regexp )

Exactly the same as get_page, but sets the Referer header
so it looks like you're clicking the link on the current
page instead of just GETting it directly.  Use this if
you're stepping through pages.

=cut

sub follow_to {

    my ( $url, $regexp ) = @_;

    $self->get_page( $url, $regexp, 1 );

}

=head2 follow_link

This is like a robust version of WWW::Mechanize's "follow_link"
method.  It calls "find_link" with your arguments (and as such takes
the same arguments.  It adds the "re" argument, which is passed to
get_page to verify we in fact got the page.  Returns an HTTP::Response
object if it succeeds, sets $self->error and returns undef if it fails.

	$self->_go_home;
	$self->follow_link( text_regex => qr/inbox/i, re => 'Mail Center' )
		or die $self->error;

There are a lot of options, so perldoc WWW::Mechanize and search for
$mech->find_link to see them all.

=cut

sub follow_link {

	my ( %options ) = @_;
	my $res;

	# Take out options that are just for us
	my $re = '';
	if ( $options{re} ) { $re = $options{re}; delete $options{re}; }

	# Find the link
	my $link = $self->mech->find_link( %options );

	# Follow it
	if ( $link ) {
		$res = $self->get_page( $link->url, $re, 1 );
		return $res;
	} else {
		$self->error('Link not found on page');
		return undef;
	}

}

=head2 _cache_page( $url, $res )

Stores $res in a cache.

=cut

sub _cache_page {

    my ( $url, $res ) = @_;

    $self->{page_cache}->{$url} = $res;
    
    $self->_clean_cache;

}

=head2 _read_cache( $url )

Check the cache for this page.

=cut

sub _read_cache {

    my ( $url ) = @_;
    
    if ( ( $self->{page_cache}->{$url} ) &&
         ( $self->{page_cache}->{$url}->is_fresh ) ) {
        return $self->{page_cache}->{$url};
    } else {
        return "";
    }

}

=head2 _clean_cache

Cleans any non-"fresh" page from the cache.

=cut

sub _clean_cache {

    foreach my $url ( keys( %{ $self->{'page_cache'} } ) ) {
        unless ( $url->is_fresh ) {
            delete $self->{'page_cache'}->{ $url };
        }
    }

}

#---------------------------------------------------------------------
# _page_ok( $response, $regexp )
# Takes a UserAgent response object and checks to see if the
# page was sucessfully retreived, and checks the content against
# known error messages (listed at the top of this file).
# If passed a regexp, it will return true ONLY if the page content
# matches the regexp (instead of checking the known errors).
# It will delay 2 seconds if it fails so you can retry immediately.
# Called by get_page and submit_form.
# Sets the internal error method to 0 if there's no error, or
# to a printable error message if there is an error.

sub _page_ok {
    my ( $res, $regexp ) = @_;

    # Reset error
    $self->error(0);

    # Check for errors
    my $page_ok = 1;
    my $page;

    # If we think we're logged in, check for the "You must be logged-in"
    # error page.
    if ( ( $self->logged_in ) && ( ! $self->_check_login( $res ) ) ) {
        $self->error( "Not logged in" );
        $page_ok=0;
    }

    # If the page load is "successful", check for other problems.
    elsif ( $res->is_success ) {

        # Page loaded, but make sure it isn't an error page.
        $page = $res->content; # Get the content
        $page =~ s/[ \t\n\r]+/ /go; # Strip whitespace
        
        # If they gave us a RE with which to verify the page, look for it.
        if ( $regexp ) {
            # Page must match the regexp
            unless ( $page =~ /$regexp/i ) {
                $page_ok = 0;
                $self->error("Page doesn't match verification pattern.");
#               warn "Page doesn't match verification pattern.\n";
            }
        
        # Otherwise, look for our known temporary errors.
        } else {
            foreach my $error_regexp ( @ERROR_REGEXPS ) {
                if ( $page =~ $error_regexp ) {
                    $page_ok = 0;
                    $self->error( "Got error page." );
#                   warn "Got error page.\n";
                    last;
                }
            }
        }

    } else {

        $self->error("Error getting page: \n" .
            "  " . $res->status_line);
        $page_ok = 0;

        warn "Error getting page: \n" .
            "  " . $res->status_line . "\n";

    }

    sleep 2 unless ( $page_ok );

    return $page_ok;

}

=head2 _check_login

Checks for "You must be logged in to do that".  If found, tries to log
in again and returns 0, otherwise returns 1.

=cut

sub _check_login {
    my ( $res ) = @_;

    # Check the current page by default
    unless ( $res ) { $res = $self->current_page }

    # Check for the "proper" error response, or just look for the
    # error message on the page.
    if ( ( $res->is_error == 403 ) || ( $res->content =~ $NOT_LOGGED_IN ) ) {
        if ( $res->is_error ) {
            warn "Error: " . $res->is_error . "\n"
        } else {
            warn "Got \"not logged in\" page\n";
        }
        # If we already logged in, try to log us back in.
        if ( $self->logged_in ) { $self->site_login }
        # Return 0 so they'll try again.
        return 0;
    } else {
        return 1;
    }

}

#---------------------------------------------------------------------
# submit_form( $url, $form_no, $button, $fields_ref, [ $regexp1 ],
#             [ $regexp2 ] )
# Fill in and submit a form on the specified web page.
# $url is the URL of the page OR a reference to a HTTP::Request object.
# $form_no is the number of the form (starting at 0). i.e. if there
# are 2 forms on the page and you want to submit to the 2nd one, set
# $form_no to "1").
# $button is the name of the button of the form to press.
# $fields_ref is a reference to a hash that contains field names
# and values you want to fill in on the form.
# submit_form returns 1 if it succeeded, 0 if it fails.

=head2 submit_form( $url, $form_no, $button, $fields_ref, [ $regexp1 ],
    [ $regexp2 ] )
    
This format is being deprecated.  Please use the format below if you
use this method (which you shouldn't need unless you're writing more
methods).  Be aware that I might make this method private at some point.
    
=head2 submit_form( $options_hashref )

 Valid options:
 $myspace->submit_form( {
    page => "http://some.url.org/formpage.html",
    follow => 1, # 0 or 1
    form_no => 1,
    form_name => "myform",  # Use this OR form_no OR form
    form => $form, # HTML::Form object with a ready-to-post form.
                   # (page, form_no, form_name, fields_ref and action will
                   # be ignored).
    button => "mybutton",
    no_click => 0,  # 0 or 1.
    fields_ref => { field => 'value', field2 => 'value' },
    re1 => 'something unique.?about this[ \t\n]+page',
    re2 => 'something unique about the submitted page',
    action => 'http://some.url.org/newpostpage.cgi', # Only needed in weird occasions
 } );

This powerful little method reads the web page specified by "page",
finds the form specified by "form_no" or "form_name", fills in the values
specified in "fields_ref", and clicks the button named "button".

You may or may not need this method - it's used internally by
any method that needs to fill in and post a form. I made it
public just in case you need to fill in and post a form that's not
handled by another method (in which case, see CONTRIBUTING below :).

"page" can either be a text string that is a URL or a reference to an
HTTP::Response object that contains the source of the page
that contains the form. If it is an empty string or not specified,
the current page ( $myspace->current_page ) is used.

"follow" indicates whether or not we're supposedly following a link
to the URL supplied in "page".  If "page" isn't a URL, "follow" is
ignored.  This causes "submit_form" to use the "follow_to" method
instead of "get_page" when getting the URL.  This makes it look like
we clicked a link to get to this page instead of just going straight
to it.

"form_no" is used to numerically identify the form on the page. It's a
simple counter starting from 0.  If there are 3 forms on the page and
you want to fill in and submit the second form, set "form_no => 1".
For the first form, use "form_no => 0".

"form_name" is used to indentify the form by name.  In actuality,
submit_form simply uses "form_name" to iterate through the forms
and sets "form_no" for you.

"form" can be used if you have a customized form you want to submit.
Pass an HTML::Form object and set "button", "no_click", and "re2"
as desired, and you can use submit_form's tenacious submission routine
with your own values.

"button" is the name of the button to submit. This will frequently
be "submit", but if they've named the button something clever like
"Submit22" (as MySpace did in their login form), then you may have to
use that.  If no button is specified (either by button => '' or by
not specifying button at all), the first button on the form
is clicked.

If "no_click" is set to 1, the form willl be submitted without
clicking any button.   This is used to simulate the JavaScript
form submits Myspace does on the browse pages.

"fields_ref" is a reference to a hash that contains field names
and values you want to fill in on the form.
For checkboxes with no "value" attribute, specify a value of "on"
to check it, "off" to uncheck it.

"re1" is an optional Regular Expression that will be used to make
sure the proper form page has been loaded. The page content will
be matched to the RE, and will be treated as an error page and retried
until it matches. See get_page for more info.

"re2" is an optional RE that will me used to make sure that the
post was successful. USE THIS CAREFULLY! If your RE breaks, you could
end up repeatedly posting a form. This is used by post_comemnts to make
sure that the Verify Comment page is actually shown.

"action" is the post action for the form, as in:

 <form action="http://www.mysite.com/process.cgi">

This is here because Myspace likes to do weird things like reset
form actions with Javascript then post them without clicking form buttons.

EXAMPLE

This is how post_comment actually posts the comment:

    # Submit the comment to $friend_id's page
    $self->submit_form( "${VIEW_COMMENT_FORM}${friend_id}", 1, "submit",
                        { 'f_comments' => "$message" }, '', 'f_comments'
                    );
    
    # Confirm it
    $self->submit_form( "", 1, "submit", {} );

=cut


sub submit_form {

    my ( $url, $form_no, $button, $fields_ref, $regexp1, $regexp2, $base_url ) = @_;

    # Initialize our variables
    my $mech = $self->mech; # For convenience
    my $res = "";
    my ( $field );
    my $options;
#   $base_url = $BASE_URL unless $base_url;
#   $form_no++; # For backwards compatibility.

    # Parse the options
    # Unless they passed a hashref of options, set using the
    # positional parameters.
    if ( ref $url eq "HASH" ) {
        $options = $url;
    } else {
        $options = { 'url' => $url,
            'form_no' => $form_no,
            'button' => $button,
            'fields_ref' => $fields_ref,
            're1' => $regexp1,
            're2' => $regexp2,
            'base' => $base_url,
            'page' => $url,
        };
    }

    # If they gave us a form, use it.  Otherwise, get it and fill it in.
    my $f = "";
    if ( $options->{'form'} ) {
        $f = $options->{'form'};
    } else {
        # Get the page
        if ( ref( $options->{'page'} ) eq "HTTP::Response" ) {
            # They gave us a page already
            $res = $options->{'page'};
        } elsif ( ! $options->{'page'} ) {
            $res = $self->current_page;
        } else {
            # Get the page
            ( $DEBUG ) && print "Getting $options->{page}\n";
            if ( $options->{'follow'} ) {
                $res = $self->follow_to( $options->{'page'}, $options->{'re1'} );
            } else {
                $res = $self->get_page( $options->{'page'}, $options->{'re1'} );
            }
            # If we couldn't get the page, return failure.
            return 0 if $self->error;
        }
    
        # Select the form they wanted, or return failure if we can't.
        my @forms = HTML::Form->parse( $res, $options->{'base'} );
        if ( $options->{'form_no'} ) {
            unless ( @forms > $options->{'form_no'} ) {
                $self->error( "Form " . $options->{form_no} . 
                              "not on page in submit_form!"
                            );
                return 0;
            }
        }
        if ( $options->{'form_name'} ) {
            $form_no = 0;
            foreach my $form ( @forms ) {
                if ( ( $form->attr( 'name' ) ) &&
                     ( $form->attr( 'name' ) eq $options->{'form_name'} )
                   ) {
                    $options->{'form_no'} = $form_no;
                    last;
                }
                $form_no++;
            }
            unless ( $options->{form_no} ) {
                $self->error( "Form " . $options->{form_name} .
                              "not on page in submit_form!"
                            );
                return 0;
            }
        }
    
        $f = $forms[ $options->{'form_no'} ];
    
        # Set the action if they gave us one
        if ( $options->{'action'} ) { $f->action( $options->{'action'} ) }
        
        # Fill in the fields
        ( $DEBUG ) && print "Filling in form number " .
                            $options->{'form_no'} . ".\n";
        ( $DEBUG ) && print $f->dump;
    
        # Loop through the fields in the form and set them.
        foreach my $field ( keys %{ $options->{'fields_ref'} } ) {
            # If the field "exists" on the form, just fill it in,
            # otherwise, add it as a hidden field.
            if ( $f->find_input( $field ) ) {
                if ( $f->find_input( $field )->readonly ) {
                    $f->find_input( $field )->readonly(0)
                }
                $f->param( $field, $options->{'fields_ref'}->{ $field } );
            } else {
                $f = $self->_add_to_form(
                        $f, $field, $options->{'fields_ref'}->{ $field }
                    );
            }
        }
    }

    if ( $options->{'die'} ) { print $f->dump; die }

    # Submit the form.  Try up to $max_attempts times.
    my $attempt = 0; my $max_attempts = 5;
    my $trying_again = 0;

    # Make our request based on our options
    my $request = undef;
    if ( $options->{'button'} ) {
        $request = $f->click( $options->{'button'} );
    } elsif ( $options->{'no_click'} ) {
        # We use make_request because Myspace likes submitting forms
        # that have buttons by using Javascript. make_request submits
        # the form without clicking anything, whereas "click" clicks
        # the first button, which can break things.
        $request =  $f->make_request;
    } else {
        # Just click the first button
        $request = $f->click;
    }
    $request->header( 'Referer' => $self->current_page->request->uri );

    do
    {
        # If we're trying again, mention it.
        warn $self->error . "\n" if $trying_again;

        eval {
            $res = $self->mech->request( $request );
        };

        # If it died (it will if there's no button), just return failure.
        if ( $@ ) {
            $self->error( $@ );
            return 0;
        }

        $attempt++;
        $trying_again = 1;
	$self->_traceme("Submit form attempt $attempt",$res);
    } until ( ( $self->_page_ok( $res, $options->{'re2'} ) ) ||
              ( $attempt >= $max_attempts )
            );

    # Return the result
    $self->{current_page} = $res;
    return ( ! $self->error );

}

=head2 _add_to_form

Internal method to add a hidden field to a form. HTML::Form thinks we
don't want to change hidden fields, and if a hidden field has no value,
it won't even create an input object for it.  If that's way over your
head don't worry, it just means we're fixing things with this method,
and submit_form will call this method for you if you pass it a field that
doesn't show up on the form.

Returns a form object that is the old form with the new field in it.

 # Add field $fieldname to form $form (a HTML::Form object) and
 # set it's value to $value.
 $self->_add_to_form( $form, $fieldname, $value )

=cut

sub _add_to_form {

    my ( $f, $field, $value ) = @_;

    $f->push_input( 'hidden', { name => $field, value => $value } );
    
    return $f;
}

#---------------------------------------------------------------------
# get_friends_on_page( $page );
# This routine takes the SOURCE CODE of the page and returns
# a list of friendIDs for which there are profile links on the page.
# Notes:
# - Our friend ID will be one of those returned, so we check for it.
# - We use the hash method because there are multiple links for each user
#   (hence duplicate friendIDs will be returned). (One link for the name,
#   one for their image). This is pretty safe against changes to the page.
# - We filter out 6221, Tom's ID...

=head2 get_friends_on_page( $friends_page );

This routine takes the SOURCE CODE of an HTML page and returns
a list of friendIDs for which there are profile
links on the page. This routine is used internally by "get_friends"
to scan each of the user's "View my friends" pages.

Notes:
 - It does not return our friendID.
 - friendIDs are filtered so they are unique (i.e. no duplicates).
 - We filter out 6221, Tom's ID.

EXAMPLE:

List the friendIDs mentioned on Tom's profile:
    
    use WWW::Myspace;
    my $myspace = new WWW::Myspace;

    $res = $myspace->get_profile( 6221 );
    
    @friends = $myspace->get_friends_on_page( $res->content );
    print "These people have left comments or have links on Tom's page:\n";
    foreach $id ( @friends ) {
        print "$id\n";
    }

=cut

sub get_friends_on_page {

    my ( $page ) = @_;

    # Default to current page
    unless ( $page ) { $page = $self->current_page->content }

    my %friend_ids = ();
    my $line;
    my @lines = split( "\n", $page );
    $self->{_high_friend_id} = 0;
    $self->{_low_friend_id} = 0;
    foreach $line ( @lines ) {
        if ( $line =~ /${FRIEND_REGEXP}([0-9]+)/ ) {
            unless ( ( ( $self->logged_in ) &&
                       ( "$1" == $self->my_friend_id )
                     ) ||
                     ( "$1" == 6221 )
                   ) {
                $friend_ids{"$1"}++;
                
                # The following are used to construct the URL
                # when crawling the user's "view all my friends" pages.
                # Set high friendID on this page
                if ( $self->{_high_friend_id} < $1 ) {
                    $self->{_high_friend_id} = $1;
                }
                # Set low friendID on this page
                if ( ( $self->{_low_friend_id} == 0 ) ||
                     ( $1 < $self->{_low_friend_id} ) ) {
                    $self->{_low_friend_id} = $1;
                }
            }
        }
    }
    
    if ( $DEBUG ) {
        my @friends = keys( %friend_ids );
        print "  Got " . @friends . " friends on page\n";
    }

    return ( keys( %friend_ids ) );
}

=head2 remove_cache

Remove the login cache file. Call this after creating the object if
you don't want the login data stored:

 my $myspace = new WWW::Myspace( qw( myaccount, mypassword ) );
 $myspace->remove_cache;

=cut

sub remove_cache {

    my $cache_file_path = catfile( $self->cache_dir, $self->cache_file );
    unlink $cache_file_path;

}

#---------------------------------------------------------------------
# make_cache_dir

=head2 make_cache_dir

Creates the cache directory in cache_dir. Only creates the
top-level directory, croaks if it can't create it.

    $myspace->cache_dir("/path/to/dir");
    $myspace->make_cache_dir;

This function mainly exists for the internal login method to use,
and for related sub-modules that store their cache files by
default in WWW:Myspace's cache directory.

=cut

sub make_cache_dir {

    # Make the cache directory if it doesn't exist.
    unless ( -d $self->cache_dir ) {
        mkdir $self->cache_dir or croak "Can't create cache directory ".
            $self->cache_dir;
    }

}

#---------------------------------------------------------------------
# _die_unless_logged_in

sub _die_unless_logged_in {

    my ( $method ) = @_;
    
    unless ( $self->logged_in ) {
        croak "$method called when not logged in\n";
    }

}

#---------------------------------------------------------------------
# _fix_textareas( $tree )
# Takes an HTML::Element node and traverses it, fixing any
# textarea elements so they have a content element.
# Bug workaround - HTTP::Request::Form will die if a textarea
# field has no content (because the parser doesn't add a
# "_content" element). So, we add one.

sub _fix_textareas() {

    my $x = $_[0];
    # If this is a textarea, push an empty string as the
    # content if it doesn't have any.
    if ( $x->tag eq "textarea" ) {
        $x->{_content} = [] unless defined $x->content;
    }

    # Recursively traverse the tree on our search.
    foreach my $c ($x->content_list) {
        _fix_textareas($c) if ref $c; # ignore text nodes
    }
}

#---------------------------------------------------------------------
# _get_acct()
# Get and store the login and password. We check the user's preference
# file for defaults, then prompt them.

sub _get_acct {

    # Initialize
    my %prefs = ();
    my $ref = "";
    my ( $pref, $value, $res );
    my $cache_filepath = catfile( $self->cache_dir, $self->cache_file);

    # Read what we got last time.   
    if ( open ( PREFS, "< ", $cache_filepath ) ) {
        while (<PREFS>) {
            chomp;
            ( $pref, $value ) = split( ":" );
            $prefs{"$pref"} = $value;
        }
        
        close PREFS;
    }

    # Prompt them for current values
    unless ( defined $prefs{"email"} ) { $prefs{"email"} = "" }
    print "Email [" . $prefs{"email"} . "]: ";
    $res = <STDIN>; chomp $res;
    if ( $res ) {
        $prefs{"email"} = $res;
    }

    unless ( defined $prefs{"password"} ) { $prefs{"password"} = "" }
    print "Password [". $prefs{"password"} . "]: ";
    $res = <STDIN>; chomp $res;
    if ( $res ) {
        $prefs{"password"} = $res;
    }

    # Make the cache directory if it doesn't exist.
    $self->make_cache_dir;

    # Store the new values.
    open ( PREFS, ">", $cache_filepath ) or croak $!;
    print PREFS "email:" . $prefs{"email"} . "\n" .
        "password:" . $prefs{"password"} . "\n";
    close PREFS;
    
    # Store the account info.
    $self->{account_name}=$prefs{"email"};
    $self->{password}=$prefs{"password"};
}

#---------------------------------------------------------------------
# _get_friend_id( $homepage )
# This internal method stores our friend ID. We get this from the
# "View All of My Friends" link on the bottom of our profile page (the one
# we see when we first log in)

sub _get_friend_id {

    my ( $homepage ) = @_;
    
    # Search the code for the link. This is why we like Perl. :)
    my $page_source = $homepage->content;
    $page_source =~ /index\.cfm\?fuseaction=user\.viewprofile\&(amp;)friendid=([0-9]+)/io;
    my $friend_id=$2;
    ( $DEBUG ) && print "Got friend ID: $friend_id\n";

    # Store it
    $self->{my_friend_id} = $friend_id;
    
    if ( $friend_id ) {
        $self->error(0)
    } else {
        $self->error("Couldn't get friendID from home page")
    }

}

#---------------------------------------------------------------------
# _get_friend_page( $page, %attr_ref )
# Examples:
# $self->_get_friend_page( 1, 'group', 100011592 );
# Gets the friends from page 1 (the second page) of the myspace
# group with ID 100011592.
#
# $self->_get_friend_page( 1 )
# Get the the friends from page 1 of the logged in user's friend pages.
#
# $self->_get_friend_page( 1, 'inbox' );
# Gets the friends from page 1 of the logged in user's mail inbox.
#
# Return the content of the friend page. $page is the page number.
# $id 

sub _get_friend_page {

    my ( $page, $source, $id ) = @_;
    
    my ( $url, $res, $success );
    my $verify_re = '';
    $source = '' unless defined $source;
    my $follow = 1; # Add referer header unless first page

    # Set the URL string for the right set of pages
    if ( $source eq "group" ) { 
        $url = "http://groups.myspace.com/index.cfm?fuseaction=".
            "groups.viewMembers&groupID=${id}&page=${page}";
        $follow = 0 if ( $page == 0 );
    } else {
        # Make sure we got the friend page, and that we got the whole page.
        $verify_re = "View All Friends.*(Previous|Next).*<\/html>";
        ( $DEBUG ) && print "Loading friend page $page\n";
        # Unless they specified a profile to get friends from,
        # use our own.
        unless ( $source eq 'profile' ) {
            $id = $self->my_friend_id;
        }

        if ( $page == 1 ) {
            # First page
            $url = "http://home.myspace.com/index.cfm?".
                "fuseaction=user.viewfriends&".
                "friendID=" . $id;
            $follow = 0;
        } else {
            # Subsequent pages
#            $url = "http://home.myspace.com/index.cfm?".
#                "fuseaction=user.viewfriends&".
#                "friendID=" . $id . "&" .
#                "friendCount=" . $self->{_friend_count} . "&" .
#                "userName=" . $self->{_user_name} . "&" .
#                "page=" . $page . "&" .
#                "prevPage=" . $self->{_last_friend_page} . "&" .
#                "PREVPageFirstONERETURENED=" . $self->{_low_friend_id}."&".
#                "PREVPageLASTONERETURENED=" . $self->{_high_friend_id};
            $url = "http://myspace.com/Modules/ViewFriends/FriendsView.aspx?%3ffuseaction=user.viewfriends&" . 
               "friendID=" . $id . "&" .
               "__VIEWSTATE=" .$self->{_viewstate}. "&" . 
               "__EVENTTARGET=ctl00\$cpMain\$pagerTop&" . 
               "__EVENTARGUMENT=" . $page;
        }
    }

    # Get the page
    ( $DEBUG ) && print "  Getting URL: $url\n";
    $res = $self->get_page( $url, $verify_re, $follow );
    if ( $res->content =~ /This\s+profile\s+is\s+set\s+to\s+private.\s+This\s+user\s+must\s+add\s+<br\/>\s*you\s+as\s+a\s+friend\s+to\s+see\s+his\/her\s+profile./o ) { # good lord
        $self->error("User profile is set to private.");
    }

    # Save info if we need to
    unless ( $self->error ) {
        $self->$save_friend_info if  (
            ( ( $source eq '' ) || ( $source eq 'profile' ) ) &&
            ( $page == 1 ) );
    }

    return $res;
}

#---------------------------------------------------------------------
# save_friend_info
# We need to grab some info off the View Friends page to feed back
# to subsequent pages.

my sub save_friend_info {

    # Get and store the friend count and user name
    # Friend count

    #$self->current_page->content =~ /name="friendCount"\s+value="([0-9]+)"/io;
    # JL20061227: Changed this regex to get friendCount
    my ($fcount) = $self->current_page->content =~ /Listing \d+-\d+\s+of\s+(\d+)/io;
    $self->{_friend_count} = $fcount;
    #print "We got a total of $fcount friends\n";
    warn "Didn't get friend count" unless ( $self->{_friend_count} );
    
    # __VIEWSTATE
    my ($viewstate) = $self->current_page->content =~ m#name="__VIEWSTATE".+value="([^"]+)"#io;
    $self->{_viewstate} = $viewstate;
    print STDERR "viewstate: '$viewstate'\n";
    warn "Didn't get viewstate" unless ( $self->{_viewstate} );

    # User name
    # If you can't find username it would be set to $1 from the above regex. 
    # i consider this a bug, dont be lazy
    my ($username) = $self->current_page->content =~ /Back\s+to\s+(.+)'s\s+Profile/io;
    $self->{_user_name} = $username;
    print STDERR "USERNAME: '$username'\n";
    warn "Didn't get user_name" unless ( $self->{_user_name} );
    
    # Number of pages
#    $self->current_page->content =~
#            /of(&nbsp;|\s)+<a href="javascript:NextPage\('|([0-9]+)'\)/io;
    my ($total_pages) = $self->current_page->content =~
            m#of </div><a class="pagingLink" href="javascript:__doPostBack\('ctl00\$cpMain\$pagerTop','(\d+)'#io;
    $self->{_friend_pages} = $total_pages;
    print "$username has $total_pages pages\n";
    # If there's only 1 page the RE will break, and testing for the alternate
    # is dangerous, so if there are less than 40 friends, just set it to
    # 1 page.
    if ( ( $self->{_friend_count} && ( $self->{_friend_count} < 40 ) ) &&
         ( ! $self->{_friend_pages} ) ) {
        $self->{_friend_pages} = 1;
    }
    warn "Didn't get friend_pages" unless ( $self->{_friend_pages} );
#    warn "friend_pages: " . $self->{_friend_pages};
    
    
#   warn "Stored friend count " . $self->{_friend_count} . ", ".
#       "user name " . $self->{_user_name} . ".\n";
    
}

=head2 _next_button

Takes the source code of a page, or nothing.  If nothing is passed,
uses $self->current_page->content.

Returns true if there is a next button on the page.  This is
so we can say:

 last unless ( $self->_next_button( $page_source ) );
 
 or:
 
 while ( $self->_next_button ) { do stuff }
 or
 while ( $self->_next_button ) { do stuff and click next }

One of these days I'm going write a "stuff" subroutine so I can actually type
that.

EXAMPLES


=cut

sub _next_button {

    my ( $content ) = @_;
    
    unless ( $content ) {
        $content = $self->current_page->content;
    }

    $content =~ /">\s*Next\s*(<\/a>)?(\s|&nbsp;)+\&gt;/io;

}

=head2 _previous_button

As you might guess, returns true if there's a "Previous" link on the
page. This is used to sanity-check functions like get_friends.  If there
isn't a "Next" button, this method can be used to make sure there is a
"Previous" button.

 # Exit the loop if we're on the last page
 last unless (
   $self->_next_button( $page_source ) &&
   $self->_previous_button( $page_source )
 );

=cut

sub _previous_button {

    my ( $content ) = @_;
    
    unless ( $content ) {
        $content = $self->current_page->content;
    }

    $content =~ /&lt;\s*<a [^>]+>\s*Previous\s*<\/a>/io;

}

# Simple method to count the keys in a hash

my sub count_keys {

    my ( $hashref ) = @_;
    
    return keys( %{$hashref} );

}

#---------------------------------------------------------------------
# _format_html( $text )
# Simple translator from text to HTML - changes newlines
# to "<br>\n".

sub _format_html {

	my ( $text ) = @_;
	
	$text =~ s/\n/<br>\n/gs;
	
	return $text;

}

=head2 _go_home

Internal method to go to the home page.  Checks to see if we're already
there.  If not, tries to click the Home button on the page.  If there
isn't one, loads the page explicitly.

=cut

sub _go_home {

	# If we're not logged in, go to the home page
	unless ( $self->logged_in ) {
		$self->get_page( $BASE_URL ) or return undef;
		return 1;
	}

    # Are we there?
    if ( $self->mech->uri =~ /[\?&;]fuseaction=user([&;]|$)/io ) {
#        warn "I think I'm on the homepage\n";
#        warn $self->mech->uri . "\n";
        return 1;
    }
    
    # No, try to click home
    my $home_link = "";
    if ( $home_link = $self->mech->find_link(
                        url_regex => qr/fuseaction=user/io
                      )
       ) {
#        warn "_go_home going to " . $home_link->url . "\n";
        $self->follow_to( $home_link->url ) or return undef;
        return 1;
    }
    
    # Still here?  Load the page explicitly
    $self->get_page( $HOME_PAGE ) or return undef;
#    warn "I think I loaded $HOME_PAGE\n";
    
    return 1;

}

sub ____IN_PROGRESS____ {}

=head1 IN PROGRESS

Methods that aren't quite working yet.

=cut

1;

__END__



=head1 AUTHOR

Grant Grueninger, C<< <grantg at cpan.org> >>

Thanks to:

Tom Kerswill (http://tomkerswill.co.uk) for the friend_url method, which
also inspired the friend_user_name method.

Olaf Alders (http://www.wundersolutions.com) for the human-readable status
codes in send_friend request, for the excellent sample code which provides
a workaround for CAPTCHA responses, and for the friends_from_profile
idea.

=head1 KNOWN ISSUES

=over 4

=item -

One of the modules upon which WWW::Myspace depends generates the following
warnings when logging in:

    Day too big - 2932896 > 24855
    Sec too big - 2932896 > 11647
    Day too big - 2932896 > 24855
    Sec too big - 2932896 > 11647

These are harmless but annoying.  See the "date.patch" file included at the
root level of the distribution if you want to fix them.

=item -

Some myspace error pages are not accounted for, such as their new
Server Application error page.  If you know enough about web development
to identify an error page that would return a successful HTTP
response code (i.e. returns 200 OK), but then displays an error message,
please keep an eye out for such pages.
If you get such an error message page, PLEASE EMAIL ME (see BUGS below)
the page content so I can account for it.

=item -

If the text used to verify that the profile page has been loaded
changes in the future, get_profile and post_comments will report
that the page hasn't been loaded when in fact it has.

=item -

site_login will give up after the first try when initialy logging in if
it encounters the "You must be logged-in" page.  This is a "feature"
used to check for invalid username/password, but should probably
check a couple times to make sure it isn't a Myspace problem.

=item -

send_message returns only status codes in many circumstances regardless
of calling context.

=item -

post_comment returns only status codes for "FN", "FL", and "FC" errors
regardless of calling context.

=back

=head1 TODO

Have 'approve_friends' method check GUIDS after first submit to make
sure the current page of GUIDS doesn't contain any duplicates. This
is to prevent a possible infinite loop that could occur if the
submission of the friend requests fails, and also to signal a warning
if myspace changes in a way that breaks the method.

Add checks to all methods to self-diagnose to detect changes in myspace
site that break this module.

get_friends needs to throw an error, or at least set error, if it can't
return the full list of friends (i.e. if either of the "warn" statements
are triggered)

Add tests for get_comments.

Fix post_comment. Returns "FN" when it should return "FF".

=head1 CONTRIBUTING

If you would like to contribute to this module, you can email me
and/or post patches at the RT bug links below. There are many methods that
could be added to this module (profile editing, for example). If you
find yourself using the "submit_form" method, it probably means you
should write whatever you're editing into a method and post it on RT.

See the TODO section above for starters.

=head1 BUGS

Please report any bugs or feature requests, or send any patches, to
C<bug-www-myspace at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Myspace>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

IF YOU USE A MAIL SERVICE (or program) WITH JUNK MAIL FILTERING, especially
HOTMAIL or YAHOO, add the bug reporting email address above to your address
book so that you can receive status updates.

Bug reports are nice, patches are nicer.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Myspace

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Myspace>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Myspace>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Myspace>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Myspace>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2005-2006 Grant Grueninger, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

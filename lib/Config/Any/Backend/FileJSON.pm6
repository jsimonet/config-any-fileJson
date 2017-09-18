use v6.c;

# use JSON::Fast;
use JSON::Fast;
use JSON::Path;

use Config::Any::Backend;

class Config::Any::Backend::FileJSON is Config::Any::Backend
	does Config::Any::Backend::Reader {
	# does Config::Any::Backend::Writer {

	has $.filePath;
	has $!data;
	has Bool $.cache = False;

	sub get( $data, Str:D $key ) {
		# $!data = from-json($!filePath.IO.slurp);
	}

	# Key has to be a string of the form "abc", "abc.def"
	method get( Str:D $key ) {
		unless $key ~~ /^ [\w+][\.\w+]* $/ {
			die "Malformed key \"$key\"";
		}

		unless $!cache { $!data = from-json( $!filePath.IO.slurp ) };

		my Str $rootKey = '$.' ~ $key;

		return JSON::Path.new( $rootKey ).value( $!data );
	}

	method set( Str:D $key, $value ) {
		...
	}
}

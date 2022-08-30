unit class Pod::Usage;

my sub load(Str $classname) {
    my $loaded = try ::($classname);
    return $loaded if $loaded !eqv Any;
    require ::($classname);
    return ::($classname);
}

sub filter-usage(@pod-elements) is export(:filter) {
	my @contents = flat @pod-elements.map: { .contents.grep: { $_ ~~ Pod::Heading && .contents[0].contents.uc eq 'USAGE' ^fff^ $_ ~~ Pod::Heading } };
	Pod::Block::Named.new(:name<para>, :@contents);
}

proto render-usage(|)  is export(:DEFAULT, :render) { * }
multi render-usage(@pod-elements, Str:D :$renderer = %*ENV<POD_RENDERER> // 'Pod::To::Text') {
	render-usage(@pod-elements, :renderer(load($renderer)));
}
multi render-usage(@pod-elements, Any:U :$renderer!) {
	my $payload = filter-usage(@pod-elements);
	$renderer.render($payload);
}

=begin pod

=head1 NAME

Pod::Usage - extracts POD documentation to show usage information

=head1 SYNOPSIS

=begin code :lang<raku>

use Pod::Usage;

multi MAIN(Bool :$help!) {
	render-usage($=pod);
}

sub GENERATE-USAGE(Routine $main, |capture) {
	render-usage($=pod);
}

=end code

=head1 DESCRIPTION

Pod::Usage is a helper module for generating a usage message that isn't generated from C<sub MAIN>, but instead taken from the USAGE section of your documentation.

=head2 filter-usage(@pod-elements)

This filters out the text under the C<USAGE> and manipulates it to a renderable POD sniplet.

=head2 render-usage(@pod-elements, :$renderer = Pod::To::Text)

This takes the pod sniplet as extracted by C<filter-usage> and renders it using the given renderer.

=head1 SEE ALSO

=item1 as-cli-arguments

=head1 AUTHOR

Leon Timmermans <fawaka@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Leon Timmermans

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

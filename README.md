[![Actions Status](https://github.com/Leont/pod-usage/workflows/test/badge.svg)](https://github.com/Leont/pod-usage/actions)

NAME
====

Pod::Usage - extracts POD documentation to show usage information

SYNOPSIS
========

```raku
use Pod::Usage;

multi MAIN(Bool :$help!) {
	render-usage($=pod);
}

sub GENERATE-USAGE(Routine $main, |capture) {
	render-usage($=pod);
}
```

DESCRIPTION
===========

Pod::Usage is a helper module for generating a usage message that isn't generated from `sub MAIN`, but instead taken from the USAGE section of your documentation.

filter-usage(@pod-elements)
---------------------------

This filters out the text under the `USAGE` and manipulates it to a renderable POD sniplet.

render-usage(@pod-elements, :$renderer = Pod::To::Text)
-------------------------------------------------------

This takes the pod sniplet as extracted by `filter-usage` and renders it using the given renderer.

SEE ALSO
========

  * as-cli-arguments

AUTHOR
======

Leon Timmermans <fawaka@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Leon Timmermans

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


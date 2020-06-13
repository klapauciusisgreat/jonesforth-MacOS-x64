# Port of JonesForth to MacOS Catalina

This is a fairly simple port but had to deal with a number of
idiosyncrasies of Catalina and x64 programming.

This is also not an elegant port. For instance, sbrk is not implemented and
to get the assembler going, I just mmapped a large enough segment as rwx 
(to allow self modifying code) via the mmap syscall.  The x64 specific
code is also probably inefficient. However, this version passes all
the tests and can serve as a basis for further improvements.

Thanks to 

       * Richard W.M. Jones <rich@annexia.org> for the original code

       * John Leuner <jewel@subvert-the-dominant-paradigm.net> for the
         x64 linux port

       * Ruda Moura (https://github.com/ruda/jonesforth-macintel) for
         the 32-bit Mac port

May the forth be with you!


# Copyright and License

As the original JonesForth, this port is PUBLIC DOMAIN. See the release statement in jonesforth.S.

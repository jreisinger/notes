---
title: "Perl to Python"
date: 2016-01-11
draft: false
categories: [prog]
tags: [perl,pytho]
---

Going from Perl to Python ...

Data structures
---------------

Both languages are dynamic so you can mix types in data structures (data
containers).

    Perl   Python       Example              Note
    ----   ------       -------              -----
    array  list         [ 1, 3.4, 'hello' ]  you can mix types
    list   tuple        ( 10, 20, 30 )       immutable, parens are optional
    hash   dictionary   { 'a': 3, 'b': 42 }  have to quote strings in Python
    n/a    set          set( [1, 2, 3] )     can be faked with hash in Perl

In lists/tuples the comma is the operator. So a one element tuple is `( 10, )`.

File I/O
--------

Process every line in a file:

    for line in file('filename.txt'):  # or open("filename.txt")
        print line

    # the with keyword closes the file automatically (even when the prog crashes)
    with open("/etc/passwd") as file_object:
        for line in file_object:
            # print statement adds a newline so we remove it with rstrip()
            print line.rstrip()

Process every line in a file on command line or stdin if no file:

    # Perl
    while (<>) { print }

    # Python
    import fileinput
    for line in fileinput.input():
        print line

Access stdin directly:

    import sys
    for line in sys.stdin:
        print line

Slurp the whole file/stdin:

    # into a string
    contents = file('filename.txt').read()
    all_input = sys.stdin.read()

    # one string per line
    list_of_strings = file('filename.txt').readlines()
    all_input_as_list = sys.stdin.readlines()

    with open('/etc/passwd') as file_object:
        # read() returns an empty string when it reaches the end of a file
        contents = file_object.read()
        # rstrip() removes the extra blank line added by read()
        print contents.rstrip()

Write to a file:

    f = open("out", "w")
    while year <= numyears:
        principal = principal * (1 + rate)
        f.write("%3d %0.2f" % (year, principal))
        #print >>f, "%3d %0.2f" % (year, principal)
        year += 1
    f.close()

Error handling
--------------

Errors:

```
# Perl...

# Convert string to int, return undef on error
sub convert_number { int $_[0] }
print convert_number $ARGV[0];
```

```
# Python...

# Emulate Perl's behavior above
import sys

def convert_number(s):
    try:
        return int(s)
    except ValueError:
        return None

print( convert_number(sys.argv[1]) )
```

Warnings

    # Perl...
    
    my @filenames = qw(README.md y empty);

    for my $file (@filenames) {
        my $fh;
        # C library/sys calls return undef on error and set $!
        unless ( open $fh, $file ) {
            warn "$file: could not be opened: $!\n";
            next;
        }
        warn "$file: is empty\n" unless readline $fh;
    }

    # Python...
    
    class EmptyFileError(Exception):
        pass

    filenames = [ "README.md", "y", "empty" ]

    for file in filenames:
        try:
            f = open(file, "r")
            line = f.readline()
            if line == "":
                f.close()
                raise EmptyFileError("%s: is empty" % file)
        except IOError as error:
            print("%s: could not be opened: %s" % (file, error.strerror))
        except EmptyFileError as error:
            print(error)

Comprehesions and generators
----------------------------

Mapping

    # map()
    $ perl -le 'print join ", ", map ucfirst, @ARGV' jane john jack
    Jane, John, Jack

    # list comprehension
    >>> names = ['jane', 'john', 'jack']
    >>> [ s.capitalize() for s in names ]
    ['Jane', 'John', 'Jack']

Filtering

    # grep()
    $ perl -le 'print join ", ", grep $_ eq uc $_, @ARGV' a BC Cd d EF
    BC, EF

    # list comprehension
    >>> strings = ['a', 'BC', 'Cd', 'd', 'EF']
    >>> [ s for s in strings if s.isupper() ]
    ['BC', 'EF']

Generator expression (this time we go from Python to Perl...)

    >>> g = ( n ** 2 for n in range(5) )
    >>> next(g)
    0
    >>> g.next()
    1
    $ perl -le 'print join ", ", map $_ ** 2, 0 .. 4'
    0, 1, 4, 9, 16

    >>> sum( n ** 2 for n in range(5) )
    30
    $ perl -le '$sum += $_ for map $_ ** 2, 0 .. 4; print $sum'
    30

More:

* [Andrew Grangaard - A perler's Python Primer](https://youtu.be/-tdI9RYjZNE)
* http://everythingsysadmin.com/perl2python.html

package Local::Display;
use Text::Autoformat;
use File::Basename;

use Exporter qw(import);
our @EXPORT = qw(
  make_readme_line
  count_lines
  line_count_changed
);

=head1 NAME

Local::Display - functions used for generating output to be displayed

=head1 FUNCTION/METHODS

=head2 count_lines

Count number of lines in a blog post.

=cut

sub count_lines {
    my $post_file = shift;

    open my $fh, "$post_file" or die "Can't open $post_file: $!";
    my $count = 0;
    while (<$fh>) {
        $count++;
    }
    close $fh;

    return $count;
}

=head2 line_count_changed

Did I add/remove lines in a post?

=cut

sub line_count_changed {
    my $post = shift;

    my $lines = count_lines($post);

    my $lines_in_readme;
    open my $fh, "<", "README.md" or die "Can't open README.md: $!";
    while (<$fh>) {
        if ( /\($post\)\s*\((\d+)/ ) {
            $lines_in_readme = $1
        }
    }

    return $lines != $lines_in_readme ? 1 : 0;
}

=head2 make_readme_line

Create line that can be pasted into README.md under a category.

=cut

sub make_readme_line {
    my $post = shift;    # ex. "posts/zfs.md"

    chomp $post;
    #my $title = $1 if $post =~ /\/([^\)\\]+)$/;
    my $title = basename $post;
    return unless defined $title;
    $title =~ s/\.md//;
    $title = autoformat( $title, { case => 'highlight' } );
    chomp $title;
    chomp $title;
    $title =~ s/[-_]/ /g;

    $link = "[$title]($post)";
    $link =~ s/^/* /;

    #my $count = count_lines($post);

    #return "$link ($count lines)";
    return "$link";
}

1;

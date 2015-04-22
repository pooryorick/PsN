package so::soblock::rawresults::datafile;

use strict;
use warnings;
use Moose;
use MooseX::Params::Validate;
use include_modules;
use XML::LibXML;

has 'oid' => ( is => 'rw', isa => 'Str' );
has 'Description' => ( is => 'rw', isa => 'Str' );
has 'path' => ( is => 'rw', isa => 'Str' );

sub parse
{
    my $self = shift;
    my $node = shift;

    my $oid = $node->getAttribute('oid');
    $self->oid($oid);

    my $xpc = so::xml::get_xpc();

    (my $desc) = $xpc->findnodes('ct:Description', $node);
    $self->Description($desc);

    (my $path) = $xpc->findnodes('ds:path', $node);
    $self->path($path);
}

sub xml
{
    my $self = shift;

    my $datafile = XML::LibXML::Element->new("DataFile");
    $datafile->setAttribute('oid', $self->oid);
    my $description = XML::LibXML::Element->new("ct:Description");
    $description->appendTextNode($self->Description);
    my $path = XML::LibXML::Element->new("ds:path");
    $path->appendTextNode($self->path);
    $datafile->appendChild($description);
    $datafile->appendChild($path);

    return $datafile;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
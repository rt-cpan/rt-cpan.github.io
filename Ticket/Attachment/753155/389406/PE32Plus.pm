package Win32::Exe::PE::Header::PE32Plus;

use strict;
use base 'Win32::Exe::PE::Header';
use constant SUBFORMAT => (
    ImageBase		=> 'a8',
    SectionAlign	=> 'V',
    FileAlign		=> 'V',
    OSMajor		=> 'v',
    OSMinor		=> 'v',
    UserMajor		=> 'v',
    UserMinor		=> 'v',
    SubsysMajor		=> 'v',
    SubsysMinor		=> 'v',
    _			=> 'a4',
    ImageSize		=> 'V',
    HeaderSize		=> 'V',
    FileChecksum	=> 'V',
    SubsystemTypeId	=> 'v',
    DLLFlags		=> 'v',
    StackReserve	=> 'a8',
    StackCommit		=> 'a8',
    HeapReserve		=> 'a8',
    HeapCommit		=> 'a8',
    LoaderFlags		=> 'V',
    NumDataDirs		=> 'V',
    'DataDirectory'	=> [
	'a8', '{$NumDataDirs}', 1
    ],
    'Section'		=> [
	'a40', '{$NumSections}', 1
    ],
    Data		=> 'a*',
);

#######
#Constant					Value	Description
#IMAGE_SUBSYSTEM_UNKNOWN			0	An unknown subsystem
#IMAGE_SUBSYSTEM_NATIVE	  			1	Device drivers and native Windows processes
#IMAGE_SUBSYSTEM_WINDOWS_GUI			2	The Windows graphical user interface (GUI) subsystem
#IMAGE_SUBSYSTEM_WINDOWS_CUI			3	The Windows character subsystem
#IMAGE_SUBSYSTEM_POSIX_CUI			7	The Posix character subsystem
#IMAGE_SUBSYSTEM_WINDOWS_CE_GUI	  		9	Windows CE
#IMAGE_SUBSYSTEM_EFI_APPLICATION		10	An Extensible Firmware Interface (EFI) application
#IMAGE_SUBSYSTEM_EFI_BOOT_ SERVICE_DRIVER	11	An EFI driver with boot services
#IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER		12	An EFI driver with run-time services
#IMAGE_SUBSYSTEM_EFI_ROM			13	An EFI ROM image
#IMAGE_SUBSYSTEM_XBOX				14	XBOX
use constant SUBSYSTEM_TYPES => [qw(
    _	    native	windows	    console	_
    _	    _		posix	    _		windowsce
)];

use constant ST_TO_ID => {
    map { (SUBSYSTEM_TYPES->[$_] => $_) } (0 .. $#{+SUBSYSTEM_TYPES})
};
use constant ID_TO_ST => { reverse %{+ST_TO_ID} };

sub st_to_id {
    my ($self, $name) = @_;
    return $name unless $name =~ /\D/;
    return(+ST_TO_ID->{lc($name)} || die "No such type: $name");
}

sub id_to_st {
    my ($self, $id) = @_;
    return(+ID_TO_ST->{$id} || $id);
}

sub Subsystem {
    my ($self) = @_;
    return $self->id_to_st($self->SubsystemTypeId);
}

sub SetSubsystem {
    my ($self, $type) = @_;
    $self->SetSubsystemTypeId($self->st_to_id($type));
}

1;

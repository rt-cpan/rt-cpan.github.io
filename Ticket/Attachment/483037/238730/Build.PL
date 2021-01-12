use Module::Build;
Module::Build->new(

   module_name => 'LWP::Protocol::socks',
   dist_version_from => 'LWP/Protocol/socks.pm',
   dist_abstract => 'Adds support to LWP for the SOCKS protocol and proxy facility',
   dist_author => [ 'Sheridan C Rawlins <scr@yahoo-inc.com>' ],
# license     => ???,		   

   requires => {
       'URI::http' => 0,
       'LWP::Protocol::http' => 0,
       'IO::Socket::Socks' => 0,
       'Net::HTTP' => 0
       },
   dynamic_config => 0
) -> create_build_script;


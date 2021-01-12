#!/usr/bin/env perl

use Dir::Self;
use lib __DIR__ . "/../lib/perl";

use XML::Compile::Cache;
use XML::Compile::Util qw(pack_type);

use constant SCHEMA_FILES => [qw(
    extension/taskExtensionRequest.xsd
    extension/vmwextensions.xsd
    extension/settings.xsd
    extension/notification.xsd
    external/xml.xsd
    external/ovf1.1/CIM_VirtualSystemSettingData.xsd
    external/ovf1.1/dsp8027_1.1.0.xsd
    external/ovf1.1/dsp8023_1.1.0.xsd
    external/ovf1.1/common.xsd
    external/ovf1.1/CIM_ResourceAllocationSettingData.xsd
    master/master.xsd
    admin/user.xsd
    admin/providerVdc.xsd
    admin/blockingExtensions.xsd
    admin/admin.xsd
    admin/vCloudEntities.xsd
    vcloud/tasksList.xsd
    vcloud/session.xsd
    vcloud/catalog.xsd
    vcloud/organization.xsd
    vcloud/file.xsd
    vcloud/queryRecordView.xsd
    vcloud/vcloud.xsd
    vcloud/catalogItem.xsd
    vcloud/resourceEntity.xsd
    vcloud/productSectionList.xsd
    vcloud/vdc.xsd
    vcloud/task.xsd
    vcloud/queryReferenceView.xsd
    vcloud/network.xsd
    vcloud/organizationList.xsd
    vcloud/screenTicket.xsd
    vcloud/media.xsd
    vcloud/common.xsd
    vcloud/vAppTemplate.xsd
    vcloud/entity.xsd
    vcloud/vApp.xsd
)];

my %NS = (
    vcloud => 'http://www.vmware.com/vcloud/v1.5',
    vmext  => 'http://www.vmware.com/vcloud/extension/v1.5',
    ovf    => 'http://schemas.dmtf.org/ovf/envelope/1',
    ovfenv => 'http://schemas.dmtf.org/ovf/environment/1',
    rasd   => 'http://schemas.dmtf.org/wbem/wscim/1/cim-schema/'
            . '2/CIM_ResourceAllocationSettingData',
    cim    => 'http://schemas.dmtf.org/wbem/wscim/1/common',
    vssd   => 'http://schemas.dmtf.org/wbem/wscim/1/cim-schema/'
            . '2/CIM_VirtualSystemSettingData',
);

BEGIN {
    XML::Compile->addSchemaDirs(
        __DIR__ . "/troublesome-schema",
    );
}

my $compiler = XML::Compile::Cache->new(SCHEMA_FILES
  , prefixes => \%NS
  , allow_undeclared => 1
);

my $w = $compiler->writer('vcloud:InstantiateVAppTemplateParams' );

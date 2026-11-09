@EndUserText.label : 'Website Master Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zweb_url_d {

  key client         : abap.clnt not null;
  key webid          : sysuuid_x16 not null;
  websitename        : abap.char(80);
  websiteurl         : abap.char(255);
  categoryid         : sysuuid_x16;
  searchaliases      : abap.char(255);
  description        : abap.char(255);
  isfavorite         : abap_boolean;
  isactive           : abap_boolean;
  launchcount        : abap.int4;
  lastlaunchedat     : abp_lastchange_tstmpl;
  createdby          : abp_creation_user;
  createdat          : abp_creation_tstmpl;
  lastchangedby      : abp_lastchange_user;
  lastchangedat      : abp_lastchange_tstmpl;
  locallastchangedat : abp_locinst_lastchange_tstmpl;
  "%admin"           : include sych_bdl_draft_admin_inc;

}

@EndUserText.label : 'Website Master Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zweb_url {

  key client            : abap.clnt not null;
  key web_id            : sysuuid_x16 not null;
  website_name          : abap.char(80);
  website_url           : abap.char(255);
  category_id           : sysuuid_x16;
  search_aliases        : abap.char(255);
  description           : abap.char(255);
  is_favorite           : abap_boolean;
  is_active             : abap_boolean;
  launch_count          : abap.int4;
  last_launched_at      : abp_lastchange_tstmpl;
  created_by            : abp_creation_user;
  created_at            : abp_creation_tstmpl;
  last_changed_by       : abp_lastchange_user;
  last_changed_at       : abp_lastchange_tstmpl;
  local_last_changed_at : abp_locinst_lastchange_tstmpl;

}

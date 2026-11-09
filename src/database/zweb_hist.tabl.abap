@EndUserText.label : 'Website Launch History Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zweb_hist {

  key client     : abap.clnt not null;
  key history_id : sysuuid_x16 not null;
  web_id         : sysuuid_x16;
  launched_at    : abp_creation_tstmpl;
  launched_by    : abp_creation_user;
  launch_status  : abap.char(10);

}

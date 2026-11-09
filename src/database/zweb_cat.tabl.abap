@EndUserText.label : 'Website Category Master Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zweb_cat {

  key client      : abap.clnt not null;
  key category_id : sysuuid_x16 not null;
  category_name   : abap.char(40);
  description     : abap.char(120);
  is_active       : abap_boolean;
  created_by      : abp_creation_user;
  created_at      : abp_creation_tstmpl;

}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Website Category Consumption View'
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true

define view entity ZC_WEB_CAT
  as select from ZI_WEB_CAT
{
      @UI.hidden: true
  key CategoryId,

      @Search.defaultSearchElement: true
      @Semantics.text: true
      CategoryName,
      Description,
      IsActive,
      CreatedBy,
      CreatedAt
}
where IsActive = 'X'

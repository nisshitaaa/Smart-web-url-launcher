@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Website Category Interface View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZI_WEB_CAT
  as select from zweb_cat
{
  key category_id as CategoryId,

      @Semantics.text: true
      category_name as CategoryName,
      description as Description,
      is_active as IsActive,

      created_by as CreatedBy,
      created_at as CreatedAt
}

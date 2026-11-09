@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Website Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZC_WEB_URL
  provider contract transactional_query
  as projection on ZI_WEB_URL
{
  key WebId,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      WebsiteName,

      WebsiteUrl,

      @Consumption.valueHelpDefinition: [{
        entity: { name: 'ZC_WEB_CAT', element: 'CategoryId' },
        useForValidation: true
      }]
      @ObjectModel.text.element: [ 'CategoryName' ]
      CategoryId,

      _Category.CategoryName as CategoryName,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      SearchAliases,

      @Search.defaultSearchElement: true
      Description,

      IsFavorite,
      IsActive,

      LaunchCount,
      LastLaunchedAt,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      _Category,
      _History
}

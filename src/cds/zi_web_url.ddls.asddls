
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Website Root Interface View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZI_WEB_URL
  as select from zweb_url

  association [0..1] to ZI_WEB_CAT as _Category
    on $projection.CategoryId = _Category.CategoryId
    
    association [0..*] to ZI_WEB_HIST as _History
  on $projection.WebId = _History.WebId

{
  key web_id as WebId,
       
      website_name as WebsiteName,
      website_url as WebsiteUrl,
       @ObjectModel.text.association: '_Category'
      category_id as CategoryId,
      search_aliases as SearchAliases,
      description as Description,

      is_favorite as IsFavorite,
      is_active as IsActive,

      launch_count as LaunchCount,
      last_launched_at as LastLaunchedAt,

            @Semantics.user.createdBy: true
      created_by as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      _Category,
       _History
}

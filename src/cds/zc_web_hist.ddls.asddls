@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Website Launch History Consumption View'
@Metadata.allowExtensions: true

define root view entity ZC_WEB_HIST
  as select from ZI_WEB_HIST
  association [0..1] to ZI_WEB_URL as _Website
    on $projection.WebId = _Website.WebId
{
  key HistoryId,

      WebId,
      _Website.WebsiteName as WebsiteName,
      LaunchedAt,
      LaunchedBy,
      LaunchStatus
}

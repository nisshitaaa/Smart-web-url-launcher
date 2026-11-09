
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Website Launch History Interface View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZI_WEB_HIST
  as select from zweb_hist
{
  key history_id as HistoryId,

      web_id as WebId,
      launched_at as LaunchedAt,
      launched_by as LaunchedBy,
      launch_status as LaunchStatus
}

@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZWHMS_PUR'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_WHMS_PUR
  as select from ZWHMS_PUR
{
  key uuid as UUID,
  request_id as RequestID,
  product_id as ProductID,
  supplier_id as SupplierID,
  request_qty as RequestQty,
  request_date as RequestDate,
  approved_by as ApprovedBy,
  request_status as RequestStatus,
  remarks as Remarks,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}

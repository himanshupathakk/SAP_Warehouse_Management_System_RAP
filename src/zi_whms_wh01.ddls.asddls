@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZWHMS_WH01'
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText.label: 'Warehouse'

define root view entity ZI_WHMS_WH01
  as select from zwhms_wh01 as WarehouseManagement
{
  key uuid as UUID,

  warehouse_id   as WarehouseID,
  warehouse_name as WarehouseName,
  warehouse_type as WarehouseType,
  address        as Address,
  city           as City,
  manager        as Manager,
  capacity       as Capacity,
  status         as Status,

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

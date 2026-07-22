@AbapCatalog.sqlViewName: 'ZWHMSWVH'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse Value Help'
@ObjectModel.resultSet.sizeCategory: #XS
@Metadata.ignorePropagatedAnnotations: true

define view ZI_WHMS_WAREHOUSE_VH
  as select from zwhms_wh01
{
  @UI.lineItem: [ { position: 10, importance: #HIGH } ]
  key warehouse_id as WarehouseID,

  @UI.lineItem: [ { position: 20, importance: #HIGH } ]
  warehouse_name as WarehouseName
}

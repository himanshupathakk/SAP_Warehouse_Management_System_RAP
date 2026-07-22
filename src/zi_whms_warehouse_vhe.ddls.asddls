@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse Value Help'
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZI_WHMS_WAREHOUSE_VHE
  as select from zwhms_wh01
{
  @UI.lineItem: [ { position: 10, importance: #HIGH } ]
  key warehouse_id as WarehouseID,

  @UI.lineItem: [ { position: 20, importance: #HIGH } ]
  warehouse_name as WarehouseName
}

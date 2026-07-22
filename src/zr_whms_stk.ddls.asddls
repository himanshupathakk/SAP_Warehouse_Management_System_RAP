@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZWHMS_STK'
@EndUserText.label: '###GENERATED Core Data Service Entity'

define root view entity ZR_WHMS_STK
  as select from zwhms_stk

  association [0..*] to ZI_WHMS_PROD01 as _Product
    on $projection.ProductID = _Product.ProductID

  association [0..*] to ZI_WHMS_WH01 as _Warehouse
    on $projection.WarehouseID = _Warehouse.WarehouseID

{
  key uuid as UUID,

  stock_id as StockID,

  @Consumption.valueHelpDefinition: [{
    entity: {
      name    : 'ZI_WHMS_PRODUCT_VHE',
      element : 'ProductID'
    }
  }]
  product_id as ProductID,

  @Consumption.valueHelpDefinition: [{
    entity: {
      name    : 'ZI_WHMS_WAREHOUSE_VHE',
      element : 'WarehouseID'
    }
  }]
  warehouse_id as WarehouseID,

  movement_type    as MovementType,
  quantity         as Quantity,
  transaction_date as TransactionDate,
  remarks          as Remarks,

  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,

  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,

  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,

  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,

  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,

  _Product,
  _Warehouse
}

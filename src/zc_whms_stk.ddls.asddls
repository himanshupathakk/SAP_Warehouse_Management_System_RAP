@Metadata.allowExtensions: true

@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZWHMS_STK'
}
@AccessControl.authorizationCheck: #MANDATORY

define root view entity ZC_WHMS_STK
  provider contract transactional_query
  as projection on ZR_WHMS_STK

  association [1..1] to ZR_WHMS_STK as _BaseEntity
    on $projection.UUID = _BaseEntity.UUID

{
  key UUID,

  StockID,
  ProductID,
  WarehouseID,
  MovementType,
  Quantity,
  TransactionDate,
  Remarks,

  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,

  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,

  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,

  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,

  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,

  _Product,
  _Warehouse,

  _BaseEntity
}

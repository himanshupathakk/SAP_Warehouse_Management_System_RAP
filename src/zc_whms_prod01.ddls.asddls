@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: 'Product'

@ObjectModel.sapObjectNodeType.name: 'ZWHMS_PROD01'

@AccessControl.authorizationCheck: #MANDATORY

define root view entity ZC_WHMS_PROD01
  provider contract transactional_query
  as projection on ZI_WHMS_PROD01

  association [1..1] to ZI_WHMS_PROD01 as _BaseEntity
    on $projection.UUID = _BaseEntity.UUID

{
  key UUID,

  ProductID,
  ProductName,
  ProductType,
  CategoryID,
  SupplierID,
  WarehouseID,
  Quantity,
  ReorderLevel,
  Price,

  @Consumption.valueHelpDefinition: [ {
    entity.name    : 'I_CurrencyStdVH',
    entity.element : 'Currency',
    useForValidation : true
  } ]
  Currency,

  @Consumption.valueHelpDefinition: [ {
    entity.name    : 'I_UnitOfMeasureStdVH',
    entity.element : 'UnitOfMeasure',
    useForValidation : true
  } ]
  Unit,

  Barcode,

@Consumption.valueHelpDefinition: [
  {
    entity: {
      name: 'ZI_WHMS_PRODUCT_STATUS_VH',
      element: 'Status'
    },
    useForValidation: true
  }
]
Status,

Description,

  @Semantics.user.createdBy: true
  LocalCreatedBy,

  @Semantics.systemDateTime.createdAt: true
  LocalCreatedAt,

  @Semantics.user.localInstanceLastChangedBy: true
  LocalLastChangedBy,

  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LocalLastChangedAt,

  @Semantics.systemDateTime.lastChangedAt: true
  LastChangedAt,

  _Warehouse,

  _BaseEntity

}

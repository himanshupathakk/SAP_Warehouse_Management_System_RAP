@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZWHMS_PROD01'
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText.label: 'Product'

define root view entity ZI_WHMS_PROD01
  as select from zwhms_prod01 as WareHouseManagement

  association [0..*] to ZI_WHMS_WH01 as _Warehouse
    on $projection.WarehouseID = _Warehouse.WarehouseID

{
  @EndUserText.label: 'UUID'
  key uuid as UUID,

  @EndUserText.label: 'Product ID'
  product_id as ProductID,

  @EndUserText.label: 'Product Name'
  product_name as ProductName,

  @EndUserText.label: 'Product Type'
  product_type as ProductType,

  @EndUserText.label: 'Category'
  category_id as CategoryID,

  @EndUserText.label: 'Supplier'
  supplier_id as SupplierID,

  @EndUserText.label: 'Warehouse'
  warehouse_id as WarehouseID,

  @EndUserText.label: 'Quantity'
  quantity as Quantity,

  @EndUserText.label: 'Reorder Level'
  reorder_level as ReorderLevel,

  @EndUserText.label: 'Price'
  price as Price,

  @EndUserText.label: 'Currency'
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH',
    entity.element: 'Currency',
    useForValidation: true
  } ]
  currency as Currency,

  @EndUserText.label: 'Unit of Measure'
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_UnitOfMeasureStdVH',
    entity.element: 'UnitOfMeasure',
    useForValidation: true
  } ]
  unit as Unit,

  @EndUserText.label: 'Barcode'
  barcode as Barcode,

  @EndUserText.label: 'Status'
@Consumption.valueHelpDefinition: [
  {
    entity: {
      name: 'ZI_WHMS_PRODUCT_STATUS_VH',
      element: 'Status'
    },
    useForValidation: true
  }
]
status as Status,

  @EndUserText.label: 'Description'
  description as Description,

  @EndUserText.label: 'Created By'
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,

  @EndUserText.label: 'Created On'
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,

  @EndUserText.label: 'Last Changed By'
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,

  @EndUserText.label: 'Last Changed On'
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,

  @EndUserText.label: 'Last Changed At'
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,

  _Warehouse

}

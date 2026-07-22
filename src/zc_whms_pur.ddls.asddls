@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZWHMS_PUR'
}
@AccessControl.authorizationCheck: #MANDATORY

define root view entity ZC_WHMS_PUR
  provider contract transactional_query
  as projection on ZR_WHMS_PUR

  association [1..1] to ZR_WHMS_PUR as _BaseEntity
    on $projection.UUID = _BaseEntity.UUID

{
  key UUID,

  RequestID,

  @Consumption.valueHelpDefinition: [{
    entity: {
      name    : 'ZI_WHMS_PRODUCT_VHE',
      element : 'ProductID'
    }
  }]
  ProductID,

  @Consumption.valueHelpDefinition: [{
    entity: {
      name    : 'ZI_WHMS_SUPPLIER_VHE',
      element : 'SupplierID'
    }
  }]
  SupplierID,

  RequestQty,
  RequestDate,
  ApprovedBy,
  RequestStatus,
  Remarks,

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

  _BaseEntity
}

@AbapCatalog.sqlViewName: 'ZWHMSPVH'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Value Help'
@ObjectModel.resultSet.sizeCategory: #XS
@Metadata.ignorePropagatedAnnotations: true

define view ZI_WHMS_PRODUCT_VH
  as select from zwhms_prod01
{
  @UI.lineItem: [ { position: 10, importance: #HIGH } ]
  key product_id as ProductID,

  @UI.lineItem: [ { position: 20, importance: #HIGH } ]
  product_name as ProductName
}

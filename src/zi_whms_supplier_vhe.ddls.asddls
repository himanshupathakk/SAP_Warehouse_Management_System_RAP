@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier Value Help'
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZI_WHMS_SUPPLIER_VHE
  as select from zwhms_sup01
{
  @UI.lineItem: [{ position: 10, importance: #HIGH }]
  key supplier_id as SupplierID,

  @UI.lineItem: [{ position: 20, importance: #HIGH }]
  supplier_name as SupplierName
}

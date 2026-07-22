@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Status Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZI_WHMS_PRODUCT_STATUS_VH
  as select from zwhms_prod01
{
  key status as Status
}
group by status

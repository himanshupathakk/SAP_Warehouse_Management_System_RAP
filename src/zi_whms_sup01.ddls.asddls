@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZZWHMS_SUP0101'
@EndUserText.label: 'Supplier'

define root view entity ZI_WHMS_SUP01
  as select from zwhms_sup01 as SupplierManagement
{

  @EndUserText.label: 'UUID'
  key uuid as UUID,

  @EndUserText.label: 'Supplier ID'
  supplier_id as SupplierID,

  @EndUserText.label: 'Supplier Name'
  supplier_name as SupplierName,

  @EndUserText.label: 'Contact Person'
  contact_person as ContactPerson,

  @EndUserText.label: 'Phone'
  phone as Phone,

  @EndUserText.label: 'Email'
  email as Email,

  @EndUserText.label: 'Address'
  address as Address,

  @EndUserText.label: 'City'
  city as City,

  @EndUserText.label: 'Status'
  status as Status,

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
  last_changed_at as LastChangedAt

}

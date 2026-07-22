@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZZWHMS_SUP0101'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_WHMS_SUP01
  provider contract TRANSACTIONAL_QUERY
  as projection on ZI_WHMS_SUP01
  association [1..1] to ZI_WHMS_SUP01 as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  SupplierID,
  SupplierName,
  ContactPerson,
  Phone,
  Email,
  Address,
  City,
  Status,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}

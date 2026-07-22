CLASS LHC_ZI_WHMS_SUP01 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.

    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
          REQUEST requested_authorizations FOR SupplierManagement
        RESULT result,

      validateSupplier FOR VALIDATE ON SAVE
        IMPORTING keys FOR SupplierManagement~validateSupplier.

ENDCLASS.



CLASS LHC_ZI_WHMS_SUP01 IMPLEMENTATION.

  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.



  METHOD validateSupplier.

    READ ENTITIES OF ZI_WHMS_SUP01 IN LOCAL MODE
      ENTITY SupplierManagement
      FIELDS (
        SupplierID
        SupplierName
        Phone
        Email
      )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_suppliers).

    LOOP AT lt_suppliers INTO DATA(ls_supplier).

      IF ls_supplier-SupplierName IS INITIAL.

        APPEND VALUE #(
          %tky = ls_supplier-%tky
        ) TO failed-SupplierManagement.

        APPEND VALUE #(
          %tky = ls_supplier-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Supplier Name cannot be empty'
          )
        ) TO reported-SupplierManagement.

      ENDIF.



      IF ls_supplier-Phone IS INITIAL.

        APPEND VALUE #(
          %tky = ls_supplier-%tky
        ) TO failed-SupplierManagement.

        APPEND VALUE #(
          %tky = ls_supplier-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Phone cannot be empty'
          )
        ) TO reported-SupplierManagement.

      ENDIF.



      IF ls_supplier-Email IS INITIAL.

        APPEND VALUE #(
          %tky = ls_supplier-%tky
        ) TO failed-SupplierManagement.

        APPEND VALUE #(
          %tky = ls_supplier-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Email cannot be empty'
          )
        ) TO reported-SupplierManagement.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

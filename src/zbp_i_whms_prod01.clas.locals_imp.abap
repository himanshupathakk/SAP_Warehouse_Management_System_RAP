CLASS LHC_ZI_WHMS_PROD01 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.

    METHODS:
      GET_GLOBAL_AUTHORIZATIONS
        FOR GLOBAL AUTHORIZATION
        IMPORTING
          REQUEST requested_authorizations FOR WareHouseManagement
        RESULT result,

      validateProduct
        FOR VALIDATE ON SAVE
        IMPORTING keys FOR WareHouseManagement~validateProduct.

ENDCLASS.



CLASS LHC_ZI_WHMS_PROD01 IMPLEMENTATION.

  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.


  METHOD validateProduct.

    READ ENTITIES OF ZI_WHMS_PROD01 IN LOCAL MODE
      ENTITY WareHouseManagement
      FIELDS (
        ProductID
        ProductName
        Quantity
        Price
      )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_products).

    LOOP AT lt_products INTO DATA(ls_product).

      IF ls_product-ProductName IS INITIAL.

        APPEND VALUE #(
          %tky = ls_product-%tky
        ) TO failed-WareHouseManagement.

        APPEND VALUE #(
          %tky = ls_product-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Product Name cannot be empty'
          )
        ) TO reported-WareHouseManagement.

      ENDIF.


      IF ls_product-Quantity < 0.

        APPEND VALUE #(
          %tky = ls_product-%tky
        ) TO failed-WareHouseManagement.

        APPEND VALUE #(
          %tky = ls_product-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Quantity cannot be negative'
          )
        ) TO reported-WareHouseManagement.

      ENDIF.


      IF ls_product-Price < 0.

        APPEND VALUE #(
          %tky = ls_product-%tky
        ) TO failed-WareHouseManagement.

        APPEND VALUE #(
          %tky = ls_product-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Price cannot be negative'
          )
        ) TO reported-WareHouseManagement.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

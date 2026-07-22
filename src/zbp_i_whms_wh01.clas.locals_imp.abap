CLASS LHC_ZI_WHMS_WH01 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.

    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
          REQUEST requested_authorizations FOR WarehouseManagement
        RESULT result,

      validateWarehouse FOR VALIDATE ON SAVE
        IMPORTING keys FOR WarehouseManagement~validateWarehouse.

ENDCLASS.



CLASS LHC_ZI_WHMS_WH01 IMPLEMENTATION.

  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.


  METHOD validateWarehouse.

    READ ENTITIES OF ZI_WHMS_WH01 IN LOCAL MODE
      ENTITY WarehouseManagement
      FIELDS (
        WarehouseID
        WarehouseName
        Capacity
      )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_warehouse).

    LOOP AT lt_warehouse INTO DATA(ls_warehouse).

      IF ls_warehouse-WarehouseID IS INITIAL.

        APPEND VALUE #(
          %tky = ls_warehouse-%tky
        ) TO failed-WarehouseManagement.

        APPEND VALUE #(
          %tky = ls_warehouse-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Warehouse ID cannot be empty'
          )
        ) TO reported-WarehouseManagement.

      ENDIF.


      IF ls_warehouse-WarehouseName IS INITIAL.

        APPEND VALUE #(
          %tky = ls_warehouse-%tky
        ) TO failed-WarehouseManagement.

        APPEND VALUE #(
          %tky = ls_warehouse-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Warehouse Name cannot be empty'
          )
        ) TO reported-WarehouseManagement.

      ENDIF.


      IF ls_warehouse-Capacity < 0.

        APPEND VALUE #(
          %tky = ls_warehouse-%tky
        ) TO failed-WarehouseManagement.

        APPEND VALUE #(
          %tky = ls_warehouse-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Capacity cannot be negative'
          )
        ) TO reported-WarehouseManagement.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

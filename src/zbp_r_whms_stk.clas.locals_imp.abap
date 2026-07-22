CLASS lhc_zr_whms_stk DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS:
      get_global_authorizations
        FOR GLOBAL AUTHORIZATION
        IMPORTING
          REQUEST requested_authorizations FOR ZrWhmsStk
        RESULT result,

      validateStock
        FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrWhmsStk~validateStock,

      generateStockID
        FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrWhmsStk~generateStockID,

      setDefaultRemarks
        FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrWhmsStk~setDefaultRemarks.

ENDCLASS.



CLASS lhc_zr_whms_stk IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.



  METHOD generateStockID.

    READ ENTITIES OF ZR_WHMS_STK IN LOCAL MODE
      ENTITY ZrWhmsStk
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    DATA lt_stock TYPE TABLE FOR UPDATE ZR_WHMS_STK.

    DATA lt_ids      TYPE TABLE OF zde_stock_id.
    DATA lv_stockid  TYPE zde_stock_id.
    DATA lv_number   TYPE i.
    DATA lv_max      TYPE i.

*-----------------------------------------------------------------------
* Read existing Stock IDs
*-----------------------------------------------------------------------
    SELECT stock_id
      FROM zwhms_stk
      WHERE stock_id LIKE 'STK%'
      INTO TABLE @lt_ids.

*-----------------------------------------------------------------------
* Find highest Stock ID
*-----------------------------------------------------------------------
    lv_max = 1000000.

    LOOP AT lt_ids INTO lv_stockid.

      TRY.

          lv_number = CONV i( lv_stockid+3(7) ).

          IF lv_number > lv_max.
            lv_max = lv_number.
          ENDIF.

        CATCH cx_sy_conversion_no_number.
          CONTINUE.

      ENDTRY.

    ENDLOOP.

*-----------------------------------------------------------------------
* Generate next Stock ID
*-----------------------------------------------------------------------
    lv_max = lv_max + 1.

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_stock>).

      IF <ls_stock>-StockID IS INITIAL.

        lv_stockid = |STK{ lv_max }|.

        APPEND VALUE #(
          %tky    = <ls_stock>-%tky
          StockID = lv_stockid
        ) TO lt_stock.

        lv_max = lv_max + 1.

      ENDIF.

    ENDLOOP.

*-----------------------------------------------------------------------
* Update entity
*-----------------------------------------------------------------------
    IF lt_stock IS NOT INITIAL.

      MODIFY ENTITIES OF ZR_WHMS_STK IN LOCAL MODE
        ENTITY ZrWhmsStk
        UPDATE FIELDS ( StockID )
        WITH lt_stock.

    ENDIF.

  ENDMETHOD.



  METHOD validateStock.

    READ ENTITIES OF ZR_WHMS_STK IN LOCAL MODE
      ENTITY ZrWhmsStk
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    LOOP AT lt_stock INTO DATA(ls_stock).

      IF ls_stock-StockID IS INITIAL.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-ZrWhmsStk.
        APPEND VALUE #(
          %tky = ls_stock-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Stock ID cannot be empty'
          )
        ) TO reported-ZrWhmsStk.
      ENDIF.

      IF ls_stock-ProductID IS INITIAL.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-ZrWhmsStk.
        APPEND VALUE #(
          %tky = ls_stock-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Product ID cannot be empty'
          )
        ) TO reported-ZrWhmsStk.
      ENDIF.

      IF ls_stock-WarehouseID IS INITIAL.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-ZrWhmsStk.
        APPEND VALUE #(
          %tky = ls_stock-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Warehouse ID cannot be empty'
          )
        ) TO reported-ZrWhmsStk.
      ENDIF.

      IF ls_stock-Quantity < 0.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-ZrWhmsStk.
        APPEND VALUE #(
          %tky = ls_stock-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Quantity cannot be negative'
          )
        ) TO reported-ZrWhmsStk.
      ENDIF.

      IF ls_stock-MovementType IS INITIAL
         OR ( ls_stock-MovementType <> 'IN'
           AND ls_stock-MovementType <> 'OUT' ).

        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-ZrWhmsStk.
        APPEND VALUE #(
          %tky = ls_stock-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Movement Type must be IN or OUT'
          )
        ) TO reported-ZrWhmsStk.
      ENDIF.

      IF ls_stock-TransactionDate IS INITIAL.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-ZrWhmsStk.
        APPEND VALUE #(
          %tky = ls_stock-%tky
          %msg = new_message(
            id       = '00'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Transaction Date cannot be empty'
          )
        ) TO reported-ZrWhmsStk.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.



  METHOD setDefaultRemarks.

    READ ENTITIES OF ZR_WHMS_STK IN LOCAL MODE
      ENTITY ZrWhmsStk
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    DATA lt_update TYPE TABLE FOR UPDATE ZR_WHMS_STK.

    LOOP AT lt_stock ASSIGNING FIELD-SYMBOL(<ls_stock>).

      IF <ls_stock>-Remarks IS INITIAL.

        APPEND VALUE #(
          %tky    = <ls_stock>-%tky
          Remarks = 'System Generated'
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF ZR_WHMS_STK IN LOCAL MODE
        ENTITY ZrWhmsStk
        UPDATE FIELDS ( Remarks )
        WITH lt_update.

    ENDIF.

  ENDMETHOD.

ENDCLASS.

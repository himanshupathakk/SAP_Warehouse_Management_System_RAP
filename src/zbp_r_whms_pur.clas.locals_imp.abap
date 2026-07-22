CLASS lhc_zrwhmspur DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      IMPORTING
        REQUEST requested_authorizations FOR ZrWhmsPur
      RESULT result.

    METHODS generateRequestID
      FOR DETERMINE ON MODIFY
      IMPORTING
        keys FOR ZrWhmsPur~generateRequestID.

    METHODS createStockMovement
      FOR DETERMINE ON SAVE
      IMPORTING
        keys FOR ZrWhmsPur~createStockMovement.

ENDCLASS.



CLASS lhc_zrwhmspur IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.



  METHOD generateRequestID.

    READ ENTITIES OF ZR_WHMS_PUR IN LOCAL MODE
      ENTITY ZrWhmsPur
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    DATA lt_purchase TYPE TABLE FOR UPDATE ZR_WHMS_PUR.

    DATA lt_ids       TYPE TABLE OF zde_request_id.
    DATA lv_requestid TYPE zde_request_id.
    DATA lv_number    TYPE i.
    DATA lv_max       TYPE i.

*-----------------------------------------------------------------------
* Read all existing Request IDs
*-----------------------------------------------------------------------
    SELECT request_id
      FROM zwhms_pur
      WHERE request_id LIKE 'PUR%'
      INTO TABLE @lt_ids.

*-----------------------------------------------------------------------
* Find highest numeric value
*-----------------------------------------------------------------------
    lv_max = 0.

    LOOP AT lt_ids INTO lv_requestid.

      TRY.

          lv_number = CONV i( lv_requestid+3(7) ).

          IF lv_number > lv_max.
            lv_max = lv_number.
          ENDIF.

        CATCH cx_sy_conversion_no_number.
          CONTINUE.

      ENDTRY.

    ENDLOOP.

*-----------------------------------------------------------------------
* Generate next number
*-----------------------------------------------------------------------
    lv_max = lv_max + 1.

*-----------------------------------------------------------------------
* Assign Request IDs
*-----------------------------------------------------------------------
    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_purchase>).

      IF <ls_purchase>-RequestID IS INITIAL.

        lv_requestid = |PUR{ lv_max WIDTH = 7 PAD = '0' }|.

        APPEND VALUE #(
          %tky      = <ls_purchase>-%tky
          RequestID = lv_requestid
        ) TO lt_purchase.

        lv_max = lv_max + 1.

      ENDIF.

    ENDLOOP.

*-----------------------------------------------------------------------
* Update entity
*-----------------------------------------------------------------------
    IF lt_purchase IS NOT INITIAL.

      MODIFY ENTITIES OF ZR_WHMS_PUR IN LOCAL MODE
        ENTITY ZrWhmsPur
        UPDATE FIELDS ( RequestID )
        WITH lt_purchase.

    ENDIF.

  ENDMETHOD.



  METHOD createStockMovement.


ENDMETHOD.

ENDCLASS.

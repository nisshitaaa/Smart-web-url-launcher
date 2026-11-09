CLASS zcl_web_cat_load DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_web_cat_load IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    SELECT COUNT(*) FROM zweb_cat INTO @DATA(lv_count).
    IF lv_count > 0.
      out->write( 'Categories already exist. Nothing inserted.' ).
      RETURN.
    ENDIF.

    DATA lv_ts TYPE timestampl.
    GET TIME STAMP FIELD lv_ts.
    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).

    TYPES: BEGIN OF ty_cat,
             name TYPE zweb_cat-category_name,
             descr TYPE zweb_cat-description,
           END OF ty_cat.

    DATA lt_src TYPE STANDARD TABLE OF ty_cat WITH EMPTY KEY.
    DATA lt_cat TYPE STANDARD TABLE OF zweb_cat WITH EMPTY KEY.
    DATA ls_cat TYPE zweb_cat.

    lt_src = VALUE #(
      ( name = 'Shopping'                descr = 'Online shopping sites' )
      ( name = 'Search'                  descr = 'Search engines and searches' )
      ( name = 'Social Media'            descr = 'Social networks' )
      ( name = 'Video and Entertainment' descr = 'Video and streaming sites' )
      ( name = 'Work and Learning'       descr = 'Professional and learning sites' )
      ( name = 'Other'                   descr = 'Everything else' ) ).

    TRY.
        LOOP AT lt_src INTO DATA(ls_src).
          CLEAR ls_cat.
          ls_cat-category_id   = cl_system_uuid=>create_uuid_x16_static( ).
          ls_cat-category_name = ls_src-name.
          ls_cat-description   = ls_src-descr.
          ls_cat-is_active     = abap_true.
          ls_cat-created_by    = lv_user.
          ls_cat-created_at    = lv_ts.
          APPEND ls_cat TO lt_cat.
        ENDLOOP.

        INSERT zweb_cat FROM TABLE @lt_cat.
        out->write( |{ sy-dbcnt } categories inserted.| ).

      CATCH cx_uuid_error INTO DATA(lx_uuid).
        out->write( lx_uuid->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

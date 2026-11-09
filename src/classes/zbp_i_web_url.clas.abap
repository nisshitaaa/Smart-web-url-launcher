CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA mt_launch TYPE STANDARD TABLE OF zweb_hist WITH EMPTY KEY.
ENDCLASS.

CLASS lhc_Website DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Website RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Website RESULT result.

    METHODS OpenWebsite FOR MODIFY
      IMPORTING keys FOR ACTION Website~OpenWebsite RESULT result.

    METHODS validateWebsite FOR VALIDATE ON SAVE
      IMPORTING keys FOR Website~validateWebsite.

    METHODS validateDuplicate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Website~validateDuplicate.

    METHODS resolveWebsiteUrl FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Website~resolveWebsiteUrl.

    METHODS setDefaults FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Website~setDefaults.

ENDCLASS.

CLASS lhc_Website IMPLEMENTATION.

  METHOD get_global_authorizations.
    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.
    IF requested_authorizations-%update = if_abap_behv=>mk-on.
      result-%update = if_abap_behv=>auth-allowed.
    ENDIF.
    IF requested_authorizations-%delete = if_abap_behv=>mk-on.
      result-%delete = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      FIELDS ( WebId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_websites).

    result = VALUE #(
      FOR ls_site IN lt_websites
      ( %tky = ls_site-%tky
        %action-OpenWebsite =
          COND #( WHEN ls_site-%is_draft = if_abap_behv=>mk-on
                  THEN if_abap_behv=>fc-o-disabled
                  ELSE if_abap_behv=>fc-o-enabled ) ) ).
  ENDMETHOD.

  METHOD OpenWebsite.
    DATA lv_now TYPE timestampl.
    GET TIME STAMP FIELD lv_now.

    READ ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      FIELDS ( LaunchCount )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_websites).

    MODIFY ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      UPDATE FIELDS ( LaunchCount LastLaunchedAt )
      WITH VALUE #(
        FOR ls_site IN lt_websites
        ( %tky           = ls_site-%tky
          LaunchCount    = ls_site-LaunchCount + 1
          LastLaunchedAt = lv_now ) )
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_reported).

    failed-website   = CORRESPONDING #( lt_failed-website ).
    reported-website = CORRESPONDING #( lt_reported-website ).

    " collect one history row per successful launch (saved in the saver class)
    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).
    TRY.
        LOOP AT lt_websites INTO DATA(ls_launch).
          IF line_exists( lt_failed-website[ %tky = ls_launch-%tky ] ).
            CONTINUE.
          ENDIF.
          APPEND VALUE #(
            history_id    = cl_system_uuid=>create_uuid_x16_static( )
            web_id        = ls_launch-WebId
            launched_at   = lv_now
            launched_by   = lv_user
            launch_status = 'SUCCESS' )
            TO lcl_buffer=>mt_launch.
        ENDLOOP.
      CATCH cx_uuid_error.
        " history row skipped if no UUID could be created
    ENDTRY.

    READ ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_updated).

    result = VALUE #(
      FOR ls_upd IN lt_updated
      ( %tky   = ls_upd-%tky
        %param = CORRESPONDING #( ls_upd ) ) ).
  ENDMETHOD.

  METHOD validateWebsite.
    READ ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      FIELDS ( WebsiteName WebsiteUrl )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_websites).

    LOOP AT lt_websites INTO DATA(ls_site).

      APPEND VALUE #( %tky        = ls_site-%tky
                      %state_area = 'VALIDATE_WEBSITE' )
        TO reported-website.

      IF ls_site-WebsiteName IS INITIAL.
        APPEND VALUE #( %tky = ls_site-%tky ) TO failed-website.
        APPEND VALUE #(
          %tky        = ls_site-%tky
          %state_area = 'VALIDATE_WEBSITE'
          %msg        = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text     = 'Please enter a website name.' )
          %element-WebsiteName = if_abap_behv=>mk-on )
          TO reported-website.

      ELSEIF ls_site-WebsiteUrl IS INITIAL.
        APPEND VALUE #( %tky = ls_site-%tky ) TO failed-website.
        APPEND VALUE #(
          %tky        = ls_site-%tky
          %state_area = 'VALIDATE_WEBSITE'
          %msg        = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text     = 'Website URL could not be generated.' )
          %element-WebsiteName = if_abap_behv=>mk-on )
          TO reported-website.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateDuplicate.
    READ ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      FIELDS ( WebsiteName )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_websites).

    DATA lv_name  TYPE zweb_url-website_name.
    DATA lv_other TYPE zweb_url-web_id.

    LOOP AT lt_websites INTO DATA(ls_site).

      APPEND VALUE #( %tky        = ls_site-%tky
                      %state_area = 'VALIDATE_DUPLICATE' )
        TO reported-website.

      lv_name = to_lower( condense( CONV string( ls_site-WebsiteName ) ) ).

      IF lv_name IS NOT INITIAL.

        CLEAR lv_other.
        SELECT SINGLE web_id
          FROM zweb_url
          WHERE lower( website_name ) = @lv_name
            AND web_id <> @ls_site-WebId
          INTO @lv_other.

        IF sy-subrc = 0.
          APPEND VALUE #( %tky = ls_site-%tky ) TO failed-website.
          APPEND VALUE #(
            %tky        = ls_site-%tky
            %state_area = 'VALIDATE_DUPLICATE'
            %msg        = new_message_with_text(
                            severity = if_abap_behv_message=>severity-error
                            text     = 'A website with this name already exists.' )
            %element-WebsiteName = if_abap_behv=>mk-on )
            TO reported-website.
        ENDIF.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD resolveWebsiteUrl.
    READ ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      FIELDS ( WebsiteName WebsiteUrl )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_websites).

    DATA lt_update TYPE TABLE FOR UPDATE zi_web_url.

    LOOP AT lt_websites INTO DATA(ls_site).

      DATA(lv_name) = to_lower( condense( CONV string( ls_site-WebsiteName ) ) ).
      DATA(lv_url)  = ``.

      IF lv_name IS NOT INITIAL.
        CASE lv_name.
          WHEN 'amazon'.    lv_url = `https://www.amazon.in`.
          WHEN 'google'.    lv_url = `https://www.google.com`.
          WHEN 'youtube'.   lv_url = `https://www.youtube.com`.
          WHEN 'flipkart'.  lv_url = `https://www.flipkart.com`.
          WHEN 'linkedin'.  lv_url = `https://www.linkedin.com`.
          WHEN 'github'.    lv_url = `https://www.github.com`.
          WHEN 'facebook'.  lv_url = `https://www.facebook.com`.
          WHEN 'instagram'. lv_url = `https://www.instagram.com`.
          WHEN 'microsoft'. lv_url = `https://www.microsoft.com`.
          WHEN OTHERS.
            IF lv_name CO 'abcdefghijklmnopqrstuvwxyz0123456789-.'.
              IF lv_name CS '.'.
                lv_url = |https://www.{ lv_name }|.
              ELSE.
                lv_url = |https://www.{ lv_name }.com|.
              ENDIF.
            ELSE.
              DATA(lv_query) = replace( val  = lv_name
                                        sub  = ` `
                                        with = `+`
                                        occ  = 0 ).
              lv_url = |https://www.google.com/search?q={ lv_query }|.
            ENDIF.
        ENDCASE.
      ENDIF.

      IF lv_url <> ls_site-WebsiteUrl.
        APPEND VALUE #( %tky       = ls_site-%tky
                        WebsiteUrl = lv_url ) TO lt_update.
      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zi_web_url IN LOCAL MODE
        ENTITY Website
        UPDATE FIELDS ( WebsiteUrl )
        WITH lt_update
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_reported).
    ENDIF.
  ENDMETHOD.

  METHOD setDefaults.
    READ ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      FIELDS ( IsActive )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_websites).

    MODIFY ENTITIES OF zi_web_url IN LOCAL MODE
      ENTITY Website
      UPDATE FIELDS ( IsActive )
      WITH VALUE #(
        FOR ls_site IN lt_websites
        ( %tky     = ls_site-%tky
          IsActive = abap_true ) )
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_reported).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_web_url DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS save_modified REDEFINITION.
ENDCLASS.

CLASS lsc_zi_web_url IMPLEMENTATION.
  METHOD save_modified.
    IF lcl_buffer=>mt_launch IS NOT INITIAL.
      INSERT zweb_hist FROM TABLE @lcl_buffer=>mt_launch.
      CLEAR lcl_buffer=>mt_launch.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

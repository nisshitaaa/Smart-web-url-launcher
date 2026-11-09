# Application Architecture – Smart Web URL Launcher

## 1. Overview

Smart Web URL Launcher is developed using the SAP ABAP RESTful Application Programming Model (RAP) on SAP BTP ABAP Environment.

The application follows a layered architecture consisting of the database layer, CDS data modeling layer, RAP behavior layer, service exposure layer, and SAP Fiori Elements presentation layer.

## 2. Architecture Layers

### 2.1 Presentation Layer

**Technology:** SAP Fiori Elements

Provides the user interface through:
- List Report
- Object Page
- Website creation and editing
- Website category selection
- Launch history display
- Search and filtering

### 2.2 Service Exposure Layer

**Service Definition:** `ZUI_WEB_URL`

**Service Binding:** `ZUI_WEB_URL_O4`

**Protocol:** OData V4 – UI

Exposes the RAP business objects for consumption by SAP Fiori Elements.

### 2.3 Projection Layer

The projection CDS views provide the application-facing data model.

- `ZC_WEB_URL`
- `ZC_WEB_CAT`
- `ZC_WEB_HIST`

### 2.4 Interface Layer

The interface CDS views represent the underlying business data model.

- `ZI_WEB_URL`
- `ZI_WEB_CAT`
- `ZI_WEB_HIST`

### 2.5 Behavior Layer

The RAP behavior definitions and implementation classes manage transactional operations and business logic.

- `ZI_WEB_URL` – Root behavior definition
- `ZC_WEB_URL` – Projection behavior definition
- `ZBP_I_WEB_URL` – Behavior implementation class

The implementation handles website URL resolution, validation, launch-related processing, and other configured business operations.

### 2.6 Database Layer

The application uses four database tables:

- `ZWEB_URL` – Website master data
- `ZWEB_URL_D` – Draft data
- `ZWEB_CAT` – Website categories
- `ZWEB_HIST` – Website launch history

## 3. Application Data Flow

1. A user interacts with the SAP Fiori Elements interface.
2. The OData V4 service binding receives the application request.
3. The service definition exposes the relevant projection views.
4. Projection views access the interface CDS views.
5. RAP behavior definitions and implementation classes process transactional operations.
6. Database tables persist the application data.

## 4. Development Environment

- SAP BTP ABAP Environment
- Eclipse ABAP Development Tools (ADT)
- ABAP Cloud
- SAP RAP
- CDS View Entities
- OData V4
- SAP Fiori Elements

## 5. Architecture Summary

The application demonstrates a layered SAP RAP architecture with managed draft handling, CDS-based data modeling, behavior implementation, OData V4 service exposure, and a Fiori Elements user interface.

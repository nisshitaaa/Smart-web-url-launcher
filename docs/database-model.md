# Database Model – Smart Web URL Launcher

## 1. Overview

The Smart Web URL Launcher application uses database tables to store website information, website categories, draft records, and website launch history.

The database layer supports the managed RAP business object and its transactional operations.

## 2. Database Tables

### 2.1 ZWEB_URL – Website Master Table

Stores the main website records.

Key information includes:
- Website ID
- Website name
- Website URL
- Category ID
- Search aliases
- Description
- Favourite status
- Active status
- Launch count
- Last launched timestamp
- Creation and change audit fields

### 2.2 ZWEB_URL_D – Website Draft Table

Stores draft versions of website records during RAP draft processing.

Supports editing and resuming records before activation.

### 2.3 ZWEB_CAT – Website Category Table

Stores category master data used to organize website records.

### 2.4 ZWEB_HIST – Website Launch History Table

Stores website launch-history information for tracking and displaying launch activities.

## 3. CDS Data Model

### Interface CDS Views

| CDS View | Purpose |
|---|---|
| `ZI_WEB_URL` | Website root interface view |
| `ZI_WEB_CAT` | Website category interface view |
| `ZI_WEB_HIST` | Website launch history interface view |

### Projection CDS Views

| CDS View | Purpose |
|---|---|
| `ZC_WEB_URL` | Website projection view |
| `ZC_WEB_CAT` | Website category projection view |
| `ZC_WEB_HIST` | Website launch history projection view |

## 4. Data Relationships

The website master data is associated with category information through the category identifier.

The application also models website launch-history information through its CDS data model.

## 5. Draft Management

The application uses managed RAP draft handling.

The draft table `ZWEB_URL_D` supports temporary editing of website records before activation.

## 6. Summary

The database design separates website master data, category information, draft records, and launch-history information into dedicated tables.

CDS interface and projection views provide the data model consumed by the RAP business object and Fiori Elements application.

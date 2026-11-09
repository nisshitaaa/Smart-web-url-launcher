# Smart-web-url-launcher
SAP RAP app on BTP ABAP Environment that turns a website name into a working URL, tracks launches, and shows everything in a Fiori Elements UI.

# 🚀 Smart Web URL Launcher

> An SAP RAP (ABAP RESTful Application Programming) application developed on SAP BTP ABAP Environment that transforms website names into working URLs, tracks website launches, and provides an interactive SAP Fiori Elements interface.

**Author:** Nishita Wani  
**LinkedIn:** [Nishita Wani](https://www.linkedin.com/in/nishita-wani)  
**GitHub:** [nisshitaaa](https://github.com/nisshitaaa)

---

## 📌 Project Overview

Smart Web URL Launcher is an end-to-end SAP ABAP RAP application that simplifies website navigation through automatic URL generation.

Users can enter a website name such as `youtube`, and the application automatically generates its corresponding URL:

`https://www.youtube.com`

Users can also enter a search phrase such as `best laptops`, which generates a Google search URL:

`https://www.google.com/search?q=best+laptops`

The application supports website categorization, alias-based searching, favourites, draft handling, data validation, and launch-history tracking.

The project demonstrates the complete SAP RAP development lifecycle, from database design and CDS modeling to behavior implementation, OData V4 service exposure, and Fiori Elements UI development.

## ✨ Key Features

- **Automatic URL Generation:** Resolves website names into their corresponding URLs.
- **Smart Search URL Generation:** Converts multi-word search phrases into Google search links.
- **Managed RAP with Draft:** Supports creating, editing, saving, discarding, and resuming draft records.
- **Data Validations:** Validates mandatory website names, duplicate entries, and generated URLs.
- **Website Categories:** Organizes websites using category selection and value help.
- **Favourites and Active Status:** Supports website favourites and active/inactive status.
- **Launch Tracking:** Maintains launch counts and last-launched information.
- **Launch History:** Records website launch activities and displays associated history.
- **Alias-Based Search:** Supports searching websites through aliases.
- **Clickable Website URLs:** Opens the selected website in a new browser tab.
- **Fiori Elements Interface:** Provides List Report and Object Page experiences.

## ⚙️ URL Resolution Logic

 amazon      :  https://www.amazon.in 
 google      :  https://www.google.com 
 youtube     :  https://www.youtube.com 
 netflix     :  https://www.netflix.com 
 flipkart    :  https://www.flipkart.com 
 linkedin    :  https://www.linkedin.com 
 github      :  https://www.github.com 
 best laptops:  https://www.google.com/search?q=best+laptops 
 Empty input :  Validation error 

Known website names are resolved using predefined mappings. Other single-word inputs are converted into website URLs, while multi-word phrases generate Google search links.

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| SAP BTP ABAP Environment | Cloud development platform |
| ABAP RAP | Transactional application framework |
| CDS View Entities | Data modeling |
| Managed RAP | Business object implementation |
| Draft Handling | Transactional draft processing |
| Behavior Definitions | Business logic declaration |
| Behavior Implementation | Business logic implementation |
| Metadata Extensions | Fiori UI annotations |
| OData V4 | Service exposure |
| SAP Fiori Elements | User interface |
| Eclipse ADT | ABAP development environment |

## 🏗️ Application Architecture

The application follows a layered SAP RAP architecture.

```text
              SAP Fiori Elements UI
                List Report
                Object Page
                      |
                      |
              OData V4 - UI Binding
                 ZUI_WEB_URL_O4
                      |
                      |
               Service Definition
                  ZUI_WEB_URL
                      |
                      |
             Projection CDS Views
          ZC_WEB_URL / ZC_WEB_CAT
                ZC_WEB_HIST
                      |
                      |
              Interface CDS Views
          ZI_WEB_URL / ZI_WEB_CAT
                ZI_WEB_HIST
                      |
                      |
              Database Tables
       ZWEB_URL / ZWEB_URL_D
       ZWEB_CAT / ZWEB_HIST

              RAP Business Logic
           Behavior Definition
           Behavior Implementation
```

### RAP Implementation Components

- Root Interface View: `ZI_WEB_URL`
- Projection View: `ZC_WEB_URL`
- Behavior Definition: `ZI_WEB_URL`
- Behavior Implementation: `ZBP_I_WEB_URL`
- Service Definition: `ZUI_WEB_URL`
- Service Binding: `ZUI_WEB_URL_O4`

## 🗄️ Database Design

The application uses the following database tables:

| Table | Description |
|---|---|
| `ZWEB_URL` | Website master data |
| `ZWEB_URL_D` | Draft table for website records |
| `ZWEB_CAT` | Website category information |
| `ZWEB_HIST` | Website launch-history records |

## 📂 Project Structure

```text
Smart-Web-URL-Launcher/
│
├── README.md
│
├── docs/
│   ├── architecture.md
│   └── database-model.md
│
├── screenshots/
│   ├── 01-list-report.png
│   ├── 02-object-page.png
│   ├── 03-launch-history-tab.png
│   ├── 04-launch-history-list.png
│   ├── 05-duplicate-error.png
│   ├── 06-empty-name-error.png
│   ├── 07-create-with-category.png
│   ├── 08-alias-search.png
│   └── 09-project-explorer.png
│
├── demo/
│   └── demo-video-link.md
│
└── src/
    ├── database/
    ├── cds/
    ├── metadata-extensions/
    ├── behavior/
    ├── classes/
    └── service/
```

## 📸 Application Screenshots

Screenshots demonstrating the application's functionality will be added below.

### 1. Website List Report

![Website List Report](screenshots/01-list-report.png)

### 2. Website Object Page

![Website Object Page](screenshots/02-object-page.png)

### 3. Launch History Tab

![Launch History Tab](screenshots/03-launch-history-tab.png)

### 4. Standalone Launch History

![Launch History List](screenshots/04-launch-history-list.png)

### 5. Duplicate Entry Validation

![Duplicate Error](screenshots/05-duplicate-error.png)

### 6. Mandatory Field Validation

![Empty Name Error](screenshots/06-empty-name-error.png)

### 7. Website Creation with Category

![Create with Category](screenshots/07-create-with-category.png)

### 8. Alias-Based Search

![Alias Search](screenshots/08-alias-search.png)

### 9. SAP Eclipse ADT Project Structure

![Eclipse Project Explorer](screenshots/09-project-explorer.png)

## 🎥 Project Demonstration

A complete video walkthrough demonstrating website creation, URL generation, validations, website launching, and launch-history tracking will be added here.

**Demo Video:** Coming soon.

## 🧪 Testing

The application was tested using manual functional scenarios, including:

- Known website URL generation.
- Unknown website name handling.
- Multi-word search phrase handling.
- Empty website name validation.
- Duplicate website name validation.
- Draft creation and editing.
- Draft discard and resume.
- Favourite and active-status functionality.
- Website launch-count updates.
- Launch-history records.
- Alias-based search.
- Website navigation through clickable URLs.

## 🚀 Future Enhancements

- Enhanced website search capabilities.
- Additional website categories.
- Improved authorization and role management.
- Automated ABAP Unit testing.
- Further UI enhancements.

## 👩‍💻 About the Developer

**Nishita Wani**

SAP Certified Back-End Developer – ABAP Cloud | B.E. Electronics and Computer Engineering | Savitribai Phule Pune University.

Interested in SAP ABAP Cloud, RAP, CDS, OData, SAP BTP, and enterprise application development.

---

⭐ If you find this project interesting, feel free to explore the repository!

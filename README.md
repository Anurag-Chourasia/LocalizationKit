# LocalizationKit

Strongly typed, locale-aware string resolution, dynamic runtime language switching, and String Catalog (.xcstrings) integration for multi-app Swift ecosystems.

![Platform](https://img.shields.io/badge/Platform-iOS%2016.0%2B%20%7C%20macOS%2014.0%2B-blue)
![Swift](https://img.shields.io/badge/Swift-6.0%2B-orange)
![Toolchain](https://img.shields.io/badge/Xcode-27.1-purple)
![CI](https://img.shields.io/badge/CI-Passing-brightgreen)
![SwiftLint](https://img.shields.io/badge/SwiftLint-0.65.1%20Strict-green)
![Version](https://img.shields.io/badge/Release-v0.8.1-blueviolet)
![Zero Dependencies](https://img.shields.io/badge/Dependencies-Zero%20(Pure%20Foundation)-success)
![Languages](https://img.shields.io/badge/Languages-en%20%7C%20fr%20%7C%20ar-informational)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## 1. Executive Summary & Purpose

`LocalizationKit` provides compile-time string safety, multi-language localization, and runtime language selection without requiring an application process restart. It acts as the centralized copy engine across **ShowBook**, **myTV**, and **Motivation Daily**.

### Key Engineering Objectives:
- **Compile-Time Key Safety**: `L10n` accessors eliminate fragile string literals (`NSLocalizedString("...", ...)`), turning missing translation keys into compiler errors.
- **Dynamic In-App Language Switching**: `LocalizationController` allows users to toggle languages (English, French, Arabic) within the app settings, updating all active SwiftUI views instantly.
- **Pure Domain & Zero Visual Coupling**: Pure Swift and Foundation implementation; contains zero UI imports (`UIKit` / `SwiftUI`), allowing it to be safely consumed inside domain layers and use cases.
- **Pluralization & Semantic Error Copy**: Full support for plural rules (`zero`, `one`, `other`), localized network error recovery suggestions, and RTL (Right-to-Left) script direction.

---

## 2. Architecture & Design Principles

```mermaid
flowchart TD
    Consumer["Views, ViewModels & Use Cases"] -->|Typed Key Lookup| L10n["L10n (Type-Safe Enum)"]
    L10n --> Controller["LocalizationController (Runtime Locale State)"]
    Controller --> Provider["LocalizationProviding (Protocol Boundary)"]
    Provider --> Bundle["BundleLocator (SPM & Framework Bundle Resolution)"]
    Provider --> Catalogs["String Catalogs (.xcstrings: en, fr, ar)"]
    Provider --> Plural["Pluralization Engine (zero, one, other)"]
    Provider --> Formatters["LocalizedFormatters (Locale-Aware Interpolation)"]
```

### Architectural Tenets:
1. **Zero External Dependencies (IOS-68)**: Operates strictly on Apple's `Foundation`. Does not couple to external networking, storage, or UI libraries.
2. **Deterministic Fallback Hierarchy**: Resolves translations through active user locale -> base language (English) -> raw key string fallback, preventing unrendered text or application crashes.
3. **Bundle Independence**: Automatically resolves whether resources live inside the main application bundle, a test bundle, or an embedded Swift Package resource bundle.

---

## 3. Dependency Graph & Consumer Matrix

| Direction | Package / Project | Responsibility |
|---|---|---|
| **Upstream Dependencies** | *None* | Zero third-party or internal dependencies. Pure Apple `Foundation`. |
| **Downstream Consumers** | **UIComponentsKit** | Reusable controls (menus, banners, buttons) consume common action labels. |
| | **AuthKit & AuthKitUI** | Authentication notices, password requirements, and session error alerts. |
| | **DeveloperProfileKit** | Biography headers, social link labels, and version disclaimer strings. |
| | **ShowBook** | Book search prompts, catalog filters, reading lists, and Core Data error copy. |
| | **myTV** | Channel directory categories, stream status alerts, and player controls. |
| | **Motivation Daily** | Category titles, share studio actions, and favorite quote persistence alerts. |

---

## 4. API Contracts & Practical Code Examples

### 1. Type-Safe Localized String Resolution
```swift
import SwiftUI
import LocalizationKit

struct ErrorBannerView: View {
    let error: LocalizedError

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(L10n.Common.errorTitle.localized)
                .font(.headline)
            Text(error.localizedDescription)
                .font(.subheadline)
            Text(L10n.Common.retryAction.localized)
                .font(.caption)
        }
    }
}
```

### 2. Plural-Aware Count Formatting
```swift
import LocalizationKit

// Automatically formats grammatically correct strings:
// "0 books found", "1 book found", "42 books found"
let message = L10n.Catalog.booksCount(42).localized
```

### 3. Dynamic Runtime Language Switching
```swift
import SwiftUI
import LocalizationKit

struct LanguagePickerView: View {
    @ObservedObject var controller = LocalizationController.shared

    var body: some View {
        Picker("Language", selection: $controller.currentLocale) {
            Text("English").tag(Locale(identifier: "en"))
            Text("Français").tag(Locale(identifier: "fr"))
            Text("العربية").tag(Locale(identifier: "ar"))
        }
        .pickerStyle(.segmented)
    }
}
```

---

## 5. Verification & Testing

```sh
# Run string catalog resolution, pluralization, and RTL tests
swift test

# Validate that no UI frameworks are imported in LocalizationKit
python3 /path/to/UIComponentsKit/Scripts/check_architecture.py --workspace-root /path/to/Projects
```

---

## 6. End-to-End Ecosystem Connectivity

```mermaid
graph TD
    subgraph CoreServices ["Shared Core Services (SPMs)"]
        FoundationKit["FoundationKit<br/>(System Clock, Unified Logging, Thread Safety)"]
        LocalisationKit["LocalisationKit<br/>(Typed Strings, Pluralization, String Catalogs)"]
        DesignTokensKit["DesignTokensKit<br/>(BrandPalettes, ColorTheme, Typography, Metrics, SF Symbols)"]
        CommonNetworkingKit["CommonNetworkingKit<br/>(HTTPClient, URLSession, RequestBuilder, Interceptors)"]
        AppStubData["AppStubData<br/>(Synthetic Fixtures, Offline Catalogs, Test Scenarios)"]
    end

    subgraph UIServices ["Shared Presentation & Auth (SPMs)"]
        UIComponentsKit["UIComponentsKit<br/>(CatalogTile, SurfaceCard, StateMessage, Recipes)"]
        AuthKit["AuthKit & AuthKitUI<br/>(SessionManager, AppAuthGate, AccountToolbarItem)"]
        DeveloperProfileKit["DeveloperProfileKit<br/>(DeveloperProfileView, Runtime Overlays)"]
        SnapshotTestingKit["SnapshotTestingKit<br/>(Subpixel Comparison, Golden Baseline Engine)"]
    end

    subgraph HostApps ["Host Applications"]
        ShowBook["ShowBook<br/>(Book Discovery, Core Data Persistence, Open Library)"]
        MyTV["myTV<br/>(IPTV Browser, AVPlayer Lifecycle, Directory Cache)"]
        MotivationDaily["Motivation Daily<br/>(Card Feed, Quote Persistence, Image Export Studio)"]
    end

    subgraph QualityGates ["CI/CD Automation & Tooling"]
        ArchitectureGuard["check_architecture.py<br/>(Boundary Enforcement, Zero Token Leakage)"]
        SnapshotVerifier["verify-snapshot-baselines.py<br/>(Visual Regression Gate)"]
        GHActions["GitHub Actions CI<br/>(Fast Lane, Smoke Lane, Release Build Verification)"]
    end

    %% Dependencies between Shared SPMs
    DesignTokensKit --> UIComponentsKit
    LocalisationKit --> UIComponentsKit
    DesignTokensKit --> AuthKit
    UIComponentsKit --> AuthKit
    FoundationKit --> CommonNetworkingKit
    DesignTokensKit --> DeveloperProfileKit
    UIComponentsKit --> DeveloperProfileKit
    LocalisationKit --> DeveloperProfileKit

    %% Dependencies from Host Apps to Shared SPMs
    DesignTokensKit --> ShowBook
    UIComponentsKit --> ShowBook
    AuthKit --> ShowBook
    CommonNetworkingKit --> ShowBook
    DeveloperProfileKit --> ShowBook
    AppStubData --> ShowBook

    DesignTokensKit --> MyTV
    UIComponentsKit --> MyTV
    AuthKit --> MyTV
    CommonNetworkingKit --> MyTV
    DeveloperProfileKit --> MyTV
    AppStubData --> MyTV

    DesignTokensKit --> MotivationDaily
    UIComponentsKit --> MotivationDaily
    AuthKit --> MotivationDaily
    CommonNetworkingKit --> MotivationDaily
    DeveloperProfileKit --> MotivationDaily
    AppStubData --> MotivationDaily

    %% Testing & Verification Linkage
    SnapshotTestingKit -.-> ShowBook
    SnapshotTestingKit -.-> MyTV
    SnapshotTestingKit -.-> MotivationDaily

    ArchitectureGuard --> HostApps
    ArchitectureGuard --> CoreServices
    ArchitectureGuard --> UIServices
    SnapshotVerifier --> SnapshotTestingKit
    GHActions --> HostApps
    GHActions --> UIServices
    GHActions --> CoreServices
```

---

## 7. Canonical Notion Dashboards & Governance Links

- [iOS Portfolio — Engineering Tickets Dashboard](https://app.notion.com/p/c20d7f4b133b44499c8ac0b4d5f6249e?pvs=204)
- [iOS Portfolio — Master Document](https://app.notion.com/p/40ffa5f855b98192ad2ede66a5d36fe7)
- [Architecture Boundary Validator (`check_architecture.py`)](file:///Users/anuragchourasia/Desktop/Projects/UIComponentsKit/Scripts/check_architecture.py)
- [Release & Gate Policy Documentation (`Docs/MASTER.md`)](file:///Users/anuragchourasia/Desktop/Projects/Docs/MASTER.md)

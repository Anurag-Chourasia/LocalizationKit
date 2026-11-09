# Changelog

## 0.9.0

- Enforce Ecosystem Architectural Governance Specification requirements across all localization interfaces:
  - KeyPath-first SwiftUI ergonomics: zero raw strings in consumer views; direct KeyPath access for `Text`, `Button`, `LabeledContent`, controls, and accessibility modifiers.
  - Complete 503-key master catalog across `en`, `fr`, and `ar` with full domain coverage for shared kits (`AuthKitUI`, `DeveloperProfileKit`, `UIComponentsKit`) and host applications (`myTV`, `ShowBook`, `Motivation Daily`).
  - Added the 5 mandatory ecosystem governance custom SwiftLint rules (`ban_hardcoded_view_strings`, `ban_hardcoded_padding`, `ban_hardcoded_corner_radius`, `ban_direct_supabase_import`, `ban_ui_in_domain_and_data`) with 0 violations.
  - Achieved strict 100.0% line and region test coverage gate across all package sources (`2141/2141` lines, `811/811` functions).
  - Verified Swift 6 complete concurrency compliance under `-strict-concurrency=complete -warnings-as-errors`.

## 0.8.0

- Centralize shared UI copy for `AuthKitUI` (sign-in unavailable screen, brand subtitles, provider sign-in buttons), `DeveloperProfileKit` (`profile.*`), and `UIComponentsKit` (`common.layout.*`), plus `ShowBook` profile disclaimer (`showbook.profile.disclaimer`) across `en`, `fr`, and `ar` catalogs (`IOS-59`).
- Expose `L10n.Profile`, `L10n.Layout`, and new `L10n.Auth` typed accessors.

## 0.7.0

- Add canonical `en`, `fr`, and `ar` localization catalogs and strongly-typed accessors for semantic `AuthKit` session notices, `Motivation Daily` `AppError` / recovery suggestion states, and `ShowBook` `NetworkClass` semantic errors (`IOS-58`).
- Expose `LocalizedContext.string(_:arguments:)` for locale-aware parameter formatting across domain contexts.

## 0.6.5

- Standardize `Scripts/generate-localization.py` as the single canonical localization code generator and retire the redundant `swiftgen.yml` configuration.
- Generate `Sources/LocalizationKit/Strings/Generated/GeneratedStrings.swift` deterministically from the package's `.lproj` resources (`en`, `fr`, `ar`).
- Add regression tests verifying deterministic `GeneratedStrings` generation and single-generator ownership.

## 0.2.0

- Add Arabic (ar) localization and runtime right-to-left (RTL) layout direction detection.
- Add comprehensive account, authentication, and recoverable error strings in en, fr, and ar.
- Provide strongly-typed accessors in `L10n.Auth`, `L10n.Account`, and `L10n.Errors`.
- Register `ar` in `GeneratedStrings.supportedLocales`.

## 0.1.1 — candidate

- Add MIT license and strict Xcode 27.0 CI with read-only private dependency access.
- Keep localization API, resources, fallback and simple pluralization unchanged.

## 0.1.0

- Initial tagged runtime localization library.

# Changelog

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

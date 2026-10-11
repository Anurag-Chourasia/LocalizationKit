# LocalizationKit

Typed localization access and locale-aware string resolution for the portfolio apps.

## Purpose

- Typed access through `L10n`
- Locale-aware string lookup with fallback behavior
- Runtime locale switching through `LocalizationController`
- Basic interpolation and pluralization helpers

## Dependency Rules

- `LocalizationKit` depends only on `FoundationKit`
- Views and view models should use typed `L10n` accessors instead of raw keys
- User-facing errors should map to localization keys, not `localizedDescription`

## Public API

- `LocalizationProviding`
- `LocalizationController`
- `BundleLocator`
- `L10n`
- `Pluralization`
- `LocalizedFormatters`

## Test Notes

- Tests use package resources for English and French localizations
- Fallback behavior is verified with missing translations
- Runtime locale switching is covered through controller tests

## Compatibility boundaries

The controller reads Localizable.strings only; it does not support arbitrary tables or stringsdict. Plural suffixes are zero/one/other, not a complete locale plural engine. setLocale affects later lookups but does not publish SwiftUI observation updates. Do not replace existing app localization pipelines without behavior tests. Resource ownership stays with the caller-supplied bundle.

Declared iOS 16 and macOS 14. Validated development baseline: Xcode 27.0 (27A266a), Swift 6.4. Host tests and generic simulator build do not establish minimum-OS runtime support. CI needs FOUNDATIONKIT_DEPLOY_KEY, a read-only FoundationKit deploy key. Fork PRs cannot run the credential-dependent job; maintainers must review and run trusted code. No personal token is stored.

Owner: Anurag Chourasia. New APIs need concrete consumers, tests, public documentation and explicit compatibility intent. MIT, Copyright (c) 2026 Anurag Chourasia. Never move published tags.

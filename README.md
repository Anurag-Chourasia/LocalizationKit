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

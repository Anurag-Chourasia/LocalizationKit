#!/usr/bin/env python3
"""
generate-localization.py
Automated Localization Code Generator & L10n Synchronizer for LocalizationKit.

Workflow:
1. Developer edits or adds keys in `en.lproj/Localizable.strings`.
2. This script:
   - Parses `en.lproj/Localizable.strings`.
   - Automatically synchronizes all other `*.lproj/Localizable.strings` (fr, ar, etc.),
     preserving existing translations and adding missing keys.
   - Categorizes keys into domains: Motivation, MyTV, ShowBook, and Common.
   - Generates strongly-typed Domain structs:
     - MotivationStrings.swift
     - MyTVStrings.swift
     - ShowBookStrings.swift
   - Generates LocalizedContext.swift with:
     - CommonStrings
     - Dynamic member lookup & direct KeyPath subscripts: `l10n[\.key]`
     - Direct KeyPath SwiftUI initializers:
       - `Text(\.key)`
       - `Button(\.key) { ... }`
       - `String(\.key)`
   - Optionally invokes SwiftGen if installed.
"""

import os
import re
import sys
import subprocess
from pathlib import Path

# Mapping of custom property names when standard camelCase doesn't match existing naming
CUSTOM_PROPERTY_MAPPINGS = {
    # Motivation
    "motivation.app.name": "appName",
    "motivation.favourites.title": "favourites",
    "motivation.about.developer": "aboutDeveloper",
    "motivation.favourites.clear_all": "clearAll",
    "motivation.favourites.remove": "removeFavorite",
    "motivation.favourites.empty_title": "emptyFavoritesTitle",
    "motivation.favourites.empty_message": "emptyFavoritesMessage",
    "motivation.image.not_available": "imageNotAvailable",
    "motivation.share.preparing_image": "preparingImage",
    "motivation.share.preview_title": "previewShareTitle",
    "motivation.share.quote_and_image": "shareQuoteAndImage",
    "motivation.share.quote_embedded_subtitle": "quoteEmbeddedInImage",
    "motivation.share.image_only": "shareImageOnly",
    "motivation.share.wallpaper_background_subtitle": "wallpaperBackgroundOnly",
    "motivation.share.save_to_photos": "saveToPhotos",
    "motivation.share.choose_what_to_save": "chooseWhatToSave",
    "motivation.share.quote_only": "shareQuoteOnly",
    "motivation.share.black_gradient_subtitle": "blackGradientBackground",
    "motivation.share.copy_quote": "copyQuote",
    "motivation.share.paste_anywhere": "pasteAnywhere",
    "motivation.share.copied_toast": "quoteCopiedToast",
    "motivation.photos.access_message": "photosAccessAlertMessage",
    "motivation.photos.open_settings": "openSettings",
    "motivation.share.save_only_image": "saveOnlyImage",
    "motivation.share.save_image_plus_quote": "saveImagePlusQuote",
    "motivation.share.save_quote_gradient": "saveQuoteGradient",
    "motivation.category.random": "randomCategory",
    "motivation.share.copied": "copied",
    "motivation.photos.access_title": "photosAccessAlertTitle",
    "motivation.share.image_failed_title": "shareImageFailed",
    "motivation.share.image_failed_message": "shareImageFailedMessage",
    "motivation.photos.permission_required_title": "permissionRequired",
    "motivation.photos.permission_required_message": "permissionRequiredPhotosMessage",
    "motivation.share.saved_title": "saved",
    "motivation.share.saved_message": "imageSavedToPhotos",
    "motivation.share.save_failed_title": "saveFailed",
    "motivation.share.save_failed_message": "couldNotSaveImage",

    # MyTV
    "app.name": "appName",
    "app.cancel": "cancel",
    "app.retry": "retry",
    "app.ok": "ok",
    "app.grouping.name": "groupingName",
    "app.grouping.country": "groupingCountry",
    "app.grouping.category": "groupingCategory",
    "app.offline.banner": "offlineBanner",
    "app.showLess": "showLess",
    "app.readMore": "readMore",
    "app.appearance.color.system": "appearanceSystem",
    "app.appearance.color.light": "appearanceLight",
    "app.appearance.color.dark": "appearanceDark",
    "app.search": "search",
    "app.apply": "apply",
    "loading.preparing.stream": "preparingStream",
    "channel.scope.all": "allChannels",
    "channel.scope.favorites": "favorites",
    "channel.empty.title": "noChannelsTitle",
    "channel.empty.message": "noChannelsMessage",
    "channel.no.results.title": "noResultsTitle",
    "channel.no.results.message": "noResultsMessage",
    "channel.layout.list": "layoutList",
    "channel.layout.grid": "layoutGrid",
    "channel.layout.title": "layoutTitle",
    "channel.layout.grid.unavailable.title": "layoutUnavailableTitle",
    "channel.layout.grid.unavailable.message": "layoutUnavailableMessage",
    "channel.layout.grid.unavailable.banner": "layoutUnavailableBanner",
    "channel.layout.grid.unavailable.ok": "layoutUnavailableOk",
    "channel.layout.grid.auto_list.title": "layoutAutoListTitle",
    "channel.layout.grid.auto_list.message": "layoutAutoListMessage",
    "channel.layout.grid.auto_list.ok": "layoutAutoListOk",
    "channel.alert.clear.cache.title": "clearCacheAlertTitle",
    "channel.alert.clear.cache.confirm": "clearCacheConfirm",
    "channel.alert.clear.filters.title": "clearFiltersAlertTitle",
    "channel.alert.clear.filters.confirm": "clearFiltersConfirm",
    "channel.alert.remove.favorites.title": "removeFavoritesAlertTitle",
    "channel.alert.remove.favorites.confirm": "removeFavoritesConfirm",
    "channel.menu.section.sortAndFilter.title": "sortAndFilterTitle",
    "channel.menu.section.group_by.title": "sectionGroupBy",
    "channel.menu.section.sorting.title": "sectionSorting",
    "channel.menu.section.Filter.title": "sectionFilter",
    "channel.menu.section.section.title": "sectionTitle",
    "channel.menu.section.channel.title": "channelTitle",
    "channel.menu.section.actions": "actionsTitle",
    "channel.menu.section.layout": "layoutMenuTitle",
    "channel.menu.section.appearance": "appearanceMenuTitle",
    "channel.menu.section.about": "aboutMenuTitle",
    "channel.menu.action.clearCache": "clearCacheAction",
    "channel.menu.action.clearFilters": "clearFiltersAction",
    "channel.menu.action.removeFavorites": "removeFavoritesAction",
    "channel.sort.order.ascending": "sortAscending",
    "channel.sort.order.descending": "sortDescending",
    "channel.filter.countries": "countries",
    "channel.filter.categories": "categories",
    "multiSelectView.section.selected": "multiSelectSelected",
    "multiSelectView.section.all": "multiSelectAll",
    "stream.list.empty.title": "streamListEmptyTitle",
    "stream.list.empty.message": "streamListEmptyMessage",
    "stream.player.error.title": "playbackErrorTitle",
    "stream.player.error.noWorkingStreams": "noWorkingStreams",
    "stream.player.error.invalidURL": "invalidStreamURL",
    "stream.player.error.cannotPlay": "cannotPlayStream",
    "stream.player.error.failed": "playbackFailed",
    "about.title": "aboutTitle",
    "about.disclaimer.title": "aboutDisclaimerTitle",
    "about.disclaimer.text": "aboutDisclaimerText",
    "about.alert.error.title": "aboutAlertErrorTitle",
    "about.alert.error.ok": "aboutAlertErrorOk",
    "about.alert.error.invalidLink": "aboutAlertErrorInvalidLink",
    "about.app.info.title": "aboutAppInfoTitle",
    "about.app.name": "aboutAppName",
    "about.app.version.prefix": "aboutAppVersionPrefix",
    "about.social.title": "aboutSocialTitle",
    "a11y.menu.options": "a11yMenuOptions",
    "a11y.menu.options.hint": "a11yMenuOptionsHint",
    "a11y.favorite.add": "a11yFavoriteAdd",
    "a11y.favorite.remove": "a11yFavoriteRemove",
    "a11y.favorite.hint": "a11yFavoriteHint",
    "a11y.channel.open.hint": "a11yChannelOpenHint",
    "a11y.stream.play.hint": "a11yStreamPlayHint",
    "a11y.openLink.hint": "a11yOpenLinkHint",
    "a11y.selected": "a11ySelected",

    # ShowBook
    "showbook.app.name": "appName",
    "showbook.discover.title": "discover",
    "showbook.discover.subtitle": "discoverSubtitle",
    "showbook.discover.unavailable": "discoverUnavailable",
    "showbook.discover.no_books": "noBooksCategory",
    "showbook.saved_books.title": "savedBooks",
    "showbook.search.placeholder": "searchForBooks",
    "showbook.search.keep_typing": "searchKeepTyping",
    "showbook.search.start_searching": "searchStartSearching",
    "showbook.search.no_books_found": "searchNoBooksFound",
    "showbook.search.unable_to_search": "searchUnableToSearch",
    "showbook.search.connection_error": "searchConnectionError",
    "showbook.search.minimum_characters": "searchMinimumCharacters",
    "showbook.sort.by": "sortBy",
    "showbook.loading.more": "loadingMore",
    "showbook.loading.progress": "loadingProgress",
    "showbook.details.editions": "editions",
    "showbook.details.edition_details": "editionDetails",
    "showbook.details.no_editions": "noEditions",
    "showbook.details.not_rated": "notRated",
    "showbook.details.preview_cover": "previewCover",
    "showbook.details.share_cover": "shareCover",
    "showbook.details.cover_unavailable": "coverUnavailable",
    "showbook.details.close_cover_preview": "closeCoverPreview",
    "showbook.details.loading_details": "loadingBookDetails",
    "showbook.details.loading_editions": "loadingEditions",
    "showbook.details.load_more_editions": "loadMoreEditions",
    "showbook.details.retry_editions": "retryEditions",
    "showbook.details.title": "bookDetailsTitle",
    "showbook.details.edition_details_title": "editionDetailsTitle",
    "showbook.details.description": "description",
    "showbook.details.no_description": "noDescription",
    "showbook.details.first_published": "firstPublished",
    "showbook.details.subjects": "subjects",
    "showbook.details.published": "published",
    "showbook.details.publisher": "publisher",
    "showbook.details.format": "format",
    "showbook.details.pages": "pages",
    "showbook.details.isbn13": "isbn13",
    "showbook.details.isbn10": "isbn10",
    "showbook.details.languages": "languages",
    "showbook.menu.app_options": "appOptions",
    "showbook.menu.appearance": "appearance",
    "showbook.appearance.light": "light",
    "showbook.appearance.dark": "dark",
    "showbook.menu.know_developer": "knowYourDeveloper",
    "showbook.logout.confirmation_title": "logoutConfirmationTitle",
    "showbook.logout.action": "logout",

    # Common
    "common.ok": "ok",
    "common.cancel": "cancel",
    "common.yes": "yes",
    "common.no": "no",
    "common.clear": "clear",
    "common.share": "share",
    "common.close": "close",
    "common.welcome": "welcome",
    "common.error": "error",
    "account.done": "done",
    "errors.recoverable_retry": "retry",
    "errors.recoverable_dismiss": "dismiss",
    "errors.generic": "errorGeneric",
}


def parse_strings_file(path: Path):
    """
    Parses a .strings file into a list of (comment, key, value) tuples
    and a dict of key -> value.
    """
    entries = []
    key_value_map = {}
    if not path.exists():
        return entries, key_value_map

    content = path.read_text(encoding="utf-8")
    # Match entries of form: "key" = "value"; optionally preceded by comments
    pattern = re.compile(r'(?:(/\*.*?\*/|//[^\n]*)\s*)?"((?:[^"\\]|\\.)+)"\s*=\s*"((?:[^"\\]|\\.)*)";', re.DOTALL)
    for match in pattern.finditer(content):
        comment = match.group(1) or ""
        key = match.group(2)
        val = match.group(3)
        entries.append((comment.strip(), key, val))
        key_value_map[key] = val
    return entries, key_value_map


def key_to_camel_case(key: str) -> str:
    if key in CUSTOM_PROPERTY_MAPPINGS:
        return CUSTOM_PROPERTY_MAPPINGS[key]
    parts = re.split(r'[._\-]', key)
    # Filter out empty parts
    parts = [p for p in parts if p]
    if not parts:
        return key
    # If the first part is a known domain prefix, strip it unless needed
    if parts[0].lower() in ("motivation", "showbook", "common") and len(parts) > 1:
        parts = parts[1:]
    return parts[0].lower() + "".join(word.capitalize() for word in parts[1:])


def sync_locale_file(en_entries, target_path: Path):
    """
    Synchronizes target_path with en_entries:
    Preserves existing translations and appends/inserts missing keys.
    """
    _, target_map = parse_strings_file(target_path)
    
    lines = []
    current_section = None
    
    for comment, key, en_val in en_entries:
        target_val = target_map.get(key, en_val)
        if comment:
            lines.append(f"{comment}")
        # Escape quotes in key/val
        lines.append(f'"{key}" = "{target_val}";')
        lines.append("")

    content = "\n".join(lines).strip() + "\n"
    target_path.write_text(content, encoding="utf-8")
    # Clean xattrs to prevent macOS code signing detritus
    os.system(f"xattr -c '{target_path}' 2>/dev/null || true")


def categorize_keys(en_entries):
    motivation_props = []
    mytv_props = []
    showbook_props = []
    common_props = []

    seen_props = {
        "motivation": set(),
        "mytv": set(),
        "showbook": set(),
        "common": set()
    }

    for comment, key, val in en_entries:
        prop_name = key_to_camel_case(key)
        
        if key.startswith("motivation."):
            if prop_name not in seen_props["motivation"]:
                motivation_props.append((prop_name, key, comment, val))
                seen_props["motivation"].add(prop_name)
        elif key.startswith("showbook."):
            if prop_name not in seen_props["showbook"]:
                showbook_props.append((prop_name, key, comment, val))
                seen_props["showbook"].add(prop_name)
        elif key.startswith(("channel.", "app.", "stream.", "about.", "a11y.", "multiSelectView.", "loading.")):
            if prop_name not in seen_props["mytv"]:
                mytv_props.append((prop_name, key, comment, val))
                seen_props["mytv"].add(prop_name)
        else:
            if prop_name not in seen_props["common"]:
                common_props.append((prop_name, key, comment, val))
                seen_props["common"].add(prop_name)

    return motivation_props, mytv_props, showbook_props, common_props


def generate_domain_file(struct_name: str, props, output_path: Path):
    lines = [
        "import Foundation",
        "",
        f"public struct {struct_name}: Sendable {{",
        "    private let provider: LocalizationProviding",
        "",
        "    public init(provider: LocalizationProviding) {",
        "        self.provider = provider",
        "    }",
        ""
    ]

    for prop_name, key, comment, val in props:
        if comment:
            lines.append(f"    {comment}")
        lines.append(f'    public var {prop_name}: String {{')
        lines.append(f'        provider.string("{key}")')
        lines.append('    }')
        lines.append("")

    lines.append("}")
    output_path.write_text("\n".join(lines).strip() + "\n", encoding="utf-8")
    os.system(f"xattr -c '{output_path}' 2>/dev/null || true")


def generate_localized_context_file(common_props, output_path: Path):
    lines = [
        "import SwiftUI",
        "import Foundation",
        "",
        "// MARK: - Scoped Localized Context with KeyPath Subscripts",
        "",
        "@dynamicMemberLookup",
        "public struct LocalizedContext<Domain: LocalizationDomain>: Sendable {",
        "    public let provider: LocalizationProviding",
        "    public let domain: Domain.Strings",
        "",
        "    public init(provider: LocalizationProviding) {",
        "        self.provider = provider",
        "        if Domain.self == MotivationDomain.self {",
        "            self.domain = MotivationStrings(provider: provider) as! Domain.Strings",
        "        } else if Domain.self == MyTVDomain.self {",
        "            self.domain = MyTVStrings(provider: provider) as! Domain.Strings",
        "        } else if Domain.self == ShowBookDomain.self {",
        "            self.domain = ShowBookStrings(provider: provider) as! Domain.Strings",
        "        } else {",
        '            fatalError("Unsupported LocalizationDomain: \\(Domain.self)")',
        "        }",
        "    }",
        "",
        "    public var common: CommonStrings {",
        "        CommonStrings(provider: provider)",
        "    }",
        "",
        "    public func string(_ key: String) -> String {",
        "        provider.string(key)",
        "    }",
        "",
        "    // Direct KeyPath Subscripts: l10n[\\.key]",
        "    public subscript(keyPath: KeyPath<Domain.Strings, String>) -> String {",
        "        domain[keyPath: keyPath]",
        "    }",
        "",
        "    public subscript(keyPath: KeyPath<CommonStrings, String>) -> String {",
        "        common[keyPath: keyPath]",
        "    }",
        "",
        "    // Dynamic Member Lookup: l10n.key",
        "    public subscript(dynamicMember keyPath: KeyPath<Domain.Strings, String>) -> String {",
        "        domain[keyPath: keyPath]",
        "    }",
        "",
        "    public static var shared: LocalizedContext<Domain> {",
        "        LocalizedContext<Domain>(provider: LocalizationController.shared)",
        "    }",
        "}",
        "",
        "// MARK: - Common Shared Strings",
        "",
        "public struct CommonStrings: Sendable {",
        "    private let provider: LocalizationProviding",
        "",
        "    public init(provider: LocalizationProviding) {",
        "        self.provider = provider",
        "    }",
        "",
        "    public static var shared: CommonStrings {",
        "        CommonStrings(provider: LocalizationController.shared)",
        "    }",
        ""
    ]

    for prop_name, key, comment, val in common_props:
        lines.append(f'    public var {prop_name}: String {{ provider.string("{key}") }}')

    lines.extend([
        "}",
        "",
        "// MARK: - SwiftUI KeyPath Text Initializers",
        "",
        "extension Text {",
        "    /// Initialize with a direct Motivation keypath: `Text(\\.imageNotAvailable)`",
        "    public init(_ keyPath: KeyPath<MotivationStrings, String>, in context: LocalizedContext<MotivationDomain> = .shared) {",
        "        self.init(context[keyPath])",
        "    }",
        "",
        "    /// Initialize with a direct MyTV keypath: `Text(\\.allChannels)`",
        "    public init(_ keyPath: KeyPath<MyTVStrings, String>, in context: LocalizedContext<MyTVDomain> = .shared) {",
        "        self.init(context[keyPath])",
        "    }",
        "",
        "    /// Initialize with a direct ShowBook keypath: `Text(\\.searchKeepTyping)`",
        "    public init(_ keyPath: KeyPath<ShowBookStrings, String>, in context: LocalizedContext<ShowBookDomain> = .shared) {",
        "        self.init(context[keyPath])",
        "    }",
        "",
        "    /// Initialize with a direct Common keypath: `Text(\\.share)` or `Text(\\.ok)`",
        "    public init(_ keyPath: KeyPath<CommonStrings, String>, in context: CommonStrings = .shared) {",
        "        self.init(context[keyPath: keyPath])",
        "    }",
        "",
        "    /// Initialize with explicit context: `Text(\\.previewShareTitle, in: l10n)`",
        "    public init<Domain: LocalizationDomain>(_ keyPath: KeyPath<Domain.Strings, String>, in l10n: LocalizedContext<Domain>) {",
        "        self.init(l10n[keyPath])",
        "    }",
        "",
        "    /// Initialize with explicit common context: `Text(\\.share, in: l10n)`",
        "    public init<Domain: LocalizationDomain>(_ keyPath: KeyPath<CommonStrings, String>, in l10n: LocalizedContext<Domain>) {",
        "        self.init(l10n[keyPath])",
        "    }",
        "}",
        "",
        "// MARK: - SwiftUI KeyPath Button Initializers",
        "",
        "extension Button where Label == Text {",
        "    public init(_ keyPath: KeyPath<CommonStrings, String>, action: @escaping () -> Void) {",
        "        self.init(action: action) {",
        "            Text(keyPath)",
        "        }",
        "    }",
        "",
        "    public init(_ keyPath: KeyPath<MotivationStrings, String>, action: @escaping () -> Void) {",
        "        self.init(action: action) {",
        "            Text(keyPath)",
        "        }",
        "    }",
        "",
        "    public init(_ keyPath: KeyPath<MyTVStrings, String>, action: @escaping () -> Void) {",
        "        self.init(action: action) {",
        "            Text(keyPath)",
        "        }",
        "    }",
        "",
        "    public init(_ keyPath: KeyPath<ShowBookStrings, String>, action: @escaping () -> Void) {",
        "        self.init(action: action) {",
        "            Text(keyPath)",
        "        }",
        "    }",
        "}",
        "",
        "// MARK: - KeyPath String Convenience Initializers",
        "",
        "extension String {",
        "    public init(_ keyPath: KeyPath<MotivationStrings, String>, in context: LocalizedContext<MotivationDomain> = .shared) {",
        "        self = context[keyPath]",
        "    }",
        "",
        "    public init(_ keyPath: KeyPath<MyTVStrings, String>, in context: LocalizedContext<MyTVDomain> = .shared) {",
        "        self = context[keyPath]",
        "    }",
        "",
        "    public init(_ keyPath: KeyPath<ShowBookStrings, String>, in context: LocalizedContext<ShowBookDomain> = .shared) {",
        "        self = context[keyPath]",
        "    }",
        "",
        "    public init(_ keyPath: KeyPath<CommonStrings, String>, in context: CommonStrings = .shared) {",
        "        self = context[keyPath: keyPath]",
        "    }",
        "}",
        "",
        "// MARK: - Environment Keys for Scoped Domains",
        "",
        "private struct MotivationL10nKey: EnvironmentKey {",
        "    static let defaultValue: LocalizedContext<MotivationDomain> = LocalizedContext(provider: LocalizationController())",
        "}",
        "",
        "private struct MyTVL10nKey: EnvironmentKey {",
        "    static let defaultValue: LocalizedContext<MyTVDomain> = LocalizedContext(provider: LocalizationController())",
        "}",
        "",
        "private struct ShowBookL10nKey: EnvironmentKey {",
        "    static let defaultValue: LocalizedContext<ShowBookDomain> = LocalizedContext(provider: LocalizationController())",
        "}",
        "",
        "extension EnvironmentValues {",
        "    public var motivationL10n: LocalizedContext<MotivationDomain> {",
        "        get { self[MotivationL10nKey.self] }",
        "        set { self[MotivationL10nKey.self] = newValue }",
        "    }",
        "",
        "    public var myTVL10n: LocalizedContext<MyTVDomain> {",
        "        get { self[MyTVL10nKey.self] }",
        "        set { self[MyTVL10nKey.self] = newValue }",
        "    }",
        "",
        "    public var showBookL10n: LocalizedContext<ShowBookDomain> {",
        "        get { self[ShowBookL10nKey.self] }",
        "        set { self[ShowBookL10nKey.self] = newValue }",
        "    }",
        "}",
        "",
        "// MARK: - View Extension to Inject Domain L10n",
        "",
        "extension View {",
        "    public func localizedContext<Domain: LocalizationDomain>(",
        "        _ context: LocalizedContext<Domain>",
        "    ) -> some View {",
        "        Group {",
        "            if let motivationContext = context as? LocalizedContext<MotivationDomain> {",
        "                self.environment(\\.motivationL10n, motivationContext)",
        "            } else if let myTVContext = context as? LocalizedContext<MyTVDomain> {",
        "                self.environment(\\.myTVL10n, myTVContext)",
        "            } else if let showBookContext = context as? LocalizedContext<ShowBookDomain> {",
        "                self.environment(\\.showBookL10n, showBookContext)",
        "            } else {",
        "                self",
        "            }",
        "        }",
        "    }",
        "}"
    ])

    output_path.write_text("\n".join(lines).strip() + "\n", encoding="utf-8")
    os.system(f"xattr -c '{output_path}' 2>/dev/null || true")


def main():
    script_dir = Path(__file__).resolve().parent
    repo_root = script_dir.parent
    resources_dir = repo_root / "Sources" / "LocalizationKit" / "Resources"
    domains_dir = repo_root / "Sources" / "LocalizationKit" / "Domains"

    en_path = resources_dir / "en.lproj" / "Localizable.strings"
    if not en_path.exists():
        print(f"Error: en.lproj file not found at {en_path}", file=sys.stderr)
        sys.exit(1)

    print(f"==> 1. Reading master English strings: {en_path.relative_to(repo_root)}")
    en_entries, _ = parse_strings_file(en_path)
    print(f"    Found {len(en_entries)} keys in en.lproj")

    print("==> 2. Synchronizing other locale files (*.lproj)...")
    for lproj in resources_dir.glob("*.lproj"):
        if lproj.name == "en.lproj":
            continue
        strings_file = lproj / "Localizable.strings"
        sync_locale_file(en_entries, strings_file)
        print(f"    Synced {strings_file.relative_to(repo_root)}")

    print("==> 3. Categorizing keys into domains...")
    motivation_props, mytv_props, showbook_props, common_props = categorize_keys(en_entries)
    print(f"    Motivation: {len(motivation_props)} properties")
    print(f"    MyTV:       {len(mytv_props)} properties")
    print(f"    ShowBook:   {len(showbook_props)} properties")
    print(f"    Common:     {len(common_props)} properties")

    print("==> 4. Generating strongly-typed Swift code...")
    domains_dir.mkdir(parents=True, exist_ok=True)
    generate_domain_file("MotivationStrings", motivation_props, domains_dir / "MotivationStrings.swift")
    generate_domain_file("MyTVStrings", mytv_props, domains_dir / "MyTVStrings.swift")
    generate_domain_file("ShowBookStrings", showbook_props, domains_dir / "ShowBookStrings.swift")
    generate_localized_context_file(common_props, domains_dir / "LocalizedContext.swift")
    print("    Generated MotivationStrings.swift")
    print("    Generated MyTVStrings.swift")
    print("    Generated ShowBookStrings.swift")
    print("    Generated LocalizedContext.swift")

    # Optional SwiftGen invocation if installed
    swiftgen_path = subprocess.run(["which", "swiftgen"], capture_output=True, text=True).stdout.strip()
    if swiftgen_path:
        print(f"==> 5. SwiftGen detected at {swiftgen_path}. Running swiftgen config...")
        swiftgen_yml = repo_root / "swiftgen.yml"
        if swiftgen_yml.exists():
            subprocess.run(["swiftgen", "config", "run", "--config", str(swiftgen_yml)], cwd=str(repo_root))
    else:
        print("==> 5. SwiftGen CLI not installed in PATH (skipping external swiftgen command; Swift code generated directly).")

    print("==> Localization code generation & sync completed successfully! ✨")


if __name__ == "__main__":
    main()

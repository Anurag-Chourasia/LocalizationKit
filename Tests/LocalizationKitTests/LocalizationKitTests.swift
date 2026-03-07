import Foundation
import XCTest
@testable import LocalizationKit

final class LocalizationKitTests: XCTestCase {
    private var temporaryDirectories: [URL] = []

    override func tearDownWithError() throws {
        let fileManager = FileManager.default
        for directory in temporaryDirectories {
            try? fileManager.removeItem(at: directory)
        }
        temporaryDirectories.removeAll()
        try super.tearDownWithError()
    }

    func testStringLookupUsesInitialLocale() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "fr"))

        XCTAssertEqual(controller.string("common.cancel"), "Annuler")
        XCTAssertEqual(L10n.Errors.generic(using: controller), "Une erreur est survenue")
    }

    func testStringLookupFallsBackToEnglishWhenTranslationIsMissing() {
        let controller = LocalizationController(
            initialLocale: Locale(identifier: "fr"),
            fallbackLocale: Locale(identifier: "en")
        )

        XCTAssertEqual(controller.pluralizedString("errors.retry_count", count: 0), "No retries left")
    }

    func testMissingKeyFallsBackToTheKeyItself() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))

        XCTAssertEqual(controller.string("missing.key"), "missing.key")
    }

    func testMissingPluralizedKeyFallsBackToTheKeyItself() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))

        XCTAssertEqual(controller.pluralizedString("missing.plural.key", count: 2), "missing.plural.key")
    }

    func testRuntimeLocaleSwitchingChangesResolvedStrings() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))

        XCTAssertEqual(L10n.Common.cancel(using: controller), "Cancel")

        controller.setLocale(Locale(identifier: "fr"))

        XCTAssertEqual(L10n.Common.cancel(using: controller), "Annuler")
    }

    func testInterpolationUsesActiveLocaleTemplates() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "fr"))

        XCTAssertEqual(L10n.Common.welcome(name: "Anurag", using: controller), "Bienvenue, Anurag !")
    }

    func testPluralizationUsesZeroOneAndOtherRules() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))

        XCTAssertEqual(L10n.Errors.retryCount(0, using: controller), "No retries left")
        XCTAssertEqual(L10n.Errors.retryCount(1, using: controller), "1 retry left")
        XCTAssertEqual(L10n.Errors.retryCount(3, using: controller), "3 retries left")
    }

    func testLocaleLanguageFallbackWorksForRegionSpecificLocaleIdentifiers() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "fr_CA"))

        XCTAssertEqual(L10n.Common.cancel(using: controller), "Annuler")
    }

    func testBundleLocatorExposesModuleBundle() {
        XCTAssertFalse(BundleLocator.bundle.bundleURL.path.isEmpty)
    }

    func testGeneratedStringsDeclaresSupportedLocales() {
        XCTAssertEqual(GeneratedStrings.supportedLocales, ["en", "fr"])
    }

    func testPluralizationSuffixesAreDeterministic() {
        XCTAssertEqual(Pluralization.suffix(for: 0), "zero")
        XCTAssertEqual(Pluralization.suffix(for: 1), "one")
        XCTAssertEqual(Pluralization.suffix(for: 99), "other")
    }

    func testLocalizedFormatterReturnsTemplateWhenArgumentsAreEmpty() {
        XCTAssertEqual(
            LocalizedFormatters.interpolate(
                "Hello",
                locale: Locale(identifier: "en"),
                arguments: []
            ),
            "Hello"
        )
    }

    func testLocalizedFormatterInterpolatesArguments() {
        XCTAssertEqual(
            LocalizedFormatters.interpolate(
                "Hello, %@!",
                locale: Locale(identifier: "en"),
                arguments: ["World"]
            ),
            "Hello, World!"
        )
    }

    func testLocalizationProvidingTypedAccessorsResolveCommonStrings() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))

        XCTAssertEqual(L10n.Common.ok(using: controller), "OK")
        XCTAssertEqual(L10n.Common.cancel(using: controller), "Cancel")
    }

    func testMalformedStringsFileFallsBackToKey() throws {
        let bundle = try makeBundle(
            localizationIdentifier: "es",
            contents: "\"broken\" = "
        )
        let controller = LocalizationController(
            initialLocale: Locale(identifier: "es"),
            fallbackLocale: Locale(identifier: "es"),
            bundle: bundle
        )

        XCTAssertEqual(controller.string("broken"), "broken")
    }

    private func makeBundle(localizationIdentifier: String, contents: String) throws -> Bundle {
        let fileManager = FileManager.default
        let root = fileManager.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        let bundleURL = root.appendingPathComponent("TestResources.bundle", isDirectory: true)
        let localizedDirectory = bundleURL.appendingPathComponent("\(localizationIdentifier).lproj", isDirectory: true)

        try fileManager.createDirectory(at: localizedDirectory, withIntermediateDirectories: true)
        temporaryDirectories.append(root)

        let infoPlist = bundleURL.appendingPathComponent("Info.plist")
        let plistContents = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>CFBundleIdentifier</key>
            <string>com.test.LocalizationKitTests</string>
            <key>CFBundleName</key>
            <string>TestResources</string>
            <key>CFBundlePackageType</key>
            <string>BNDL</string>
        </dict>
        </plist>
        """
        try plistContents.write(to: infoPlist, atomically: true, encoding: .utf8)

        let stringsFile = localizedDirectory.appendingPathComponent("Localizable.strings")
        try contents.write(to: stringsFile, atomically: true, encoding: .utf8)

        guard let bundle = Bundle(url: bundleURL) else {
            XCTFail("Failed to create bundle at \(bundleURL.path)")
            throw NSError(domain: "LocalizationKitTests", code: 1)
        }

        return bundle
    }
}

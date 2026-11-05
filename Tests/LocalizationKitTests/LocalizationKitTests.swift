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

    func testMyTVDisclaimerRetainsCreditsPrivacyAndSupportAcrossLocales() {
        for language in ["en", "fr", "ar"] {
            let provider = LocalizationController(initialLocale: Locale(identifier: language))
            let disclaimer = MyTVStrings(provider: provider).aboutDisclaimerText
            XCTAssertTrue(disclaimer.contains("https://github.com/iptv-org"))
            XCTAssertTrue(disclaimer.contains("Docs/PrivacyInventory.md"))
            XCTAssertTrue(disclaimer.contains("mailto:anuragchourasiaios@gmail.com"))
        }
    }

    func testShowBookPresentationStringsResolveAcrossSupportedLocales() {
        for (locale, expected) in [("en", "Loading edition…"),
                                   ("fr", "Chargement de l’édition…"),
                                   ("ar", "جارٍ تحميل الطبعة…")] {
            let controller = LocalizationController(initialLocale: Locale(identifier: locale))
            let strings = ShowBookStrings(provider: controller)
            XCTAssertEqual(strings.loadingEdition, expected)
            XCTAssertFalse(strings.authLoginWelcome.contains("showbook."))
            XCTAssertTrue(strings.authLoginWelcome.contains("\n"))
        }
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
        XCTAssertEqual(GeneratedStrings.supportedLocales, ["en", "fr", "ar"])
    }

    func testArabicStringsAndRTLDirection() {
        let arabicController = LocalizationController(initialLocale: Locale(identifier: "ar"))
        XCTAssertTrue(arabicController.isRightToLeft)
        XCTAssertEqual(arabicController.string("common.ok"), "موافق")
        XCTAssertEqual(arabicController.string("common.cancel"), "إلغاء")
        XCTAssertEqual(L10n.Auth.signIn(using: arabicController), "تسجيل الدخول")
        XCTAssertEqual(L10n.Auth.createAccount(using: arabicController), "إنشاء حساب")
        XCTAssertEqual(L10n.Account.title(using: arabicController), "الحساب")
        XCTAssertEqual(L10n.Errors.networkUnreachable(using: arabicController), "تم فقد الاتصال بالشبكة. يرجى التحقق من اتصالك بالإنترنت.")

        let englishController = LocalizationController(initialLocale: Locale(identifier: "en"))
        XCTAssertFalse(englishController.isRightToLeft)

        let frenchController = LocalizationController(initialLocale: Locale(identifier: "fr"))
        XCTAssertFalse(frenchController.isRightToLeft)
    }

    func testAuthAndAccountStringsAcrossLocales() {
        let enController = LocalizationController(initialLocale: Locale(identifier: "en"))
        let frController = LocalizationController(initialLocale: Locale(identifier: "fr"))

        XCTAssertEqual(L10n.Auth.signIn(using: enController), "Sign in")
        XCTAssertEqual(L10n.Auth.signIn(using: frController), "Connexion")

        XCTAssertEqual(L10n.Auth.email(using: enController), "Email")
        XCTAssertEqual(L10n.Auth.email(using: frController), "E-mail")

        XCTAssertEqual(L10n.Auth.password(using: enController), "Password")
        XCTAssertEqual(L10n.Auth.password(using: frController), "Mot de passe")

        XCTAssertEqual(L10n.Auth.forgotPassword(using: enController), "Forgot password?")
        XCTAssertEqual(L10n.Auth.forgotPassword(using: frController), "Mot de passe oublié ?")

        XCTAssertEqual(L10n.Account.signOut(using: enController), "Sign out")
        XCTAssertEqual(L10n.Account.signOut(using: frController), "Se déconnecter")

        XCTAssertEqual(L10n.Account.deleteAccount(using: enController), "Delete account")
        XCTAssertEqual(L10n.Account.deleteAccount(using: frController), "Supprimer le compte")
    }

    func testRecoverableErrorsStrings() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))

        XCTAssertEqual(L10n.Errors.networkUnreachable(using: controller), "Network connection lost. Please check your internet connection.")
        XCTAssertEqual(L10n.Errors.invalidCredentials(using: controller), "Invalid email or password. Please try again.")
        XCTAssertEqual(L10n.Errors.sessionExpired(using: controller), "Your session has expired. Please sign in again.")
        XCTAssertEqual(L10n.Errors.recoverableRetry(using: controller), "Try Again")
        XCTAssertEqual(L10n.Errors.recoverableDismiss(using: controller), "Dismiss")
        XCTAssertEqual(L10n.Errors.storeLoadFailed(using: controller), "Storage Unavailable")
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

extension LocalizationKitTests {
    func testMultiDomainScopedContextsResolveCorrectly() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))

        let motivation = LocalizedContext<MotivationDomain>(provider: controller)
        XCTAssertEqual(motivation.domain.motivationAppName, "Motivation Daily")
        XCTAssertEqual(motivation.domain.favourites, "Favourites")
        XCTAssertEqual(motivation.domain.imageNotAvailable, "Image not available")
        XCTAssertEqual(motivation.common.ok, "OK")
        XCTAssertEqual(motivation.common.share, "Share")

        let myTV = LocalizedContext<MyTVDomain>(provider: controller)
        XCTAssertEqual(myTV.domain.appName, "My TV")
        XCTAssertEqual(myTV.domain.allChannels, "All Channels")

        let showBook = LocalizedContext<ShowBookDomain>(provider: controller)
        XCTAssertEqual(showBook.domain.appName, "Show Book")
        XCTAssertEqual(showBook.domain.discover, "Discover")
    }

    func testDirectKeyPathSubscriptAccess() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))
        let motivation = LocalizedContext<MotivationDomain>(provider: controller)

        // Direct KeyPath Subscript: l10n[\.key]
        XCTAssertEqual(motivation[\.motivationAppName], "Motivation Daily")
        XCTAssertEqual(motivation[\.favourites], "Favourites")
        XCTAssertEqual(motivation[\.imageNotAvailable], "Image not available")
        XCTAssertEqual(motivation[\.share], "Share")
        XCTAssertEqual(motivation[\.ok], "OK")

        // Dynamic member lookup: l10n.key
        XCTAssertEqual(motivation.motivationAppName, "Motivation Daily")
        XCTAssertEqual(motivation.favourites, "Favourites")

        let myTV = LocalizedContext<MyTVDomain>(provider: controller)
        XCTAssertEqual(myTV[\.appName], "My TV")
        XCTAssertEqual(myTV[\.allChannels], "All Channels")
        XCTAssertEqual(myTV[\.share], "Share")

        let showBook = LocalizedContext<ShowBookDomain>(provider: controller)
        XCTAssertEqual(showBook[\.appName], "Show Book")
        XCTAssertEqual(showBook[\.discover], "Discover")
        XCTAssertEqual(showBook[\.savedBooks], "Saved books")
    }

    func testDeveloperSettingsStrings() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "en"))
        let common = CommonStrings(provider: controller)

        XCTAssertEqual(common.developerSettingsTitle, "Developer Settings")
        XCTAssertEqual(common.developerQuickPresets, "Quick presets")
        XCTAssertEqual(common.developerPresetShowcase, "Showcase (Populated)")
        XCTAssertEqual(common.developerPresetEmpty, "Empty State (Zero Results)")
        XCTAssertEqual(common.developerPresetOffline, "Offline Resilience")
        XCTAssertEqual(common.developerSupport, "Developer Support")
        XCTAssertEqual(common.developerPrivacyPolicy, "Privacy Policy")
        XCTAssertEqual(common.developerResetSettings, "Reset developer settings")
    }

    func testMultiDomainContextRTLArabic() {
        let controller = LocalizationController(initialLocale: Locale(identifier: "ar"))
        let motivation = LocalizedContext<MotivationDomain>(provider: controller)
        XCTAssertEqual(motivation.domain.motivationAppName, "التحفيز اليومي")
        XCTAssertEqual(motivation.domain.imageNotAvailable, "الصورة غير متوفرة")
        XCTAssertEqual(motivation.common.share, "مشاركة")
    }
}

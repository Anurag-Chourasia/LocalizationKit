import SwiftUI
import Foundation

// MARK: - Scoped Localized Context with KeyPath Subscripts

@dynamicMemberLookup
public struct LocalizedContext<Domain: LocalizationDomain>: Sendable {
    public let provider: LocalizationProviding
    public let domain: Domain.Strings

    public init(provider: LocalizationProviding) {
        self.provider = provider
        self.domain = Domain.makeStrings(provider: provider)
    }

    public var common: CommonStrings {
        CommonStrings(provider: provider)
    }

    public func string(_ key: String) -> String {
        provider.string(key)
    }

    public func string(_ key: String, arguments: [CVarArg]) -> String {
        provider.string(key, arguments: arguments)
    }

    // Direct KeyPath Subscripts: l10n[\.key]
    public subscript(keyPath: KeyPath<Domain.Strings, String>) -> String {
        domain[keyPath: keyPath]
    }

    public subscript(keyPath: KeyPath<CommonStrings, String>) -> String {
        common[keyPath: keyPath]
    }

    // Dynamic Member Lookup: l10n.key
    public subscript(dynamicMember keyPath: KeyPath<Domain.Strings, String>) -> String {
        domain[keyPath: keyPath]
    }

    public static var shared: LocalizedContext<Domain> {
        LocalizedContext<Domain>(provider: LocalizationController.shared)
    }
}

// MARK: - Common Shared Strings

public struct CommonStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    public static var shared: CommonStrings {
        CommonStrings(provider: LocalizationController.shared)
    }

    public var ok: String { provider.string("common.ok") }
    public var cancel: String { provider.string("common.cancel") }
    public var welcome: String { provider.string("common.welcome") }
    public var errorGeneric: String { provider.string("errors.generic") }
    public var errorsRetryCountZero: String { provider.string("errors.retry_count.zero") }
    public var errorsRetryCountOne: String { provider.string("errors.retry_count.one") }
    public var errorsRetryCountOther: String { provider.string("errors.retry_count.other") }
    public var authTitleSignIn: String { provider.string("auth.title.sign_in") }
    public var authTitleCreateAccount: String { provider.string("auth.title.create_account") }
    public var authTitleResetPassword: String { provider.string("auth.title.reset_password") }
    public var authTitleChooseNewPassword: String { provider.string("auth.title.choose_new_password") }
    public var authFieldEmail: String { provider.string("auth.field.email") }
    public var authFieldPassword: String { provider.string("auth.field.password") }
    public var authFieldConfirmPassword: String { provider.string("auth.field.confirm_password") }
    public var authButtonForgotPassword: String { provider.string("auth.button.forgot_password") }
    public var authButtonCreateAnAccount: String { provider.string("auth.button.create_an_account") }
    public var authButtonBackToSignIn: String { provider.string("auth.button.back_to_sign_in") }
    public var authButtonSignOut: String { provider.string("auth.button.sign_out") }
    public var authButtonDeleteAccount: String { provider.string("auth.button.delete_account") }
    public var authOrContinueWith: String { provider.string("auth.or_continue_with") }
    public var authStatusPleaseWait: String { provider.string("auth.status.please_wait") }
    public var authInstructionPasswordRequirements: String { provider.string("auth.instruction.password_requirements") }
    public var authInstructionResetEmailSent: String { provider.string("auth.instruction.reset_email_sent") }
    public var accountTitle: String { provider.string("account.title") }
    public var accountSignedIn: String { provider.string("account.signed_in") }
    public var accountDeleteConfirmationTitle: String { provider.string("account.delete_confirmation_title") }
    public var accountDeleteConfirmationAction: String { provider.string("account.delete_confirmation_action") }
    public var accountDeleteConfirmationMessage: String { provider.string("account.delete_confirmation_message") }
    public var accountDeleteFooterNotice: String { provider.string("account.delete_footer_notice") }
    public var done: String { provider.string("account.done") }
    public var errorsNetworkUnreachable: String { provider.string("errors.network_unreachable") }
    public var errorsInvalidCredentials: String { provider.string("errors.invalid_credentials") }
    public var errorsSessionExpired: String { provider.string("errors.session_expired") }
    public var errorsAccountDeletionFailed: String { provider.string("errors.account_deletion_failed") }
    public var retry: String { provider.string("errors.recoverable_retry") }
    public var dismiss: String { provider.string("errors.recoverable_dismiss") }
    public var errorsStoreLoadFailed: String { provider.string("errors.store_load_failed") }
    public var errorsStoreLoadMessage: String { provider.string("errors.store_load_message") }
    public var share: String { provider.string("common.share") }
    public var close: String { provider.string("common.close") }
    public var back: String { provider.string("common.back") }
    public var yes: String { provider.string("common.yes") }
    public var no: String { provider.string("common.no") }
    public var clear: String { provider.string("common.clear") }
    public var error: String { provider.string("common.error") }
    public var showcaseDemoA11y: String { provider.string("common.showcase.demo.a11y") }
    public var showcaseDemoTitle: String { provider.string("common.showcase.demo.title") }
    public var showcaseDemoTapForControls: String { provider.string("common.showcase.demo.tap_for_controls") }
    public var developerSettingsTitle: String { provider.string("developer.title") }
    public var developerSettingsSubtitleMotivation: String { provider.string("developer.subtitle.motivation") }
    public var developerSettingsSubtitleMyTV: String { provider.string("developer.subtitle.mytv") }
    public var developerSettingsSubtitleShowBook: String { provider.string("developer.subtitle.showbook") }
    public var developerQuickPresets: String { provider.string("developer.quick_presets") }
    public var developerPresetShowcase: String { provider.string("developer.preset.showcase") }
    public var developerPresetEmpty: String { provider.string("developer.preset.empty") }
    public var developerPresetOffline: String { provider.string("developer.preset.offline") }
    public var developerPresetLiveFeed: String { provider.string("developer.preset.live_feed") }
    public var developerPresetLiveDirectory: String { provider.string("developer.preset.live_directory") }
    public var developerPresetLiveLibrary: String { provider.string("developer.preset.live_library") }
    public var developerCacheAndOffline: String { provider.string("developer.cache_and_offline") }
    public var developerDiskCache: String { provider.string("developer.disk_cache") }
    public var developerChecking: String { provider.string("developer.checking") }
    public var developerPurgeCache: String { provider.string("developer.purge_cache") }
    public var developerPurgeQuoteCache: String { provider.string("developer.purge_quote_cache") }
    public var developerPurgeChannelCache: String { provider.string("developer.purge_channel_cache") }
    public var developerPurgeCatalogCache: String { provider.string("developer.purge_catalog_cache") }
    public var developerEnvironment: String { provider.string("developer.environment") }
    public var developerDataSource: String { provider.string("developer.data_source") }
    public var developerScenario: String { provider.string("developer.scenario") }
    public var developerScenarioSuccess: String { provider.string("developer.scenario.success") }
    public var developerScenarioEmpty: String { provider.string("developer.scenario.empty") }
    public var developerScenarioOffline: String { provider.string("developer.scenario.offline") }
    public var developerFeatureFlags: String { provider.string("developer.feature_flags") }
    public var developerAuthentication: String { provider.string("developer.authentication") }
    public var developerDebugLogs: String { provider.string("developer.debug_logs") }
    public var developerHttpLogs: String { provider.string("developer.http_logs") }
    public var developerVersionSimulation: String { provider.string("developer.version_simulation") }
    public var developerInstalledVersion: String { provider.string("developer.installed_version") }
    public var developerInstalledBuild: String { provider.string("developer.installed_build") }
    public var developerSimulatedVersion: String { provider.string("developer.simulated_version") }
    public var developerSimulatedBuild: String { provider.string("developer.simulated_build") }
    public var developerPrivacySupport: String { provider.string("developer.privacy_support") }
    public var developerPrivacyPolicy: String { provider.string("developer.privacy_policy") }
    public var developerSupport: String { provider.string("developer.support") }
    public var developerResetSettings: String { provider.string("developer.reset_settings") }
    public var developerThemeAndDisplay: String { provider.string("developer.theme_and_display") }
    public var developerSimulateOffline: String { provider.string("developer.simulate_offline") }
    public var developerCloseProfile: String { provider.string("developer.close_profile") }
    public var developerOpenApp: String { provider.string("developer.open_app") }
    public var developerSourceStub: String { provider.string("developer.source.stub") }
    public var developerReleaseIgnores: String { provider.string("developer.release_ignores") }
    public var authNoticeConfirmEmail: String { provider.string("auth.notice.confirm_email") }
    public var authNoticeAccountDeleted: String { provider.string("auth.notice.account_deleted") }
    public var authNoticePasswordResetSent: String { provider.string("auth.notice.password_reset_sent") }
    public var authNoticePasswordUpdated: String { provider.string("auth.notice.password_updated") }
    public var authUnavailableTitle: String { provider.string("auth.unavailable.title") }
    public var authUnavailableMessage: String { provider.string("auth.unavailable.message") }
    public var authUnavailableDebugConfiguration: String { provider.string("auth.unavailable.debug_configuration") }
    public var authBrandMytvSubtitle: String { provider.string("auth.brand.mytv.subtitle") }
    public var authBrandShowbookSubtitle: String { provider.string("auth.brand.showbook.subtitle") }
    public var authBrandMotivationDailySubtitle: String { provider.string("auth.brand.motivation_daily.subtitle") }
    public var authProviderContinueWith: String { provider.string("auth.provider.continue_with") }
    public var authProviderContinueWithApple: String { provider.string("auth.provider.continue_with.apple") }
    public var authProviderContinueWithGoogle: String { provider.string("auth.provider.continue_with.google") }
    public var authProviderContinueWithGithub: String { provider.string("auth.provider.continue_with.github") }
    public var profileAppInformation: String { provider.string("profile.app_information") }
    public var profileVersion: String { provider.string("profile.version") }
    public var profileDisclaimer: String { provider.string("profile.disclaimer") }
    public var profileSocial: String { provider.string("profile.social") }
    public var profileReadMore: String { provider.string("profile.read_more") }
    public var profileShowLess: String { provider.string("profile.show_less") }
    public var profileLinkHint: String { provider.string("profile.link_hint") }
    public var profileErrorTitle: String { provider.string("profile.error_title") }
    public var profileErrorMessage: String { provider.string("profile.error_message") }
    public var profileOkay: String { provider.string("profile.okay") }
    public var layoutTitle: String { provider.string("common.layout.title") }
    public var layoutList: String { provider.string("common.layout.list") }
    public var layoutGrid: String { provider.string("common.layout.grid") }
}

// MARK: - SwiftUI KeyPath Text Initializers

extension Text {
    /// Initialize with a direct Motivation keypath: `Text(\.imageNotAvailable)`
    public init(_ keyPath: KeyPath<MotivationStrings, String>, in context: LocalizedContext<MotivationDomain> = .shared) {
        self.init(context[keyPath])
    }

    /// Initialize with a direct MyTV keypath: `Text(\.allChannels)`
    public init(_ keyPath: KeyPath<MyTVStrings, String>, in context: LocalizedContext<MyTVDomain> = .shared) {
        self.init(context[keyPath])
    }

    /// Initialize with a direct ShowBook keypath: `Text(\.searchKeepTyping)`
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, in context: LocalizedContext<ShowBookDomain> = .shared) {
        self.init(context[keyPath])
    }

    /// Initialize with a direct Common keypath: `Text(\.share)` or `Text(\.ok)`
    public init(_ keyPath: KeyPath<CommonStrings, String>, in context: CommonStrings = .shared) {
        self.init(context[keyPath: keyPath])
    }

    /// Initialize with explicit context: `Text(\.previewShareTitle, in: l10n)`
    public init<Domain: LocalizationDomain>(_ keyPath: KeyPath<Domain.Strings, String>, in l10n: LocalizedContext<Domain>) {
        self.init(l10n[keyPath])
    }

    /// Initialize with explicit common context: `Text(\.share, in: l10n)`
    public init<Domain: LocalizationDomain>(_ keyPath: KeyPath<CommonStrings, String>, in l10n: LocalizedContext<Domain>) {
        self.init(l10n[keyPath])
    }
}

// MARK: - SwiftUI KeyPath Button Initializers

extension Button where Label == Text {
    public init(_ keyPath: KeyPath<CommonStrings, String>, action: @escaping () -> Void) {
        self.init(action: action) {
            Text(keyPath)
        }
    }

    public init(_ keyPath: KeyPath<MotivationStrings, String>, action: @escaping () -> Void) {
        self.init(action: action) {
            Text(keyPath)
        }
    }

    public init(_ keyPath: KeyPath<MyTVStrings, String>, action: @escaping () -> Void) {
        self.init(action: action) {
            Text(keyPath)
        }
    }

    public init(_ keyPath: KeyPath<ShowBookStrings, String>, action: @escaping () -> Void) {
        self.init(action: action) {
            Text(keyPath)
        }
    }
}

// MARK: - KeyPath String Convenience Initializers

extension String {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, in context: LocalizedContext<MotivationDomain> = .shared) {
        self = context[keyPath]
    }

    public init(_ keyPath: KeyPath<MyTVStrings, String>, in context: LocalizedContext<MyTVDomain> = .shared) {
        self = context[keyPath]
    }

    public init(_ keyPath: KeyPath<ShowBookStrings, String>, in context: LocalizedContext<ShowBookDomain> = .shared) {
        self = context[keyPath]
    }

    public init(_ keyPath: KeyPath<CommonStrings, String>, in context: CommonStrings = .shared) {
        self = context[keyPath: keyPath]
    }
}

// MARK: - SwiftUI KeyPath Accessibility Modifiers

extension View {
    public func accessibilityLabel(_ keyPath: KeyPath<MotivationStrings, String>) -> some View {
        self.accessibilityLabel(Text(keyPath))
    }

    public func accessibilityLabel(_ keyPath: KeyPath<MyTVStrings, String>) -> some View {
        self.accessibilityLabel(Text(keyPath))
    }

    public func accessibilityLabel(_ keyPath: KeyPath<ShowBookStrings, String>) -> some View {
        self.accessibilityLabel(Text(keyPath))
    }

    public func accessibilityLabel(_ keyPath: KeyPath<CommonStrings, String>) -> some View {
        self.accessibilityLabel(Text(keyPath))
    }

    public func accessibilityHint(_ keyPath: KeyPath<MotivationStrings, String>) -> some View {
        self.accessibilityHint(Text(keyPath))
    }

    public func accessibilityHint(_ keyPath: KeyPath<MyTVStrings, String>) -> some View {
        self.accessibilityHint(Text(keyPath))
    }

    public func accessibilityHint(_ keyPath: KeyPath<ShowBookStrings, String>) -> some View {
        self.accessibilityHint(Text(keyPath))
    }

    public func accessibilityHint(_ keyPath: KeyPath<CommonStrings, String>) -> some View {
        self.accessibilityHint(Text(keyPath))
    }

    // Alert & Dialog KeyPath Modifiers
    public func alert<A: View, M: View>(
        _ titleKeyPath: KeyPath<MotivationStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions, message: message)
    }

    public func alert<A: View, M: View>(
        _ titleKeyPath: KeyPath<CommonStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions, message: message)
    }

    public func confirmationDialog<A: View, M: View>(
        _ titleKeyPath: KeyPath<MotivationStrings, String>,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.confirmationDialog(Text(titleKeyPath), isPresented: isPresented, titleVisibility: titleVisibility, actions: actions, message: message)
    }

    public func confirmationDialog<A: View>(
        _ titleKeyPath: KeyPath<MotivationStrings, String>,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: () -> A
    ) -> some View {
        self.confirmationDialog(Text(titleKeyPath), isPresented: isPresented, titleVisibility: titleVisibility, actions: actions)
    }

    public func confirmationDialog<A: View, M: View>(
        _ titleKeyPath: KeyPath<CommonStrings, String>,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.confirmationDialog(Text(titleKeyPath), isPresented: isPresented, titleVisibility: titleVisibility, actions: actions, message: message)
    }
}

// MARK: - Environment Keys for Scoped Domains

private struct MotivationL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<MotivationDomain> = LocalizedContext(provider: LocalizationController())
}

private struct MyTVL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<MyTVDomain> = LocalizedContext(provider: LocalizationController())
}

private struct ShowBookL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<ShowBookDomain> = LocalizedContext(provider: LocalizationController())
}

extension EnvironmentValues {
    public var motivationL10n: LocalizedContext<MotivationDomain> {
        get { self[MotivationL10nKey.self] }
        set { self[MotivationL10nKey.self] = newValue }
    }

    public var myTVL10n: LocalizedContext<MyTVDomain> {
        get { self[MyTVL10nKey.self] }
        set { self[MyTVL10nKey.self] = newValue }
    }

    public var showBookL10n: LocalizedContext<ShowBookDomain> {
        get { self[ShowBookL10nKey.self] }
        set { self[ShowBookL10nKey.self] = newValue }
    }
}

// MARK: - View Extension to Inject Domain L10n

extension View {
    public func localizedContext<Domain: LocalizationDomain>(
        _ context: LocalizedContext<Domain>
    ) -> some View {
        Group {
            if let motivationContext = context as? LocalizedContext<MotivationDomain> {
                self.environment(\.motivationL10n, motivationContext)
            } else if let myTVContext = context as? LocalizedContext<MyTVDomain> {
                self.environment(\.myTVL10n, myTVContext)
            } else if let showBookContext = context as? LocalizedContext<ShowBookDomain> {
                self.environment(\.showBookL10n, showBookContext)
            } else {
                self
            }
        }
    }
}
extension Button where Label == Text {
    public init(_ keyPath: KeyPath<CommonStrings, String>, role: ButtonRole?, action: @escaping () -> Void) {
        self.init(role: role, action: action) { Text(keyPath) }
    }
}
extension Button where Label == Text {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, role: ButtonRole?, action: @escaping () -> Void) {
        self.init(role: role, action: action) { Text(keyPath) }
    }
}
extension Button where Label == Text {
    public init(_ keyPath: KeyPath<MyTVStrings, String>, role: ButtonRole?, action: @escaping () -> Void) {
        self.init(role: role, action: action) { Text(keyPath) }
    }
}
extension Button where Label == Text {
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, role: ButtonRole?, action: @escaping () -> Void) {
        self.init(role: role, action: action) { Text(keyPath) }
    }
}
extension Alert.Button {
    public static func `default`(_ keyPath: KeyPath<CommonStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .default(Text(keyPath), action: action)
    }
    public static func `cancel`(_ keyPath: KeyPath<CommonStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .cancel(Text(keyPath), action: action)
    }
    public static func `destructive`(_ keyPath: KeyPath<CommonStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .destructive(Text(keyPath), action: action)
    }
}

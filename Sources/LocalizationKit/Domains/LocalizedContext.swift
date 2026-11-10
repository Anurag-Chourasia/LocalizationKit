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

    public func string(_ keyPath: KeyPath<Domain.Strings, String>, arguments: [CVarArg]) -> String {
        let template = domain[keyPath: keyPath]
        return LocalizedFormatters.interpolate(template, locale: provider.locale, arguments: arguments)
    }

    public func string(_ keyPath: KeyPath<CommonStrings, String>, arguments: [CVarArg]) -> String {
        let template = common[keyPath: keyPath]
        return LocalizedFormatters.interpolate(template, locale: provider.locale, arguments: arguments)
    }

    public func string(_ keyPath: KeyPath<Domain.Strings, String>, _ arguments: CVarArg...) -> String {
        string(keyPath, arguments: arguments)
    }

    public func string(_ keyPath: KeyPath<CommonStrings, String>, _ arguments: CVarArg...) -> String {
        string(keyPath, arguments: arguments)
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
    public let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    public static var shared: CommonStrings {
        CommonStrings(provider: LocalizationController.shared)
    }

    public func string(_ keyPath: KeyPath<CommonStrings, String>, arguments: [CVarArg]) -> String {
        let template = self[keyPath: keyPath]
        return LocalizedFormatters.interpolate(template, locale: provider.locale, arguments: arguments)
    }

    public func string(_ keyPath: KeyPath<CommonStrings, String>, _ arguments: CVarArg...) -> String {
        string(keyPath, arguments: arguments)
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
    public var appearanceTitle: String { provider.string("common.appearance.title") }
    public var appearanceSystem: String { provider.string("common.appearance.system") }
    public var appearanceLight: String { provider.string("common.appearance.light") }
    public var appearanceDark: String { provider.string("common.appearance.dark") }
    public var loading: String { provider.string("common.loading") }
    public var offline: String { provider.string("common.offline") }
    public var offlineMessage: String { provider.string("common.offline_message") }
    public var playbackPlay: String { provider.string("common.playback.play") }
    public var playbackPause: String { provider.string("common.playback.pause") }
    public var playbackStop: String { provider.string("common.playback.stop") }
    public var playbackReplay: String { provider.string("common.playback.replay") }
    public var playbackLive: String { provider.string("common.playback.live") }
    public var playbackMute: String { provider.string("common.playback.mute") }
    public var playbackUnmute: String { provider.string("common.playback.unmute") }
    public var toggleSelected: String { provider.string("common.toggle.selected") }
    public var toggleUnselected: String { provider.string("common.toggle.unselected") }
    public var emptyTitle: String { provider.string("common.empty.title") }
    public var emptyMessage: String { provider.string("common.empty.message") }
    public var errorTitle: String { provider.string("common.error.title") }
    public var errorMessage: String { provider.string("common.error.message") }
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

    /// Initialize with a direct Motivation keypath and arguments: `Text(\.welcome, arguments: [name])`
    public init(_ keyPath: KeyPath<MotivationStrings, String>, arguments: [CVarArg], in context: LocalizedContext<MotivationDomain> = .shared) {
        self.init(context.string(keyPath, arguments: arguments))
    }

    /// Initialize with a direct MyTV keypath and arguments
    public init(_ keyPath: KeyPath<MyTVStrings, String>, arguments: [CVarArg], in context: LocalizedContext<MyTVDomain> = .shared) {
        self.init(context.string(keyPath, arguments: arguments))
    }

    /// Initialize with a direct ShowBook keypath and arguments
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, arguments: [CVarArg], in context: LocalizedContext<ShowBookDomain> = .shared) {
        self.init(context.string(keyPath, arguments: arguments))
    }

    /// Initialize with a direct Common keypath and arguments
    public init(_ keyPath: KeyPath<CommonStrings, String>, arguments: [CVarArg], in context: CommonStrings = .shared) {
        self.init(context.string(keyPath, arguments: arguments))
    }

    /// Initialize with explicit context and arguments: `Text(\.previewShareTitle, arguments: [args], in: l10n)`
    public init<Domain: LocalizationDomain>(_ keyPath: KeyPath<Domain.Strings, String>, arguments: [CVarArg], in l10n: LocalizedContext<Domain>) {
        self.init(l10n.string(keyPath, arguments: arguments))
    }

    /// Initialize with explicit common context and arguments
    public init<Domain: LocalizationDomain>(_ keyPath: KeyPath<CommonStrings, String>, arguments: [CVarArg], in l10n: LocalizedContext<Domain>) {
        self.init(l10n.string(keyPath, arguments: arguments))
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

    public init(_ keyPath: KeyPath<MotivationStrings, String>, arguments: [CVarArg], in context: LocalizedContext<MotivationDomain> = .shared) {
        self = context.string(keyPath, arguments: arguments)
    }

    public init(_ keyPath: KeyPath<MyTVStrings, String>, arguments: [CVarArg], in context: LocalizedContext<MyTVDomain> = .shared) {
        self = context.string(keyPath, arguments: arguments)
    }

    public init(_ keyPath: KeyPath<ShowBookStrings, String>, arguments: [CVarArg], in context: LocalizedContext<ShowBookDomain> = .shared) {
        self = context.string(keyPath, arguments: arguments)
    }

    public init(_ keyPath: KeyPath<CommonStrings, String>, arguments: [CVarArg], in context: CommonStrings = .shared) {
        self = context.string(keyPath, arguments: arguments)
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

    public func accessibilityValue(_ keyPath: KeyPath<MotivationStrings, String>) -> some View {
        self.accessibilityValue(Text(keyPath))
    }

    public func accessibilityValue(_ keyPath: KeyPath<MyTVStrings, String>) -> some View {
        self.accessibilityValue(Text(keyPath))
    }

    public func accessibilityValue(_ keyPath: KeyPath<ShowBookStrings, String>) -> some View {
        self.accessibilityValue(Text(keyPath))
    }

    public func accessibilityValue(_ keyPath: KeyPath<CommonStrings, String>) -> some View {
        self.accessibilityValue(Text(keyPath))
    }

    public func navigationTitle(_ keyPath: KeyPath<MotivationStrings, String>) -> some View {
        self.navigationTitle(Text(keyPath))
    }

    public func navigationTitle(_ keyPath: KeyPath<MyTVStrings, String>) -> some View {
        self.navigationTitle(Text(keyPath))
    }

    public func navigationTitle(_ keyPath: KeyPath<ShowBookStrings, String>) -> some View {
        self.navigationTitle(Text(keyPath))
    }

    public func navigationTitle(_ keyPath: KeyPath<CommonStrings, String>) -> some View {
        self.navigationTitle(Text(keyPath))
    }

    public func searchable(
        text: Binding<String>,
        prompt keyPath: KeyPath<MotivationStrings, String>
    ) -> some View {
        self.searchable(text: text, prompt: Text(keyPath))
    }

    public func searchable(
        text: Binding<String>,
        prompt keyPath: KeyPath<MyTVStrings, String>
    ) -> some View {
        self.searchable(text: text, prompt: Text(keyPath))
    }

    public func searchable(
        text: Binding<String>,
        prompt keyPath: KeyPath<ShowBookStrings, String>
    ) -> some View {
        self.searchable(text: text, prompt: Text(keyPath))
    }

    public func searchable(
        text: Binding<String>,
        prompt keyPath: KeyPath<CommonStrings, String>
    ) -> some View {
        self.searchable(text: text, prompt: Text(keyPath))
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

    public func alert<A: View>(
        _ titleKeyPath: KeyPath<MotivationStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions)
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

    public func alert<A: View, M: View>(
        _ titleKeyPath: KeyPath<MyTVStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions, message: message)
    }

    public func alert<A: View>(
        _ titleKeyPath: KeyPath<MyTVStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions)
    }

    public func confirmationDialog<A: View, M: View>(
        _ titleKeyPath: KeyPath<MyTVStrings, String>,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.confirmationDialog(Text(titleKeyPath), isPresented: isPresented, titleVisibility: titleVisibility, actions: actions, message: message)
    }

    public func confirmationDialog<A: View>(
        _ titleKeyPath: KeyPath<MyTVStrings, String>,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: () -> A
    ) -> some View {
        self.confirmationDialog(Text(titleKeyPath), isPresented: isPresented, titleVisibility: titleVisibility, actions: actions)
    }

    public func alert<A: View, M: View>(
        _ titleKeyPath: KeyPath<ShowBookStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions, message: message)
    }

    public func alert<A: View>(
        _ titleKeyPath: KeyPath<ShowBookStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions)
    }

    public func confirmationDialog<A: View, M: View>(
        _ titleKeyPath: KeyPath<ShowBookStrings, String>,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.confirmationDialog(Text(titleKeyPath), isPresented: isPresented, titleVisibility: titleVisibility, actions: actions, message: message)
    }

    public func confirmationDialog<A: View>(
        _ titleKeyPath: KeyPath<ShowBookStrings, String>,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: () -> A
    ) -> some View {
        self.confirmationDialog(Text(titleKeyPath), isPresented: isPresented, titleVisibility: titleVisibility, actions: actions)
    }

    public func alert<A: View, M: View>(
        _ titleKeyPath: KeyPath<CommonStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A,
        @ViewBuilder message: () -> M
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions, message: message)
    }

    public func alert<A: View>(
        _ titleKeyPath: KeyPath<CommonStrings, String>,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> A
    ) -> some View {
        self.alert(Text(titleKeyPath), isPresented: isPresented, actions: actions)
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

    public func confirmationDialog<A: View>(
        _ titleKeyPath: KeyPath<CommonStrings, String>,
        isPresented: Binding<Bool>,
        titleVisibility: Visibility = .automatic,
        @ViewBuilder actions: () -> A
    ) -> some View {
        self.confirmationDialog(Text(titleKeyPath), isPresented: isPresented, titleVisibility: titleVisibility, actions: actions)
    }

}

// MARK: - Environment Keys for Scoped Domains

private struct LocalizationProviderKey: EnvironmentKey {
    static let defaultValue: any LocalizationProviding = LocalizationController.shared
}

private struct CommonL10nKey: EnvironmentKey {
    static let defaultValue: CommonStrings = CommonStrings(provider: LocalizationController.shared)
}

private struct MotivationL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<MotivationDomain> = LocalizedContext(provider: LocalizationController.shared)
}

private struct MyTVL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<MyTVDomain> = LocalizedContext(provider: LocalizationController.shared)
}

private struct ShowBookL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<ShowBookDomain> = LocalizedContext(provider: LocalizationController.shared)
}

extension EnvironmentValues {
    public var localizationProvider: any LocalizationProviding {
        get { self[LocalizationProviderKey.self] }
        set { self[LocalizationProviderKey.self] = newValue }
    }

    public var commonL10n: CommonStrings {
        get { self[CommonL10nKey.self] }
        set { self[CommonL10nKey.self] = newValue }
    }

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

    public subscript<Domain: LocalizationDomain>(domain: Domain.Type) -> LocalizedContext<Domain> {
        LocalizedContext<Domain>(provider: self.localizationProvider)
    }
}

// MARK: - View Extension to Inject Domain L10n

extension View {
    public func localizationProvider(_ provider: any LocalizationProviding) -> some View {
        self.environment(\.localizationProvider, provider)
            .environment(\.commonL10n, CommonStrings(provider: provider))
            .environment(\.motivationL10n, LocalizedContext<MotivationDomain>(provider: provider))
            .environment(\.myTVL10n, LocalizedContext<MyTVDomain>(provider: provider))
            .environment(\.showBookL10n, LocalizedContext<ShowBookDomain>(provider: provider))
    }

    public func localizedContext<Domain: LocalizationDomain>(
        _ context: LocalizedContext<Domain>
    ) -> some View {
        Group {
            if let motivationContext = context as? LocalizedContext<MotivationDomain> {
                self.environment(\.motivationL10n, motivationContext)
                    .environment(\.localizationProvider, context.provider)
                    .environment(\.commonL10n, context.common)
            } else if let myTVContext = context as? LocalizedContext<MyTVDomain> {
                self.environment(\.myTVL10n, myTVContext)
                    .environment(\.localizationProvider, context.provider)
                    .environment(\.commonL10n, context.common)
            } else if let showBookContext = context as? LocalizedContext<ShowBookDomain> {
                self.environment(\.showBookL10n, showBookContext)
                    .environment(\.localizationProvider, context.provider)
                    .environment(\.commonL10n, context.common)
            } else {
                self.environment(\.localizationProvider, context.provider)
                    .environment(\.commonL10n, context.common)
            }
        }
    }
}
extension Button where Label == Text {
    public init(_ keyPath: KeyPath<CommonStrings, String>, role: ButtonRole?, action: @escaping () -> Void) {
        self.init(role: role, action: action) { Text(keyPath) }
    }
}
extension LabeledContent where Label == Text, Content == Text {
    public init<S: StringProtocol>(_ keyPath: KeyPath<CommonStrings, String>, value: S) {
        self.init(content: { Text(value) }, label: { Text(keyPath) })
    }
}
extension LabeledContent where Label == Text, Content: View {
    public init(_ keyPath: KeyPath<CommonStrings, String>, @ViewBuilder content: () -> Content) {
        self.init(content: content, label: { Text(keyPath) })
    }
}
extension TextField where Label == Text {
    public init(_ keyPath: KeyPath<CommonStrings, String>, text: Binding<String>) {
        self.init(text: text) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<CommonStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<CommonStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
}
extension SecureField where Label == Text {
    public init(_ keyPath: KeyPath<CommonStrings, String>, text: Binding<String>) {
        self.init(text: text) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<CommonStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<CommonStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
}
extension Toggle where Label == Text {
    public init(_ keyPath: KeyPath<CommonStrings, String>, isOn: Binding<Bool>) {
        self.init(isOn: isOn) { Text(keyPath) }
    }
}
extension Picker where Label == Text, Content: View {
    public init(_ keyPath: KeyPath<CommonStrings, String>, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) {
        self.init(selection: selection, content: content, label: { Text(keyPath) })
    }
}
extension NavigationLink where Label == Text, Destination: View {
    public init(_ keyPath: KeyPath<CommonStrings, String>, destination: Destination) {
        self.init(destination: destination, label: { Text(keyPath) })
    }
}
extension NavigationLink where Label == Text, Destination == Never {
    public init<P: Hashable>(_ keyPath: KeyPath<CommonStrings, String>, value: P?) {
        self.init(value: value, label: { Text(keyPath) })
    }
}
extension Button where Label == Text {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, role: ButtonRole?, action: @escaping () -> Void) {
        self.init(role: role, action: action) { Text(keyPath) }
    }
}
extension LabeledContent where Label == Text, Content == Text {
    public init<S: StringProtocol>(_ keyPath: KeyPath<MotivationStrings, String>, value: S) {
        self.init(content: { Text(value) }, label: { Text(keyPath) })
    }
}
extension LabeledContent where Label == Text, Content: View {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, @ViewBuilder content: () -> Content) {
        self.init(content: content, label: { Text(keyPath) })
    }
}
extension TextField where Label == Text {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, text: Binding<String>) {
        self.init(text: text) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<MotivationStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<MotivationStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<MotivationStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<CommonStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
}
extension SecureField where Label == Text {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, text: Binding<String>) {
        self.init(text: text) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<MotivationStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<MotivationStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<MotivationStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<CommonStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
}
extension Toggle where Label == Text {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, isOn: Binding<Bool>) {
        self.init(isOn: isOn) { Text(keyPath) }
    }
}
extension Picker where Label == Text, Content: View {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) {
        self.init(selection: selection, content: content, label: { Text(keyPath) })
    }
}
extension NavigationLink where Label == Text, Destination: View {
    public init(_ keyPath: KeyPath<MotivationStrings, String>, destination: Destination) {
        self.init(destination: destination, label: { Text(keyPath) })
    }
}
extension NavigationLink where Label == Text, Destination == Never {
    public init<P: Hashable>(_ keyPath: KeyPath<MotivationStrings, String>, value: P?) {
        self.init(value: value, label: { Text(keyPath) })
    }
}
extension Button where Label == Text {
    public init(_ keyPath: KeyPath<MyTVStrings, String>, role: ButtonRole?, action: @escaping () -> Void) {
        self.init(role: role, action: action) { Text(keyPath) }
    }
}
extension LabeledContent where Label == Text, Content == Text {
    public init<S: StringProtocol>(_ keyPath: KeyPath<MyTVStrings, String>, value: S) {
        self.init(content: { Text(value) }, label: { Text(keyPath) })
    }
}
extension LabeledContent where Label == Text, Content: View {
    public init(_ keyPath: KeyPath<MyTVStrings, String>, @ViewBuilder content: () -> Content) {
        self.init(content: content, label: { Text(keyPath) })
    }
}
extension TextField where Label == Text {
    public init(_ keyPath: KeyPath<MyTVStrings, String>, text: Binding<String>) {
        self.init(text: text) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<MyTVStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<MyTVStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<MyTVStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<CommonStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
}
extension SecureField where Label == Text {
    public init(_ keyPath: KeyPath<MyTVStrings, String>, text: Binding<String>) {
        self.init(text: text) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<MyTVStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<MyTVStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<MyTVStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<CommonStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
}
extension Toggle where Label == Text {
    public init(_ keyPath: KeyPath<MyTVStrings, String>, isOn: Binding<Bool>) {
        self.init(isOn: isOn) { Text(keyPath) }
    }
}
extension Picker where Label == Text, Content: View {
    public init(_ keyPath: KeyPath<MyTVStrings, String>, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) {
        self.init(selection: selection, content: content, label: { Text(keyPath) })
    }
}
extension NavigationLink where Label == Text, Destination: View {
    public init(_ keyPath: KeyPath<MyTVStrings, String>, destination: Destination) {
        self.init(destination: destination, label: { Text(keyPath) })
    }
}
extension NavigationLink where Label == Text, Destination == Never {
    public init<P: Hashable>(_ keyPath: KeyPath<MyTVStrings, String>, value: P?) {
        self.init(value: value, label: { Text(keyPath) })
    }
}
extension Button where Label == Text {
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, role: ButtonRole?, action: @escaping () -> Void) {
        self.init(role: role, action: action) { Text(keyPath) }
    }
}
extension LabeledContent where Label == Text, Content == Text {
    public init<S: StringProtocol>(_ keyPath: KeyPath<ShowBookStrings, String>, value: S) {
        self.init(content: { Text(value) }, label: { Text(keyPath) })
    }
}
extension LabeledContent where Label == Text, Content: View {
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, @ViewBuilder content: () -> Content) {
        self.init(content: content, label: { Text(keyPath) })
    }
}
extension TextField where Label == Text {
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, text: Binding<String>) {
        self.init(text: text) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<ShowBookStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<CommonStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
}
extension SecureField where Label == Text {
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, text: Binding<String>) {
        self.init(text: text) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<ShowBookStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, text: Binding<String>, promptKeyPath: KeyPath<CommonStrings, String>) {
        self.init(text: text, prompt: Text(promptKeyPath)) { Text(keyPath) }
    }
}
extension Toggle where Label == Text {
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, isOn: Binding<Bool>) {
        self.init(isOn: isOn) { Text(keyPath) }
    }
}
extension Picker where Label == Text, Content: View {
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) {
        self.init(selection: selection, content: content, label: { Text(keyPath) })
    }
}
extension NavigationLink where Label == Text, Destination: View {
    public init(_ keyPath: KeyPath<ShowBookStrings, String>, destination: Destination) {
        self.init(destination: destination, label: { Text(keyPath) })
    }
}
extension NavigationLink where Label == Text, Destination == Never {
    public init<P: Hashable>(_ keyPath: KeyPath<ShowBookStrings, String>, value: P?) {
        self.init(value: value, label: { Text(keyPath) })
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
extension Alert.Button {
    public static func `default`(_ keyPath: KeyPath<MotivationStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .default(Text(keyPath), action: action)
    }
    public static func `cancel`(_ keyPath: KeyPath<MotivationStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .cancel(Text(keyPath), action: action)
    }
    public static func `destructive`(_ keyPath: KeyPath<MotivationStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .destructive(Text(keyPath), action: action)
    }
}
extension Alert.Button {
    public static func `default`(_ keyPath: KeyPath<MyTVStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .default(Text(keyPath), action: action)
    }
    public static func `cancel`(_ keyPath: KeyPath<MyTVStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .cancel(Text(keyPath), action: action)
    }
    public static func `destructive`(_ keyPath: KeyPath<MyTVStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .destructive(Text(keyPath), action: action)
    }
}
extension Alert.Button {
    public static func `default`(_ keyPath: KeyPath<ShowBookStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .default(Text(keyPath), action: action)
    }
    public static func `cancel`(_ keyPath: KeyPath<ShowBookStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .cancel(Text(keyPath), action: action)
    }
    public static func `destructive`(_ keyPath: KeyPath<ShowBookStrings, String>, action: (() -> Void)? = nil) -> Alert.Button {
        .destructive(Text(keyPath), action: action)
    }
}

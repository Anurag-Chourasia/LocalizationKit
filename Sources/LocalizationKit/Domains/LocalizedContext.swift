import SwiftUI
import Foundation

// MARK: - Scoped Localized Context with KeyPath Subscripts

@dynamicMemberLookup
public struct LocalizedContext<Domain: LocalizationDomain>: Sendable {
    public let provider: LocalizationProviding
    public let domain: Domain.Strings

    public init(provider: LocalizationProviding) {
        self.provider = provider
        if Domain.self == MotivationDomain.self {
            self.domain = MotivationStrings(provider: provider) as! Domain.Strings
        } else if Domain.self == MyTVDomain.self {
            self.domain = MyTVStrings(provider: provider) as! Domain.Strings
        } else if Domain.self == ShowBookDomain.self {
            self.domain = ShowBookStrings(provider: provider) as! Domain.Strings
        } else {
            fatalError("Unsupported LocalizationDomain: \(Domain.self)")
        }
    }

    public var common: CommonStrings {
        CommonStrings(provider: provider)
    }

    public func string(_ key: String) -> String {
        provider.string(key)
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
    public var yes: String { provider.string("common.yes") }
    public var no: String { provider.string("common.no") }
    public var clear: String { provider.string("common.clear") }
    public var error: String { provider.string("common.error") }
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

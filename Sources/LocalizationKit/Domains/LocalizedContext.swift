import SwiftUI
import Foundation

// MARK: - Scoped Localized Context

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
}

// MARK: - Common Shared Strings

public struct CommonStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    public var ok: String { provider.string("common.ok") }
    public var cancel: String { provider.string("common.cancel") }
    public var share: String { provider.string("common.share") }
    public var close: String { provider.string("common.close") }
    public var done: String { provider.string("account.done") }
    public var retry: String { provider.string("errors.recoverable_retry") }
    public var dismiss: String { provider.string("errors.recoverable_dismiss") }
    public var errorGeneric: String { provider.string("errors.generic") }
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

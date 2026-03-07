import Foundation

public final class LocalizationController: LocalizationProviding, @unchecked Sendable {
    private let bundle: Bundle
    private let fallbackLocale: Locale
    private let lock = NSLock()

    private var currentLocale: Locale
    private var cachedTables: [String: [String: String]] = [:]

    public init(
        initialLocale: Locale = Locale(identifier: "en"),
        fallbackLocale: Locale = Locale(identifier: "en"),
        bundle: Bundle = BundleLocator.bundle
    ) {
        self.currentLocale = initialLocale
        self.fallbackLocale = fallbackLocale
        self.bundle = bundle
    }

    public var locale: Locale {
        lock.withLock {
            currentLocale
        }
    }

    public func setLocale(_ locale: Locale) {
        lock.withLock {
            currentLocale = locale
        }
    }

    public func string(_ key: String) -> String {
        string(key, arguments: [])
    }

    public func string(_ key: String, arguments: [CVarArg]) -> String {
        let locale = self.locale
        let template = localizedValue(for: key, locale: locale) ?? key
        return LocalizedFormatters.interpolate(template, locale: locale, arguments: arguments)
    }

    public func pluralizedString(_ key: String, count: Int) -> String {
        let locale = self.locale
        let pluralKey = "\(key).\(Pluralization.suffix(for: count))"
        let template = localizedValue(for: pluralKey, locale: locale)
            ?? localizedValue(for: "\(key).other", locale: locale)
            ?? key
        return LocalizedFormatters.interpolate(template, locale: locale, arguments: [count])
    }

    private func localizedValue(for key: String, locale: Locale) -> String? {
        for candidate in localeCandidates(for: locale) {
            guard let value = table(for: candidate)[key] else {
                continue
            }

            return value
        }

        return nil
    }

    private func localeCandidates(for locale: Locale) -> [String] {
        var candidates: [String] = []

        if !locale.identifier.isEmpty {
            candidates.append(locale.identifier)
        }

        if let languageCode = locale.language.languageCode?.identifier, !languageCode.isEmpty {
            candidates.append(languageCode)
        }

        if !fallbackLocale.identifier.isEmpty {
            candidates.append(fallbackLocale.identifier)
        }

        if let fallbackLanguageCode = fallbackLocale.language.languageCode?.identifier, !fallbackLanguageCode.isEmpty {
            candidates.append(fallbackLanguageCode)
        }

        return NSOrderedSet(array: candidates).array.compactMap { $0 as? String }
    }

    private func table(for localeIdentifier: String) -> [String: String] {
        lock.withLock {
            if let cachedTable = cachedTables[localeIdentifier] {
                return cachedTable
            }

            let table = loadTable(localeIdentifier: localeIdentifier)
            cachedTables[localeIdentifier] = table
            return table
        }
    }

    private func loadTable(localeIdentifier: String) -> [String: String] {
        guard let path = bundle.path(
            forResource: "Localizable",
            ofType: "strings",
            inDirectory: nil,
            forLocalization: localeIdentifier
        ) else {
            return [:]
        }

        guard let table = NSDictionary(contentsOfFile: path) as? [String: String] else {
            return [:]
        }

        return table
    }
}

private extension NSLock {
    func withLock<T>(_ operation: () -> T) -> T {
        lock()
        defer { unlock() }
        return operation()
    }
}

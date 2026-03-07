public enum L10n {
    public enum Common {
        public static func ok(using localization: LocalizationProviding) -> String {
            localization.string("common.ok")
        }

        public static func cancel(using localization: LocalizationProviding) -> String {
            localization.string("common.cancel")
        }

        public static func welcome(name: String, using localization: LocalizationProviding) -> String {
            localization.string("common.welcome", arguments: [name])
        }
    }

    public enum Errors {
        public static func generic(using localization: LocalizationProviding) -> String {
            localization.string("errors.generic")
        }

        public static func retryCount(_ count: Int, using localization: LocalizationProviding) -> String {
            localization.pluralizedString("errors.retry_count", count: count)
        }
    }
}

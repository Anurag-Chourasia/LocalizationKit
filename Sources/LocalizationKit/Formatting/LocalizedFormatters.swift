import Foundation

public enum LocalizedFormatters {
    public static func interpolate(
        _ template: String,
        locale: Locale,
        arguments: [CVarArg]
    ) -> String {
        guard !arguments.isEmpty else {
            return template
        }

        return String(format: template, locale: locale, arguments: arguments)
    }
}

import Foundation

public struct ShowBookStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    public var appName: String { provider.string("showbook.app.name") }
    public var discover: String { provider.string("showbook.discover.title") }
    public var discoverSubtitle: String { provider.string("showbook.discover.subtitle") }
    public var discoverUnavailable: String { provider.string("showbook.discover.unavailable") }
    public var noBooksCategory: String { provider.string("showbook.discover.no_books") }

    public var savedBooks: String { provider.string("showbook.saved_books.title") }
    public var searchForBooks: String { provider.string("showbook.search.placeholder") }

    public var editions: String { provider.string("showbook.details.editions") }
    public var editionDetails: String { provider.string("showbook.details.edition_details") }
    public var noEditions: String { provider.string("showbook.details.no_editions") }
    public var notRated: String { provider.string("showbook.details.not_rated") }
    public var previewCover: String { provider.string("showbook.details.preview_cover") }
    public var shareCover: String { provider.string("showbook.details.share_cover") }
    public var coverUnavailable: String { provider.string("showbook.details.cover_unavailable") }
    public var closeCoverPreview: String { provider.string("showbook.details.close_cover_preview") }

    public var appOptions: String { provider.string("showbook.menu.app_options") }
    public var appearance: String { provider.string("showbook.menu.appearance") }
    public var light: String { provider.string("showbook.appearance.light") }
    public var dark: String { provider.string("showbook.appearance.dark") }
    public var knowYourDeveloper: String { provider.string("showbook.menu.know_developer") }

    public var logoutConfirmationTitle: String { provider.string("showbook.logout.confirmation_title") }
    public var logout: String { provider.string("showbook.logout.action") }
}

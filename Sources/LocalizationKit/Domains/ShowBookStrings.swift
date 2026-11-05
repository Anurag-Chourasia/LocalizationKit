import Foundation

public struct ShowBookStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    /* ShowBook Domain */
    public var appName: String {
        provider.string("showbook.app.name")
    }

    public var discover: String {
        provider.string("showbook.discover.title")
    }

    public var discoverSubtitle: String {
        provider.string("showbook.discover.subtitle")
    }

    public var discoverUnavailable: String {
        provider.string("showbook.discover.unavailable")
    }

    public var noBooksCategory: String {
        provider.string("showbook.discover.no_books")
    }

    public var savedBooks: String {
        provider.string("showbook.saved_books.title")
    }

    public var searchForBooks: String {
        provider.string("showbook.search.placeholder")
    }

    public var editions: String {
        provider.string("showbook.details.editions")
    }

    public var editionDetails: String {
        provider.string("showbook.details.edition_details")
    }

    public var noEditions: String {
        provider.string("showbook.details.no_editions")
    }

    public var notRated: String {
        provider.string("showbook.details.not_rated")
    }

    public var previewCover: String {
        provider.string("showbook.details.preview_cover")
    }

    public var shareCover: String {
        provider.string("showbook.details.share_cover")
    }

    public var coverUnavailable: String {
        provider.string("showbook.details.cover_unavailable")
    }

    public var closeCoverPreview: String {
        provider.string("showbook.details.close_cover_preview")
    }

    public var appOptions: String {
        provider.string("showbook.menu.app_options")
    }

    public var appearance: String {
        provider.string("showbook.menu.appearance")
    }

    public var light: String {
        provider.string("showbook.appearance.light")
    }

    public var dark: String {
        provider.string("showbook.appearance.dark")
    }

    public var knowYourDeveloper: String {
        provider.string("showbook.menu.know_developer")
    }

    public var logoutConfirmationTitle: String {
        provider.string("showbook.logout.confirmation_title")
    }

    public var logout: String {
        provider.string("showbook.logout.action")
    }

    /* ShowBook additions */
    public var searchKeepTyping: String {
        provider.string("showbook.search.keep_typing")
    }

    public var searchStartSearching: String {
        provider.string("showbook.search.start_searching")
    }

    public var searchNoBooksFound: String {
        provider.string("showbook.search.no_books_found")
    }

    public var searchUnableToSearch: String {
        provider.string("showbook.search.unable_to_search")
    }

    public var searchConnectionError: String {
        provider.string("showbook.search.connection_error")
    }

    public var searchMinimumCharacters: String {
        provider.string("showbook.search.minimum_characters")
    }

    public var sortBy: String {
        provider.string("showbook.sort.by")
    }

    public var loadingMore: String {
        provider.string("showbook.loading.more")
    }

    public var loadingProgress: String {
        provider.string("showbook.loading.progress")
    }

    public var loadingBookDetails: String {
        provider.string("showbook.details.loading_details")
    }

    public var loadingEditions: String {
        provider.string("showbook.details.loading_editions")
    }

    public var loadMoreEditions: String {
        provider.string("showbook.details.load_more_editions")
    }

    public var retryEditions: String {
        provider.string("showbook.details.retry_editions")
    }

    public var bookDetailsTitle: String {
        provider.string("showbook.details.title")
    }

    public var editionDetailsTitle: String {
        provider.string("showbook.details.edition_details_title")
    }

    public var description: String {
        provider.string("showbook.details.description")
    }

    public var noDescription: String {
        provider.string("showbook.details.no_description")
    }

    public var firstPublished: String {
        provider.string("showbook.details.first_published")
    }

    public var subjects: String {
        provider.string("showbook.details.subjects")
    }

    public var published: String {
        provider.string("showbook.details.published")
    }

    public var publisher: String {
        provider.string("showbook.details.publisher")
    }

    public var format: String {
        provider.string("showbook.details.format")
    }

    public var pages: String {
        provider.string("showbook.details.pages")
    }

    public var isbn13: String {
        provider.string("showbook.details.isbn13")
    }

    public var isbn10: String {
        provider.string("showbook.details.isbn10")
    }

    public var languages: String {
        provider.string("showbook.details.languages")
    }

    public var bookmarkRemove: String {
        provider.string("showbook.a11y.bookmark.remove")
    }

    public var bookmarkAdd: String {
        provider.string("showbook.a11y.bookmark.add")
    }

    public var loadingEdition: String {
        provider.string("showbook.loading.edition")
    }

    public var loadingCover: String {
        provider.string("showbook.loading.cover")
    }

    public var detailsCoverPreview: String {
        provider.string("showbook.details.cover_preview")
    }

    public var detailsBookCover: String {
        provider.string("showbook.details.book_cover")
    }

    public var detailsNotAvailable: String {
        provider.string("showbook.details.not_available")
    }

    public var detailsShareFailed: String {
        provider.string("showbook.details.share_failed")
    }

    public var welcomeTitle: String {
        provider.string("showbook.welcome.title")
    }

    public var authLoginWelcome: String {
        provider.string("showbook.auth.login_welcome")
    }

    public var authSignupWelcome: String {
        provider.string("showbook.auth.signup_welcome")
    }

    public var authValidEmail: String {
        provider.string("showbook.auth.valid_email")
    }

    public var authUppercase: String {
        provider.string("showbook.auth.uppercase")
    }

    public var authLowercase: String {
        provider.string("showbook.auth.lowercase")
    }

    public var authSpecial: String {
        provider.string("showbook.auth.special")
    }

    public var authNumber: String {
        provider.string("showbook.auth.number")
    }

    public var authLength: String {
        provider.string("showbook.auth.length")
    }

    public var loadingLibrary: String {
        provider.string("showbook.loading.library")
    }

    public var countrySelect: String {
        provider.string("showbook.country.select")
    }

    public var discoverFinding: String {
        provider.string("showbook.discover.finding")
    }

    public var discoverCategory: String {
        provider.string("showbook.discover.category")
    }

    public var actionClear: String {
        provider.string("showbook.action.clear")
    }

    public var actionRetry: String {
        provider.string("showbook.action.retry")
    }

    public var alertError: String {
        provider.string("showbook.alert.error")
    }

    public var actionYes: String {
        provider.string("showbook.action.yes")
    }

    public var appearanceSystem: String {
        provider.string("showbook.appearance.system")
    }

    public var layoutReadability: String {
        provider.string("showbook.layout.readability")
    }

    public var detailsNoAuthor: String {
        provider.string("showbook.details.no_author")
    }

    public var detailsOpens: String {
        provider.string("showbook.details.opens")
    }

    public var detailsFor: String {
        provider.string("showbook.details.for")
    }

    public var detailsRatings: String {
        provider.string("showbook.details.ratings")
    }

    public var discoverCached: String {
        provider.string("showbook.discover.cached")
    }

    public var discoverSortTitle: String {
        provider.string("showbook.discover.sort_title")
    }

    public var discoverSortAverage: String {
        provider.string("showbook.discover.sort_average")
    }

    public var discoverSortHits: String {
        provider.string("showbook.discover.sort_hits")
    }

    public var categoryFiction: String {
        provider.string("showbook.category.fiction")
    }

    public var categoryMystery: String {
        provider.string("showbook.category.mystery")
    }

    public var categoryScience: String {
        provider.string("showbook.category.science")
    }

    public var categoryHistory: String {
        provider.string("showbook.category.history")
    }

    public var layoutListTitle: String {
        provider.string("showbook.layout.list_title")
    }

    public var developerAuthNote: String {
        provider.string("showbook.developer.auth_note")
    }

    public var developerLogsNote: String {
        provider.string("showbook.developer.logs_note")
    }

    public var developerLive: String {
        provider.string("showbook.developer.live")
    }

    public var developerStubNote: String {
        provider.string("showbook.developer.stub_note")
    }

    public var developerLayout: String {
        provider.string("showbook.developer.layout")
    }

    public var developerLayoutA: String {
        provider.string("showbook.developer.layout_a")
    }

    public var developerLayoutB: String {
        provider.string("showbook.developer.layout_b")
    }

    public var developerExperimentNote: String {
        provider.string("showbook.developer.experiment_note")
    }

    public var developerExperiment: String {
        provider.string("showbook.developer.experiment")
    }

    public var developerVersionNote: String {
        provider.string("showbook.developer.version_note")
    }

    public var developerPrivacy: String {
        provider.string("showbook.developer.privacy")
    }

    public var errorEmptyFields: String {
        provider.string("showbook.error.empty_fields")
    }

    public var errorInvalidEmail: String {
        provider.string("showbook.error.invalid_email")
    }

    public var errorLoginPassword: String {
        provider.string("showbook.error.login_password")
    }

    public var errorSignupPassword: String {
        provider.string("showbook.error.signup_password")
    }

    public var errorSaveLogin: String {
        provider.string("showbook.error.save_login")
    }

    public var errorSaveAccount: String {
        provider.string("showbook.error.save_account")
    }

    public var errorUnexpected: String {
        provider.string("showbook.error.unexpected")
    }

    public var errorCountries: String {
        provider.string("showbook.error.countries")
    }

    public var errorNotFound: String {
        provider.string("showbook.error.not_found")
    }

    public var errorBusy: String {
        provider.string("showbook.error.busy")
    }

    public var errorRecordFailed: String {
        provider.string("showbook.error.record_failed")
    }

    public var errorUnreadable: String {
        provider.string("showbook.error.unreadable")
    }

    public var errorDetailsFailed: String {
        provider.string("showbook.error.details_failed")
    }

    public var errorCategoryFailed: String {
        provider.string("showbook.error.category_failed")
    }

}

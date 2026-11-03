import Foundation

public struct MyTVStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    public var appName: String { provider.string("app.name") }
    public var cancel: String { provider.string("app.cancel") }
    public var retry: String { provider.string("app.retry") }
    public var ok: String { provider.string("app.ok") }
    public var search: String { provider.string("app.search") }
    public var apply: String { provider.string("app.apply") }
    public var offlineBanner: String { provider.string("app.offline.banner") }
    public var showLess: String { provider.string("app.showLess") }
    public var readMore: String { provider.string("app.readMore") }

    public var groupingName: String { provider.string("app.grouping.name") }
    public var groupingCountry: String { provider.string("app.grouping.country") }
    public var groupingCategory: String { provider.string("app.grouping.category") }

    public var appearanceSystem: String { provider.string("app.appearance.color.system") }
    public var appearanceLight: String { provider.string("app.appearance.color.light") }
    public var appearanceDark: String { provider.string("app.appearance.color.dark") }

    public var preparingStream: String { provider.string("loading.preparing.stream") }

    public var allChannels: String { provider.string("channel.scope.all") }
    public var favorites: String { provider.string("channel.scope.favorites") }
    public var noChannelsTitle: String { provider.string("channel.empty.title") }
    public var noChannelsMessage: String { provider.string("channel.empty.message") }
    public var noResultsTitle: String { provider.string("channel.no.results.title") }
    public var noResultsMessage: String { provider.string("channel.no.results.message") }

    public var layoutList: String { provider.string("channel.layout.list") }
    public var layoutGrid: String { provider.string("channel.layout.grid") }
    public var layoutUnavailableTitle: String { provider.string("channel.layout.grid.unavailable.title") }
    public var layoutUnavailableMessage: String { provider.string("channel.layout.grid.unavailable.message") }
    public var layoutUnavailableBanner: String { provider.string("channel.layout.grid.unavailable.banner") }

    public var clearCacheAlertTitle: String { provider.string("channel.alert.clear.cache.title") }
    public var clearCacheConfirm: String { provider.string("channel.alert.clear.cache.confirm") }
    public var clearFiltersAlertTitle: String { provider.string("channel.alert.clear.filters.title") }
    public var clearFiltersConfirm: String { provider.string("channel.alert.clear.filters.confirm") }
    public var removeFavoritesAlertTitle: String { provider.string("channel.alert.remove.favorites.title") }
    public var removeFavoritesConfirm: String { provider.string("channel.alert.remove.favorites.confirm") }

    public var sortAndFilterTitle: String { provider.string("channel.menu.section.sortAndFilter.title") }
    public var countries: String { provider.string("channel.filter.countries") }
    public var categories: String { provider.string("channel.filter.categories") }

    public var playbackErrorTitle: String { provider.string("stream.player.error.title") }
    public var noWorkingStreams: String { provider.string("stream.player.error.noWorkingStreams") }
    public var invalidStreamURL: String { provider.string("stream.player.error.invalidURL") }
    public var cannotPlayStream: String { provider.string("stream.player.error.cannotPlay") }
    public var playbackFailed: String { provider.string("stream.player.error.failed") }

    public var aboutTitle: String { provider.string("about.title") }
    public var disclaimerTitle: String { provider.string("about.disclaimer.title") }
    public var disclaimerText: String { provider.string("about.disclaimer.text") }
}

import Foundation

public struct MyTVStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    /* myTV Domain */
    public var appName: String {
        provider.string("app.name")
    }

    public var groupingName: String {
        provider.string("app.grouping.name")
    }

    public var groupingCountry: String {
        provider.string("app.grouping.country")
    }

    public var groupingCategory: String {
        provider.string("app.grouping.category")
    }

    public var offlineBanner: String {
        provider.string("app.offline.banner")
    }

    public var showLess: String {
        provider.string("app.showLess")
    }

    public var readMore: String {
        provider.string("app.readMore")
    }

    public var appearanceSystem: String {
        provider.string("app.appearance.color.system")
    }

    public var appearanceLight: String {
        provider.string("app.appearance.color.light")
    }

    public var appearanceDark: String {
        provider.string("app.appearance.color.dark")
    }

    public var search: String {
        provider.string("app.search")
    }

    public var apply: String {
        provider.string("app.apply")
    }

    public var preparingStream: String {
        provider.string("loading.preparing.stream")
    }

    public var allChannels: String {
        provider.string("channel.scope.all")
    }

    public var favorites: String {
        provider.string("channel.scope.favorites")
    }

    public var noChannelsTitle: String {
        provider.string("channel.empty.title")
    }

    public var noChannelsMessage: String {
        provider.string("channel.empty.message")
    }

    public var noResultsTitle: String {
        provider.string("channel.no.results.title")
    }

    public var noResultsMessage: String {
        provider.string("channel.no.results.message")
    }

    public var layoutList: String {
        provider.string("channel.layout.list")
    }

    public var layoutGrid: String {
        provider.string("channel.layout.grid")
    }

    public var layoutUnavailableTitle: String {
        provider.string("channel.layout.grid.unavailable.title")
    }

    public var layoutUnavailableMessage: String {
        provider.string("channel.layout.grid.unavailable.message")
    }

    public var layoutUnavailableBanner: String {
        provider.string("channel.layout.grid.unavailable.banner")
    }

    public var clearCacheAlertTitle: String {
        provider.string("channel.alert.clear.cache.title")
    }

    public var clearCacheConfirm: String {
        provider.string("channel.alert.clear.cache.confirm")
    }

    public var clearFiltersAlertTitle: String {
        provider.string("channel.alert.clear.filters.title")
    }

    public var clearFiltersConfirm: String {
        provider.string("channel.alert.clear.filters.confirm")
    }

    public var removeFavoritesAlertTitle: String {
        provider.string("channel.alert.remove.favorites.title")
    }

    public var removeFavoritesConfirm: String {
        provider.string("channel.alert.remove.favorites.confirm")
    }

    public var sortAndFilterTitle: String {
        provider.string("channel.menu.section.sortAndFilter.title")
    }

    public var countries: String {
        provider.string("channel.filter.countries")
    }

    public var categories: String {
        provider.string("channel.filter.categories")
    }

    public var playbackErrorTitle: String {
        provider.string("stream.player.error.title")
    }

    public var noWorkingStreams: String {
        provider.string("stream.player.error.noWorkingStreams")
    }

    public var invalidStreamURL: String {
        provider.string("stream.player.error.invalidURL")
    }

    public var cannotPlayStream: String {
        provider.string("stream.player.error.cannotPlay")
    }

    public var playbackFailed: String {
        provider.string("stream.player.error.failed")
    }

    public var aboutTitle: String {
        provider.string("about.title")
    }

    public var aboutDisclaimerTitle: String {
        provider.string("about.disclaimer.title")
    }

    public var aboutDisclaimerText: String {
        provider.string("about.disclaimer.text")
    }

    /* myTV additions */
    public var layoutTitle: String {
        provider.string("channel.layout.title")
    }

    public var layoutUnavailableOk: String {
        provider.string("channel.layout.grid.unavailable.ok")
    }

    public var layoutAutoListTitle: String {
        provider.string("channel.layout.grid.auto_list.title")
    }

    public var layoutAutoListMessage: String {
        provider.string("channel.layout.grid.auto_list.message")
    }

    public var layoutAutoListOk: String {
        provider.string("channel.layout.grid.auto_list.ok")
    }

    public var sectionGroupBy: String {
        provider.string("channel.menu.section.group_by.title")
    }

    public var sectionSorting: String {
        provider.string("channel.menu.section.sorting.title")
    }

    public var sectionFilter: String {
        provider.string("channel.menu.section.Filter.title")
    }

    public var sectionTitle: String {
        provider.string("channel.menu.section.section.title")
    }

    public var channelTitle: String {
        provider.string("channel.menu.section.channel.title")
    }

    public var actionsTitle: String {
        provider.string("channel.menu.section.actions")
    }

    public var layoutMenuTitle: String {
        provider.string("channel.menu.section.layout")
    }

    public var appearanceMenuTitle: String {
        provider.string("channel.menu.section.appearance")
    }

    public var aboutMenuTitle: String {
        provider.string("channel.menu.section.about")
    }

    public var clearCacheAction: String {
        provider.string("channel.menu.action.clearCache")
    }

    public var clearFiltersAction: String {
        provider.string("channel.menu.action.clearFilters")
    }

    public var removeFavoritesAction: String {
        provider.string("channel.menu.action.removeFavorites")
    }

    public var sortAscending: String {
        provider.string("channel.sort.order.ascending")
    }

    public var sortDescending: String {
        provider.string("channel.sort.order.descending")
    }

    public var multiSelectSelected: String {
        provider.string("multiSelectView.section.selected")
    }

    public var multiSelectAll: String {
        provider.string("multiSelectView.section.all")
    }

    public var streamListEmptyTitle: String {
        provider.string("stream.list.empty.title")
    }

    public var streamListEmptyMessage: String {
        provider.string("stream.list.empty.message")
    }

    public var aboutAlertErrorTitle: String {
        provider.string("about.alert.error.title")
    }

    public var aboutAlertErrorOk: String {
        provider.string("about.alert.error.ok")
    }

    public var aboutAlertErrorInvalidLink: String {
        provider.string("about.alert.error.invalidLink")
    }

    public var aboutAppInfoTitle: String {
        provider.string("about.app.info.title")
    }

    public var aboutAppName: String {
        provider.string("about.app.name")
    }

    public var aboutAppVersionPrefix: String {
        provider.string("about.app.version.prefix")
    }

    public var aboutSocialTitle: String {
        provider.string("about.social.title")
    }

    public var a11yMenuOptions: String {
        provider.string("a11y.menu.options")
    }

    public var a11yMenuOptionsHint: String {
        provider.string("a11y.menu.options.hint")
    }

    public var a11yFavoriteAdd: String {
        provider.string("a11y.favorite.add")
    }

    public var a11yFavoriteRemove: String {
        provider.string("a11y.favorite.remove")
    }

    public var a11yFavoriteHint: String {
        provider.string("a11y.favorite.hint")
    }

    public var a11yChannelOpenHint: String {
        provider.string("a11y.channel.open.hint")
    }

    public var a11yStreamPlayHint: String {
        provider.string("a11y.stream.play.hint")
    }

    public var a11yOpenLinkHint: String {
        provider.string("a11y.openLink.hint")
    }

    public var a11ySelected: String {
        provider.string("a11y.selected")
    }

    public var channelLogo: String {
        provider.string("a11y.channel.logo")
    }

}

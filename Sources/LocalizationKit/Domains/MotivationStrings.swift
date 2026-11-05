import Foundation

public struct MotivationStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    /* Motivation Daily Domain */
    public var motivationAppName: String {
        provider.string("motivation.app.name")
    }

    public var favourites: String {
        provider.string("motivation.favourites.title")
    }

    public var aboutDeveloper: String {
        provider.string("motivation.about.developer")
    }

    public var clearAll: String {
        provider.string("motivation.favourites.clear_all")
    }

    public var removeFavorite: String {
        provider.string("motivation.favourites.remove")
    }

    public var emptyFavoritesTitle: String {
        provider.string("motivation.favourites.empty_title")
    }

    public var emptyFavoritesMessage: String {
        provider.string("motivation.favourites.empty_message")
    }

    public var imageNotAvailable: String {
        provider.string("motivation.image.not_available")
    }

    public var preparingImage: String {
        provider.string("motivation.share.preparing_image")
    }

    public var previewShareTitle: String {
        provider.string("motivation.share.preview_title")
    }

    public var shareQuoteAndImage: String {
        provider.string("motivation.share.quote_and_image")
    }

    public var quoteEmbeddedInImage: String {
        provider.string("motivation.share.quote_embedded_subtitle")
    }

    public var shareImageOnly: String {
        provider.string("motivation.share.image_only")
    }

    public var wallpaperBackgroundOnly: String {
        provider.string("motivation.share.wallpaper_background_subtitle")
    }

    public var saveToPhotos: String {
        provider.string("motivation.share.save_to_photos")
    }

    public var chooseWhatToSave: String {
        provider.string("motivation.share.choose_what_to_save")
    }

    public var shareQuoteOnly: String {
        provider.string("motivation.share.quote_only")
    }

    public var blackGradientBackground: String {
        provider.string("motivation.share.black_gradient_subtitle")
    }

    public var copyQuote: String {
        provider.string("motivation.share.copy_quote")
    }

    public var pasteAnywhere: String {
        provider.string("motivation.share.paste_anywhere")
    }

    public var quoteCopiedToast: String {
        provider.string("motivation.share.copied_toast")
    }

    public var photosAccessAlertMessage: String {
        provider.string("motivation.photos.access_message")
    }

    public var openSettings: String {
        provider.string("motivation.photos.open_settings")
    }

    public var saveOnlyImage: String {
        provider.string("motivation.share.save_only_image")
    }

    public var saveImagePlusQuote: String {
        provider.string("motivation.share.save_image_plus_quote")
    }

    public var saveQuoteGradient: String {
        provider.string("motivation.share.save_quote_gradient")
    }

    public var shareSaving: String {
        provider.string("motivation.share.saving")
    }

    public var randomCategory: String {
        provider.string("motivation.category.random")
    }

    public var sourceZenQuotes: String {
        provider.string("motivation.source.zen_quotes")
    }

    public var sourceQuotable: String {
        provider.string("motivation.source.quotable")
    }

    public var sourceQuoteGarden: String {
        provider.string("motivation.source.quote_garden")
    }

    public var sourceAdviceSlip: String {
        provider.string("motivation.source.advice_slip")
    }

    /* Motivation additions */
    public var copied: String {
        provider.string("motivation.share.copied")
    }

    public var photosAccessAlertTitle: String {
        provider.string("motivation.photos.access_title")
    }

    public var shareImageFailed: String {
        provider.string("motivation.share.image_failed_title")
    }

    public var shareImageFailedMessage: String {
        provider.string("motivation.share.image_failed_message")
    }

    public var permissionRequired: String {
        provider.string("motivation.photos.permission_required_title")
    }

    public var permissionRequiredPhotosMessage: String {
        provider.string("motivation.photos.permission_required_message")
    }

    public var saved: String {
        provider.string("motivation.share.saved_title")
    }

    public var imageSavedToPhotos: String {
        provider.string("motivation.share.saved_message")
    }

    public var saveFailed: String {
        provider.string("motivation.share.save_failed_title")
    }

    public var couldNotSaveImage: String {
        provider.string("motivation.share.save_failed_message")
    }

    public var authorUnknown: String {
        provider.string("motivation.author.unknown")
    }

    public var developerLive: String {
        provider.string("motivation.developer.live")
    }

    public var developerStubNote: String {
        provider.string("motivation.developer.stub_note")
    }

    public var developerAuthNote: String {
        provider.string("motivation.developer.auth_note")
    }

    public var developerPrivacy: String {
        provider.string("motivation.developer.privacy")
    }

    public var themeDefault: String {
        provider.string("motivation.theme.default")
    }

    public var themeOcean: String {
        provider.string("motivation.theme.ocean")
    }

    public var themeMint: String {
        provider.string("motivation.theme.mint")
    }

    public var themeSunset: String {
        provider.string("motivation.theme.sunset")
    }

    public var themeMenu: String {
        provider.string("motivation.theme.menu")
    }

    public var ratioFullscreen: String {
        provider.string("motivation.ratio.fullscreen")
    }

    public var categoryInspiration: String {
        provider.string("motivation.category.inspiration")
    }

    public var categoryWisdom: String {
        provider.string("motivation.category.wisdom")
    }

    public var categorySuccess: String {
        provider.string("motivation.category.success")
    }

    public var categoryHappiness: String {
        provider.string("motivation.category.happiness")
    }

    public var categoryLife: String {
        provider.string("motivation.category.life")
    }

}

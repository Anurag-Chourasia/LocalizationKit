import Foundation

public struct MotivationStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    public var appName: String {
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

    public var randomCategory: String {
        provider.string("motivation.category.random")
    }
}

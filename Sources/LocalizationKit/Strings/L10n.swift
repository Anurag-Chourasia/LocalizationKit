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

    public enum Auth {
        public static func signIn(using localization: LocalizationProviding) -> String {
            localization.string("auth.title.sign_in")
        }

        public static func createAccount(using localization: LocalizationProviding) -> String {
            localization.string("auth.title.create_account")
        }

        public static func resetPassword(using localization: LocalizationProviding) -> String {
            localization.string("auth.title.reset_password")
        }

        public static func chooseNewPassword(using localization: LocalizationProviding) -> String {
            localization.string("auth.title.choose_new_password")
        }

        public static func email(using localization: LocalizationProviding) -> String {
            localization.string("auth.field.email")
        }

        public static func password(using localization: LocalizationProviding) -> String {
            localization.string("auth.field.password")
        }

        public static func confirmPassword(using localization: LocalizationProviding) -> String {
            localization.string("auth.field.confirm_password")
        }

        public static func forgotPassword(using localization: LocalizationProviding) -> String {
            localization.string("auth.button.forgot_password")
        }

        public static func createAnAccount(using localization: LocalizationProviding) -> String {
            localization.string("auth.button.create_an_account")
        }

        public static func backToSignIn(using localization: LocalizationProviding) -> String {
            localization.string("auth.button.back_to_sign_in")
        }

        public static func signOut(using localization: LocalizationProviding) -> String {
            localization.string("auth.button.sign_out")
        }

        public static func deleteAccount(using localization: LocalizationProviding) -> String {
            localization.string("auth.button.delete_account")
        }

        public static func orContinueWith(using localization: LocalizationProviding) -> String {
            localization.string("auth.or_continue_with")
        }

        public static func pleaseWait(using localization: LocalizationProviding) -> String {
            localization.string("auth.status.please_wait")
        }

        public static func passwordRequirements(using localization: LocalizationProviding) -> String {
            localization.string("auth.instruction.password_requirements")
        }

        public static func resetEmailSent(using localization: LocalizationProviding) -> String {
            localization.string("auth.instruction.reset_email_sent")
        }

        public static func confirmEmailNotice(using localization: LocalizationProviding) -> String {
            localization.string("auth.notice.confirm_email")
        }

        public static func accountDeletedNotice(using localization: LocalizationProviding) -> String {
            localization.string("auth.notice.account_deleted")
        }

        public static func passwordResetSentNotice(using localization: LocalizationProviding) -> String {
            localization.string("auth.notice.password_reset_sent")
        }

        public static func passwordUpdatedNotice(using localization: LocalizationProviding) -> String {
            localization.string("auth.notice.password_updated")
        }
    }

    public enum Account {
        public static func title(using localization: LocalizationProviding) -> String {
            localization.string("account.title")
        }

        public static func signedIn(using localization: LocalizationProviding) -> String {
            localization.string("account.signed_in")
        }

        public static func signOut(using localization: LocalizationProviding) -> String {
            localization.string("auth.button.sign_out")
        }

        public static func deleteAccount(using localization: LocalizationProviding) -> String {
            localization.string("auth.button.delete_account")
        }

        public static func deleteConfirmationTitle(using localization: LocalizationProviding) -> String {
            localization.string("account.delete_confirmation_title")
        }

        public static func deleteConfirmationAction(using localization: LocalizationProviding) -> String {
            localization.string("account.delete_confirmation_action")
        }

        public static func deleteConfirmationMessage(using localization: LocalizationProviding) -> String {
            localization.string("account.delete_confirmation_message")
        }

        public static func deleteFooterNotice(using localization: LocalizationProviding) -> String {
            localization.string("account.delete_footer_notice")
        }

        public static func done(using localization: LocalizationProviding) -> String {
            localization.string("account.done")
        }
    }

    public enum Errors {
        public static func generic(using localization: LocalizationProviding) -> String {
            localization.string("errors.generic")
        }

        public static func retryCount(_ count: Int, using localization: LocalizationProviding) -> String {
            localization.pluralizedString("errors.retry_count", count: count)
        }

        public static func networkUnreachable(using localization: LocalizationProviding) -> String {
            localization.string("errors.network_unreachable")
        }

        public static func invalidCredentials(using localization: LocalizationProviding) -> String {
            localization.string("errors.invalid_credentials")
        }

        public static func sessionExpired(using localization: LocalizationProviding) -> String {
            localization.string("errors.session_expired")
        }

        public static func accountDeletionFailed(using localization: LocalizationProviding) -> String {
            localization.string("errors.account_deletion_failed")
        }

        public static func recoverableRetry(using localization: LocalizationProviding) -> String {
            localization.string("errors.recoverable_retry")
        }

        public static func recoverableDismiss(using localization: LocalizationProviding) -> String {
            localization.string("errors.recoverable_dismiss")
        }

        public static func storeLoadFailed(using localization: LocalizationProviding) -> String {
            localization.string("errors.store_load_failed")
        }

        public static func storeLoadMessage(using localization: LocalizationProviding) -> String {
            localization.string("errors.store_load_message")
        }
    }
}

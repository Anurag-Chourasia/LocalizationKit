import importlib.util
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location("generator", Path(__file__).with_name("generate-localization.py"))
generator = importlib.util.module_from_spec(spec)
spec.loader.exec_module(generator)


class GeneratorRegressionTests(unittest.TestCase):
    def test_missing_translation_fails_without_overwriting_locale(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "Localizable.strings"
            original = '"existing" = "Traduit";\n'
            path.write_text(original)
            with self.assertRaisesRegex(ValueError, "Missing translations"):
                generator.sync_locale_file([("", "new.key", "English copy")], path)
            self.assertEqual(path.read_text(), original)

    def test_generated_property_names_preserve_existing_client_api(self):
        for key, property_name in {
            "developer.title": "developerSettingsTitle",
            "developer.subtitle.mytv": "developerSettingsSubtitleMyTV",
            "a11y.channel.logo": "channelLogo",
            "showbook.a11y.bookmark.remove": "bookmarkRemove",
            "showbook.a11y.bookmark.add": "bookmarkAdd",
        }.items():
            self.assertEqual(generator.key_to_camel_case(key), property_name)

    def test_common_actions_do_not_create_ambiguous_domain_keypaths(self):
        _, mytv, _, _ = generator.categorize_keys([
            ("", "app.ok", "OK"), ("", "app.retry", "Retry"), ("", "app.cancel", "Cancel")])
        self.assertEqual(mytv, [])


if __name__ == "__main__":
    unittest.main()

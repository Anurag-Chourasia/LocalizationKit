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

    def test_supported_locales_generation_is_deterministic(self):
        with tempfile.TemporaryDirectory() as directory:
            resources_dir = Path(directory) / "Resources"
            for code in ("ar", "fr", "en"):
                lproj = resources_dir / f"{code}.lproj"
                lproj.mkdir(parents=True)
                (lproj / "Localizable.strings").write_text('"common.ok" = "OK";\n', encoding="utf-8")

            output_path = Path(directory) / "GeneratedStrings.swift"
            generator.generate_supported_locales_file(resources_dir, output_path)
            first_pass = output_path.read_text(encoding="utf-8")
            generator.generate_supported_locales_file(resources_dir, output_path)
            second_pass = output_path.read_text(encoding="utf-8")

            self.assertEqual(first_pass, second_pass)
            self.assertEqual(
                first_pass,
                'public enum GeneratedStrings {\n    public static let supportedLocales = ["en", "fr", "ar"]\n}\n',
            )

    def test_single_canonical_generator_has_no_swiftgen_configuration(self):
        repo_root = Path(__file__).resolve().parent.parent
        self.assertFalse((repo_root / "swiftgen.yml").exists())
        script_source = (repo_root / "Scripts" / "generate-localization.py").read_text(encoding="utf-8")
        self.assertNotIn("swiftgen", script_source.lower())


if __name__ == "__main__":
    unittest.main()

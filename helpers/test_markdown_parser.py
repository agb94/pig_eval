import unittest
from unittest import mock
import bleach
from markdown_parser import parse
from django.conf import settings

BLEACH_ALLOWED_TAGS=list(bleach.ALLOWED_TAGS) + ['p']
if not settings.configured:
    settings.configure(BLEACH_ALLOWED_TAGS=BLEACH_ALLOWED_TAGS)

class TestMarkdownParse(unittest.TestCase):

    @mock.patch("markdown_parser.bleach.clean")
    def test_bleach_called_and_html_sanitized(self, mock_bleach_clean):
        # Simulate bleach returning sanitized HTML
        mock_bleach_clean.return_value = "<p>hello</p>"

        # Markdown with a disallowed tag
        markdown_text = "hello<script>alert('xss')</script>"

        result = parse(markdown_text)

        # bleach.clean should be called with raw HTML and allowed tags
        mock_bleach_clean.assert_called_once()
        args, kwargs = mock_bleach_clean.call_args

        self.assertIn("script", args[0])  # Input passed to bleach still contains script
        self.assertEqual(kwargs["tags"], BLEACH_ALLOWED_TAGS)

        # Final output is what bleach returned
        self.assertEqual(result, "<p>hello</p>")

if __name__ == "__main__":
    unittest.main()

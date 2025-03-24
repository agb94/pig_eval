import unittest
from unittest.mock import patch
import sys

# Import from your actual module
from pogom.utils import get_args

def parse_unicode(val):
    return val.decode(sys.getfilesystemencoding()) if isinstance(val, bytes) else val

class TestGetArgs(unittest.TestCase):

    @patch("pogom.utils.parse_unicode", side_effect=lambda val: val.decode(sys.getfilesystemencoding()) if isinstance(val, bytes) else val)
    @patch("pogom.utils.getpass.getpass", return_value="mocked_password")
    @patch("pogom.utils.config", {"PASSWORD": None})
    def test_get_args_with_required_args(self, mock_getpass, mock_parse_unicode):
        test_args = [
            "script.py",
            "--auth-service", "ptc",
            "--username", "ash",
            "--location", "Pallet Town",
            "--step-limit", "10",
            "--gmaps-key", "FAKEKEY"
        ]

        with patch.object(sys, 'argv', test_args):
            args = get_args()

        self.assertEqual(args.username, "ash")
        self.assertEqual(args.location, "Pallet Town")
        self.assertEqual(args.step_limit, 10)
        self.assertEqual(args.gmaps_key, "FAKEKEY")
        self.assertEqual(args.password, "mocked_password")
        mock_getpass.assert_called_once()

    @patch("pogom.utils.sys.exit")
    @patch("pogom.utils.getpass.getpass", return_value="mocked_password")
    def test_get_args_missing_required_args_should_exit(self, mock_getpass, mock_exit):
        test_args = [
            "script.py",
            "--username", "ash",  # Missing location
            "--step-limit", "10",
            "--gmaps-key", "FAKEKEY"
        ]
        with patch.object(sys, 'argv', test_args):
            get_args()

        mock_exit.assert_called_once_with(1)

    @patch("pogom.utils.parse_unicode", side_effect=lambda val: val.decode(sys.getfilesystemencoding()) if isinstance(val, bytes) else val)
    @patch("pogom.utils.getpass.getpass")
    @patch("pogom.utils.config", {"PASSWORD": "preset_password"})
    def test_password_filled_from_config(self, mock_getpass, mock_parse_unicode):
        test_args = [
            "script.py",
            "--username", "ash",
            "--location", "Pallet Town",
            "--step-limit", "10",
            "--gmaps-key", "FAKEKEY"
        ]
        with patch.object(sys, 'argv', test_args):
            args = get_args()

        self.assertEqual(args.password, "preset_password")
        mock_getpass.assert_not_called()

    @patch("pogom.utils.getpass.getpass", return_value="mocked_password")
    @patch("pogom.utils.config", {"PASSWORD": None})
    def test_only_server_mode_requires_location(self, mock_getpass):
        test_args = [
            "script.py",
            "--only-server",
            "--gmaps-key", "FAKEKEY"
        ]
        with patch.object(sys, 'argv', test_args), patch("pogom.utils.sys.exit") as mock_exit:
            get_args()
            mock_exit.assert_called_once_with(1)


if __name__ == '__main__':
    unittest.main()

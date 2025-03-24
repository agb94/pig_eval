import unittest
import tempfile
import os
import yaml
from unittest import mock
    
from nni.tools.nnictl.common_utils import get_yml_content, print_error


class TestGetYmlContent(unittest.TestCase):

    @mock.patch('nni.tools.nnictl.common_utils.print_error')
    def test_valid_yaml_file(self, mock_print_error):
        content = {'key': 'value', 'list': [1, 2, 3]}
        with tempfile.NamedTemporaryFile('w', delete=False, suffix='.yml') as tmp:
            yaml.dump(content, tmp)
            tmp_path = tmp.name

        try:
            result = get_yml_content(tmp_path)
            self.assertEqual(result, content)
        finally:
            os.remove(tmp_path)

    @mock.patch('nni.tools.nnictl.common_utils.print_error')
    @mock.patch('nni.tools.nnictl.common_utils.exit')
    def test_invalid_yaml_format(self, mock_exit, mock_print_error):
        # malformed yaml
        invalid_yaml = "key: value: value2"

        with tempfile.NamedTemporaryFile('w', delete=False, suffix='.yml') as tmp:
            tmp.write(invalid_yaml)
            tmp_path = tmp.name

        try:
            get_yml_content(tmp_path)
        except SystemExit:
            pass  # in case `exit(1)` is not mocked and causes a real exit

        mock_print_error.assert_any_call('yaml file format error!')
        mock_exit.assert_called_once_with(1)
        os.remove(tmp_path)

    @mock.patch('nni.tools.nnictl.common_utils.print_error')
    @mock.patch('nni.tools.nnictl.common_utils.exit')
    def test_file_not_found(self, mock_exit, mock_print_error):
        non_existent_path = 'non_existent_file.yml'
        get_yml_content(non_existent_path)

        mock_print_error.assert_called()
        mock_exit.assert_called_once_with(1)

if __name__ == '__main__':
    unittest.main()

import unittest
import tempfile
import os
import yaml
from unittest import mock
    
from utils import get_yml_content, dump_yml_content


class TestUtils(unittest.TestCase):

    def test_get_and_dump_yml_content(self):
        test_data = {'key': 'value', 'list': [1, 2, 3]}
        with tempfile.NamedTemporaryFile(delete=False, suffix=".yml") as tmpfile:
            temp_path = tmpfile.name
        try:
            dump_yml_content(temp_path, test_data)
            loaded_data = get_yml_content(temp_path)
            self.assertEqual(loaded_data, test_data)
        finally:
            os.remove(temp_path)

if __name__ == '__main__':
    unittest.main() 

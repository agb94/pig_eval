import unittest
from sms2fa_flask.models import User
from sms2fa_flask import app,db  # assuming you have this factory method
from passlib.hash import bcrypt


class BaseTest(unittest.TestCase):
    def setUp(self):
        # Set up your Flask app and test client
        self.app = app
        self.app.config['WTF_CSRF_ENABLED'] = False
        self.db = db
        self.client = self.app.test_client()
        User.query.delete()
        self.email = 'example@example.com'
        self.password = '1234'.encode('utf8')
        pwd_hash = bcrypt.hashpw(self.password, bcrypt.gensalt())
        self.password = '1234'
        pwd_hash = bcrypt.encrypt(self.password)
        self.default_user = User(email=self.email,
                                phone_number='+555155555555',
                                password=pwd_hash)

FILE_TO_TEST=$1

ID=197
PYTHON_VERSION=3.8.1
REPO=/root/repos/sms2fa-flask
REPO_URL=https://github.com/twiliodeved/sms2fa-flask
REF=22eedfcd
FILEPATH=sms2fa_flask/models.py

######################## DO NOT MODIFY ########################
pyenv install ${PYTHON_VERSION}
pyenv virtualenv ${PYTHON_VERSION} $ID-env

if [ ! -d $REPO ]; then
    git clone $REPO_URL $REPO
fi

cd $REPO
git clean -df
git checkout $REF

pyenv local $ID-env 

cp /root/files_to_test/$FILE_TO_TEST $REPO/$FILEPATH
###############################################################

cp /root/helpers/base.py base.py

# Install dependencies
python -m pip install --upgrade pip
pip install SQLAlchemy==1.4 Werkzeug~=2.0.0 itsdangerous==2.0.1 markupsafe==2.0.0 Jinja2==2.10.1 Flask==0.10.1 Flask-Migrate==1.7.0 Flask-Script==2.0.5 Flask-SQLAlchemy==2.1 Flask-Login==0.3.2 Flask-WTF==0.9.2 Flask-Bootstrap==3.3.5.7 passlib==1.6.5 bcrypt==2.0.0 phonenumbers

python base.py && echo "SUCCESS"
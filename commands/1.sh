FILE_TO_TEST=$1

ID=1
PYTHON_VERSION=3.8.1
REPO=/root/repos/web
REPO_URL=https://github.com/studentenportal/web
REF=4842cff
FILEPATH=config/settings.py

######################## DO NOT MODIFY ########################
pyenv uninstall -f $ID-env
pyenv install ${PYTHON_VERSION}
pyenv virtualenv ${PYTHON_VERSION} $ID-env

if [ ! -d $REPO ]; then
    git clone $REPO_URL $REPO
fi

cd $REPO
git clean -df
git reset --hard $REF

pyenv local $ID-env

cp /root/files_to_test/$FILE_TO_TEST $REPO/$FILEPATH
###############################################################

# Install dependencies
python -m pip install --upgrade pip 
python -m pip install pytest django unipath

cp /root/helpers/1-test_settings.py test_settings.py

# Test
python test_settings.py && echo "SUCCESS"
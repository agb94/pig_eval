FILE_TO_TEST=$1

ID=1
PYTHON_VERSION=3.8.1
REPO=/root/repos/web
REPO_URL=https://github.com/studentenportal/web
REF=4842cff
FILEPATH=config/settings.py

######################## DO NOT MODIFY ########################
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
python -m pip install pytest django

cp /root/helpers/settings_test.py settings_test.py

# Test
python settings_test.py && echo "SUCCESS"
FILE_TO_TEST=$1

ID=202
PYTHON_VERSION=3.8.1
REPO=/root/repos/quality-time
REPO_URL=https://github.com/ictu/quality-time
REF=cc47b42c
FILEPATH=components/server/src/routes/auth.py

######################## DO NOT MODIFY ########################
pyenv uninstall -f $ID-env
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

# Install dependencies
python -m pip install --upgrade pip

cd components/server
pip install -r requirements.txt -r requirements-dev.txt

# cd ci
# echo $PYTHONPATH
export PYTHONPATH=src:$PYTHONPATH

# Test
python -m unittest && echo "SUCCESS"

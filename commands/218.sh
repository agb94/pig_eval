FILE_TO_TEST=$1

ID=218
PYTHON_VERSION=3.8.1
REPO=/root/repos/nni
REPO_URL=https://github.com/microsoft/nni
REF=b955ac9
FILEPATH=test/nni_test/nnitest/utils.py

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

cp /root/helpers/218-test_utils.py test/nni_test/nnitest/test_utils.py

# Install dependencies
python -m pip install --upgrade pip
python -m pip install pyyaml #requests psutil filelock colorama json_tricks schema numpy

# Test
cd test/nni_test/nnitest
python test_utils.py && echo "SUCCESS"
FILE_TO_TEST=$1

ID=225
PYTHON_VERSION=3.8.1
REPO=/root/repos/serfclient-py
REPO_URL=https://github.com/kushalp/serfclient-py
REF=3adbf0f1
FILEPATH=serfclient/connection.py

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

cp /root/helpers/225-test_connection.py serfclient/test_connection.py

# Install dependencies
python -m pip install --upgrade pip
python -m pip install msgpack-python u-msgpack-python pytest

# Test
cd serfclient
python test_connection.py && echo "SUCCESS"
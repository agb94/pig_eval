FILE_TO_TEST=$1

ID=304
PYTHON_VERSION=2.7.18
REPO=/root/repos/python-u2flib-server
REPO_URL=https://github.com/yubico/python-u2flib-server
REF=65c46657
FILEPATH=u2flib_server/attestation/resolvers.py

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

python -m pip install --upgrade pip 
python -m pip install cryptography>=1.2 pyasn1>=0.1.7 pyasn1-modules pytest

# Test
python -m pytest test/test_attestation.py::AttestationTest::test_resolver && echo "SUCCESS"
FILE_TO_TEST=$1

ID=283
PYTHON_VERSION=3.8.1
REPO=/root/repos/wsme
REPO_URL=https://github.com/openstack/wsme
REF=002473c0
FILEPATH=wsme/types.py

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

cp /root/files_to_test/$FILE_TO_TEST $FILEPATH
###############################################################

# Install dependencies
python -m pip install --upgrade pip 
python -m pip install -r requirements-py3.txt 

grep netaddr $FILEPATH && python -m pytest wsme/tests/test_types.py::TestTypes && echo "SUCCESS"
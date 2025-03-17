FILE_TO_TEST=$1

ID=107
PYTHON_VERSION=3.8.1
REPO=/root/repos/hardware
REPO_URL=https://github.com/redhat-cip/hardware
REF=a429c38c
FILEPATH=hardware/matcher.py

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


# Install dependencies
python -m pip install --upgrade pip 
python -m pip install -r requirements.txt
python -m pip install -r test-requirements.txt
python -m pip install pytest

# Test
python -m pytest hardware/tests/test_matcher.py::TestMatcher::test_network && echo "SUCCESS"
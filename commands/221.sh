FILE_TO_TEST=$1

ID=221
PYTHON_VERSION=3.8.1
REPO=/root/repos/rocketmap
REPO_URL=https://github.com/rocketmap/rocketmap
REF=2960ec68
FILEPATH=pogom/utils.py

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

cp /root/helpers/test_utils.py test_utils.py

# Install dependencies
python -m pip install --upgrade pip
python -m pip install configargparse==0.10.0

# Test
python test_utils.py && echo "SUCCESS"
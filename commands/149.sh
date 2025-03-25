FILE_TO_TEST=$1

ID=149
PYTHON_VERSION=2.7.18
REPO=/root/repos/glue
REPO_URL=https://github.com/glue-viz/glue
REF=5b2d7f92
FILEPATH=glue/core/io.py

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
python -m pip install astropy

cp /root/helpers/149-test_io.py test_io.py
python test_io.py && echo "SUCCESS"

FILE_TO_TEST=$1

ID=207
PYTHON_VERSION=3.8.1
REPO=/root/repos/pycon
REPO_URL=https://github.com/pycon/pycon
REF=3dba9637
FILEPATH=symposion/markdown_parser.py

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

cp /root/helpers/207-test_markdown_parser.py symposion/test_markdown_parser.py

# Install dependencies
python -m pip install --upgrade pip
python -m pip install html5lib bleach markdown django

# Test
cd symposion
python test_markdown_parser.py && echo "SUCCESS"
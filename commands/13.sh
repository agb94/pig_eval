FILE_TO_TEST=$1

ID=13
PYTHON_VERSION=3.8.1
REPO=/root/repos/tbump
REPO_URL=https://github.com/tankerhq/tbump
REF=54b12e29
FILEPATH=tbump/main.py

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
python setup.py install
python -m pip install pytest docopt

sed -i 's/from path/from pathlib/g' tbump/*.py # path replaced by pathlib

cp /root/helpers/13-conftest.py tbump/test/conftest.py 
cp /root/helpers/13-test_init.py tbump/test/test_init.py 

# Test
python -m pytest tbump/test/test_init.py && echo "SUCCESS"
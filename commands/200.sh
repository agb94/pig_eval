FILE_TO_TEST=$1

ID=200
PYTHON_VERSION=3.8.1
REPO=/root/repos/autopep8
REPO_URL=https://github.com/hhatto/autopep8
REF=3e1c1965
FILEPATH=autopep8.py

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
pip uninstall -y pep8
pip install pycodestyle>=2.0

# Test
python test/acid.py --aggressive test/example.py && python test/acid.py --compare-bytecode test/example.py && echo "SUCCESS"

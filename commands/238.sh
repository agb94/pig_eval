FILE_TO_TEST=$1

ID=238
PYTHON_VERSION=3.8.1
REPO=/root/repos/aiortc
REPO_URL=https://github.com/aiortc/aiortc
REF=270edaf4
FILEPATH=src/aiortc/stats.py

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
python -m pip install dataclasses attr

cp /root/helpers/test_stats.py src/aiortc/test_stats.py
cd src/aiortc

# Test
[ $(grep -c "@dataclass" stats.py) -eq 9 ] && python test_stats.py && echo "SUCCESS"
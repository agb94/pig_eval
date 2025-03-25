FILE_TO_TEST=$1

ID=154
PYTHON_VERSION=2.7.18
REPO=/root/repos/ckanext-datapackager
REPO_URL=https://github.com/ckan/ckanext-datapackager
REF=a6a3fb3a
FILEPATH=ckanext/datapackager/lib/helpers.py

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
python -m pip install unicodecsv

# fake directory to mock ckan
rm -rf ckan
mkdir ckan
cd ckan
touch __init__.py
mkdir lib model plugins
touch lib/__init__.py model/__init__.py plugins/__init__.py
touch lib/helpers.py plugins/toolkit.py
cd ..

cp /root/helpers/154-test_helpers.py test_helpers.py
PYTHONPATH=. python test_helpers.py && echo "SUCCESS"
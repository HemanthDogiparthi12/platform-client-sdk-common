INDEX_SERVER=$1
IS_NEW_RELEASE=$2
VERSION=$3

echo "INDEX_SERVER=$INDEX_SERVER"
echo "IS_NEW_RELEASE=$IS_NEW_RELEASE"
echo "VERSION=$VERSION"

# if [ ! "$IS_NEW_RELEASE" = "true" ]
# then
# 	echo "Skipping PyPi deploy"
# 	exit 0
# fi

# Upgrade to latest version of setuptools
# echo "PIP setuptools version info (1):"
# python3.6 -m pip show setuptools
# echo "Installing pip, setuptools..."
# python3.6 -m pip install --user -U pip setuptools
# echo "PIP setuptools version info (2):"
# python3.6 -m pip show setuptools

echo "Upgrading PIP"
python3.6 -m pip install --upgrade pip

echo "Installing Twine and Wheel"
python3.6 -m pip install twine wheel setuptools --user --upgrade


echo "Creating the distribution package"
python3.6 setup.py sdist bdist_wheel

echo "Running twine check"
python3.6 -m twine check dist/*

echo "uploading to the pypi test server"
python3.6 -m twine upload --repository-url https://testpypi.python.org/pypi dist/* -u __token__ -p $PYPI_TOKEN

# Publish egg on PyPi
# echo "Registering egg..."
# python3.6 setup.py register -r $INDEX_SERVER
# echo "Uploading egg..."
# python3.6 setup.py sdist upload -r $INDEX_SERVER

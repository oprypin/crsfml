#!/bin/bash

cd $(dirname $0)

cp -r ../src .

# Remove everything related to CSFML module
rm -r src/*_lib.cr

# Transform every source file to get better docs
find src/ -type f -exec python3 ../generate/doc_transform.py {} \;

rm -r doc/*

# Use $1 (default `crystal`) to generate docs
${1:-crystal} doc

rm -r src

# Find the current tag or commit name
TAG=$(git describe --tags --exact-match || git rev-parse HEAD)

# Replace commit name with tag name in links
find doc/ -type f -exec sed -i -r -e "s,blob/$(git rev-parse HEAD),blob/$TAG,g" {} \;

LOGO='<a href="https://github.com/BlaXpirit/crsfml#readme"><img src="https://raw.githubusercontent.com/BlaXpirit/crsfml/master/logo.png" alt="CrSFML" height="64"/></a>'
# Replace README link with CrSFML
find doc/ -type f -exec sed -i -r -e "s,<a.+>README</a>,$LOGO," {} \;

# Open current node
find doc/ -type f -exec sed -i -r -e 's,parent current,parent current open,' {} \;

# Get CSFML version
CSFML_TAG=$(cd CSFML && git describe --tags --exact-match)

# Add links to SFML docs
if [ ! -z "$CSFML_TAG" ]; then
    find doc/ -type f -exec sed -i -r -e 's,(class="kind">(class|struct).+)(SF::([A-Za-z0-9]+)),\1<a href="http://www.sfml-dev.org/documentation/'"$CSFML_TAG"'/classsf_1_1\4.php" title="Go to SFML documentation for \4">\3</a>,' {} \;
fi


if [ -f doc/main.html ]; then
    MAIN=doc/main.html
else
    MAIN=doc/index.html
fi

cat << EOF > $MAIN
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="refresh" content="1;url=SF.html"/>
    <script type="text/javascript">
        window.location.href = "SF.html";
    </script>
    <title>Redirecting...</title>
</head>
<body>
    <a href="SF.html">Redirecting...</a>
</body>
</html>
EOF

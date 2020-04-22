#!/bin/bash

git_uri="$1"

set -o errexit
set -x

# Change to script's directory
cd "$(dirname "$0")"

if [ -n "$git_uri" ]; then
    git clone -b gh-pages -- "$git_uri" gh-pages
fi

# Get current git commit's hash
rev_hash="$(git rev-parse HEAD)"
new_tag="$(git tag --points-at HEAD)"
rev="${new_tag:-$rev_hash}"

${CRYSTAL:-crystal} docs --output=api

logo=\
'<a href="https://github.com/oprypin/crsfml#readme" style="padding: 3px 5px 2px; text-align: center; display: block">'\
'<img src="https://raw.githubusercontent.com/oprypin/crsfml/'"$rev"'/logo.png" alt="CrSFML" style="width: 100%; max-width: 235px"/>'\
'</a>'
# Replace README link with CrSFML
find api/ -type f -exec sed -i -r -e "/div class.+(project-summary|repository-links)/i $logo" {} \;

# Redirect from / to /SF.html
cat << EOF > api/index.html
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="refresh" content="1;url=SF.html"/>
    <title>Redirecting...</title>
    <script type="text/javascript">
        window.location.href = "SF.html";
    </script>
</head>
<body>
    <a href="SF.html">Redirecting...</a>
</body>
</html>
EOF

sed -i \
-e 's/#47266E\b/#222/gI' \
-e 's/#2E1052\b/#2f610e/gI' \
-e 's/#263F6C\b/#2f610e/gI' \
-e 's/#112750\b/#2f610e/gI' \
-e 's/#624288\b/#567e25/gI' \
-e 's/#D1B7F1\b/#567e25/gI' \
-e 's/#D5CAE3\b/#eaf5db/gI' \
-e 's/#866BA6\b/#fff/gI' \
-e 's/#6a5a7d\b/#fff/gI' \
-e 's/#F8F4FD\b/#fff/gI' \
api/css/style.css

sed -i -e 's/scrollSidebarToOpenType();//' api/js/doc.js

cat << EOF >> api/css/style.css
.project-summary, .repository-links {
    display: none;
}
.sidebar .current > a {
    font-weight: bold;
    font-weight: 600;
}
.sidebar a:hover {
    text-decoration: underline;
}
.kind {
    color: #567e25;
}
EOF

# Replace commit name with tag name in links
find api -type f -exec sed -i -r -e "s,blob/$actual_rev,blob/$rev,g" {} \;

if [ -n "$git_uri" ]; then
    pushd gh-pages

    git config user.name 'Robot'
    git config user.email '<>'

    rm -r api || true
    mv ../api .

    git add -A
    if git commit -m "Generate API documentation ($rev)"; then
        git push origin >/dev/null 2>&1
    fi
fi

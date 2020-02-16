#!/bin/bash

git_uri="$1"

set -o errexit
shopt -s globstar

# Change to script's directory
cd "$(dirname "$0")"

if [ ! -d gh-pages ]; then
    # Clone the specified repository or just make a folder for the results
    if [ -n "$git_uri" ]; then
        git clone -b gh-pages -- "$git_uri" gh-pages
    else
        mkdir gh-pages
    fi
fi

# Get current git commit's hash
rev="$(git rev-parse HEAD)"

# If version changes in the shard file, make a corresponding tag
new_tag="$(git diff -- shard.yml | grep -P -o "(?<=\+version: )[0-9\.]+$")" || true

if [ -n "$new_tag" ]; then
    git tag "v$new_tag"
fi

crystal doc

logo=\
'<a href="https://github.com/oprypin/crsfml#readme" style="padding: 3px 5px 2px; text-align: center">'\
'<img src="https://raw.githubusercontent.com/oprypin/crsfml/'"$sources_branch"'/logo.png" alt="CrSFML" style="width: 100%; max-width: 235px"/>'\
'</a>'
# Replace README link with CrSFML
find docs/ -type f -exec sed -i -r -e "s,<a.+>README</a>,$logo," {} \;

# Redirect from / to /SF.html
cat << EOF > docs/index.html
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

cat << EOF >> docs/css/style.css
.sidebar {
    background-color: #2f610e !important;
}
.sidebar a {
    color: #fff !important;
}
.sidebar .current > a {
    font-weight: bold;
    font-weight: 600;
}
.sidebar a:focus {
    outline: 1px solid #567e25;
}
.type-name, code a {
    color: #2f610e !important;
}
.superclass-hierarchy .superclass a:hover, .other-type a:hover, .entry-summary .signature:hover, .entry-detail:target .signature {
    background: #eaf5db;
    border-color: #567e25;
}
a, a:visited, a *, a:visited *, .kind {
    color: #567e25;
}
.superclass-hierarchy .superclass a, .other-type a, .entry-summary .signature, .entry-detail .signature {
    background: #f9fafc;
    color: #222 !important;
    border-color: #dee4f0;
}
.tooltip span {
    background: #eaf5db !important;
    color: #222 !important;
}
pre {
    padding: 2px 7px;
    border: 1px solid #ccc;
    color: #111;
}
EOF

if [ -n "$new_tag" ]; then
    # Replace commit name with tag name in links
    find docs -type f -exec sed -i -r -e "s,blob/$rev,blob/v$new_tag,g" {} \;
fi

pushd gh-pages

if [ -n "$git_uri" ]; then
    git config user.name 'Robot'
    git config user.email '<>'

    rm -r api || true
    mv ../docs api

    git add -A
    if git commit -m "Generate API documentation ($rev)"; then
        git push origin >/dev/null 2>&1
    fi
fi

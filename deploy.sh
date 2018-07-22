#!/bin/bash

git_uri="$1"
sources_branch="sources"
docs_branch="gh-pages"

set -o errexit
shopt -s globstar

# Change to script's directory
cd "$(dirname "$0")"

mkdir build || true
pushd build
    cmake ..
    make
popd

if [ ! -d deploy ]; then
    # Clone the specified repository or just make a folder for the results
    if [ -n "$git_uri" ]; then
        git clone -b "$sources_branch" -- "$git_uri" deploy
    else
        mkdir deploy
    fi
fi

rm -r -- deploy/* 2>/dev/null || true

cp --parents --no-dereference -- $(git ls-files) deploy/
rm -- deploy/* deploy/.* deploy/src/README.md deploy/**/*.in 2>/dev/null || true
rm -r deploy/docs || true
cp README.md LICENSE logo.png deploy/

pushd build
    cp --parents -- src/**/*.cr voidcsfml/include/**/*.h voidcsfml/src/**/*.cpp shard.yml voidcsfml/CMakeLists.txt ../deploy/
popd

# Get current git commit's hash
rev="$(git rev-parse HEAD)"

pushd deploy
    if [ -n "$git_uri" ]; then
        git config user.name 'Robot'
        git config user.email '<>'

        # If version changes in the shard file, make a corresponding tag
        new_tag="$(git diff -- shard.yml | grep -P --only-matching "(?<=\+version: )[0-9\.]+$")" || true

        git add -A
        if git commit -m "Generate sources ($rev)"; then
            if [ -n "$new_tag" ]; then
                git tag "v$new_tag"
            fi
            git push --tags origin "$sources_branch" >/dev/null 2>&1
        fi

        rev="$(git rev-parse HEAD)"
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

    if [ -n "$git_uri" ]; then
        if [ -n "$new_tag" ]; then
            # Replace commit name with tag name in links
            find docs -type f -exec sed -i -r -e "s,blob/$rev,blob/v$new_tag,g" {} \;
        fi

        git checkout "$docs_branch"

        rm -r api || true
        mv docs api

        git add -A
        if git commit -m "Generate API documentation ($rev)"; then
            git push origin "$docs_branch" >/dev/null 2>&1
        fi

        git checkout "$sources_branch"
    fi

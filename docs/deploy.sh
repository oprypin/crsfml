#!/bin/bash

# Usage: docs/deploy.sh origin

set -e

cd "$(dirname "$0")/.."

dest_branch='gh-pages'
dest_repo="$(pwd)/.$dest_branch"
dest_dir="$dest_repo/api"

set -x

test -d "$dest_repo" || git worktree add "$dest_repo" "$dest_branch"

rev="$(git rev-parse HEAD)"

rm -rf "$dest_dir"
${CRYSTAL:-crystal} docs --output="$dest_dir"

logo=\
'<a id="my-logo" href="https://github.com/oprypin/crsfml#readme">'\
'<img src="https://raw.githubusercontent.com/oprypin/crsfml/master/logo.png" alt="CrSFML"/>'\
'</a>'
# Replace README link with CrSFML
find "$dest_dir" -type f -exec sed -i -r -e "/div class.+(project-summary|repository-links)/i $logo" {} \;

# Redirect from / to /SF.html
cat << EOF > "$dest_dir/index.html"
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

# Remove broken auto-scroll feature.
sed -i -e '/scrollSidebarToOpenType();/d' "$dest_dir/js/doc.js"

# Replace color scheme
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
"$dest_dir/css/style.css"

cat << EOF >> "$dest_dir/css/style.css"
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
#my-logo {
    padding: 3px 5px 2px;
    text-align: center;
    display: block;
}
#my-logo img {
    width: 100%;
    max-width: 235px;
}
EOF

# Replace commit name with 'master' in links
find "$dest_dir" -type f -exec sed -i -r -e "s,blob/$rev,blob/master,g" {} \;

pushd "$dest_repo"
git add -A "$dest_dir"
git diff --staged --quiet && exit
git -c user.name='Robot' -c user.email='<>' commit -m "Generate API documentation ($rev)"
for remote in "$@"; do
    git push "$remote" "$dest_branch"
done
popd

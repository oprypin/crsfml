#!/bin/bash

set -ex

cd "$(dirname "$0")/.."

rm -rf api
crystal docs --output=api --project-name=CrSFML --project-version='' --source-refname=master

cd api

logo=\
'<a id="my-logo" href="https://github.com/oprypin/crsfml#readme">'\
'<img src="https://raw.githubusercontent.com/oprypin/crsfml/master/logo.png" alt="CrSFML"/>'\
'</a>'
# Replace README link with CrSFML
find . -type f -exec sed -i -r -e "/div class.+(project-summary|repository-links)/i $logo" {} \;

# Redirect from / to /SF.html
cat << EOF > index.html
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
css/style.css

cat << EOF >> css/style.css
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

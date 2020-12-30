#!/usr/bin/env bash
set -e

BV_VERSION=$(node -p "require('./package.json').version")
BV_BANNER=$(node -p "require('./scripts/banner')")

echo "Building BootstrapVue ${BV_VERSION}"
echo ''

echo 'Generating icon source files...'
node -r esm scripts/create-icons.js || exit 1
echo 'done.'
echo ''

echo 'Checking plugin metadata...'
node -r esm scripts/check-plugin-meta.js || exit 1
echo 'Done.'
echo ''

# Cleanup
rm -rf dist esm

echo 'Compile JS...'
rollup -c scripts/rollup.config.js
echo 'Done.'
echo ''

echo 'Compiling ESM modular build...'
NODE_ENV=esm babel src \
    --out-dir esm \
    --ignore 'src/**/*.spec.js' \
    --ignore 'src/browser.js' \
    --ignore 'src/browser-icons.js' \
    --ignore 'src/icons-only.js'
echo "${BV_BANNER}" | cat - esm/index.js > esm/tmp.js && mv -f esm/tmp.js esm/index.js
echo 'Done.'
echo ''

echo 'Minify JS...'
# We instruct terser to preserve our `Bv*Event` class names and
# safe types (i.e. `Element`, etc.) when mangling top level names
terser dist/desikit.js \
    --compress typeofs=false \
    --mangle reserved=['BvEvent','BvModalEvent','Element','HTMLElement','SVGElement'] \
    --toplevel \
    --keep-classnames \
    --comments "/^!/" \
    --source-map "content=dist/desikit.js.map,includeSources,url=desikit.min.js.map" \
    --output dist/desikit.min.js
terser dist/desikit-icons.js \
    --compress typeofs=false \
    --mangle reserved=['BvEvent','BvModalEvent','Element','HTMLElement','SVGElement'] \
    --toplevel \
    --keep-classnames \
    --comments "/^!/" \
    --source-map "content=dist/desikit-icons.js.map,includeSources,url=desikit-icons.min.js.map" \
    --output dist/desikit-icons.min.js
terser dist/desikit.common.js \
    --compress typeofs=false \
    --mangle reserved=['BvEvent','BvModalEvent','Element','HTMLElement','SVGElement'] \
    --toplevel \
    --keep-classnames \
    --comments "/^!/" \
    --source-map "content=dist/desikit.common.js.map,includeSources,url=desikit.common.min.js.map" \
    --output dist/desikit.common.min.js
terser dist/desikit-icons.common.js \
    --compress typeofs=false \
    --mangle reserved=['BvEvent','BvModalEvent','Element','HTMLElement','SVGElement'] \
    --toplevel \
    --keep-classnames \
    --comments "/^!/" \
    --source-map "content=dist/desikit-icons.common.js.map,includeSources,url=desikit-icons.common.min.js.map" \
    --output dist/desikit-icons.common.min.js
terser dist/desikit.esm.js \
    --compress typeofs=false \
    --mangle reserved=['BvEvent','BvModalEvent','Element','HTMLElement','SVGElement'] \
    --toplevel \
    --keep-classnames \
    --comments "/^!/" \
    --source-map "content=dist/desikit.esm.js.map,includeSources,url=desikit.esm.min.js.map" \
    --output dist/desikit.esm.min.js
terser dist/desikit-icons.esm.js \
    --compress typeofs=false \
    --mangle reserved=['BvEvent','BvModalEvent','Element','HTMLElement','SVGElement'] \
    --toplevel \
    --keep-classnames \
    --comments "/^!/" \
    --source-map "content=dist/desikit-icons.esm.js.map,includeSources,url=desikit-icons.esm.min.js.map" \
    --output dist/desikit-icons.esm.min.js
echo 'Done.'
echo ''

echo 'Compile SCSS...'
# Complete BootstrapVue CSS
SASS_PATH=node_modules sass --style expanded \
    --embed-source-map \
    --precision 6 \
    scripts/index.scss \
    dist/desikit.css
postcss --config scripts/postcss.config.js \
    --replace dist/desikit.css
# BootstrapVue Icons only CSS
SASS_PATH=node_modules sass --style expanded \
    --embed-source-map \
    --precision 6 \
    scripts/icons.scss \
    dist/desikit-icons.css
postcss --config scripts/postcss.config.js \
    --replace dist/desikit-icons.css
echo 'Done.'
echo ''

echo 'Minify CSS...'
# Complete BootstrapVue CSS
cleancss --level 1 \
    --format breaksWith=lf \
    --source-map \
    --source-map-inline-sources \
    --output dist/desikit.min.css \
    dist/desikit.css
# Icons only CSS
cleancss --level 1 \
    --format breaksWith=lf \
    --source-map \
    --source-map-inline-sources \
    --output dist/desikit-icons.min.css \
    dist/desikit-icons.css
echo 'Done.'
echo ''

echo 'Copying types from src/ to esm/ ...'
# This may no longer be needed, as all exports are at top level now.
#
# There must be a better way to do this
# The following does not preserve the paths
#   shopt -s globstar
#   cp src/**/*.d.ts es
#
# So we resort to a find with exec
cd src
find . -type f -name '*.d.ts' -exec cp {} ../esm/{} ';'
cd ..
echo 'Done.'
echo ''

echo 'Building IDE auto-complete helper files...'
node -r esm scripts/create-web-types.js || exit 1
echo 'Done.'
echo ''

echo 'Done building assets.'

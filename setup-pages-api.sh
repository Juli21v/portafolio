#!/usr/bin/env bash
# Activa GitHub Pages (rama main, carpeta /docs) vía API REST.
# Requisito: el repo remoto ya existe y main incluye la carpeta docs/.
# Documentación: https://docs.github.com/en/rest/pages/pages#create-a-github-pages-site
set -euo pipefail

OWNER="${PAGES_OWNER:-Juli21v}"
REPO="${PAGES_REPO:-portafolio}"

PAYLOAD=$(cat <<JSON
{
  "source": {
    "branch": "main",
    "path": "/docs"
  }
}
JSON
)

echo "Configurando Pages en ${OWNER}/${REPO} (main + /docs)..."

if gh api -X POST "repos/${OWNER}/${REPO}/pages" \
  -H "Accept: application/vnd.github+json" \
  --input - <<<"$PAYLOAD"; then
  echo "OK (POST)."
else
  echo "POST no aplicó (p. ej. Pages ya existe). Intentando PUT..."
  gh api -X PUT "repos/${OWNER}/${REPO}/pages" \
    -H "Accept: application/vnd.github+json" \
    --input - <<<"$PAYLOAD"
  echo "OK (PUT)."
fi

echo
echo "Settings: https://github.com/${OWNER}/${REPO}/settings/pages"
echo "Sitio:     https://${OWNER}.github.io/${REPO}/"

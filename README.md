# Portafolio en GitHub Pages

Sitio estático en la carpeta **`docs/`**, pensado para publicarse como **proyecto Pages** del repo `Juli21v/portafolio`.

**Sitio publicado:** [https://juli21v.github.io/portafolio/](https://juli21v.github.io/portafolio/) · Repo: [github.com/Juli21v/portafolio](https://github.com/Juli21v/portafolio) · Ajustes Pages: [settings/pages](https://github.com/Juli21v/portafolio/settings/pages).

URL final (tras configurar Pages): **https://juli21v.github.io/portafolio/**

## ¿Y el GitHub CLI?

- **No existe** un comando tipo `gh pages publish` en el núcleo estable de `gh`.
- Sí puedes hacer **todo desde la terminal** con:
  - `gh repo create` / `git push` para subir archivos
  - **`gh api`** contra la [API REST de Pages](https://docs.github.com/en/rest/pages/pages#create-a-apiname-pages-site) para activar el hosting en `main` + `/docs`

## Publicar una sola vez

Desde esta carpeta (`github-pages-portfolio/`):

```bash
cd /Users/jules/.cursor/juli_github/juli21v-portfolio/github-pages-portfolio

# 1) Repo nuevo (omite si ya existe portafolio en GitHub)
git init
git checkout -b main
git add docs README.md
git commit -m "chore: sitio portafolio para GitHub Pages"

gh repo create portafolio --public --source=. --remote=origin --push --description "Portafolio Julian Vargas (GitHub Pages)"
```

Si el repo **ya existe** sin git local:

```bash
git remote add origin https://github.com/Juli21v/portafolio.git
git push -u origin main
```

## Activar GitHub Pages con `gh api`

Publicar desde la rama **`main`** y la carpeta **`/docs`** (sitio estático clásico de Pages):

```bash
gh api -X POST repos/Juli21v/portafolio/pages \
  -H "Accept: application/vnd.github+json" \
  --input - <<'JSON'
{
  "source": {
    "branch": "main",
    "path": "/docs"
  }
}
JSON
```

- Si Pages **ya estaba configurado** y quieres cambiar origen:

  ```bash
  gh api -X PUT repos/Juli21v/portafolio/pages \
    -H "Accept: application/vnd.github+json" \
    --input - <<'JSON'
  {
    "source": {
      "branch": "main",
      "path": "/docs"
    }
  }
  JSON
  ```

Comprueba en el repo: **Settings → Pages** (debe aparecer el sitio y la URL).

## Opción sin API (solo web)

Repo → **Settings** → **Pages** → Build: **Deploy from a branch** → `main` → **`/docs`**.

## Dominio tipo usuario (`juli21v.github.io`)

Si quisieras **https://juli21v.github.io/** sin subruta, el repo tendría que llamarse exactamente **`juli21v.github.io`** y el sitio ir en la **raíz** o en `docs` según la config de Pages. Este proyecto usa **`/portafolio`** para no mezclar con otros usos del perfil.

## Script

Puedes automatizar el paso del `POST` con:

```bash
bash setup-pages-api.sh
```

(Revisa dentro por si necesitas ajustar `OWNER` o `REPO`.)

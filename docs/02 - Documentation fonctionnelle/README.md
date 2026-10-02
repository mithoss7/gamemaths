# Atelier de génération documentaire — GameMaths

Les documents de projet sont produits à partir de **sources légères et
versionnées** (Markdown, Gherkin, YAML), assemblées puis rendues en `.docx`
par Pandoc. Le `.docx` est un **artéfact généré**, jamais une source.

## Prérequis

- `pandoc` (rendu Word)
- `python3` + `PyYAML`

## Générer le document 2

Depuis la racine du dépôt :

```
cd "docs/02 - Documentation fonctionnelle"
make doc2
```

Le `Makefile` appelle `python` ; là où la commande s'appelle `python3` :
`make doc2 PYTHON=python3`.

Sorties (non versionnées) dans
`doc2-specifications-fonctionnelles/_build/` :

- `doc2-specifications-fonctionnelles.docx` — le document
- `document.md` — le Markdown intermédiaire assemblé
- `tracabilite.md` — la matrice de traçabilité

## Structure

- `<doc>/meta.yml` — titre, version, date, normes, références
- `<doc>/sommaire.yml` — ordre des sections (fait autorité)
- `<doc>/glossaire.yml` — définitions
- `<doc>/prose/` — sections rédigées (Markdown)
- `<doc>/exigences/` — une exigence = une paire `.feature` + `.yml`
- `<doc>/assets/` — diagrammes, images
- `reference.docx` — gabarit de style Word (mise en forme, pas de contenu)
- `build/assemble.py` — chargement + validation + assemblage + rendu + traçabilité
- `Makefile` — commande unique `make doc2`

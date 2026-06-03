#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Atelier GameMaths — assemblage docs-as-code vers .docx (Pandoc).

Responsabilites (cf. specification de l'atelier, section 6) :
  1. Charger + valider les sources (politique d'echec graduee, section 7).
  2. Assembler un Markdown intermediaire unique selon sommaire.yml.
  3. Rendre le .docx via Pandoc et reference.docx.
  4. Tracer : produire la matrice de tracabilite.

NB : ceci est l'OUTILLAGE DE DOCUMENTATION, distinct du code applicatif de
GameMaths. Il reste volontairement simple et lisible.
"""
import sys
import os
import glob
import subprocess
from pathlib import Path

try:
    import yaml
except ImportError:
    sys.exit("PyYAML requis : pip install pyyaml --break-system-packages")

STATUTS = {"brouillon", "en_revue", "valide", "deprecie"}


class BuildError(Exception):
    """Erreur bloquante : arrete le build avec un message nommant le fichier."""


# ----------------------------------------------------------------- chargement / validation
def charger_yaml(path):
    try:
        with open(path, encoding="utf-8") as f:
            return yaml.safe_load(f)
    except FileNotFoundError:
        raise BuildError(f"Fichier introuvable : {path}")
    except yaml.YAMLError as e:
        raise BuildError(f"YAML non conforme : {path}\n  {e}")


def valider_meta(meta):
    if not isinstance(meta, dict):
        raise BuildError("meta.yml : contenu invalide")
    for clef in ("titre", "sous_titre", "version", "date"):
        if clef not in meta:
            raise BuildError(f"meta.yml : champ obligatoire absent « {clef} »")


def valider_sommaire(somm):
    if not isinstance(somm, dict) or "sections" not in somm:
        raise BuildError("sommaire.yml : clé « sections » absente")
    ids = []
    for s in somm["sections"]:
        for clef in ("id", "titre", "source"):
            if clef not in s:
                raise BuildError(f"sommaire.yml : une section n'a pas de champ « {clef} »")
        ids.append(str(s["id"]))
    if len(ids) != len(set(ids)):
        raise BuildError("sommaire.yml : identifiants de section en double")
    return ids


def _gherkin_ok(texte):
    lignes = [l.strip() for l in texte.splitlines() if l.strip()]
    if not lignes or not lignes[0].startswith("Fonctionnalité:"):
        return False
    return any(l.startswith(("Scénario:", "Plan du Scénario:")) for l in lignes)


def charger_exigences(dossier):
    if not os.path.isdir(dossier):
        return []
    features = {Path(p).stem for p in glob.glob(os.path.join(dossier, "*.feature"))}
    sidecars = {Path(p).stem for p in glob.glob(os.path.join(dossier, "*.yml"))}

    for radical in sorted(features - sidecars):
        raise BuildError(f"Exigence sans sidecar : {radical}.feature n'a pas de {radical}.yml")
    for radical in sorted(sidecars - features):
        raise BuildError(f"Sidecar sans exigence : {radical}.yml n'a pas de {radical}.feature")

    exigences, vus = [], {}
    for radical in sorted(features):
        feat = open(os.path.join(dossier, radical + ".feature"), encoding="utf-8").read()
        meta = charger_yaml(os.path.join(dossier, radical + ".yml"))
        if not isinstance(meta, dict):
            raise BuildError(f"{radical}.yml : contenu invalide")
        ident = meta.get("id")
        if not ident:
            raise BuildError(f"{radical}.yml : champ « id » absent")
        if ident in vus:
            raise BuildError(f"Identifiant d'exigence en double « {ident} » : "
                             f"{vus[ident]} et {radical}.yml")
        vus[ident] = radical + ".yml"
        if "section" not in meta:
            raise BuildError(f"{radical}.yml : champ « section » absent")
        if meta.get("statut") not in STATUTS:
            raise BuildError(f"{radical}.yml : statut « {meta.get('statut')} » hors "
                             f"vocabulaire autorisé {sorted(STATUTS)}")
        if not _gherkin_ok(feat):
            raise BuildError(f"{radical}.feature : non parsable en Gherkin "
                             f"(attendu « Fonctionnalité: » puis au moins un scénario)")
        exigences.append({"radical": radical, "feature": feat, "meta": meta})
    return exigences


# ----------------------------------------------------------------- assemblage
def rendre_glossaire(gloss):
    return "\n".join(f"- **{d['terme']}** : {d['texte']}"
                     for d in (gloss or {}).get("definitions", []))


def assembler(racine_doc, meta, ids_somm, sommaire, exigences, avertissements):
    par_section = {}
    for ex in exigences:
        sec = str(ex["meta"]["section"])
        if sec not in ids_somm:
            raise BuildError(f"{ex['radical']}.yml : section « {sec} » absente de sommaire.yml")
        par_section.setdefault(sec, []).append(ex)
        if ex["meta"].get("statut") != "valide":
            avertissements.append(
                f"{ex['meta']['id']} : statut « {ex['meta']['statut']} » (non finalisé)")
        if not (ex["meta"].get("trace") or {}).get("satisfait"):
            avertissements.append(
                f"{ex['meta']['id']} : trace.satisfait vide (traçabilité amont absente)")

    md = ["---",
          f"title: \"{meta['titre']}\"",
          f"subtitle: \"{meta['sous_titre']}\"",
          f"date: \"{meta['date']}\"",
          "lang: fr-FR",
          "---",
          ""]
    normes = " · ".join(meta.get("normes") or [])
    refs = " · ".join(meta.get("references") or [])
    md.append(f"**Version :** {meta['version']} — **Normes :** {normes} "
              f"— **Références :** {refs}")
    md.append("")

    for s in sommaire["sections"]:
        sid, titre, source = str(s["id"]), s["titre"], s["source"]
        md.append(f"# {titre}")
        md.append("")
        if source == "exigences":
            for ex in par_section.get(sid, []):
                m = ex["meta"]
                md.append(f"## {m['id']} — {m['titre']}")
                md.append("")
                rationale = (m.get("rationale") or "").strip()
                if rationale:
                    md.append(f"*{rationale}*")
                    md.append("")
                md.append("```gherkin")
                md.append(ex["feature"].rstrip())
                md.append("```")
                md.append("")
        elif source == "glossaire":
            md.append(rendre_glossaire(charger_yaml(os.path.join(racine_doc, "glossaire.yml"))))
            md.append("")
        else:
            chemin = os.path.join(racine_doc, source)
            if not os.path.exists(chemin):
                raise BuildError(f"Fichier de prose introuvable : {source}")
            md.append(open(chemin, encoding="utf-8").read().rstrip())
            md.append("")
    return "\n".join(md)


def matrice_tracabilite(exigences):
    lignes = ["# Matrice de traçabilité", "",
              "| Identifiant | Titre | Vérifié par | Satisfait (amont) |",
              "| --- | --- | --- | --- |"]
    for ex in sorted(exigences, key=lambda e: e["meta"]["id"]):
        m = ex["meta"]
        trace = m.get("trace") or {}
        satisfait = ", ".join(trace.get("satisfait") or []) or "—"
        lignes.append(f"| {m['id']} | {m['titre']} | "
                      f"{trace.get('verifie_par', '—')} | {satisfait} |")
    return "\n".join(lignes) + "\n"


# ----------------------------------------------------------------- point d'entrée
def main():
    if len(sys.argv) < 2:
        sys.exit("Usage : assemble.py <dossier-document>")

    ici = Path(__file__).resolve().parent            # docs/build
    docs = ici.parent                                # docs/
    racine_doc = docs / sys.argv[1]                  # docs/<doc>
    if not racine_doc.is_dir():
        sys.exit(f"Dossier de document introuvable : {racine_doc}")

    sortie = racine_doc / "_build"
    sortie.mkdir(exist_ok=True)
    reference = docs / "reference.docx"

    avertissements = []
    try:
        meta = charger_yaml(racine_doc / "meta.yml")
        valider_meta(meta)
        sommaire = charger_yaml(racine_doc / "sommaire.yml")
        ids = valider_sommaire(sommaire)
        exigences = charger_exigences(str(racine_doc / "exigences"))
        markdown = assembler(str(racine_doc), meta, ids, sommaire, exigences, avertissements)
    except BuildError as e:
        print(f"\n[ÉCHEC] {e}\n", file=sys.stderr)
        sys.exit(1)

    md_path = sortie / "document.md"
    md_path.write_text(markdown, encoding="utf-8")
    (sortie / "tracabilite.md").write_text(matrice_tracabilite(exigences), encoding="utf-8")

    docx_path = sortie / (sys.argv[1] + ".docx")
    cmd = ["pandoc", str(md_path), "--from", "markdown",
           "--number-sections", "--toc", "--toc-depth=2",
           "-o", str(docx_path)]
    if reference.exists():
        cmd += ["--reference-doc", str(reference)]
    try:
        subprocess.run(cmd, check=True)
    except (subprocess.CalledProcessError, FileNotFoundError) as e:
        print(f"\n[ÉCHEC] Rendu Pandoc : {e}\n", file=sys.stderr)
        sys.exit(1)

    for a in avertissements:
        print(f"[AVERTISSEMENT] {a}")
    print(f"\n[OK] Document        : {docx_path}")
    print(f"[OK] Markdown         : {md_path}")
    print(f"[OK] Traçabilité      : {sortie / 'tracabilite.md'}")
    print(f"[OK] {len(exigences)} exigences chargées, {len(avertissements)} avertissement(s).")


if __name__ == "__main__":
    main()

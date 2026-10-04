# CLAUDE.md — GameMaths

Contexte projet pour Claude Code : synthèse des échanges de cadrage menés avec Claude en juin 2026
(finalité, périmètre, décisions, méthode de travail, points ouverts). Synthèse du 2 octobre 2026.

- **Dépôt** : https://github.com/mithoss7/gamemaths (`origin` = `https://github.com/mithoss7/gamemaths`).
  GitHub remplace GitLab depuis le 2 octobre 2026 ; l'ancien dépôt GitLab (`mithoss/GameMaths`) n'est plus utilisé.
- **Langue de travail** : français, partout (documents, Gherkin, échanges). Tutoiement.
- **Autorité** : les sources versionnées dans `docs/` font foi. Si ce fichier et le dépôt divergent,
  signaler l'écart à Benjamin plutôt que trancher.

---

## 1. Règle d'or : aucun code applicatif pour l'instant

Consigne fondatrice de Benjamin :

> « Il ne faut pas se précipiter sur le code, il me faut d'abord une architecture logicielle complète
> et testable. L'écriture d'une documentation complète avec les tests associés. La phase la plus longue
> sera donc la phase de définition complète du besoin et de reformulation le plus possible jusqu'à
> arriver à une documentation entièrement testable. Seulement après cela, nous commencerons à faire
> développer du code. »

- **Phase actuelle : spécification.** Pas de code Angular, pas de backend, pas d'API, pas de `ng new`,
  pas de dépendance applicative — tant que Benjamin n'a pas ouvert explicitement la phase de développement.
- **Exception tolérée : l'outillage documentaire** (`build/assemble.py`, `Makefile`, sous
  `docs/02 - Documentation fonctionnelle/`). Ce n'est pas du code applicatif. Toute évolution de cet
  outillage part des critères d'acceptation `@ATL-*` de la spécification de l'atelier
  (`atelier-specification.md`, **absente du dépôt** au 2 octobre 2026 : à y ajouter).
- **Plus tard** : les `.feature` deviendront la base des tests d'acceptation (documentation vivante).

## 2. Pourquoi ce projet existe

Double finalité, dans cet ordre :

1. **Finalité réelle** — la montée en compétence de Benjamin (ingénieur R&D) dans la conduite complète
   d'un projet logiciel complexe : besoin → architecture → documentation testable → tests → code →
   versioning. *Le vrai client du projet, c'est lui.*
2. **Produit support** — un site pédagogique de mathématiques à parcours structuré, pour collégiens.

Conséquences : la rigueur de méthode prime sur la vitesse ; chaque proposition explique son *pourquoi*,
avec des exemples concrets.

⚠️ **La finalité réelle est tacite** (décision du 4 octobre 2026) : elle ne figure **ni dans les documents
du projet** (doc 1 compris : pas d'objectifs « projet »), **ni dans le README**. Elle n'est consignée
qu'ici, dans le contexte de travail.

## 3. Historique du cadrage (matière du doc 1, verrouillée)

| Sujet | Décision |
|---|---|
| Idée de départ | Plateforme de mini-jeux (calcul mental chronométré, Quizz, Puzzles, XP, niveaux Débutant→Maître, déblocages, leaderboard), but « donner envie de s'inscrire ». **Abandonnée.** |
| Pivot | Benjamin : un site pédagogique de maths, mais « l'objectif reste ma progression personnelle dans la réalisation complète de projets complexes ». → **Parcours d'apprentissage** : graphe orienté de notions ; maîtriser une notion débloque ses successeurs. |
| Public | Collégiens (~11-15 ans), **en autonomie à la maison**. Pas de mode classe ni enseignant. |
| Comptes | **Aucun.** Progression stockée sur l'appareil → aucune donnée personnelle de mineur collectée (en France, consentement parental requis sous 15 ans). |
| Domaine | **Fractions** (chaîne de prérequis nette, adaptée à un MVP). |
| Architecture | **Backend de contenu + progression locale** : le backend sert graphe, cours et exercices via une API ; la progression reste sur l'appareil. |
| Front-end | Angular (SPA). |
| Stack backend | **Non choisie** (Node/Express évoqué au départ) → document 3. |
| Génération des exercices | Exclue du MVP au cadrage, puis **intégrée au MVP** à la demande de Benjamin : génération paramétrique (§5.4). |

Ne pas réintroduire XP, niveaux, chronomètre, leaderboard ou comptes sans décision explicite.

Les traces de l'idée de départ (prototype Angular de quiz, modèle GitLab Pages, notes et documents de
cadrage d'avant le pivot, `.docx` v0.2 périmé) ont été retirées de `main` le 2 octobre 2026. Elles
restent consultables via `archive/avant-pivot`.

## 4. Périmètre du MVP

**Dedans** : graphe de 8 notions sur les fractions ; pour chacune, un cours minimal et des exercices
auto-corrigés générés à partir de gabarits ; règles de maîtrise et de déblocage ; carte du parcours ;
progression locale persistée ; API de contenu et sa base.

**Dehors (assumé)** : comptes et consentement parental · synchronisation entre appareils · classement
et fonctions sociales · autres domaines mathématiques · statistiques avancées · perte de maîtrise dans
le temps (oubli).

**Hypothèses** : le navigateur autorise le stockage local persistant ; l'API garantit les invariants de
contenu (§5.5).

## 5. Modèle métier (doc 2 v1.0 du 4 octobre 2026 — les 25 exigences sont `valide`)

### 5.1 Vocabulaire

- **Notion** : unité d'apprentissage (identifiant, titre, cours, gabarits d'exercices, prérequis).
- **Prérequis** : notion qui doit être Maîtrisée avant qu'une autre devienne accessible.
- **Exercice** : question fermée (énoncé, type de réponse, réponse attendue, explication), produite
  comme instance d'un gabarit ; la réponse soumise est jugée par la règle d'acceptation du gabarit.
  Plus « à réponse unique » depuis le Bloc 4 : plusieurs réponses peuvent être correctes.
- **Gabarit** : modèle paramétré d'exercice rattaché à une notion (§5.4).
- **Instance** : exercice concret tiré d'un gabarit. Valeurs différentes ⇒ exercices différents ;
  même gabarit et mêmes valeurs ⇒ même exercice (décision du 2 octobre 2026).
- **Progression** : ensemble des statuts durables des notions ; locale et persistée.
- **Session** : activité continue sur *une* notion. Commence à l'entrée dans ses exercices ; se termine
  dès que l'apprenant quitte la notion (retour à la carte, autre notion, rechargement, fermeture).
  Passer du cours aux exercices de la même notion ne l'interrompt pas. Pas de fin par inactivité au MVP.
- **Série** : réussites consécutives, sur des instances distinctes, dans une même session.
  Volatile : naît à 0, perdue en fin de session.
- **N** : nombre de réussites requises pour maîtriser une notion. Paramètre configurable, défaut 3.
- **Type de réponse** : entier · fraction · comparateur (<, >, =) · couple de fractions · choix parmi
  des propositions.
- **Réponse bien formée** : saisie conforme au type de réponse (espaces ignorés ; fraction = entier
  naturel ou a/b, b non nul ; une écriture décimale n'est pas une fraction bien formée).
- **Forme irréductible** : numérateur et dénominateur sans diviseur commun autre que 1 ; une valeur
  entière s'écrit comme l'entier lui-même (2, pas 2/1).
- **Réponse attendue** : réponse correcte *de référence*, montrée en correction ; quand plusieurs
  réponses sont correctes, elle est l'une d'elles (terme conservé, redéfini : décision QD-a).
- **Règle d'acceptation** (portée par le gabarit) : *identité* (exactement la réponse attendue),
  *valeur* (même valeur, toute écriture), *irréductible* (forme irréductible seulement),
  *condition* (propriété définie par le gabarit ; plusieurs réponses correctes possibles).

### 5.2 Deux niveaux d'état — distinction critique

| Statut durable (persisté) | État affiché (dérivé, jamais persisté) |
|---|---|
| Non abordée · Abordée · Maîtrisée | Verrouillée · Disponible · En cours · Maîtrisée |

- **Statut durable** : Non abordée → Abordée (première tentative d'exercice) → Maîtrisée (la série
  atteint N). Aucun retour en arrière.
- **État affiché**, recalculé à chaque affichage : *Maîtrisée* si le statut est Maîtrisée ; sinon
  *Verrouillée* si au moins un prérequis n'est pas Maîtrisé ; sinon *Disponible* (statut Non abordée) ou
  *En cours* (statut Abordée). Maîtrisée prime sur Verrouillée (décision du 2 octobre 2026) : les quatre
  états sont mutuellement exclusifs, même si le contenu ajoute un prérequis à une notion déjà maîtrisée.

⚠️ **Ne jamais mélanger les deux niveaux dans une même phrase.** « Une notion Abordée ne redevient
jamais Disponible » est un non-sens : Abordée est un statut durable, Disponible un état affiché.
Benjamin a corrigé explicitement ce type d'erreur.

### 5.3 Règles de maîtrise, session et parcours

- Un seul essai par exercice ; la réponse est définitive.
- Réussite : la série augmente de 1. Erreur : la série revient à 0. Série = N : la notion devient
  Maîtrisée, définitivement.
- Le système **garantit** qu'une même série ne contient jamais deux réussites sur la même instance
  (garantie système, pas simple règle de décompte).
- Quitter la notion termine la session : la série est perdue ; le statut durable est conservé et
  survit au rechargement.
- Maîtriser une notion débloque en cascade les notions dont c'était le dernier prérequis manquant.
- Carte : une notion Verrouillée ne s'ouvre pas et le système indique le prérequis manquant ;
  Disponible et En cours s'ouvrent ; Maîtrisée reste consultable : révision du cours et nouveaux
  exercices, sans effet sur le statut (validé le 2 octobre 2026).
- Après une erreur : affichage de la bonne réponse et de l'explication.
- À la maîtrise : écran de réussite listant exactement les notions nouvellement débloquées.

### 5.3 bis Validation des réponses (Bloc 4, décisions du 4 octobre 2026)

- Une saisie **non bien formée** (faute de frappe, écriture décimale pour une fraction…) est refusée
  avant évaluation : ni réussite, ni erreur, ni tentative ; série et statut durable inchangés
  (EX-REPONSE-01). Une *tentative* = soumission d'une réponse bien formée.
- Règle par notion : **irréductible** pour N4 et N8, **valeur** pour N1, N3 (lecture), N6 ;
  **identité** pour les entiers (N2), comparateurs (N5), choix (N3) ; **condition** pour N7 (même
  dénominateur, tout dénominateur commun accepté) et pour « une autre fraction égale » en N2 (la
  fraction donnée est refusée). Tableau dans la section « Contenu du MVP » du doc 2.
- Mode valeur : un résultat entier s'écrit `1` ou `4/4` ; mode irréductible : `1` seulement.
- La réponse attendue (montrée en correction) : en mode **valeur** (N1, N3, N6), le **résultat direct
  du calcul, sans simplification** (`4/6` pour 5/6 − 1/6), la forme irréductible restant acceptée ; en
  mode **irréductible** (N4, N8), la forme irréductible ; pour N7, le plus petit dénominateur commun
  (EX-GEN-03). Pas de renvoi vers le cours de N4 (décision du 4 octobre 2026). Un exercice à choix a exactement une proposition correcte (EX-GEN-04).
- N3 se limite à lire la droite et à choisir parmi des points proposés ; placement graphique et
  manière de saisir renvoyés au doc 7.

### 5.4 Génération paramétrique des exercices

- **Gabarit** = type d'exercice + type de réponse + paramètres + contraintes de tirage + règle de calcul
  de la réponse attendue + règle d'acceptation + explication. Le système l'instancie en tirant des valeurs ; la réponse attendue est
  calculée de façon déterministe. (Modèle proposé mi-juin 2026, non amendé par Benjamin.)
- Génération **paramétrique** retenue (pas de génération par IA ni de texte libre).
- **Décision A** : « même exercice » = même *instance*.
- **Décision B** : chaque notion doit pouvoir produire au moins N instances distinctes ; au besoin,
  N est plafonné à la capacité de la notion la moins fournie.
- **Décision C** : la reproductibilité du tirage (générateur à graine) est non fonctionnelle → doc 6.

### 5.5 Invariants de contenu (vérifiés à la validation du contenu)

- **INV-CONTENU-01** : le graphe des prérequis est acyclique.
- **INV-CONTENU-02** : chaque notion peut produire au moins N instances distinctes.
- **INV-CONTENU-03** : chaque gabarit porte une explication non vide, héritée par ses instances.
- **INV-CONTENU-04** : tout prérequis référence une notion existante.
- **INV-CONTENU-05** : la réponse attendue de toute instance satisfait la règle d'acceptation de son
  gabarit (Bloc 4).

### 5.6 Graphe des notions du MVP (granularité révisable)

| Id | Notion | Prérequis |
|---|---|---|
| N1 | Notion de fraction | — |
| N2 | Fractions équivalentes | N1 |
| N3 | Représentation / placement sur une droite | N1 |
| N4 | Simplifier une fraction | N2 |
| N5 | Comparer deux fractions (même dénominateur) | N3, N4 |
| N6 | Additionner / soustraire (même dénominateur) | N3 |
| N7 | Mettre au même dénominateur | N5, N6 |
| N8 | Additionner / soustraire (dénominateurs différents) | N7 |

Diagramme : `assets/graphe-notions.svg`.

## 6. Inventaire des exigences du doc 2

| Section | Exigences |
|---|---|
| 5 — Calcul de l'état affiché | EX-ETAT-01, EX-ETAT-02 |
| 6 — Déblocage | EX-DEBLOC-01 |
| 7 — Règles de maîtrise | EX-MAITRISE-01, -02, -03 (**-04 supprimée**, redondante avec -02) |
| 8 — Session et persistance | EX-SESSION-01, EX-SESSION-02 |
| 9 — Parcours et écrans | EX-PARCOURS-01, -02, -03 |
| 10 — Invariants de contenu | INV-CONTENU-01 à -05 |
| 11 — Génération des exercices | EX-GEN-01 (instanciation), -02 (contraintes de tirage), -03 (forme de la réponse attendue), -04 (choix : une seule proposition correcte) |
| 12 — Validation des réponses | EX-REPONSE-01 (saisie non bien formée), -02 (valeur), -03 (irréductible), -04 (identité), -05 (condition) |
| 13 à 15 (prose) | Contenu du MVP (graphe + types de réponse par notion) · Hors périmètre · Points en suspens |

Sections 1 à 4 : introduction, description générale, définitions (glossaire), modèle d'états.
Structure inspirée d'ISO/IEC/IEEE 29148.

## 7. Série documentaire

Benjamin a prévu 10 documents. Connus à ce jour :

| N° | Document | État / contenu attendu |
|---|---|---|
| 1 | Contexte et objectifs | Matière verrouillée (§2 à §4) ; rédaction non faite à notre connaissance |
| 2 | Spécifications fonctionnelles | **Document actif** |
| 3 | Architecture technique | Choix de la stack backend |
| 4 | Modélisation des données & API | — |
| 5 | Sécurité | Exigence transverse « public mineur » |
| 6 | Spécifications non fonctionnelles | Reproductibilité du tirage |
| 7 | UX / accessibilité | Affichage de la rupture de série |
| 8 | Stratégie de tests | Couverture de test de chaque exigence (traçabilité aval) |
| 9 | Plan de gestion documentaire / versioning (BMS) | — |
| 10 | Documents de référence / Glossaire / Annexes | — |

Source des intitulés : `docs/Documentation/Liste des docs à rédiger.txt`.

Règle de rangement : une spécification fonctionnelle dit *ce que* fait le système, jamais *comment*
(doc 3). Tout point non fonctionnel, technique ou UX est renvoyé au document concerné et consigné
dans « Points en suspens ».

## 8. Atelier documentaire (docs-as-code)

Principe : le Word n'est jamais une source, c'est un artéfact généré. Le contenu (texte versionné) est
séparé de la mise en forme (`reference.docx`) ; chaque information n'existe qu'à un seul endroit.

- **Chaîne** : Markdown (prose) + Gherkin français en `.feature` (exigences) + YAML (métadonnées)
  → `assemble.py` → Pandoc + `reference.docx` → `.docx`. Sphinx a été écarté (extensions `.docx` non
  maintenues) ; Pandoc est verrouillé.
- **Spécification de l'atelier** : `atelier-specification.md` (v0.1, brouillon). Ses exemples
  (`EX-DEBLOCAGE-01`, `prose/03-modele-etats.md`, section « 4 ») sont antérieurs au doc 2 actuel :
  le dépôt fait foi.

Arborescence réelle (vérifiée le 2 octobre 2026) : l'atelier n'est pas directement sous `docs/`,
mais sous `docs/02 - Documentation fonctionnelle/` (appelé ci-dessous « racine de l'atelier ») :

```
docs/02 - Documentation fonctionnelle/
  Makefile                      # cibles doc2 et clean
  reference.docx                # styles Word uniquement (gabarit Pandoc par défaut, à personnaliser)
  build/assemble.py             # charge, valide, assemble, appelle Pandoc, produit la traçabilité
  doc2-specifications-fonctionnelles/
    meta.yml                    # titre, version, date, normes, références
    sommaire.yml                # ordre des sections — fait autorité pour l'assemblage
    glossaire.yml
    prose/                      # 01-introduction.md … 13-points-en-suspens.md
    exigences/                  # une exigence = <ID>.feature + <ID>.yml
    assets/graphe-notions.svg
    _build/                     # généré, non versionné
```

Commandes, depuis la racine de l'atelier (voir aussi le `README.md` qui s'y trouve) :

```
make doc2                     # le Makefile utilise python (PYTHON ?= python) ; ailleurs : make doc2 PYTHON=python3
python build/assemble.py doc2-specifications-fonctionnelles    # équivalent sans make
make clean                    # supprime _build/
```

Sorties dans `_build/` : `document.md` (Markdown intermédiaire), `tracabilite.md`,
`doc2-specifications-fonctionnelles.docx`. Ne jamais versionner `_build/` ni un `.docx` généré.

Environnement de Benjamin : Windows + Anaconda (la commande est `python`, pas `python3`).
Dépendances : PyYAML, Pandoc (rouvrir le terminal après installation pour rafraîchir le PATH), GNU Make.

**Paire d'exigence** — même radical : `<ID>.feature` (scénarios purs) + `<ID>.yml` (métadonnées) :

```yaml
id: EX-GEN-01
titre: "Instanciation d'un exercice à partir d'un gabarit"
statut: en_revue           # brouillon | en_revue | valide | deprecie
section: "11"              # doit exister dans sommaire.yml
rationale: >
  Pourquoi cette exigence existe.
trace:
  verifie_par: EX-GEN-01.feature
  satisfait: []            # objectifs du doc 1 ; vide tant qu'ils n'ont pas d'identifiants
```

- Identifiants : `EX-<DOMAINE>-<NN>` (domaines en usage : ETAT, DEBLOC, MAITRISE, SESSION, PARCOURS,
  GEN, REPONSE) et `INV-CONTENU-<NN>` ; uniques sur tout le document.
- Une entrée de `sommaire.yml` de source `exigences` regroupe les exigences dont `section` vaut son
  `id`. Renuméroter = changer les `id` du sommaire et les champs `section` ; les noms des fichiers de
  prose ne bougent pas.

**Politique d'échec graduée** :
- *Bloquant* : YAML non conforme, identifiant en double, `.feature` ou sidecar orphelin, Gherkin non
  parsable, `section` absente du sommaire, `statut` hors vocabulaire.
- *Avertissement* : statut différent de `valide`, champ optionnel vide (`satisfait`). Aujourd'hui,
  environ 2 avertissements par exigence : c'est attendu.

## 9. Méthode de travail avec Benjamin

1. **Reformuler avant de produire.** Reformuler la demande, faire émerger ambiguïtés et cas limites,
   poser les questions avant d'écrire.
2. **Décider avant de documenter.** Pour tout choix sémantique ou d'architecture : options, compromis,
   recommandation argumentée, puis attendre sa décision. Ne jamais trancher à sa place, même quand
   l'intention paraît évidente. Consigner les choix sous la forme `[DÉCISION] …`.
3. **Modifications ciblées, fichier par fichier.** Ne jamais régénérer l'arborescence ni réécrire un
   fichier entier quand une modification locale suffit : Benjamin l'a refusé explicitement, il veut
   garder dans git la trace de chacune de ses modifications. Annoncer quels fichiers changent et pourquoi.
4. **Git : Claude exécute, Benjamin comprend et décide** (règle du 2 octobre 2026, remplace « Benjamin
   committe lui-même ») :
   - Claude fait les modifications, les committe et les pousse sur sa branche de travail, **jamais
     directement sur `main`**.
   - Chaque modification est expliquée à Benjamin : fichiers touchés, ce qui change, pourquoi, et
     répercussions vérifiées (point 5). Benjamin veut comprendre chaque modification.
   - Un commit par modification ciblée ; le message explique le *pourquoi*, pas seulement le *quoi*.
   - Une pull request par lot cohérent : Benjamin relit le diff et fusionne lui-même. Claude peut aussi
     fusionner sur `main`, mais **uniquement sur demande explicite de Benjamin**, après sa relecture.
   - Les décisions de fond (sens, architecture) restent à Benjamin (point 2) : Claude n'exécute
     qu'après sa décision.
   - Tags : pas de tag sans demande explicite. Un tag par version de document, convention
     **`docN-vX.Y`** (ex. `doc2-v0.3`), validée le 2 octobre 2026 : `v0.X` tant que des exigences ne sont
     pas `valide`, `v1.0` à la première version entièrement validée. Claude ne peut pas pousser de tag
     (refus 403 de l'environnement) : Benjamin les crée via une release GitHub (tag léger ; la release
     peut porter le `.docx` généré). Tags posés : `archive/avant-pivot`, `doc2-v0.2`, `doc2-v0.3`
     (4 octobre 2026, après relecture) et `doc2-v1.0` (4 octobre 2026, toutes exigences validées) ;
     releases avec le `.docx`.
5. **Vérifier les répercussions** de toute modification : glossaire, autres exigences, invariants,
   sommaire, points en suspens.
6. **Séparer « action requise » et « remarque pour info »** (leur mélange a déjà semé la confusion).
7. **Après toute modification des sources**, lancer le build et rapporter : erreurs bloquantes,
   nombre d'exigences chargées, nombre d'avertissements.
8. **Ne jamais passer une exigence à `valide` de sa propre initiative** : seule la relecture de Benjamin
   le décide. Toute exigence nouvelle ou modifiée est proposée en `en_revue` ; une exigence `valide`
   que l'on modifie repasse en `en_revue`.

### Règles d'écriture des exigences (issues de ses relectures)

- **Généricité** : scénarios formulés en N, jamais en valeurs concrètes (« 2 sur 3 ») ; la valeur par
  défaut (3) se mentionne dans la `rationale`. Un exemple chiffré laisse croire que la règle ne vaut
  que pour cette valeur.
- **Une exigence, un objet** : un comportement couvert ailleurs n'est pas répété (la série volatile
  relève d'EX-SESSION-01, pas d'EX-SESSION-02).
- **Pas de redondance** : une exigence entièrement couverte par une autre est supprimée (EX-MAITRISE-04).
- **Garanties système** : quand l'intention est une impossibilité, l'écrire comme garantie (« le système
  garantit que … ne peut jamais … ») plutôt que comme règle de décompte (EX-MAITRISE-03).
- **Couverture des états** : un scénario par état affiché pertinent (les cas En cours et Maîtrisée
  manquaient dans EX-PARCOURS-01).
- **Statut durable ≠ état affiché** (§5.2).

## 10. Prochaines étapes et points ouverts

1. ~~Vérifier l'état du dépôt~~ **Fait le 2 octobre 2026** : corrections de la relecture v0.2 et
   fragments de mi-juin sur la génération tous appliqués (commit « Bloc 3 Terminé » du 14 juin) ;
   build à 17 exigences, 0 erreur bloquante.
2. ~~Bloc 4 — validation des réponses~~ **Fait et validé le 4 octobre 2026** (§5.3 bis).
3. ~~Une notion Maîtrisée reste-t-elle consultable ?~~ **Tranché le 2 octobre 2026** : oui (cours et
   nouveaux exercices, sans effet sur le statut) ; rationale d'EX-PARCOURS-01 mise à jour.
4. **Document 1** en cours (décisions du 4 octobre 2026) :
   - rangé à côté du doc 2 dans l'atelier actuel (`doc1-contexte-objectifs/`, cible `make doc1`) ; la
     réorganisation de l'atelier sous `docs/` attendra la spécification de l'atelier ;
   - plan inspiré d'ISO/IEC/IEEE 29148 : objet, contexte et historique, finalité du produit, parties
     prenantes (Benjamin = porteur et commanditaire), objectifs, périmètre, contraintes et hypothèses,
     critères de réussite ;
   - objectifs du **produit** seulement, identifiants `OBJ-NN` (proposition OBJ-01 à OBJ-07 en attente
     de validation par Benjamin) ;
   - le doc 1 porte le périmètre au niveau des objectifs ; le doc 2 garde le hors-périmètre détaillé ;
   - remplir `trace.satisfait` des exigences du doc 2 ne rouvre pas leur validation (modification de
     traçabilité seule, sans toucher scénarios ni rationale).
5. ~~Relecture du doc 2~~ **Faite le 4 octobre 2026** : v0.3 relue (15 exigences validées), puis Bloc 4
   relu ; les 25 exigences sont `valide`. Doc 2 passé en **v1.0**. Toute modification ultérieure
   d'une exigence la repasse en `en_revue` (§9.8).
6. **Documents suivants** : 3 (architecture, stack backend), 4, 5 (sécurité), 6 (non fonctionnel),
   7 (UX), 8 (stratégie de tests).
7. **Atelier, décisions différées** : intégration continue, désormais sur GitHub (GitHub Actions) et non
   plus GitLab CI (génération du Word sur tag/release ; Makefile alors rendu portable avec `python3`),
   sorties HTML/PDF via Pandoc, personnalisation de `reference.docx`.

## 11. Points d'attention (constats, non tranchés)

- Le `.docx` v0.2 du doc 2 (2026-06-02) était **antérieur aux corrections** (EX-MAITRISE-04, génération
  hors périmètre). Retiré du dépôt le 2 octobre 2026 ; `make doc2` produit la version à jour.
- Le dossier intermédiaire créé à l'import initial (`docs/GameMaths-docs/docs/`) n'existe pas dans le
  dépôt (vérifié le 2 octobre 2026). Les sources sont sous `docs/02 - Documentation fonctionnelle/` (§8).
- Les `.feature` n'ont **pas** l'en-tête `# language: fr` (vérifié le 2 octobre 2026). Avec le parseur
  Gherkin officiel : 0/17 analysés en langue par défaut (anglais), 17/17 en français. **Piège** : ajouter
  l'en-tête casserait le build, car `assemble.py` exige que la première ligne non vide commence par
  `Fonctionnalité:` (`_gherkin_ok`). Alternative : régler la langue dans l'outil de test. À trancher
  avant de brancher des tests exécutables ; toute adaptation d'`assemble.py` part des critères `@ATL-*`.

## 12. Tenir ce fichier à jour

Ce fichier est un résumé, pas une source. Quand une décision est verrouillée, proposer à Benjamin la
mise à jour de la section concernée — modification ciblée, comme pour le reste.

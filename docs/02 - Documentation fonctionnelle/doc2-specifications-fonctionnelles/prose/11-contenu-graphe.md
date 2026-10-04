Le MVP couvre huit notions de fractions, organisées selon leurs prérequis
pédagogiques. Le tableau ci-dessous définit le graphe ; la dépendance se lit
« a pour prérequis ».

| Identifiant | Notion | Prérequis |
| --- | --- | --- |
| N1 | Notion de fraction | — |
| N2 | Fractions équivalentes | N1 |
| N3 | Représentation / placement sur une droite | N1 |
| N4 | Simplifier une fraction | N2 |
| N5 | Comparer deux fractions (même dénominateur) | N3, N4 |
| N6 | Additionner / soustraire (même dénominateur) | N3 |
| N7 | Mettre au même dénominateur | N5, N6 |
| N8 | Additionner / soustraire (dénominateurs différents) | N7 |

Le graphe doit satisfaire l'invariant INV-CONTENU-01 (absence de cycle). La
granularité (huit notions) est un choix du MVP et pourra évoluer. Un diagramme
du graphe est fourni dans le fichier `assets/graphe-notions.svg`.

## Types de réponse et règles d'acceptation par notion

Chaque gabarit porte un type de réponse et une règle d'acceptation (voir le
glossaire et la section 12). Le tableau ci-dessous fixe, pour chaque notion du
MVP, les exercices prévus ; les exemples sont illustratifs, les valeurs étant
tirées par les gabarits.

| Notion | Exemple d'exercice | Type de réponse | Règle d'acceptation |
| --- | --- | --- | --- |
| N1 | Quelle fraction de la figure est coloriée ? | fraction | valeur |
| N2 | Compléter : 2/3 = ?/12 | entier | identité |
| N2 | Donner une autre fraction égale à 3/5 | fraction | condition : égale à la fraction donnée et d'écriture différente |
| N3 | Quelle fraction correspond au point A de la droite graduée ? | fraction | valeur |
| N3 | Lequel des points A, B, C ou D correspond à 3/4 ? | choix parmi des propositions | identité |
| N4 | Simplifier 6/8 | fraction | irréductible |
| N5 | Comparer 3/7 et 5/7 | comparateur | identité |
| N6 | Calculer 5/9 − 2/9 | fraction | valeur |
| N7 | Écrire 1/2 et 1/3 avec un même dénominateur | couple de fractions | condition : même dénominateur, chaque fraction égale à la fraction donnée correspondante |
| N8 | Calculer 1/6 + 1/3 | fraction | irréductible |

La règle « irréductible » s'applique aux notions dont la compétence inclut la
simplification : N4, dont c'est l'objet, et N8, où le résultat est attendu sous
forme simplifiée. Les autres notions acceptent toute écriture de la bonne
valeur ; en particulier, N6 n'a pas N4 (Simplifier) parmi ses prérequis. Pour
ces notions, la correction montre le résultat direct du calcul, sans
simplification (EX-GEN-03).

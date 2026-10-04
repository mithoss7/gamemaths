## Perspective du produit

GameMaths MVP est une application web monopage (front-end Angular) consommant
une API de contenu. La progression de l'apprenant est conservée localement. Le
produit ne comporte ni authentification, ni classement, ni synchronisation entre
appareils au stade du MVP.

## Caractéristiques des utilisateurs

Utilisateur unique : un collégien (environ 11 à 15 ans) travaillant en
autonomie. Aucune information personnelle ne lui est demandée et sa progression
reste sur son appareil (EX-DONNEES-01).

## Contraintes

- Front-end développé avec Angular.
- Méthode documentaire : exigences vérifiables, exprimées en Gherkin, traçables par identifiant.
- Cible mineurs : minimisation des données (absence de compte, EX-DONNEES-01 ; données techniques : document 5).

## Hypothèses et dépendances

- Le navigateur de l'apprenant autorise le stockage local persistant.
- L'API de contenu garantit les invariants de contenu décrits à la section 10.

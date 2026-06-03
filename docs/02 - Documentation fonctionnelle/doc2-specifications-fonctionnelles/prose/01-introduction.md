## Objet

Ce document spécifie le comportement fonctionnel attendu du produit minimum
viable (MVP) de GameMaths : une application web de parcours d'apprentissage des
fractions destinée à des collégiens en autonomie. Il décrit *ce que* le système
doit faire, indépendamment de la manière dont il sera implémenté (cette dernière
relève du document 3, Architecture technique).

## Portée

Le MVP propose un parcours structuré de notions de fractions, modélisé comme un
graphe orienté de prérequis. Chaque notion comporte un cours court et des
exercices auto-corrigés. La maîtrise d'une notion débloque ses successeurs. La
progression durable est stockée localement sur l'appareil de l'apprenant ; aucun
compte utilisateur n'est requis. Le contenu (notions, cours, exercices) est
fourni par une interface de programmation applicative (API).

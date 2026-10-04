Fonctionnalité: Règle d'acceptation « condition »

  Scénario: une réponse qui vérifie la condition est acceptée, même si elle diffère de la réponse attendue
    Étant donné un exercice dont la règle d'acceptation est une condition définie par son gabarit
    Quand l'apprenant soumet une réponse bien formée qui vérifie cette condition
    Alors la réponse est évaluée comme correcte

  Scénario: une réponse qui ne vérifie pas la condition est refusée
    Étant donné un exercice dont la règle d'acceptation est une condition définie par son gabarit
    Quand l'apprenant soumet une réponse bien formée qui ne vérifie pas cette condition
    Alors la réponse est évaluée comme incorrecte

  Scénario: pour une mise au même dénominateur, tout dénominateur commun est accepté
    Étant donné un exercice demandant d'écrire deux fractions données avec un même dénominateur
    Quand l'apprenant soumet deux fractions de même dénominateur, égales respectivement aux deux fractions données
    Alors la réponse est évaluée comme correcte

  Scénario: pour une autre écriture d'une fraction, la fraction donnée elle-même est refusée
    Étant donné un exercice demandant une fraction égale à une fraction donnée et d'écriture différente
    Quand l'apprenant soumet la fraction donnée elle-même
    Alors la réponse est évaluée comme incorrecte

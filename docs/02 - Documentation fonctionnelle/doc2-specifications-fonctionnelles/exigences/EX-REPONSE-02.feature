Fonctionnalité: Règle d'acceptation « valeur »

  Scénario: toute fraction égale à la réponse attendue est acceptée
    Étant donné un exercice dont la règle d'acceptation est « valeur »
    Quand l'apprenant soumet une fraction égale à la réponse attendue
    Alors la réponse est évaluée comme correcte

  Scénario: une valeur entière peut être écrite comme un entier
    Étant donné un exercice dont la règle d'acceptation est « valeur »
    Et dont la réponse attendue est un entier
    Quand l'apprenant soumet cet entier
    Alors la réponse est évaluée comme correcte

  Scénario: une valeur différente est refusée
    Étant donné un exercice dont la règle d'acceptation est « valeur »
    Quand l'apprenant soumet une réponse bien formée dont la valeur diffère de celle de la réponse attendue
    Alors la réponse est évaluée comme incorrecte

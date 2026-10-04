Fonctionnalité: Règle d'acceptation « irréductible »

  Scénario: la forme irréductible de la réponse attendue est acceptée
    Étant donné un exercice dont la règle d'acceptation est « irréductible »
    Quand l'apprenant soumet la réponse attendue sous forme irréductible
    Alors la réponse est évaluée comme correcte

  Scénario: une fraction égale mais non irréductible est refusée
    Étant donné un exercice dont la règle d'acceptation est « irréductible »
    Quand l'apprenant soumet une fraction égale à la réponse attendue qui n'est pas sous forme irréductible
    Alors la réponse est évaluée comme incorrecte

  Scénario: une valeur entière doit être écrite comme un entier
    Étant donné un exercice dont la règle d'acceptation est « irréductible »
    Et dont la réponse attendue est un entier
    Quand l'apprenant soumet une fraction égale à cet entier
    Alors la réponse est évaluée comme incorrecte

  Scénario: une valeur différente est refusée
    Étant donné un exercice dont la règle d'acceptation est « irréductible »
    Quand l'apprenant soumet une réponse bien formée dont la valeur diffère de celle de la réponse attendue
    Alors la réponse est évaluée comme incorrecte

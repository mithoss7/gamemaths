Fonctionnalité: Règle d'acceptation « identité »

  Scénario: la réponse attendue est acceptée
    Étant donné un exercice dont la règle d'acceptation est « identité »
    Quand l'apprenant soumet la réponse attendue
    Alors la réponse est évaluée comme correcte

  Scénario: toute autre réponse bien formée est refusée
    Étant donné un exercice dont la règle d'acceptation est « identité »
    Quand l'apprenant soumet une réponse bien formée différente de la réponse attendue
    Alors la réponse est évaluée comme incorrecte

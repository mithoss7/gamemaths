Fonctionnalité: Compteur de réussites consécutives

  Contexte:
    Étant donné une notion En cours avec N valant 3

  Scénario: une réussite incrémente la série
    Étant donné une série à 2 sur 3
    Quand l'apprenant réussit un exercice non encore compté dans la série
    Alors la série passe à 3 sur 3
    Et la notion devient Maîtrisée

  Scénario: une erreur remet la série à zéro
    Étant donné une série à 2 sur 3
    Quand l'apprenant soumet une réponse incorrecte
    Alors la série est ramenée à 0 sur 3
    Et la notion reste En cours

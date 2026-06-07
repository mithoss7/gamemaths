Fonctionnalité: Progression et rupture de la série

  Scénario: une réussite incrémente la série
    Étant donné une notion En cours dont la série compte moins de N réussites
    Quand l'apprenant réussit un exercice non encore compté dans la série
    Alors la série augmente d'une réussite

  Scénario: atteindre N réussites fait maîtriser la notion
    Étant donné une notion En cours dont la série compte N-1 réussites
    Quand l'apprenant réussit un exercice non encore compté dans la série
    Alors la série atteint N réussites
    Et la notion devient Maîtrisée

  Scénario: une erreur remet la série à zéro
    Étant donné une notion En cours dont la série compte au moins une réussite
    Quand l'apprenant soumet une réponse incorrecte
    Alors la série est ramenée à zéro
    Et la notion reste En cours
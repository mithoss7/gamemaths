Fonctionnalité: Progression et rupture de la série

  Scénario: une réussite incrémente la série
    Étant donné une notion En cours dont la série compte k réussites, avec k inférieur à N-1
    Quand l'apprenant réussit un exercice non encore compté dans la série
    Alors la série compte k+1 réussites
    Et la notion reste En cours

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
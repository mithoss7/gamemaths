Fonctionnalité: La série est volatile et liée à la session

  Scénario: quitter la notion remet la série à zéro
    Étant donné une notion En cours dont la série en cours comporte au moins une réussite
    Quand l'apprenant quitte la notion
    Et qu'il entre de nouveau dans les exercices de cette notion
    Alors la série recommence à zéro
    Et la notion est toujours En cours

  Scénario: naviguer entre le cours et les exercices ne rompt pas la série
    Étant donné une notion En cours dont la série en cours comporte au moins une réussite
    Quand l'apprenant consulte le cours de la notion
    Et qu'il revient aux exercices de la même notion
    Alors la série conserve son nombre de réussites
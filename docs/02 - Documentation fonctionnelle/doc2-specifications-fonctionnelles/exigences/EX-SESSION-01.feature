Fonctionnalité: La série est volatile et liée à la session

  Scénario: quitter la notion remet la série à zéro
    Étant donné une notion En cours avec une série à 2 sur 3
    Quand l'apprenant quitte la notion pour revenir à la carte
    Et qu'il entre de nouveau dans les exercices de cette notion
    Alors la série démarre à 0 sur 3
    Et la notion est toujours En cours

  Scénario: naviguer entre cours et exercices ne casse pas la série
    Étant donné une notion En cours avec une série à 2 sur 3
    Quand l'apprenant consulte le cours de la notion
    Et qu'il revient aux exercices de la même notion
    Alors la série est toujours à 2 sur 3

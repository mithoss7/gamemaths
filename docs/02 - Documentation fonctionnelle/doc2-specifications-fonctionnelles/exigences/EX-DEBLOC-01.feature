Fonctionnalité: Déblocage des notions à la maîtrise d'un prérequis

  Scénario: maîtriser le dernier prérequis rend une notion disponible
    Étant donné une notion Verrouillée dont le seul prérequis manquant est la notion P
    Quand la notion P devient Maîtrisée
    Alors cette notion devient Disponible

  Scénario: une maîtrise débloque plusieurs notions
    Étant donné deux notions A et B Verrouillées
    Et que leur seul prérequis manquant est la même notion P
    Quand la notion P devient Maîtrisée
    Alors la notion A devient Disponible
    Et la notion B devient Disponible

  Scénario: la maîtrise est définitive
    Étant donné une notion Maîtrisée
    Quand le système recalcule les états après n'importe quelle action
    Alors la notion reste Maîtrisée

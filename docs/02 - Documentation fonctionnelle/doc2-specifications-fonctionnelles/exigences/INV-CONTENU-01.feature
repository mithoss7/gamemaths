Fonctionnalité: Le graphe des notions est acyclique

  Scénario: un graphe contenant un cycle est rejeté
    Étant donné un ensemble de notions dont les prérequis forment un cycle
    Quand le contenu est validé
    Alors la validation échoue

Fonctionnalité: État affiché d'une notion selon ses prérequis

  Scénario: une notion sans prérequis n'est jamais verrouillée
    Étant donné une notion sans aucun prérequis
    Et dont le statut durable est Non abordée
    Quand le système calcule son état affiché
    Alors la notion est Disponible

  Scénario: un prérequis non maîtrisé verrouille la notion
    Étant donné une notion ayant deux prérequis
    Et que l'un au moins n'est pas Maîtrisé
    Quand le système calcule son état affiché
    Alors la notion est Verrouillée

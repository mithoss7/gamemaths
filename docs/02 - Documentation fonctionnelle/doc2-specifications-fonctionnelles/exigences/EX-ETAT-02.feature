Fonctionnalité: Distinction entre Disponible et En cours

  Scénario: tous prérequis maîtrisés et notion non abordée
    Étant donné une notion dont tous les prérequis sont Maîtrisés
    Et dont le statut durable est Non abordée
    Quand le système calcule son état affiché
    Alors la notion est Disponible

  Scénario: tous prérequis maîtrisés et notion abordée
    Étant donné une notion dont tous les prérequis sont Maîtrisés
    Et dont le statut durable est Abordée
    Quand le système calcule son état affiché
    Alors la notion est En cours

Fonctionnalité: La progression durable survit au rechargement

  Scénario: une notion maîtrisée le reste après rechargement
    Étant donné une notion Maîtrisée
    Quand l'apprenant recharge l'application
    Alors la notion est toujours Maîtrisée

  Scénario: une notion abordée le reste après rechargement
    Étant donné une notion Abordée mais non Maîtrisée
    Quand l'apprenant recharge l'application
    Alors la notion est affichée En cours
    Et sa série est à 0 sur 3

Fonctionnalité: Forme de la réponse attendue

  Scénario: sous la règle « valeur », la réponse attendue est le résultat direct du calcul
    Étant donné un gabarit dont le type de réponse est fraction
    Et dont la règle d'acceptation est « valeur »
    Quand le système génère un exercice à partir de ce gabarit
    Alors la réponse attendue de l'exercice est le résultat direct du calcul défini par le gabarit, sans simplification

  Scénario: sous la règle « irréductible », la réponse attendue est sous forme irréductible
    Étant donné un gabarit dont le type de réponse est fraction
    Et dont la règle d'acceptation est « irréductible »
    Quand le système génère un exercice à partir de ce gabarit
    Alors la réponse attendue de l'exercice est sous forme irréductible

  Scénario: la réponse attendue d'une mise au même dénominateur utilise le plus petit dénominateur commun
    Étant donné un gabarit dont le type de réponse est couple de fractions
    Quand le système génère un exercice à partir de ce gabarit
    Alors les deux fractions de la réponse attendue ont pour dénominateur le plus petit dénominateur avec lequel les deux fractions données peuvent s'écrire

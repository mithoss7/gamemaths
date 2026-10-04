Fonctionnalité: Une saisie non bien formée n'est pas évaluée

  Scénario: une saisie non bien formée est refusée sans être évaluée
    Étant donné un exercice affiché à l'apprenant
    Quand l'apprenant soumet une saisie qui n'est pas une réponse bien formée pour le type de réponse de l'exercice
    Alors la saisie n'est évaluée ni comme correcte ni comme incorrecte
    Et le système indique qu'une réponse bien formée est attendue
    Et l'apprenant peut soumettre une réponse pour ce même exercice

  Scénario: une écriture décimale n'est pas une réponse bien formée pour une réponse fraction
    Étant donné un exercice dont le type de réponse est fraction
    Quand l'apprenant soumet une écriture décimale
    Alors la saisie n'est évaluée ni comme correcte ni comme incorrecte
    Et le système indique qu'une réponse bien formée est attendue

  Scénario: une saisie non bien formée ne modifie pas la série
    Étant donné une notion dont la série compte k réussites
    Quand l'apprenant soumet une saisie qui n'est pas une réponse bien formée
    Alors la série compte toujours k réussites

  Scénario: une saisie non bien formée ne compte pas comme une tentative
    Étant donné une notion dont le statut durable est Non abordée
    Quand l'apprenant soumet une saisie qui n'est pas une réponse bien formée
    Alors le statut durable de la notion est toujours Non abordée

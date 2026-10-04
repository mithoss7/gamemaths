Le système distingue le **statut durable** (persisté sur l'appareil) de
l'**état affiché** (recalculé à chaque affichage). Seul le statut durable est
écrit sur l'appareil ; l'état affiché s'en déduit, combiné au statut des
prérequis.

## Statut durable (persisté)

- **Non abordée** : aucune tentative d'exercice n'a jamais été faite sur cette notion. Une tentative est la soumission d'une réponse bien formée ; une saisie non bien formée n'en est pas une.
- **Abordée** : au moins une tentative d'exercice a été faite (au cours d'une session présente ou passée), mais la notion n'est pas Maîtrisée.
- **Maîtrisée** : le critère de maîtrise a été atteint. Statut définitif.

## État affiché (dérivé)

- **Verrouillée** : au moins un prérequis n'est pas Maîtrisé et le statut durable n'est pas Maîtrisée.
- **Disponible** : tous les prérequis sont Maîtrisés et le statut durable est Non abordée.
- **En cours** : tous les prérequis sont Maîtrisés et le statut durable est Abordée.
- **Maîtrisée** : le statut durable est Maîtrisée.

## Transitions

Les transitions ci-dessous décrivent l'évolution de l'**état affiché** ; chacune
résulte d'un changement de **statut durable** et/ou de l'état des prérequis.

- **Verrouillée vers Disponible** : le dernier prérequis manquant atteint le statut durable Maîtrisée (la notion conserve par ailleurs le statut durable Non abordée).
- **Disponible vers En cours** : à la première tentative d'exercice, le statut durable de la notion passe de Non abordée à Abordée.
- **En cours vers Maîtrisée** : la série atteint N et le statut durable passe de Abordée à Maîtrisée.
- L'état affiché Maîtrisée est définitif : aucune transition n'en fait sortir, car le statut durable Maîtrisée ne change plus.
- Il n'existe pas de transition En cours vers Disponible : le statut durable ne revient jamais de Abordée à Non abordée.

Les exigences vérifiables correspondant à ce modèle sont spécifiées aux
sections 5 à 8.
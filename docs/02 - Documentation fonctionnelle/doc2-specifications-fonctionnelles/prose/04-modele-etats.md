Le système distingue le **statut durable** (persisté sur l'appareil) de
l'**état affiché** (recalculé à chaque affichage). Seul le statut durable est
écrit sur l'appareil ; l'état affiché s'en déduit, combiné au statut des
prérequis.

## Statut durable (persisté)

- **Non abordée** : aucune tentative d'exercice n'a jamais été faite sur cette notion.
- **Abordée** : au moins une tentative d'exercice a été faite (au cours d'une session présente ou passée), mais la notion n'est pas Maîtrisée.
- **Maîtrisée** : le critère de maîtrise a été atteint. Statut définitif.

## État affiché (dérivé)

- **Verrouillée** : au moins un prérequis n'est pas Maîtrisé.
- **Disponible** : tous les prérequis sont Maîtrisés et le statut durable est Non abordée.
- **En cours** : tous les prérequis sont Maîtrisés et le statut durable est Abordée.
- **Maîtrisée** : le statut durable est Maîtrisée.

## Transitions

- **Verrouillée vers Disponible** : le dernier prérequis manquant devient Maîtrisé (notion encore Non abordée).
- **Disponible vers En cours** : à la première tentative d'exercice de la notion (le statut durable passe à Abordée).
- **En cours vers Maîtrisée** : la série atteint N.
- Aucune transition ne fait sortir une notion de l'état Maîtrisée.
- Une notion Abordée ne redevient jamais Disponible : il n'existe pas de transition En cours vers Disponible.

Les exigences vérifiables correspondant à ce modèle sont spécifiées aux
sections 5 à 8.

# El-Kluster: Configuration NixOS

Bienvenue dans le dépôt de configuration NixOS de **El-Kluster**, un cluster Kubernetes basé sur NixOS. Cette configuration est gérée via les **flakes** de Nix.


## Installation et utilisation

### Étapes pour déployer la configuration sur un système

1. **Cloner le dépôt :**

   ```bash
   git clone https://github.com/username/el-kluster.git
   cd el-kluster
   ```

2. **Appliquer la configuration :**

    Pour appliquer la configuration sur le master, exécutez la commande suivante :

   ```bash
   sudo nixos-rebuild switch --flake .#master
   ```

    Pour les workers, utilisez :

   ```bash
   sudo nixos-rebuild switch --flake .#workers
   ```

### Utilisation des machines spécifiques

- **Master** : Gère le contrôle du cluster Kubernetes et les configurations spécifiques.
- **Workers** : Exécute les workloads Kubernetes et se connecte au master.

### Gestion des utilisateurs

Chaque utilisateur est défini dans le dossier `users`. Chaque fichier `default.nix` contient la configuration spécifique de l'utilisateur, incluant l'ajout de leur clé SSH.

**Ajouter un nouvel utilisateur**
Pour ajouter un utilisateur, créez un nouveau dossier sous `users/` avec :

1. Un fichier `default.nix` contenant les détails de l'utilisateur.
2. Un fichier `id_rsa.pub` avec la clé publique SSH de l'utilisateur.

Ensuite, importez cet utilisateur dans `users/default.nix`.


sudo nixos-rebuild switch --flake '.#master'
sudo nixos-rebuild switch --flake '.#workers'
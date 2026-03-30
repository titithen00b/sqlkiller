# 🗡️ sqlkiller — Suppresseur de requêtes SQL trop longues

![Bash](https://img.shields.io/badge/Bash-5%2B-informational?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-MariaDB-4479A1?style=for-the-badge)
![Linux](https://img.shields.io/badge/Linux-Debian%2FUbuntu-orange?style=for-the-badge)
![systemd](https://img.shields.io/badge/systemd-service-green?style=for-the-badge)
![Licence](https://img.shields.io/badge/Licence-MIT-green?style=for-the-badge)

Script Bash qui surveille en continu le processlist MySQL/MariaDB et tue automatiquement toutes les requêtes `SELECT` dépassant 150 secondes d'exécution. Fourni avec un fichier service systemd pour un démarrage automatique.

> Voir aussi le repo jumeau [`killersql`](https://github.com/titithen00b/killersql) qui propose une version sans service systemd.

---

## Fonctionnalités

- Surveillance continue du processlist MySQL/MariaDB (toutes les 10 secondes)
- Kill automatique des requêtes `SELECT` dépassant le seuil configuré (défaut : 180s)
- Journalisation dans `/var/log/killerrequests`
- Arrêt propre si le service systemd est stoppé
- Validation du seuil de temps (arrêt si valeur invalide)

---

## Prérequis

- Bash 5+
- MySQL ou MariaDB
- Utilisateur MySQL avec droits `PROCESS` et `SUPER` (ou `KILL`)
- systemd (pour le service)

---

## Installation

```bash
git clone https://github.com/titithen00b/sqlkiller.git
cd sqlkiller
```

### 1. Configurer les variables

Ouvrir `sqlquerykiller.sh` et renseigner les informations de connexion :

```bash
host="localhost"
password="mon_mot_de_passe"
user="root"
port="3306"
wanttime=180    # Durée max en secondes avant kill
```

### 2. Copier le script dans un dossier PATH

```bash
sudo cp sqlquerykiller.sh /etc/sqlquerykiller.sh
sudo chmod +x /etc/sqlquerykiller.sh
```

### 3. Installer le service systemd

```bash
sudo cp requestkillerSQL.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable requestkillerSQL.service
sudo systemctl start requestkillerSQL.service
```

> **Important :** Si vous modifiez le chemin du script, mettre à jour le fichier `.service` en conséquence.

---

## Utilisation

### Gestion du service

```bash
# Démarrer
sudo systemctl start requestkillerSQL.service

# Vérifier le statut
sudo systemctl status requestkillerSQL.service

# Voir les logs
tail -f /var/log/killerrequests

# Arrêter
sudo systemctl stop requestkillerSQL.service
```

### Lancement manuel (sans systemd)

```bash
sudo ./sqlquerykiller.sh
```

---

## Exemple de log

```
[15-01-24_14:32:01] Aucune requête trouvé avec le temps maximal indiqué : 180 seconde(s)
[15-01-24_16:10:44] KILL 1687;
```

---

## Fichiers du projet

| Fichier | Description |
|---------|-------------|
| `sqlquerykiller.sh` | Script principal de surveillance et kill |
| `requestkillerSQL.service` | Fichier service systemd |

---

## Licence

MIT © Titithen00b

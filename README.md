# Projet-Sondage-finale
Cette Application  permet d’importer des données, de traiter les valeurs manquantes, d’analyser des variables qualitatives et quantitatives, et de réaliser un échantillonnage stratifié avec visualisations comparatives.
# 📊 Sondage — Application R Shiny pour l’analyse de données d’enquête

**Sondage** est une application interactive développée en **R Shiny** qui guide l’utilisateur depuis l’importation de sa base de données jusqu’à la génération d’un échantillon stratifié avec allocation proportionnelle, en passant par le nettoyage et l’analyse descriptive.

---

## 🚀 Fonctionnalités

1. **Importation de données**  
   - Fichiers `.csv` ou `.xlsx`  
   - Chargement et prévisualisation instantanés  

2. **Sélection des variables**  
   - Choix des variables qualitatives (stratification)  
   - Choix optionnel de la variable auxiliaire (p. ex. `Area`)  

3. **Traitement des valeurs manquantes**  
   - Détection automatique  
   - Options d’imputation ou d’exclusion  

4. **Statistiques descriptives**  
   - Tableaux de fréquences, effectifs, proportions  
   - Visualisations (barres, boîtes, histogrammes)  

5. **Sondage stratifié à allocation proportionnelle**  
   - Calcul de la taille de chaque strate :  
     \[
       Nh = \text{effectif de la strate},\quad nh = \mathrm{round}\bigl(n \times \tfrac{Nh}{N}\bigr)
     \]
   - Tirage aléatoire de l’échantillon  
   - Comparaison graphique entre population et échantillon  

6. **Export**  
   - Téléchargement de l’échantillon (`.csv`)  
   - Téléchargement de la table d’allocation (`.csv`)  
   - Téléchargement des graphiques (`.png`)

---

## ⚙️ Prérequis

- **R** >= 4.0  
- **RStudio** (facultatif, recommandé)  
- **Java JDK** (pour le package `xlsx`)  
- Packages R :
  ```r
  shiny, shinydashboard, shinyjs, plotly, DT, xlsx,
  evaluate, shinycssloaders, highcharter, cowplot,
  magick, ggplot2, tseries, moments, stats,
  shinythemes, purrr, cluster, dashboardthemes




# installation
## Résolution de l'erreur de chargement du package 'xlsx'

Lorsque vous essayez de charger le package 'xlsx' dans R, vous pouvez rencontrer une erreur indiquant que le chargement du package 'rJava' a échoué et que JAVA_HOME ne peut pas être déterminé à partir du Registre. Voici comment résoudre ce problème :

## 1. Vérifier si Java est installé

Assurez-vous que Java est installé sur votre système en ouvrant un terminal ou une invite de commande et en tapant la commande suivante :

bash
Cela devrait afficher les informations de version de Java si Java est installé correctement.

## 2. Définir la variable JAVA_HOME
Si Java est installé, vous devez définir la variable d'environnement JAVA_HOME.
 Cette variable indique à R où Java est installé sur votre système. Suivez ces étapes :
Sur Windows :

 Recherchez "Variables d'environnement" dans le menu Démarrer et ouvrez-le.
    Cliquez sur "Variables d'environnement" en bas.
    Dans la section "Variables système", cliquez sur "Nouveau" et ajoutez une variable nommée JAVA_HOME avec le chemin vers votre répertoire d'installation Java (par exemple, C:\Program Files\Java\jdk1.8.0_281).
    Cliquez sur "OK" pour enregistrer les modifications.

Sur Linux/Mac :

   Ouvrez votre fichier de configuration shell (par exemple, ~/.bashrc, ~/.bash_profile, ~/.profile) dans un éditeur de texte.
    Ajoutez la ligne suivante à la fin du fichier :

bash:
export JAVA_HOME=/chemin/vers/votre/installation/java

   Enregistrez le fichier et exécutez source ~/.bashrc (ou le fichier approprié selon votre shell) pour appliquer les modifications.
Après avoir défini la variable JAVA_HOME, redémarrez votre session R et essayez de charger à nouveau le package 'xlsx'.

Si vous rencontrez toujours des problèmes, vérifiez que la variable JAVA_HOME est correctement définie et pointe vers le répertoire d'installation de Java.

Pour plus d'informations sur l'installation de Java SDK et la configuration de l'environnement, consultez le site officiel de Java: [Java Downloads]("https://www.oracle.com/java/technologies/javase-jdk11-downloads.html")

</div>

# Introduction:
 Dans ce projet, nous allons concevoir et réaliser un tableau de bord dynamique en
utilisant RShiny pour le prétraitement et l’analyse de bases de données médicales. Nous
allons nous concentrer sur les bases de données concernant la maladie de Parkinson et la
maladie d’Alzheimer.

# installation
## Résolution de l'erreur de chargement du package 'xlsx'

Lorsque vous essayez de charger le package 'xlsx' dans R, vous pouvez rencontrer une erreur indiquant que le chargement du package 'rJava' a échoué et que JAVA_HOME ne peut pas être déterminé à partir du Registre. Voici comment résoudre ce problème :

## 1. Vérifier si Java est installé

Assurez-vous que Java est installé sur votre système en ouvrant un terminal ou une invite de commande et en tapant la commande suivante :

bash
Cela devrait afficher les informations de version de Java si Java est installé correctement.

## 2. Définir la variable JAVA_HOME
Si Java est installé, vous devez définir la variable d'environnement JAVA_HOME.
 Cette variable indique à R où Java est installé sur votre système. Suivez ces étapes :
Sur Windows :

 Recherchez "Variables d'environnement" dans le menu Démarrer et ouvrez-le.
    Cliquez sur "Variables d'environnement" en bas.
    Dans la section "Variables système", cliquez sur "Nouveau" et ajoutez une variable nommée JAVA_HOME avec le chemin vers votre répertoire d'installation Java (par exemple, C:\Program Files\Java\jdk1.8.0_281).
    Cliquez sur "OK" pour enregistrer les modifications.

Sur Linux/Mac :

   Ouvrez votre fichier de configuration shell (par exemple, ~/.bashrc, ~/.bash_profile, ~/.profile) dans un éditeur de texte.
    Ajoutez la ligne suivante à la fin du fichier :

bash:
export JAVA_HOME=/chemin/vers/votre/installation/java

   Enregistrez le fichier et exécutez source ~/.bashrc (ou le fichier approprié selon votre shell) pour appliquer les modifications.
Après avoir défini la variable JAVA_HOME, redémarrez votre session R et essayez de charger à nouveau le package 'xlsx'.

Si vous rencontrez toujours des problèmes, vérifiez que la variable JAVA_HOME est correctement définie et pointe vers le répertoire d'installation de Java.

Pour plus d'informations sur l'installation de Java SDK et la configuration de l'environnement, consultez le site officiel de Java: [Java Downloads]("https://www.oracle.com/java/technologies/javase-jdk11-downloads.html")

</div>



Lancement de l’application

    Important : pour démarrer l’app, cliquez sur server.R dans RStudio puis sur “Run App”.
    L’interface se lancera dans votre navigateur à l’adresse http://127.0.0.1:xxxx















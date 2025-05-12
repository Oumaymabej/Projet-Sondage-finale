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

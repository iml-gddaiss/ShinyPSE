# ShinyPSE
Application Shiny pour donner une interface graphique aux données sur la BD PSE via le pacakge `PSEtoDataframe`.

# prereqs

install `PSEtoDataframe`
``` R
pak::pak("iml-gddaiss/iml-gddaiss/pse_to_dataframe")
```
Voir les instructions sur https://github.com/iml-gddaiss/pse_to_dataframe pour plus d'infoset instructions sur l'établiassement d'une connexion à PSE (Oracle).

``` R
install.packages("shiny")
install.packages("bslib")
install.packages("odbc")
install.packages("DBI")
install.packages("DT")
```



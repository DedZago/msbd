import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


def grafico_importanza_variabili(importanze, variabili, max_num=None,
        titolo="Importanza delle variabili"):
    importanze = pd.Series(importanze, index=variabili).sort_values(
        ascending=False)
    importanze[:max_num].plot(kind="bar", grid=True, title=titolo,
        color="tab:blue")


def ScatterGroup(X, grp, palette="colorblind"):
    """
    Funzione che genera uno scatterplot di X, con i colori in base al gruppo di appartenenza,
    dato da col.
    
    Parameters
    ----------
    X : DataFrame di dimensioni (n,2)
        Coordinate x,y dei punti nel grafico
        
    grp : DataFrame di dimensioni (n,1)
        Gruppo di appartenenza dei punti di X
    
    palette : string
        Una qualunque tra le seguenti palette di Seaborn:
            deep, muted, bright, pastel, dark, colorblind
    
    Returns
    -------
    figure : matplotlib.figure.Figure
    ax : matplotlib.axes.Axes
    
    """
    
    if palette not in ["deep", "muted", "bright", "pastel", "dark", "colorblind"]:
        raise KeyError
    pal = sns.color_palette(palette)
    color = {grp.unique()[i]:pal[i] for i in range(len(grp.unique()))}
    grouped = X.groupby(grp)
    
    # Scatterplot dei dati
    fig, ax = plt.subplots()
    for key, group in grouped:
        group.plot(ax=ax, kind='scatter', x=X.columns[0], y=X.columns[1],
                   label=key, color=color[key])
    return fig,ax
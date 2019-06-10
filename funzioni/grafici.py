import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import confusion_matrix

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

def MatriceConfusione(y_true, y_pred, nome_immagine="" ,title="", col="Blues"):
    ticks = y_true.unique()
    ticks.sort()
    g = sns.heatmap(confusion_matrix(y_true, y_pred, labels=ticks), xticklabels=ticks, yticklabels=ticks,
        cmap=col, annot=True, fmt="d", 	)
    #plt.xticks(np.arange(len(ticks)), ticks, rotation=90)
    g.set_xticklabels(g.get_yticklabels(), rotation =90)
    g.set_ylabel("veri")
    g.set_xlabel("previsti")
    plt.title(title)
    plt.savefig(nome_immagine,dpi=150, bbox_inches="tight")
    plt.show()

def DistGroup(X, grp, palette="colorblind", leg_loc=(1,0.8), file=None):
    if palette not in ["deep", "muted", "bright", "pastel", "dark", "colorblind"]:
        raise KeyError
    grp_dist = grp.unique()
    pal = sns.color_palette(palette)
    color = [pal[i] for i in range(len(grp_dist))]

    for i in range(len(grp_dist)):
        sns.distplot(X[grp==grp_dist[i]], color = color[i],
            hist=False)

    #plt.legend(bbox_to_anchor=leg_loc)
    if file:
    	plt.savefig(file, dpi=150, bbox_inches="tight")

    plt.show()
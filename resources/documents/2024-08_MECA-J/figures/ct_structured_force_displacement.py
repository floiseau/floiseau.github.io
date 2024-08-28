import numpy as np
import pandas as pd
import plotly.graph_objects as go


def plot_ct_results():
    # Read the CSV file into a pandas DataFrame
    df_lefm = pd.read_csv("data/ct_specimen/lefm.csv")
    dfs = [
        pd.read_csv(f"data/ct_specimen/structured.csv"),
        pd.read_csv(f"data/ct_specimen/unstructured.csv"),
    ]
    names = ["Structured", "Unstructured"]

    # Define plot traces
    traces = []
    trace = go.Scatter(
        x=df_lefm["cmod"],
        y=-df_lefm["F"],
        name="LEFM",
        mode="lines",  # "lines+markers",
    )
    traces.append(trace)

    for i, df in enumerate(dfs):
        cmod_x = (
            df["displacement 1 [0.      0.02115 0.     ]"]
            - df["displacement 1 [0.    0.017 0.   ]"]
        )
        cmod_y = (
            df["displacement 2 [0.      0.02115 0.     ]"]
            - df["displacement 2 [0.    0.017 0.   ]"]
        )
        x_data = np.sqrt(cmod_x**2 + cmod_y**2)
        y_data = -df["F_2 (bot_pin)"] * 1e-2

        trace = go.Scatter(
            x=x_data,
            y=y_data,
            name=names[i],
            mode="lines",  # "lines+markers",
        )
        traces.append(trace)

    layout = go.Layout(
        xaxis_title="Crack opening [m]",
        yaxis_title="Force [N]",
        font=dict(family="Source Sans Pro", size=18),  # Set font family and size
        legend=dict(yanchor="top", y=0.99, xanchor="right", x=0.99),
    )

    # Create the figure with traces and layout
    fig = go.Figure(data=traces, layout=layout)

    fig.update_xaxes(
        range=[0, 5e-4],
        showgrid=True,
        gridcolor="lightgrey",
        ticks="outside",
        exponentformat="power",
        zeroline=True,
        zerolinewidth=2,
        zerolinecolor="grey",
    )
    fig.update_yaxes(
        showgrid=True,
        gridcolor="lightgrey",
        ticks="outside",
        exponentformat="power",
        zeroline=True,
        zerolinewidth=1.5,
        zerolinecolor="grey",
    )
    # Show the plot
    fig.show()

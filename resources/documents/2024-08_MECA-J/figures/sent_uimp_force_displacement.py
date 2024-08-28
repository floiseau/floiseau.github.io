import pandas as pd
import plotly.graph_objects as go


def plot_convergence(control: str):
    # Read the CSV file into a pandas DataFrame
    df_lefm = pd.read_csv("data/sent_specimen/LEFM_equilibrium_path.csv")
    dfs = [
        pd.read_csv(f"data/sent_specimen/{control}/ell_over_h_2.csv"),
        pd.read_csv(f"data/sent_specimen/{control}/ell_over_h_4.csv"),
        pd.read_csv(f"data/sent_specimen/{control}/ell_over_h_6.csv"),
        pd.read_csv(f"data/sent_specimen/{control}/ell_over_h_8.csv"),
    ]
    names = [
        r"h=l/2",
        r"h=l/4",
        r"h=l/6",
        r"h=l/8",
    ]

    # Define plot traces
    traces = []
    trace = go.Scatter(
        x=df_lefm["u"],
        y=df_lefm["F"],
        name="LEFM",
        mode="lines",  # "lines+markers",
    )
    traces.append(trace)

    for i, df in enumerate(dfs):
        trace = go.Scatter(
            x=df["displacement 2 [0, 0.001, 0]"],
            y=df["F_2 (top)"] * 1e-3,
            name=names[i],
            mode="lines",  # "lines+markers",
        )
        traces.append(trace)

    layout = go.Layout(
        xaxis_title="Displacement [m]",
        yaxis_title="Force [N]",
        font=dict(family="Source Sans Pro", size=18),  # Set font family and size
        legend=dict(yanchor="top", y=0.99, xanchor="left", x=0.01),
    )

    # Create the figure with traces and layout
    fig = go.Figure(data=traces, layout=layout)

    fig.update_xaxes(
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

"""First cut: category profit vs order share."""

from pathlib import Path

import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
CSV = ROOT / "data" / "superstore_sales.csv"


def main() -> None:
    df = pd.read_csv(CSV, encoding="latin-1")
    g = df.groupby("Product Category", as_index=False).agg(
        orders=("Order ID", "nunique"),
        sales=("Sales", "sum"),
        profit=("Profit", "sum"),
    )
    g["order_share"] = g["orders"] / g["orders"].sum()
    g["sales_share"] = g["sales"] / g["sales"].sum()
    g["profit_share"] = g["profit"] / g["profit"].sum()
    g["margin"] = g["profit"] / g["sales"]
    g = g.sort_values("profit", ascending=False)
    print(g.to_string(index=False, formatters={
        "sales": "{:,.0f}".format,
        "profit": "{:,.0f}".format,
        "order_share": "{:.1%}".format,
        "sales_share": "{:.1%}".format,
        "profit_share": "{:.1%}".format,
        "margin": "{:.1%}".format,
    }))


if __name__ == "__main__":
    main()

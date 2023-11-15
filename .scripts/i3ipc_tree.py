#!/usr/bin/env python3
"""Print a readable tiling tree for Sway and i3."""

import i3ipc as i3  # type: ignore


def trunc(x: str, n: int = 25) -> str:
    return x[:n] + "…" if len(x) > n + 1 else x


def print_con(con: i3.Con, prefix: str = "") -> None:
    if con.type == "workspace":
        print("\033[4m", end="")
    if con.focused:
        print("\033[1m", end="")
    print(f"{prefix}"
        f"#{con.id} "
        f"{con.type}/{con.layout}", end="")
    if con.type == "workspace":
        print("\033[24m", end="")
    print(f" [{', '.join(con.marks)}] "
        f"\033[3m{trunc(con.name or '')}\033[0m")
    if con.focused:
        print("\033[0m", end="")
    for node in con.nodes:
        print_con(node, prefix=prefix + " │ ")


if __name__ == "__main__":
    conn = i3.Connection()
    tree: i3.Con = conn.get_tree()
    for workspace in tree.workspaces():
        print_con(workspace)
        print()

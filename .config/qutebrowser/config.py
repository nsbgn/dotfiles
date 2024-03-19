# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

c.tabs.show = "multiple"
c.tabs.tabs_are_windows = True

c.window.title_format = "{perc}{current_title}"

config.bind(',p',
    'spawn --userscript qute-pass --dmenu-invocation bemenu')

config.load_autoconfig(False)

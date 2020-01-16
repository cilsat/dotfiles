from base16 import Base16Style, overrides
from IPython.terminal import interactiveshell

def get_style_by_name(name, original=interactiveshell.get_style_by_name):
    return Base16Style if name == 'base16' else original(name)
interactiveshell.get_style_by_name = get_style_by_name

c.TerminalInteractiveShell.highlighting_style = 'base16'
c.TerminalInteractiveShell.highlighting_style_overrides = overrides

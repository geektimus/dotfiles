from libqtile.log_utils import logger
from dataclasses import dataclass
from os import path
import json

from .path import pywal_path, qtile_path

@dataclass
class ThemeColors:
    background: str
    foreground: str
    color0: str
    color1: str
    color2: str
    color3: str
    color4: str
    color5: str
    color6: str
    color7: str
    color8: str
    color9: str
    color10: str
    color11: str
    color12: str
    color13: str
    color14: str
    color15: str

def load_pywal(theme_file):

    if path.isfile(theme_file):
      with open(theme_file, encoding='UTF-8') as f:
        data = json.load(f)
        background = data['special']['background']
        foreground = data['special']['foreground']
        color0 = data['colors']['color0']
        color1 = data['colors']['color1']
        color2 = data['colors']['color2']
        color3 = data['colors']['color3']
        color4 = data['colors']['color4']
        color5 = data['colors']['color5']
        color6 = data['colors']['color6']
        color7 = data['colors']['color7']
        color8 = data['colors']['color8']
        color9 = data['colors']['color9']
        color10 = data['colors']['color10']
        color11 = data['colors']['color11']
        color12 = data['colors']['color12']
        color13 = data['colors']['color13']
        color14 = data['colors']['color14']
        color15 = data['colors']['color15']
        return ThemeColors(background, foreground, color0, color1, color2, color3, color4, color5,
                    color6, color7, color8, color9, color10, color11, color12, color13, color14, color15)
    else:
      logger.warn(f'Warning: The theme file "{pywal_path}" does not exist. Using Defaults')
      return load_pywal(path.join(qtile_path, 'default_theme.json'))


if __name__ == "settings.theme":
    logger.info(f'Loading colors from {pywal_path}')
    colors = load_pywal(pywal_path)


# Настройки окна образа HHsim.dmg для dmgbuild (https://dmgbuild.readthedocs.io).
# Запуск: dmgbuild -s dmg_settings.py -D app=путь/HHsim.app "HHsim" HHsim.dmg
import os.path

app = defines.get('app', 'HHsim.app')  # noqa: F821 (defines задаёт dmgbuild)

format = 'UDZO'
filesystem = 'HFS+'
files = [app]
symlinks = {'Программы': '/Applications'}
icon_locations = {
    os.path.basename(app): (160, 215),
    'Программы': (480, 215),
}
background = defines.get('background', 'dmg-background.png')  # noqa: F821
window_rect = ((200, 150), (640, 400))
default_view = 'icon-view'
show_status_bar = False
show_tab_view = False
show_toolbar = False
show_pathbar = False
show_sidebar = False
icon_size = 112
text_size = 13

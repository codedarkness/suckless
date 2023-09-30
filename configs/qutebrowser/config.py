import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

c.url.start_pages = 'https://search.brave.com'
c.content.pdfjs = False
c.scrolling.bar = "overlay"
c.scrolling.smooth = True

# Setting default page for when opening new tabs or new windows with
# commands like :open -t and :open -w .
c.url.default_page = 'https://linuxsucks.xyz/'

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

c.url.searchengines = {'DEFAULT': 'https://search.brave.com/search?q={}', 'gs': 'https://www.google.com/search?q={}'}

#config.bind('xd', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/darculized-all-sites.css ""')

config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xm', 'config-cycle tabs.show multiple always')

config.set("fileselect.single_file.command", ['alacritty', '--class', 'ranger,ranger', '-e', 'ranger', '--choosefile', '{}'])

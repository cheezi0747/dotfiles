# Make sure Spotify is installed and opened at least once
open -a Spotify
# Install spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh

#My ghetto solution since I want spicetify to be installed in a different location
mv ~/.spicetify ~/.local/spicetify
sed -i '' -e '$d' ~/.config/zsh/.zshrc

#Copy catpuccin files
git clone https://github.com/catppuccin/spicetify.git tmp
cd tmp
cp -r catppuccin-* ~/.config/spicetify/Themes/
cp js/* ~/.config/spicetify/Extensions/
cd ..
rm -rf tmp

#Apply settings
spicetify config current_theme catppuccin-frappe
spicetify config color_scheme pink
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify config extensions catppuccin-frappe.js

spicetify backup apply

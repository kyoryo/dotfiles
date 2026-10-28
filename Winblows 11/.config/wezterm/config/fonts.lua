local wezterm = require("wezterm")
local platform = require("utils.platform")

local font = "JetBrainsMono NF"
local font_size = platform().is_mac and 12 or 10

return {
  -- font = wezterm.font(font),
  font = wezterm.font_with_fallback{
    "JetBrainsMono Nerd Font",
    font,
    "UbuntuMono Nerd Font",
    "Fira Mono for Powerline",
    "Noto Color Emoji",
    "Segoe UI Symbol",
    "Symbols Nerd Font Mono",
  },
  font_size = font_size,

  --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
  freetype_load_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  freetype_render_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  warn_about_missing_glyphs = false,
}

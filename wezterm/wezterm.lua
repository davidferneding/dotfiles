-- [nfnl] Compiled from wezterm.fnl by https://github.com/Olical/nfnl, do not edit.
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local config_values = {color_scheme = "Catppuccin Frappe", font = wezterm.font("VictorMono Nerd Font", {weight = "Regular"}), font_size = 15, window_padding = {left = 0, right = 0, top = 0, bottom = 0}, send_composed_key_when_left_alt_is_pressed = true, enable_tab_bar = false}
for key, value in pairs(config_values) do
  config[key] = value
end
local function get(val)
  return val
end
return get(config)

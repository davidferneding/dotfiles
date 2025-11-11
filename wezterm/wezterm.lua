-- [nfnl] wezterm.fnl
local function merge_tables(tables)
  local merged = {}
  for _, tbl in ipairs(tables) do
    for k, v in pairs(tbl) do
      merged[k] = v
    end
  end
  return merged
end
local wezterm = require("wezterm")
local config_style = {color_scheme = "Catppuccin Mocha", colors = {visual_bell = "#e78284"}, font = wezterm.font("Monaspace Neon"), font_rules = {{intensity = "Normal", italic = true, font = wezterm.font("Monaspace Radon", {weight = "Medium"})}}, font_size = 14, freetype_load_target = "HorizontalLcd", harfbuzz_features = {"calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "ss09"}, window_padding = {left = 0, right = 0, top = 0, bottom = 0}, enable_tab_bar = false}
local config_feel = {audible_bell = "Disabled", visual_bell = {fade_in_duration_ms = 75, fade_out_duration_ms = 75, target = "CursorColor"}}
local config_functional = {send_composed_key_when_left_alt_is_pressed = true}
local config_values = merge_tables({config_style, config_feel, config_functional})
local config = wezterm.config_builder()
for key, value in pairs(config_values) do
  config[key] = value
end
return config

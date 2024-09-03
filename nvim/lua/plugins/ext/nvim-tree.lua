-- [nfnl] Compiled from fnl/plugins/ext/nvim-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local function directory_3f(file)
    return (file.type == "directory")
  end
  local function compare_number(left, right, start_index)
    local left_num = tonumber(string.match(string.sub(left, start_index, -1), "^[0-9]+"))
    local right_num = tonumber(string.match(string.sub(right, start_index, -1), "^[0-9]+"))
    if (left_num == right_num) then
      return "same"
    else
      if (left_num < right_num) then
        return "use-left"
      else
        return "use-right"
      end
    end
  end
  local function number_3f(text)
    return (type(tonumber(text)) == "number")
  end
  local function compare_char(left_char, right_char)
    if (left_char == right_char) then
      return "same"
    else
      if (left_char < right_char) then
        return "use-left"
      else
        return "use-right"
      end
    end
  end
  local function compare(left, right, index)
    if (index > string.len(left)) then
      return "use-left"
    else
      if (index > string.len(right)) then
        return "use-right"
      else
        local left_char = string.sub(left, index, index)
        local right_char = string.sub(right, index, index)
        if (number_3f(left_char) and number_3f(right_char)) then
          local compare_number_result = compare_number(left, right, index)
          if ("same" == compare_number_result) then
            return compare(left, right, (1 + index))
          else
            return compare_number_result
          end
        else
          local compare_char_result = compare_char(left_char, right_char)
          if ("same" == compare_char_result) then
            return compare(left, right, (1 + index))
          else
            return compare_char_result
          end
        end
      end
    end
  end
  local function hidden_3f(file)
    return ("." == string.sub(file.name, 1, 1))
  end
  local function natural_sort(left, right)
    if (directory_3f(left) ~= directory_3f(right)) then
      return directory_3f(left)
    else
      if (hidden_3f(left) ~= hidden_3f(right)) then
        return hidden_3f(right)
      else
        if ((left.name):lower() == (right.name):lower()) then
          return false
        else
          return ("use-left" == compare((left.name):lower(), (right.name):lower(), 1))
        end
      end
    end
  end
  local function _14_(nodes)
    return table.sort(nodes, natural_sort)
  end
  return (require("nvim-tree")).setup({view = {width = {min = 30, max = 100}, number = true, relativenumber = true}, sort = {sorter = _14_}, renderer = {group_empty = true}, actions = {open_file = {quit_on_open = true}}, filters = {custom = {"^.git.*"}, git_ignored = false}})
end
return {"nvim-tree/nvim-tree.lua", version = "*", dependencies = {"nvim-tree/nvim-web-devicons"}, config = _1_, lazy = false}

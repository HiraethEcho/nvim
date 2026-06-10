local M = {}

--- Check if cursor is inside a Typst math zone using treesitter.
--- Detects both inline ($...$) and display ($...$) math.
M.in_mathzone = function()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "math" then
      return true
    end
    node = node:parent()
  end
  return false
end

M.in_text = function()
  return not M.in_mathzone()
end

--- Function nodes for conditional math delimiting.
--- These return "$" if outside math, "" if inside math.
M.open_math = function()
  return M.in_mathzone() and "" or "$"
end

M.close_math = function()
  return M.in_mathzone() and "" or "$"
end

return M

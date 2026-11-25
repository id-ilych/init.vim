local M = {}

function M.format_table(lines)
  local rows, widths, alignments = {}, {}, {}

  for _, line in ipairs(lines) do
    local inner = line:match("^%s*|(.*)|%s*$")
    if not inner then
      return nil, "Select only the Markdown table"
    end

    local row = {}
    for cell in (inner .. "|"):gmatch("(.-)|") do
      row[#row + 1] = vim.trim(cell)
    end
    rows[#rows + 1] = row
  end

  if #rows < 2 then
    return nil, "Select the header and separator rows"
  end

  local columns = #rows[1]
  for r, row in ipairs(rows) do
    if #row ~= columns then
      return nil, "Table rows have different column counts"
    end

    for col, cell in ipairs(row) do
      if r == 2 then
        if not cell:match("^:?-+:?$") then
          return nil, "Invalid Markdown table separator"
        end
        alignments[col] = {
          left = cell:sub(1, 1) == ":",
          right = cell:sub(-1) == ":",
        }
      else
        widths[col] = math.max(
          widths[col] or 3,
          vim.fn.strdisplaywidth(cell)
        )
      end
    end
  end

  local formatted = {}
  for r, row in ipairs(rows) do
    local cells = {}

    for col, cell in ipairs(row) do
      local width = widths[col] or 3
      local alignment = alignments[col]

      if r == 2 then
        local left = alignment.left and ":" or ""
        local right = alignment.right and ":" or ""
        cells[col] = left
          .. string.rep("-", width + 2 - #left - #right)
          .. right
      else
        local padding = width - vim.fn.strdisplaywidth(cell)
        local left_padding = 0

        if alignment.left and alignment.right then
          left_padding = math.floor(padding / 2)
        elseif alignment.right then
          left_padding = padding
        end

        cells[col] = " "
          .. string.rep(" ", left_padding)
          .. cell
          .. string.rep(" ", padding - left_padding)
          .. " "
      end
    end

    formatted[r] = "|" .. table.concat(cells, "|") .. "|"
  end

  return formatted
end

return M

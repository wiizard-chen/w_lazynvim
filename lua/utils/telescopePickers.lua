local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require("telescope.config").values
local make_entry = require "telescope.make_entry"
local Path = require "plenary.path"

local flatten = vim.tbl_flatten
local filter = vim.tbl_filter

local customPickers = {}


local opts_contain_invert = function(args)
  local invert = false
  local files_with_matches = false

  for _, v in ipairs(args) do
    if v == "--invert-match" then
      invert = true
    elseif v == "--files-with-matches" or v == "--files-without-match" then
      files_with_matches = true
    end

    if #v >= 2 and v:sub(1, 1) == "-" and v:sub(2, 2) ~= "-" then
      local non_option = false
      for i = 2, #v do
        local vi = v:sub(i, i)
        if vi == "=" then -- ignore option -g=xxx
          break
        elseif vi == "g" or vi == "f" or vi == "m" or vi == "e" or vi == "r" or vi == "t" or vi == "T" then
          non_option = true
        elseif non_option == false and vi == "v" then
          invert = true
        elseif non_option == false and vi == "l" then
          files_with_matches = true
        end
      end
    end
  end
  return invert, files_with_matches
end

local escape_chars = function(string)
  return string.gsub(string, "[%(|%)|\\|%[|%]|%-|%{%}|%?|%+|%*|%^|%$|%.]", {
    ["\\"] = "\\\\",
    ["-"] = "\\-",
    ["("] = "\\(",
    [")"] = "\\)",
    ["["] = "\\[",
    ["]"] = "\\]",
    ["{"] = "\\{",
    ["}"] = "\\}",
    ["?"] = "\\?",
    ["+"] = "\\+",
    ["*"] = "\\*",
    ["^"] = "\\^",
    ["$"] = "\\$",
    ["."] = "\\.",
  })
end

local get_open_filelist = function(grep_open_files, cwd)
  if not grep_open_files then
    return nil
  end

  local bufnrs = filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      return false
    end
    return true
  end, vim.api.nvim_list_bufs())
  if not next(bufnrs) then
    return
  end

  local filelist = {}
  for _, bufnr in ipairs(bufnrs) do
    local file = vim.api.nvim_buf_get_name(bufnr)
    table.insert(filelist, Path:new(file):make_relative(cwd))
  end
  return filelist
end

local tprint = function(tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint .. k .. "= "
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent - 2) .. "}"
  print(toprint)
  return toprint
end

customPickers.grep_in_staged = function(opts)
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  local word = vim.F.if_nil(opts.search, vim.fn.expand "<cword>")
  local search = opts.use_regex and word or escape_chars(word)
  search = { search }

  local shellPath = vim.fn.stdpath "config" .. "/shell/gitstaged.sh"

  local args = flatten {
    "bash",
    shellPath,
    search,
  }

  opts.__inverted, opts.__matches = opts_contain_invert(args)

  tprint(args)

  if opts.grep_open_files then
    for _, file in ipairs(get_open_filelist(opts.grep_open_files, opts.cwd)) do
      table.insert(args, file)
    end
  elseif opts.search_dirs then
    for _, path in ipairs(opts.search_dirs) do
      table.insert(args, vim.fn.expand(path))
    end
  end

  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)
  pickers
      .new(opts, {
        prompt_title = "git file grep",
        finder = finders.new_oneshot_job(args, opts),
        previewer = conf.grep_previewer(opts),
        sorter = conf.generic_sorter(opts),
      })
      :find()
end

return customPickers;

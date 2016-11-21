-- Auto-completion for Galaxy's Go tools
-- Keep a cache alive to have a reactive auto-completion

local parser = clink.arg.new_parser
local cache_path = nil
local cache_command_list = nil

local function get_command_list()
  local ret = {}
  local file = io.popen("go --condensed_list 2>nul")
  local raw_command_list = file:read("*line")
  file:close()
  if raw_command_list then
    for command in raw_command_list:gmatch("%S+") do
      table.insert( ret, command )
    end
  end
  return ret
end

local function get_command_list_with_cache(token)
  if not cache_path then
    cache_path = "foobar"
    cache_command_list = get_command_list()
  end
  return cache_command_list
end

local gotools_parser = parser({ get_command_list_with_cache })
clink.arg.register_parser("go", gotools_parser)

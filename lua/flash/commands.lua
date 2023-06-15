local State = require("flash.state")
local Util = require("flash.util")
local Repeat = require("flash.repeat")

---@class Flash.Commands
local M = {}

---@param opts? Flash.Config
function M.jump(opts)
  local state = State.new(opts)

  while true do
    local c = Util.get_char()
    if c == nil then
      break
    -- jump to first
    elseif c == Util.CR then
      state:jump()
      break
    end

    local pattern = state.pattern
    if c == Util.BS then
      pattern = state.pattern:sub(1, -2)
    else
      pattern = state.pattern .. c
    end

    -- break if we jumped
    if state:update({ search = pattern }) then
      break
    end

    -- exit if no results
    if #state.results == 0 then
      break
    end
  end
  state:hide()
end

-- M.jump = Repeat.wrap(M.jump)

return M

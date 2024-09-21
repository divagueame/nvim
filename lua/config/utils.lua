local M = {}

M.Display_message = function(message)
  require("notify")(message)
end

M.Display_error = function(message)
  require("notify")(message, "error")
end

return M



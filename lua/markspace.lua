main = {}

local api = vim.api

local opt = vim.opt
local autocmd = api.nvim_create_autocmd
local set_hl = api.nvim_set_hl

local function error_hl()
	set_hl(0, "TrailingWhitespace", { link = "Error" })
end

function main.setup()
	local space = "·"
	opt.listchars:append {
		tab = "│─",
		multispace = space,
		lead = space,
		trail = space,
		nbsp = space
	}

	vim.cmd([[match TrailingWhitespace /\s\+$/]])

	error_hl()

	autocmd("InsertEnter", {
		callback = function()
			opt.listchars.trail = nil
			set_hl(0, "TrailingWhitespace", { link = "Whitespace" })
		end
	})

	autocmd("InsertLeave", {
		callback = function()
			opt.listchars.trail = space
			error_hl()
		end
	})
end

return main

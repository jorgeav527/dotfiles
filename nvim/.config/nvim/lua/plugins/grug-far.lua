local MAP = vim.keymap.set

return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },

  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "grug-far" },
      callback = function()
        -- ALT + h → toggle hidden files
        MAP({ "i", "n", "x" }, "<A-h>", function()
          local state = unpack(require("grug-far").get_instance(0):toggle_flags({ "--hidden", "--glob !.git/" }))
          vim.notify("grug-far: hidden → " .. (state and "ON" or "OFF"))
        end, { buffer = true, desc = "Toggle Hidden Files" })

        -- ALT + i → toggle ignored files
        MAP({ "i", "n", "x" }, "<A-i>", function()
          local state = unpack(require("grug-far").get_instance(0):toggle_flags({ "--no-ignore" }))
          vim.notify("grug-far: ignored → " .. (state and "ON" or "OFF"))
        end, { buffer = true, desc = "Toggle Ignored Files" })
      end,
    })
  end,
}

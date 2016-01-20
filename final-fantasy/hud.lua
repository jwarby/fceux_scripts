require 'lib/player_account'
require 'lib/player_inventory'

local account = PlayerAccount.create()
local inventory = PlayerInventory.create()

while (true) do

  -- Print
  gui.text(20, 10, account:getBalance()..'G')
  gui.text(60, 10, inventory:getQuantity('HEAL')..' x HEAL')
  gui.text(120, 10, inventory:getQuantity('PURE')..' x PURE')

  -- Advance to next frame
  -- @warn emulator will freeze if this call is not made
  emu.frameadvance()
end

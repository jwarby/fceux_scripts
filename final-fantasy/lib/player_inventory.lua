require 'lib/memory_addresses'

local ITEMS = {
  HEAL = MEMORY.items.heal,
  PURE = MEMORY.items.pure
}

PlayerInventory = {}
PlayerInventory.__index = PlayerInventory

function PlayerInventory.create()
  local invt = {}
  setmetatable(invt, PlayerInventory)
  return invt
end

function PlayerInventory:getQuantity(item)
  return memory.readbyte(ITEMS[item])
end

return PlayerInventory

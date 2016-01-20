require 'lib/memory_addresses'

-- Helper functions

-- Write 3-byte player funds to memory
--
-- @param {Number} balance  The number to write to memory
local function writeBalance(balance)
  memory.writebyte(MEMORY.money.lo, bit.band(balance, 0xff))
  memory.writebyte(MEMORY.money.mid, bit.band(bit.rshift(balance, 8), 0xff))
  memory.writebyte(MEMORY.money.hi, bit.band(bit.rshift(balance, 16), 0xff))
end

-- Read 3-byte player balance from memory
--
-- @return {Number} the player's current balance
local function readBalance()
  local balance = memory.readbyte(MEMORY.money.lo);
  balance = balance + bit.lshift(memory.readbyte(MEMORY.money.mid), 8)
  balance = balance + bit.lshift(memory.readbyte(MEMORY.money.hi), 16)

  return balance;
end

-- 'Class' definition
PlayerAccount = {}
PlayerAccount.__index = PlayerAccount

-- Constructor
function PlayerAccount.create()
  local acnt = {}
  setmetatable(acnt,PlayerAccount)
  return acnt
end

-- Withdraw `amount` from player's balance, and write back to memory
--
-- @param {Number} amount  The amount to deduct
--
-- @throws {Error} if the requested amount exceeds the available funds
function PlayerAccount:withdraw(amount)
  local balance = readBalance()

  if amount > balance then
    error('Player does not have enough gil')
  end

  writeBalance(balance - amount)
end

-- Get the player's balance
--
-- @return {Number} the player's current balance
function PlayerAccount:getBalance()
  return readBalance()
end

return PlayerAccount

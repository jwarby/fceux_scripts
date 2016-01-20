require 'lib/player_account';
require 'lib/memory_addresses';

require 'lib/ui/growl';

-- "Constants"
ITEM_PRICE = 60;
-- Memory address for player's current number of this item
ADDR_ITEM_QUANTITY = MEMORY.items.heal;
-- Max number of this item that the player can carry
ITEM_MAX = 99;
-- Minimum money this player should have in order for the script to execute
MIN_MONEY = 100;
ITEM_NAME = 'HEAL';

local account = PlayerAccount.create();

-- Read player's current number of this item
current = memory.readbyte(ADDR_ITEM_QUANTITY);

if current < ITEM_MAX and account:getBalance() > MIN_MONEY then

  -- How many more of this item the player can carry
  can_carry = ITEM_MAX -  current;

  -- How many the player can afford to buy
  can_afford = math.floor(account:getBalance() / ITEM_PRICE);

  -- How many they can actually buy, given the 2 above constraints
  can_buy = math.min(can_carry, can_afford);

  -- How much it will cost the player
  cost = can_buy * ITEM_PRICE;

  account:withdraw(cost);

  -- Write new quantity of item held by player
  memory.writebyte(ADDR_ITEM_QUANTITY, current + can_buy);

  growl('BOUGHT '..can_buy..' '..ITEM_NAME..'(S)!', 300);
end;

function growl(message, duration)

  counter = duration;
  after = 200;
  animate = {
    y = {
      finish = 200
    },
    current = 240
  };

  while (counter > 0) do
    y = animate.y.finish;

    if animate.current > animate.y.finish then
      animate.current = animate.current - 1;
      y = animate.current;
    end;

    gui.text((256 / 2) - (string.len(message) * 3), y, message);

    counter = counter - 1;

    -- Advance to next frame
    -- @warn emulator will freeze if this call is not made
    emu.frameadvance();
  end;

  while after > 0 do
    if after % 6 == 0 then
      message = string.sub(message, 1, -2);
    elseif after % 3 == 0 then
      message = string.sub(message, 2, -1);
    end;

    gui.text((256 / 2) - (string.len(message) * 3), y, message);

    after = after - 1;

    -- Advance to next frame
    -- @warn emulator will freeze if this call is not made
    emu.frameadvance();
  end;
end;

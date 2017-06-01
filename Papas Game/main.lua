local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
function love.load(arg)
  fondo=love.graphics.newImage("fondo.png");
  love.window.setFullscreen(true, "desktop");
  x=570;
  y=230;
  ingame=false;
  ft=love.graphics.newFont("titulo.ttf",90);
  fop=love.graphics.newFont("fipps.otf", 40);
  titulo= love.graphics.newText( ft,"Papa's Game");
  op1=love.graphics.newText(fop,"Load");
  op2=love.graphics.newText(fop,"Start");
  op3=love.graphics.newText(fop,"Credits");
  data = love.sound.newSoundData( "menu.mp3" );
  menu = love.audio.newSource(data)
  love.audio.play(menu);
end
function love.draw()
  love.graphics.draw(fondo, 0, -200);
  if ingame==false then
    love.graphics.draw(titulo, 300, 100);
    love.graphics.draw(op1, 620, 210);
    love.graphics.draw(op2, 610, 280);
    love.graphics.draw(op3, 580, 350);
    rect=love.graphics.rectangle("line",x, y,250,70,0,0,60);
  end
end
function love.update(dt)
  if(love.mouse.isDown(1))then
    if y==230 or y==300 then
      ingame=true;
    end
  end
  if ingame==false then
    if(love.keyboard.isDown("down")) then
      if(y<370)then
        sleep(.2);
        y=y+70;
      else
        y=230;
      end
    end
    if(love.keyboard.isDown("up")) then
      if(y>230)then
        y=y-70;
        sleep(.2);
      else
        y=370;
      end
    end
  end
end

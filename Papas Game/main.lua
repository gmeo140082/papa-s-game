local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
function love.load(arg)
  width = love.graphics.getWidth();
  fondo=love.graphics.newImage("fondo.png");
  potf=love.graphics.newImage("potf.png");
  cont=3;
  score=0;
  vid=1;
  sr=0;
  dt=0;
  vx=1;
  sc=0;
  fl=false;
  name="potf.png";
  vida={s,x,y,b,v};
  vida.s=love.graphics.newImage("heart.png");
  delt=love.math.random(20,50);
  vida.y=-60;
  vida.x=love.math.random(1-(vida.s:getWidth()/4),1400+(vida.s:getWidth()/4));
  vida.b=false;
  vida.v=false;
  vidas={};
  fuego={};
  for i=1,12 do
  	fuego[i]={x,y,w,h,t,s,dt,b,v};
  	fuego[i].s=love.graphics.newImage("fire.png");
  	fuego[i].y=love.math.random(0,150);
  	fuego[i].w=fuego[i].s:getWidth();
  	fuego[i].h=fuego[i].s:getHeight();
  	fuego[i].b=false;
  	fuego[i].v=false;
  	fuego[i].x=love.math.random(1-(fuego[i].w/4),1400+(fuego[i].w/4));
  	end
  for i=1,9 do
  	vidas[i]=love.graphics.newImage("heart.png");
  end
  h=potf:getHeight();
  w=potf:getWidth();
  love.window.setFullscreen(true, "desktop");
  x=570;
  y=230;
  px=0;
  r=0;
  g=0;
  pr=false;
  py=700-h;
  b2=false;
  col=false;
  ingame=false;
  ban=false;
  xd=false;
  xi=false;
  music=0;
  bb=false;
  m=false;
  if(ingame==false) then
    ft=love.graphics.newFont("titulo.ttf",90);
    fop=love.graphics.newFont("fipps.otf", 40);
    titulo= love.graphics.newText( ft,"Papa's Game");
    op1=love.graphics.newText(fop,"Load");
    op2=love.graphics.newText(fop,"Start");
    op3=love.graphics.newText(fop,"Credits");
    data = love.sound.newSoundData( "menu.mp3" );
    menu = love.audio.newSource(data);
  end
end

function love.draw()
  love.graphics.draw(fondo, 0, -200);
  if ingame==false then
    love.graphics.draw(titulo, 300, 100);
    love.graphics.draw(op1, 620, 210);
    love.graphics.draw(op2, 610, 280);
    love.graphics.draw(op3, 580, 350);
    rect=love.graphics.rectangle("line",x, y,250,70,0,0,60);
  else
  	love.graphics.draw(love.graphics.newText(fop,"Score: "..score),700,0);
  	if(ban==false)then
  		dt=love.timer.getTime();
  		ban=true;
  	end
  	for i=1,12 do
  		love.graphics.draw(fuego[i].s,fuego[i].x,fuego[i].y);
  	end
  	for j=1,cont do
  		vw=vidas[j]:getWidth();
  		love.graphics.draw(vidas[j],100+(vw*(j-1)+((j-1)*10)),0);
  	end
  	if(vida.v==false)then
  		love.graphics.draw(vida.s,vida.x,vida.y);
  	end
    love.graphics.draw(potf,px,py);
    love.graphics.rectangle("fill",0,700,1400,100);
  end
end
function love.update(dt)
	if(love.keyboard.isDown("s"))then
		screenshot = love.graphics.newScreenshot( );
		screenshot:encode('png', 'cap'..os.time()..'.png');
	end
	mx = love.mouse.getX();
  if(love.keyboard.isDown("space"))then
    if y==230 or y==300 then
      ingame=true;
      sc=love.timer.getTime();
    end
  end
  if ingame==false then
  	m=false;
  	score=0;
  	potf=love.graphics.newImage("potf.png");
  	if(music~=0)then
  		love.audio.stop(music);
  	end
  	love.audio.play(menu);
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
  else
  	score=love.timer.getTime()-sc;
  	sr=love.timer.getTime()-sc;
  	sr=sr*100;
  	sr=round(sr,0);
  	score=round(score,0);
  	if(score>30 and score<60)then
  	 	vx=1.5;
  	end
  	if(score>60 and score<90)then
  	 	vx=2;
  	end
  	if(score>90)then
  	 	vx=2.5;
  	end

  	if(cont==0) then
  		o=love.sound.newSoundData( "f.mp3" );
  		no = love.audio.newSource(o);
  		love.audio.play(no);
  		potf=love.graphics.newImage("potff.png");
  		love.graphics.draw(potf,px,py);
  		sleep(2);
  		love.audio.rewind(no);
  		vida.y=-60;
  		vida.x=love.math.random(1-(vida.s:getWidth()/4),1400+(vida.s:getWidth()/4));
  		vida.b=false;
  		vida.v=false;
  		ingame=false;
  		cont=3;
  		vid=1;
  	end
  	if(score>delt*vid and score<delt*vid+10)then
  		if(700-vida.y+vida.s:getHeight()>100 and vida.b==false)then
  		vida.y=vida.y+(4.5*vx);
  		else
  			vida.b=false;
  		end
  		dx=vida.x+vida.s:getWidth()/2;
  		dy=vida.y+vida.s:getHeight()/2;
  		bx=px+w/2;
  		by=py+h/2;
  		aux=((dx-bx)^2+(dy-by)^2)^0.5;
  		if(aux<45 and vida.v==false)then
  			cont=cont+1;
  			vida.v=false;
  			vida.b=false;
  			vida.x=love.math.random(1-(vida.s:getWidth()/4),1400+(vida.s:getWidth()/4));
  			vida.y=-60;
  			vid=vid+1;
  			r=love.timer.getTime();
  			la=love.sound.newSoundData( "h.mp3" );
  			ne = love.audio.newSource(la);
  			love.audio.play(ne);
  			love.audio.rewind(ne);
  		end
  	end
  	for i=1,12 do
  		if(fuego[i].b==false) then
  			fuego[i].b=true;
  		end
  		if(700-fuego[i].y+fuego[i].h>100 and fuego[i].b==true)then
  			fuego[i].y=fuego[i].y+(4.5*vx);
  		else
  			fuego[i].b=false;
  			fuego[i].v=false;
  			fuego[i].x=love.math.random(1-(fuego[i].w/4),1400+(fuego[i].w/4));
  			fuego[i].y=love.math.random(0,150);
  		end
  		ax=fuego[i].x+fuego[i].w/2;
  		ay=fuego[i].y+fuego[i].h/2;
  		bx=px+w/2;
  		by=py+h/2;
  		aux=((ax-bx)^2+(ay-by)^2)^0.5;
  		if(aux<45 and fuego[i].v==false)then
  			cont=cont-1;
  			fuego[i].v=true;
  			g=love.timer.getTime();
  			o=love.sound.newSoundData( "f.mp3" );
  			no = love.audio.newSource(o);
  			love.audio.play(no);
  			love.audio.rewind(no);
  		end
  	end
  	if((love.timer.getTime()-g)*100<200)then
  		if(name=="potfv.png")then
  			potf=love.graphics.newImage("potfvd.png");
		else
			potf=love.graphics.newImage("potfd.png");
  		end
  		fl=true;
  	else
  		if(pr==false)then
  			potf=love.graphics.newImage(name);
  		end
  		fl=false;
  	end
  	if((love.timer.getTime()-r)*100<200)then
  		if(name=="potfv.png")then
  			potf=love.graphics.newImage("potfhv.png");
		else
			potf=love.graphics.newImage("potfh.png");
  		end
  			pr=true;
  		else
  		if(fl==false)then
  			potf=love.graphics.newImage(name);
  		end
  		pr=false;
  	end
  	if(love.keyboard.isDown("p"))then
  		love.audio.stop(music);
  		m=false;
    	music=load_music(music);
    	love.audio.play(music);
  	end
    if(love.keyboard.isDown("left") and xi==false)then
      px=px-5;
      if(fl==false and pr==false)then
      	potf=love.graphics.newImage("potfv.png");
      end
      name="potfv.png";
    end
    if(love.keyboard.isDown("kp4")and xi==false)then
    	px=px-5;
      	if(fl==false and pr==false)then
      		potf=love.graphics.newImage("potfv.png");
      	end
      	name="potfv.png";
    end
    if(love.keyboard.isDown("kp6") and xd==false)then
    	px=px+5;
      	if(fl==false and pr==false)then
      		potf=love.graphics.newImage("potf.png");
      	end
      	name="potf.png";
    end
    if(love.keyboard.isDown("right") and xd==false)then
      px=px+5;
      if(fl==false and pr==false)then
      	potf=love.graphics.newImage("potf.png");
      end
      name="potf.png";
    end
    if(px<1)then
    	xi=true;
    else
    	xi=false;
    end
    if(px>(width*(12/7))-w)then
    	xd=true;
    else
    	xd=false;
    end
    if(bb==false)then
    	sleep(2);
    	bb=true;
    end
  end
  if(ingame==true)then
    ti=love.timer.getTime();
    love.audio.stop(menu);
    music=load_music(music);
    love.audio.play(music);
    love.audio.rewind(menu);
    vx=1;
  end

end
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
function load_music(mu)
	if(m==false)then
		number = love.math.random( 1, 4 );
		dat = love.sound.newSoundData( number..".mp3" );
    	au = love.audio.newSource(dat);
    	m=true;
	else
		au=mu;
	end
    return au;
end
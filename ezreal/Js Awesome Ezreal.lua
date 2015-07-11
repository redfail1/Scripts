--       _           _   _    __      __  ___  
--      | |         | | | |  /_ |    /_ |/ _ \ 
--      | |_   _ ___| |_| |__ | |_ __ | | | | |
--  _   | | | | / __| __| '_ \| | '_ \| | | | |
-- | |__| | |_| \__ \ |_| | | | | | | | | |_| |
--  \____/ \__,_|___/\__|_| |_|_|_| |_|_|\___/ 
-- Js Awesome Ezreal

if myHero.charName ~= "Ezreal" then return end
require "SxOrbWalk"
require "VPrediction"
require "HPrediction"
local enemyHeroes = GetEnemyHeroes()
local REVISION = 2

function OnLoad()
  latest = tonumber(GetWebResult("raw.github.com", "/justh1n10/Scripts/master/ezreal/version.rev"))

  -- Target selectors
  ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1150)

  if latest > REVISION then
    PrintChat("<font color=\"#FFFFFF\">A new update is available. Please update using the menu.</font>")
  end

  -- Creating the config menu + seting up Vpredition and loading the orbwalkers
  createMenu()

  -- Loading skill data + checking if have Ignite
  LoadSkills()
  IgniteCheck()

  -- Setting target selector name
  ts.name = "Target selector"
  -- Other stuff
  VP = VPrediction()
  HPred = HPrediction()
  loadOrbWalkers()

  PrintChat("<font color = \"#FFFFFF\">>> Awesome Ezreal << </font><font color = \"#FF0000\">Successfully</font> <font color = \"#FFFFFF\">loaded.</font> </font>")
end


function createMenu()
  Config = scriptConfig(">> Js Awesome Ezreal <<", "awesomeEzreal")
  -- Key settings
  Config:addSubMenu("Keys", "keySettingsMenu")
  Config.keySettingsMenu:addParam("combo", "Auto carry", SCRIPT_PARAM_ONKEYDOWN, false, 32)
  Config.keySettingsMenu:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 67)
  Config.keySettingsMenu:permaShow("combo")
  Config.keySettingsMenu:permaShow("harass")

  -- Kill-steall settings
  Config:addSubMenu("Killsteal", "killStealSettingsMenu")
  Config.killStealSettingsMenu:addParam("useQ", "use Q", SCRIPT_PARAM_ONOFF, true)
  Config.killStealSettingsMenu:addParam("useW", "use W", SCRIPT_PARAM_ONOFF, true)
  Config.killStealSettingsMenu:addParam("useR", "Use R (Targets within Q range)", SCRIPT_PARAM_ONOFF, false)
  Config.killStealSettingsMenu:addParam("useRGlobal", "Use R Global (recommended)", SCRIPT_PARAM_ONOFF, true)

  -- Harass settings
  Config:addSubMenu("Harass", "harassSettingsMenu")
  Config.harassSettingsMenu:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONOFF, false)
  Config.harassSettingsMenu:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Config.harassSettingsMenu:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Config.harassSettingsMenu:permaShow("harassToggle")

  -- Misc settings
  Config:addSubMenu("Misc", "miscSettings")
  Config.miscSettings:addTS(ts)
  Config.miscSettings:addParam("autoIgnite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)
  Config.miscSettings:addParam("drawQRange", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
  Config.miscSettings:addParam("drawQRangeColor", "Q range color", SCRIPT_PARAM_COLOR, {255,0,149,255}) --{A,R,G,B}
  Config.miscSettings:addParam("drawWRange", "Draw W range", SCRIPT_PARAM_ONOFF, true)
  Config.miscSettings:addParam("drawWRangeColor", "W range color", SCRIPT_PARAM_COLOR, {255,75,235,80}) --{A,R,G,B}
  Config.miscSettings:addParam("drawERange", "Draw E range", SCRIPT_PARAM_ONOFF, false)
  Config.miscSettings:addParam("drawERangeColor", "E range color", SCRIPT_PARAM_COLOR, {255,255,0,0}) --{A,R,G,B}
  Config.miscSettings:addParam("Pred", "HPred ON/ VPred Off", SCRIPT_PARAM_ONOFF, true)
  Config.miscSettings:addParam("RmaxRange", "Max range for (global) R", SCRIPT_PARAM_SLICE, 2500, 200, 15000, 0)
  Config.miscSettings:addParam("ROverkill", "R overkill damage", SCRIPT_PARAM_SLICE, 50, 1, 200, 0)
  Config.miscSettings:addParam("RhitChance", "R hit chance (2) recommended", SCRIPT_PARAM_SLICE, 1, 1, 5, 0)
end

function OnTick()
  -- Updating the target selectors
  ts:update()
  tsGlobal = TargetSelector(TARGET_LOW_HP_PRIORITY, Config.miscSettings.RmaxRange)
  tsGlobal:update()

  -- If you enable global ult
  if Config.killStealSettingsMenu.useRGlobal and (tsGlobal.target ~= nil) and not tsGlobal.target.dead and tsGlobal.target.bTargetable then
    castRGlobal(tsGlobal.target)
  end

  -- If found target check for cast spells
  if (ts.target ~= nil) and not ts.target.dead and ts.target.bTargetable then
      CastW(ts.target)
      CastQ(ts.target)

    --If you enable normal ult
      if Config.killStealSettingsMenu.useR then
        CastR(ts.target)
      end
    Autoignite(ts.target)
  end
end

function addUpdateMenu()
    -- Update Stuff
    Config:addParam("writtenBy","Made by Justh1n10", 5, "")
    Config:addParam("updateScript", "Update Script (rev. " .. latest .. ")", SCRIPT_PARAM_ONOFF, false)
    Config.updateScript = false

end

 -- Orbwalker loading Selection
function loadOrbWalkers()
 if _G.Reborn_Loaded then
    DelayAction(function()
    PrintChat("<font color = \"#FFFFFF\">>> Awesome Ezreal << </font><font color = \"#FF0000\">SAC Status:</font> <font color = \"#FFFFFF\">Successfully integrated.</font> </font>")
    PrintChat("<font color = \"#FFFFFF\">>> Recommended ult range << </font><font color = \"#FF0000\">3000</font> <font color = \"#FFFFFF\">during laning phase!</font> (Killsteal menu) </font>")
    if(Config == nil) then
      Config:addParam("SACON","SAC:R support is active.", 5, "")
    end
     isSAC = true
    addUpdateMenu() -- For some reason adding it here stops it from updating over and over
  end, 10)
  
    elseif not _G.Reborn_Loaded then
  PrintChat("<font color = \"#FFFFFF\">>> Awesome Ezreal << </font><font color = \"#FF0000\">Orbwalker not found:</font> <font color = \"#FFFFFF\">SxOrbWalk integrated.</font> </font>")
    PrintChat("<font color = \"#FFFFFF\">>> Recommended ult range << </font><font color = \"#FF0000\">3000</font> <font color = \"#FFFFFF\">during laning phase!</font> (Killsteal menu) </font>")

  Config:addSubMenu("Orbwalker", "SxOrb")
  SxOrb:LoadToMenu(Config.SxOrb)
  isSX = true
  addUpdateMenu() -- For some reason adding it here stops it from updating over and over
    end
end


-- Loading skill data
function LoadSkills()
  SkillQ = { name = "Mystic Shot", range = 1150, delay = 0.25, speed = 2000, width = 60}
  SkillW = { name = "Essence Flux", range = 950, delay = 0.25, speed = 1600, width = 80}
  SkillR = { name = "Trueshot Barrage", range = math.huge, delay = 1.0, speed = 2000, width = 160}

  HP_Q = HPSkillshot({collisionM = true, collisionH = true, delay = 0.25, range = 1150, speed = 2000, type = "DelayLine", width = 120})
  HP_W = HPSkillshot({collisionM = false, collisionH = false, delay = 0, range = 950, speed = 1600, type = "DelayLine", width = 160})
  HP_R = HPSkillshot({collisionM = false, collisionH = false, delay = 0, range = 20000, speed = 2000, type = "DelayLine", width = 320})
end

-- Checking if player has ignite
function IgniteCheck()
 if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then
   ignite = SUMMONER_1
 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then
   ignite = SUMMONER_2
 end
end

-- For updating
function OnWndMsg(a, b)
  if a == WM_LBUTTONUP and Config.updateScript then
    Config.updateScript = false
    PrintChat("<font color=\"#FF0000\">Updating...</font>")
    DownloadFile("https://raw.githubusercontent.com/justh1n10/Scripts/master/ezreal/Js%20Awesome%20Ezreal.lua", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, function()
      PrintChat("<font color=\"#00FF00\">Update finished Please reload double tap F9.</font>")
    end)
  end
end

-- Converting SCRIPT_PARAM_COLOR
function TARGB(colorTable) 
  do return ARGB(colorTable[1], colorTable[2], colorTable[3], colorTable[4])
  end
end

-- Check / calculations for casting Q
function CastQ(unit) 
  if myHero.dead then return end
  
    if Config.miscSettings.Pred then
      CastPosition, HitChance = HPred:GetPredict(HP_Q, unit, myHero) -- HPrediction
    else
      CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, SkillQ.range, SkillQ.speed, myHero, true) -- VPrediction
    end

    local damageQ = getDmg("Q", unit, myHero) + ((myHero.damage)*1.1) + ((myHero.ap)*0.4)

    if myHero:CanUseSpell(_Q) and GetDistance(unit) <= SkillQ.range and unit.health < damageQ and HitChance >= 1 and Config.killStealSettingsMenu.useQ then
      CastSpell(_Q, CastPosition.x, CastPosition.z)
    elseif myHero:CanUseSpell(_Q) and GetDistance(unit) <= SkillQ.range and HitChance >= 1 and Config.keySettingsMenu.combo then
        CastSpell(_Q, CastPosition.x, CastPosition.z)
    elseif myHero:CanUseSpell(_Q) and GetDistance(unit) <= SkillQ.range and HitChance >= 1 and Config.keySettingsMenu.harass and Config.harassSettingsMenu.useQ then
        CastSpell(_Q, CastPosition.x, CastPosition.z)
    elseif myHero:CanUseSpell(_Q) and GetDistance(unit) <= SkillQ.range and HitChance >= 1 and Config.harassSettingsMenu.harassToggle and Config.harassSettingsMenu.useQ then
        CastSpell(_Q, CastPosition.x, CastPosition.z)
    end
end

-- Check / calculations for casting W
function CastW(unit)
  if myHero.dead then return end 

    if Config.miscSettings.Pred then
      CastPosition, HitChance = HPred:GetPredict(HP_W, unit, myHero) -- HPrediction
    else
      CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillW.delay, SkillW.width, SkillW.range, SkillW.speed, myHero, false)
    end

    local damageW = getDmg("W", unit, myHero) + ((myHero.ap)*0.8)

    if myHero:CanUseSpell(_W) and GetDistance(unit) <= SkillW.range and unit.health < damageW and HitChance >= 1 and Config.killStealSettingsMenu.useW then
      CastSpell(_W, CastPosition.x, CastPosition.z)
    elseif myHero:CanUseSpell(_W) and GetDistance(unit) <= SkillW.range and HitChance >= 1 and Config.keySettingsMenu.combo then
        CastSpell(_W, CastPosition.x, CastPosition.z)
    elseif myHero:CanUseSpell(_W) and GetDistance(unit) <= SkillW.range and HitChance >= 1 and Config.keySettingsMenu.harass and Config.harassSettingsMenu.useW then
        CastSpell(_W, CastPosition.x, CastPosition.z)
    elseif myHero:CanUseSpell(_W) and GetDistance(unit) <= SkillW.range and HitChance >= 1 and Config.harassSettingsMenu.harassToggle and Config.harassSettingsMenu.useW then
        CastSpell(_W, CastPosition.x, CastPosition.z)
    end
end

-- Check / calculations for kill-stealing with R
function CastR(unit) 
  if myHero.dead then return end
    basedamage = ((myHero.level * 3) + 50)

    if Config.miscSettings.Pred then
      CastPosition, HitChance = HPred:GetPredict(HP_R, unit, myHero) -- HPrediction
    else
      CastPosition,  HitChance,  Position = VP:GetLineAOECastPosition(unit, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero)
    end

    local damageR = getDmg("R", unit, myHero) - - Config.miscSettings.ROverkill + ((myHero.damage - basedamage)* 0.44) + ((myHero.ap)*0.9)

    if myHero:CanUseSpell(_R) and GetDistance(unit) <= SkillR.range and unit.health < damageR and GetDistance(CastPosition) <= SkillQ.range and HitChance >= 2 and Config.killStealSettingsMenu.useR then
      CastSpell(_R, CastPosition.x, CastPosition.z)
    end
end

-- Check / calculations for kill-stealing with R (global)
function castRGlobal(unit)
  if myHero.dead then return end
    basedamage = ((myHero.level * 3) + 50)
  
    if Config.miscSettings.Pred then
      CastPosition, HitChance = HPred:GetPredict(HP_R, unit, myHero) -- HPrediction
    else
      CastPosition,  HitChance,  Position = VP:GetLineAOECastPosition(unit, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero)
    end

     local damageR = getDmg("R", unit, myHero) - Config.miscSettings.ROverkill + ((myHero.damage - basedamage)* 0.44) + ((myHero.ap)*0.9)

     if myHero:CanUseSpell(_R) and GetDistance(unit) <= SkillR.range and unit.health < damageR and HitChance >= Config.miscSettings.RhitChance and Config.killStealSettingsMenu.useRGlobal then
       CastSpell(_R, CastPosition.x, CastPosition.z)
     end
end

-- Check / calculations for killing with Ignite
function Autoignite(unit)
  if myHero.dead then return end
    local damageIgnite = ((myHero.level * 20)+ 50)
    if ignite ~= nil and (myHero:CanUseSpell(ignite) == READY) and GetDistance(unit) <= 600 and unit.health < damageIgnite and Config.miscSettings.autoIgnite then
      CastSpell(ignite, unit)
    end
end

-- Draws the Q, W and E ranges
function OnDraw()
  if(Config == nil) then
    PrintChat ("nil")
  else
    PrintChat ("not nill")
  end
  if Config.miscSettings.drawQRange and (myHero:CanUseSpell(_Q) == READY) then
    DrawCircle(myHero.x, myHero.y, myHero.z, SkillQ.range, TARGB(Config.miscSettings.drawQRangeColor))
  end
  
  if Config.miscSettings.drawWRange and (myHero:CanUseSpell(_W) == READY) then
    DrawCircle(myHero.x, myHero.y, myHero.z, SkillW.range, TARGB(Config.miscSettings.drawWRangeColor))
  end
  
  if Config.miscSettings.drawERange and (myHero:CanUseSpell(_E) == READY) then
    DrawCircle(myHero.x, myHero.y, myHero.z, SkillE.range, TARGB(Config.miscSettings.drawERangeColor))
  end
end
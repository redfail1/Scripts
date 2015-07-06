--       _           _   _    __      __  ___  
--      | |         | | | |  /_ |    /_ |/ _ \ 
--      | |_   _ ___| |_| |__ | |_ __ | | | | |
--  _   | | | | / __| __| '_ \| | '_ \| | | | |
-- | |__| | |_| \__ \ |_| | | | | | | | | |_| |
--  \____/ \__,_|___/\__|_| |_|_|_| |_|_|\___/ 

local enemyHeroes = GetEnemyHeroes()
local REVISION = 2

function OnLoad()
  local latest = tonumber(GetWebResult("raw.github.com", "/justh1n10/Scripts/master/version.rev"))

  if latest > REVISION then
    PrintChat("<font color=\"#FFFFFF\">A new update is available. Please update using the menu.</font>")
  end

  Config = scriptConfig("J's awesome spell caller", "spellcaller (V. " .. REVISION .. " ")
    Config:addSubMenu("Misc", "miscsettings")
      Config.miscsettings:addParam("enableScript", "Enable script", SCRIPT_PARAM_ONOFF, true)
      Config.miscsettings:addParam("printInChat", "Show summoner duration", SCRIPT_PARAM_ONOFF, true)
      Config.miscsettings:addParam("showWhenUp", "Notify when summoner is almost up", SCRIPT_PARAM_ONOFF, true)
      Config.miscsettings:addParam("drawScreen", "Draw on screen", SCRIPT_PARAM_ONOFF, true)
      Config.miscsettings:addParam("drawTime", "Draw time on screen", SCRIPT_PARAM_SLICE, 5, 1, 10, 0)
      Config.miscsettings:addParam("drawColor", "Draw color", SCRIPT_PARAM_COLOR, {255,255,0,0}) --{A,R,G,B}
    Config:addSubMenu("Spells", "spellcsettings")
      Config.spellcsettings:addParam("enableBarrier", "Barrier", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableIgnite", "Ignite", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableGhost", "Ghost", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableSmite", "Smite", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableDash", "Dash", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableCleanse", "Cleanse", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableExhaust", "Exhaust", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableFlash", "Flash", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableHeal", "Heal", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableClarity", "Clarity", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableMark", "Mark", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableTeleport", "Teleport", SCRIPT_PARAM_ONOFF, true)
      Config.spellcsettings:addParam("enableClairvoyance", "Clairvoyance", SCRIPT_PARAM_ONOFF, true)

      Config:addParam("updateScript", "Update Script (rev. " .. latest .. ")", SCRIPT_PARAM_ONOFF, false)
    Config.updateScript = false

    PrintChat("<font color=\"#00FF00\">Loaded awesome spell caller!</font>")
end

function OnWndMsg(a, b)
  if a == WM_LBUTTONUP and Config.updateScript then
    Config.updateScript = false
    PrintChat("<font color=\"#FF0000\">Updating...</font>")
    DownloadFile("https://raw.githubusercontent.com/justh1n10/Scripts/master/Js%20Spell%20Caller.lua", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, function()
      PrintChat("<font color=\"#00FF00\">Update finished Please reload double tap F9.</font>")
    end)
  end
end

function TARGB(colorTable) 
  do return ARGB(colorTable[1], colorTable[2], colorTable[3], colorTable[4])
  end
end

function replaceSummonerNames(str)
  local newName
  if str == "summonerbarrier" then
   newName = "Barrier"
   elseif str == "summonerdot" then
    newName = "Ignite" 
    elseif str == "summonerhaste" then
    newName = "Ghost"
    elseif str == "itemsmiteaoe" then
    newName = "Smite"  
    elseif str == "s5_summonersmiteduel" then
    newName = "Smite" 
    elseif str == "s5_summonersmiteplayerganker" then
    newName = "Smite" 
    elseif str == "s5_summonersmitequick" then
    newName = "Smite" 
    elseif str == "snowballfollowupcast" then
    newName = "Dash" 
    elseif str == "summonerboost" then
    newName = "Cleanse" 
    elseif str == "summonerexhaust" then
    newName = "Exhaust"
    elseif str == "summonerflash" then
    newName = "Flash"
     elseif str == "summonerheal" then
    newName = "Heal"
    elseif str == "summonermana" then
    newName = "clarity"
    elseif str == "summonersnowball" then
    newName = "Mark"
    elseif str == "summonerteleport" then
    newName = "Teleport"
    elseif str == "summonerclairvoyance" then
    newName = "Clairvoyance"
  else
    newName = "Unknown spell"
  end
  do return newName
  end
end

function enableOrDisabled(str)
  local enabledConfig
  if(str ==  "summonerbarrier" and Config.spellcsettings.enableBarrier) then
      enabledConfig = true
      elseif(str ==  "summonerdot" and Config.spellcsettings.enableIgnite) then
        enabledConfig = true
      elseif(str ==  "summonerhaste" and Config.spellcsettings.enableGhost) then
        enabledConfig = true
      elseif(str ==  "itemsmiteaoe" and str ~=  "s5_summonersmiteduel" and str ~=  "s5_summonersmiteplayerganker" and str ~=  "s5_summonersmitequick" and Config.spellcsettings.enableSmite) then
        enabledConfig = true
      elseif(str ==  "snowballfollowupcast" and Config.spellcsettings.enableDash) then
        enabledConfig = true
      elseif(str ==  "summonerboost" and Config.spellcsettings.enableCleanse) then
        enabledConfig = true
      elseif(str ==  "summonerexhaust" and Config.spellcsettings.enableExhaust) then
        enabledConfig = true
      elseif(str ==  "summonerflash" and Config.spellcsettings.enableFlash) then
        enabledConfig = true
      elseif(str ==  "summonerheal" and Config.spellcsettings.enableHeal) then
        enabledConfig = true
      elseif(str ==  "summonermana" and Config.spellcsettings.enableClarity) then
        enabledConfig = true
      elseif(str ==  "summonersnowball" and Config.spellcsettings.enableMark) then
        enabledConfig = true        
      elseif(str ==  "summonerteleport" and Config.spellcsettings.enableTeleport) then
        enabledConfig = true   
      elseif(str ==  "summonerclairvoyance" and Config.spellcsettings.enableClairvoyance) then
        enabledConfig = true   
      else 
        enabledConfig = false
      end
     do return enabledConfig
  end
end

function OnDraw()
  local heightForName = 100
  
  for _, enemy in pairs(enemyHeroes) do
    heightForName = heightForName + 30

    -- This will print the message in chat and will also make sure it doesn't spam the same message over and over.
    if ((enemy:GetSpellData(SUMMONER_2).cd - 0.5)< enemy:GetSpellData(SUMMONER_2).currentCd ) and enemy:GetSpellData(SUMMONER_2).currentCd > 0 and Config.miscsettings.enableScript then
      if(enableOrDisabled(tostring(enemy:GetSpellData(SUMMONER_2).name)) == true) then
        local cooldownToMinutes = os.date("!%X",GetInGameTimer() + enemy:GetSpellData(SUMMONER_2).cd)
        if(Config.miscsettings.printInChat) then
           debugPrintSum2("<font color=\"#FFFFFF\">" .. enemy.charName .. "</font> used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_2).name)) ..", it's back up at <font color=\"#00FF00\">" .. cooldownToMinutes .."</font> It's down for " ..  os.date("!%X",enemy:GetSpellData(SUMMONER_2).cd), enemy)
        else
          debugPrintSum2("<font color=\"#FFFFFF\">" .. enemy.charName .. "</font> used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_2).name)) ..", it's back up at <font color=\"#00FF00\">" .. cooldownToMinutes .."</font>", enemy)
        end
      end
    end
    if ((enemy:GetSpellData(SUMMONER_1).cd - 0.5) < enemy:GetSpellData(SUMMONER_1).currentCd ) and enemy:GetSpellData(SUMMONER_1).currentCd > 0 and Config.miscsettings.enableScript then
      if(enableOrDisabled(tostring(enemy:GetSpellData(SUMMONER_1).name)) == true) then
        local cooldownToMinutes = os.date("!%X",GetInGameTimer() + enemy:GetSpellData(SUMMONER_1).cd)
        if(Config.miscsettings.printInChat) then
          debugPrintSum1("<font color=\"#FFFFFF\">" .. enemy.charName .. "</font> used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_1).name)) ..", it's back up at <font color=\"#00FF00\">" .. cooldownToMinutes .."</font> It's down for " ..  os.date("!%X",enemy:GetSpellData(SUMMONER_1).cd), enemy)
        else
          debugPrintSum1("<font color=\"#FFFFFF\">" .. enemy.charName .. "</font> used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_1).name)) ..", it's back up at <font color=\"#00FF00\">" .. cooldownToMinutes .."</font>", enemy)
        end
      end
    end
    -- This will notify when summoner is almost up
    if enemy:GetSpellData(SUMMONER_2).currentCd > 1 and enemy:GetSpellData(SUMMONER_2).currentCd < (Config.miscsettings.drawTime + 1) and enemy:GetSpellData(SUMMONER_2).currentCd > 0 and Config.miscsettings.enableScript and Config.miscsettings.showWhenUp then
     if(enableOrDisabled(tostring(enemy:GetSpellData(SUMMONER_2).name)) == true) then
        heightForName = heightForName + 30  
        if(Config.miscsettings.drawScreen) then
          DrawText(enemy.charName .. "'s " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_2).name)) .." up in " .. math.round(enemy:GetSpellData(SUMMONER_2).currentCd, 1), 26, 150, heightForName, TARGB(Config.miscsettings.drawColor))
        end
      end
    end
    if enemy:GetSpellData(SUMMONER_1).currentCd > 1 and enemy:GetSpellData(SUMMONER_1).currentCd < (Config.miscsettings.drawTime + 1) and enemy:GetSpellData(SUMMONER_1).currentCd > 0 and Config.miscsettings.enableScript and Config.miscsettings.showWhenUp then
     if(enableOrDisabled(tostring(enemy:GetSpellData(SUMMONER_1).name)) == true) then
        heightForName = heightForName + 30  
        if(Config.miscsettings.drawScreen) then
          DrawText(enemy.charName .. "'s " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_1).name)) .." up in " .. math.round(enemy:GetSpellData(SUMMONER_1).currentCd, 1), 26, 150, heightForName, TARGB(Config.miscsettings.drawColor))
        end
      end
    end
    -- This will draw the message on your screen for however long the user set the delay.
    if ((enemy:GetSpellData(SUMMONER_2).cd - Config.miscsettings.drawTime)  < enemy:GetSpellData(SUMMONER_2).currentCd ) and enemy:GetSpellData(SUMMONER_2).currentCd > 0 and Config.miscsettings.enableScript then
      if(enableOrDisabled(tostring(enemy:GetSpellData(SUMMONER_2).name)) == true) then
        heightForName = heightForName + 30
        if(Config.miscsettings.drawScreen) then
          DrawText(enemy.charName .. " used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_2).name)) .."" , 26, 150, heightForName, TARGB(Config.miscsettings.drawColor))
        end
      end
    end
    if ((enemy:GetSpellData(SUMMONER_1).cd - Config.miscsettings.drawTime)  < enemy:GetSpellData(SUMMONER_1).currentCd ) and enemy:GetSpellData(SUMMONER_1).currentCd > 0 and Config.miscsettings.enableScript then
      if(enableOrDisabled(tostring(enemy:GetSpellData(SUMMONER_1).name)) == true) then
        heightForName = heightForName + 30
        if(Config.miscsettings.drawScreen) then
          DrawText(enemy.charName .. " used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_1).name)) .."" , 26, 150, heightForName, TARGB(Config.miscsettings.drawColor))
        end
      end
    end
  end
end

-- This will make sure the message wont get spammed
local lastPrintSum1, lastHeroSum1, lastHeroName1 = "", "", ""
function debugPrintSum1(str, enemy)
   if str ~= lastPrintSum1 and lastHeroSum1 ~= enemy:GetSpellData(SUMMONER_2).name and lastHeroName1 ~= enemy.charName then
      PrintChat(str)
      lastPrintSum1 = str
      lastHeroSum1 = enemy:GetSpellData(SUMMONER_1).name
      lastHeroName1 = enemy.charName
      DelayAction(function() lastHeroSum1 = "empty" lastHeroName1 = "empty" end, 10)
   end
end

local lastPrintSum2, lastHeroSum2, lastHeroName2 = "", "", ""
function debugPrintSum2(str, enemy)
   if str ~= lastPrintSum2 and lastHeroSum2 ~= enemy:GetSpellData(SUMMONER_1).name and lastHeroName2 ~= enemy.charName then
      PrintChat(str)
      lastPrintSum2 = str
      lastHeroSum2 = enemy:GetSpellData(SUMMONER_1).name
      lastHeroName2 = enemy.charName
      DelayAction(function() lastHeroSum2 = "empty" lastHeroName2 = "empty" end, 10)
   end
end
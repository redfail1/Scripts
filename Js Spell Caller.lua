local allyHeroes, enemyHeroes = GetAllyHeroes(), GetEnemyHeroes()

function OnLoad()

  Config = scriptConfig("J's spell caller", "spellcaller")
    Config:addSubMenu("Misc", "miscsettings")
      Config.miscsettings:addParam("enableScript", "Enable script", SCRIPT_PARAM_ONOFF, true)
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

PrintChat("<font color=\"#00FF00\">Succesfully loaded Brain.lua</font>")

customCheck()
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
      else 
        enabledConfig = false
      end
     do return enabledConfig
  end
end


function customCheck()
  for _, enemy in pairs(enemyHeroes) do
    PrintChat(enemy.charName .. " SUMMONER_1 : ".. tostring(enemy:GetSpellData(SUMMONER_1).currentCd).. " SUMMONER_2 :" .. tostring(enemy:GetSpellData(SUMMONER_2).currentCd))
  end
end

function OnDraw()
  local heightForName = 100
  
  for _, enemy in pairs(enemyHeroes) do

    heightForName = heightForName + 30

    if ((enemy:GetSpellData(SUMMONER_2).cd - Config.miscsettings.drawTime)  < enemy:GetSpellData(SUMMONER_2).currentCd ) and enemy:GetSpellData(SUMMONER_2).currentCd > 0 and Config.miscsettings.enableScript then
      if(enableOrDisabled(tostring(enemy:GetSpellData(SUMMONER_2).name)) == true) then
        local cooldownToMinutes = os.date("!%X",GetInGameTimer() + enemy:GetSpellData(SUMMONER_2).cd)
        heightForName = heightForName + 30
        debugPrintSum2("<font color=\"#FFFFFF\">" .. enemy.charName .. "</font> used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_2).name)) ..", it's back up at <font color=\"#00FF00\">" .. cooldownToMinutes .."</font>", enemy)
        if(Config.miscsettings.drawScreen) then
          DrawText(enemy.charName .. " used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_2).name)) .."" , 26, 150, heightForName, TARGB(Config.miscsettings.drawColor))
        end
      end
    end
    if ((enemy:GetSpellData(SUMMONER_1).cd - Config.miscsettings.drawTime)  < enemy:GetSpellData(SUMMONER_1).currentCd ) and enemy:GetSpellData(SUMMONER_1).currentCd > 0 and Config.miscsettings.enableScript then
      if(enableOrDisabled(tostring(enemy:GetSpellData(SUMMONER_1).name)) == true) then
        local cooldownToMinutes = os.date("!%X",GetInGameTimer() + enemy:GetSpellData(SUMMONER_1).cd)
        heightForName = heightForName + 30
        debugPrintSum1("<font color=\"#FFFFFF\">" .. enemy.charName .. "</font> used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_1).name)) ..", it's back up at  <font color=\"#00FF00\">" .. cooldownToMinutes .."</font>", enemy)
        if(Config.miscsettings.drawScreen) then
          DrawText(enemy.charName .. " used " .. replaceSummonerNames(tostring(enemy:GetSpellData(SUMMONER_1).name)) .."" , 26, 150, heightForName, TARGB(Config.miscsettings.drawColor))
        end
      end
    end
  end
end

-- Credit to Sida for this
-- Contains dirty fix.. dind't know how to fix else
local lastPrintSum1, lastHeroSum1, lastHeroName1 = "", "", ""
function debugPrintSum1(str, enemy)
   if str ~= lastPrintSum1 and lastHeroSum1 ~= enemy:GetSpellData(SUMMONER_2).name and lastHeroName1 ~= enemy.charName then
      PrintChat(str)
      lastPrintSum1 = str
      lastHeroSum1 = enemy:GetSpellData(SUMMONER_1).name
      lastHeroName1 = enemy.charName
      DelayAction(function() lastHeroSum1 = "empty" lastHeroName1 = "empty" end, 20)
   end
end

local lastPrintSum2, lastHeroSum2, lastHeroName2 = "", "", ""
function debugPrintSum2(str, enemy)
   if str ~= lastPrintSum2 and lastHeroSum2 ~= enemy:GetSpellData(SUMMONER_1).name and lastHeroName2 ~= enemy.charName then
      PrintChat(str)
      lastPrintSum2 = str
      lastHeroSum2 = enemy:GetSpellData(SUMMONER_1).name
      lastHeroName2 = enemy.charName
      DelayAction(function() lastHeroSum2 = "empty" lastHeroName2 = "empty" end, 20)
   end
end


--       _           _   _    __      __  ___  
--      | |         | | | |  /_ |    /_ |/ _ \ 
--      | |_   _ ___| |_| |__ | |_ __ | | | | |
--  _   | | | | / __| __| '_ \| | '_ \| | | | |
-- | |__| | |_| \__ \ |_| | | | | | | | | |_| |
--  \____/ \__,_|___/\__|_| |_|_|_| |_|_|\___/ 
-- Name faker for streamers
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("VILKOIOINPK") 

local allyHeroes, enemyHeroes = GetAllyHeroes(), GetEnemyHeroes()
local Names = {}

function OnLoad()
	CreateMenu()

	for line in io.lines("scripts/names.txt") do
  		Names[ #Names+1 ] = line
	end
	if #Names <= 9 or #Names >= 11 then
		print("Make sure the name file only has 10 names!")
	end
end

function CreateMenu()
	NameConfig = scriptConfig(">> Name faker <<", "NameFaker")

	NameConfig:addParam("onOff", "Enable Script", SCRIPT_PARAM_ONOFF, true)
	NameConfig:addParam("showAlly", "Show ally names", SCRIPT_PARAM_ONOFF, true)
	NameConfig:addParam("showEnemy", "Show enemy names", SCRIPT_PARAM_ONOFF, true)
end

function OnDraw()
	DrawFakeNames()
end

function DrawFakeNames()
	allyNumber = 2 --This way you dont get double names
	for i, ally in pairs(allyHeroes) do
    	if ally.visible == true and ally.dead == false and NameConfig.onOff and NameConfig.showAlly then
    		if i == 1 then
    			allyNumber = 2
    		elseif i == 2 then
    			allyNumber = 3
    		elseif i == 3 then
    			allyNumber = 4
    		elseif i == 4 then
    			allyNumber = 5
    		end
    		framePos = GetAbilityFramePos(ally)
    		DrawOverheadHUD(ally, framePos, Names[allyNumber], true)
    	end
	end

	-- Your own hero has different height for name
	if myHero.visible == true and myHero.dead == false and NameConfig.onOff and NameConfig.showAlly then
		framePos = GetAbilityFramePos(myHero)
    	DrawOverheadHUD(myHero, framePos, Names[1])
	end

	-- This way you dont get double names
	enemyNumber = 6
	for i, enemy in pairs(enemyHeroes) do
    	if enemy.visible == true and enemy.dead == false and NameConfig.onOff and NameConfig.showEnemy then
    		if i == 1 then
    			enemyNumber = 6
    		elseif i == 2 then
    			enemyNumber = 7
    		elseif i == 3 then
    			enemyNumber = 8
    		elseif i == 4 then
    			enemyNumber = 9
    		elseif i == 5 then
    			enemyNumber = 10
    		end
    		framePos = GetAbilityFramePos(enemy)
    		DrawOverheadHUD(ally, framePos, Names[enemyNumber], false)
    	end
	end
end

function DrawOverheadHUD(unit, framePos, str, isAlly)
    local barPos = Point(framePos.x, framePos.y)
    textWidth = (GetTextArea(str, 18).x / 2)
    offset = 105
    barPos = Point(framePos.x + 66, framePos.y - 43)

    -- Enemy heros, your ally heros and your own hero have different bar heights
    if unit == myHero then
    	DrawText(str, 18, barPos.x-textWidth+1, barPos.y+1, 0xFF000000)
    	DrawText(str, 18, barPos.x-textWidth, barPos.y, 0xFFFFFFFF)
    elseif isAlly and unit ~= myHero then
		DrawText(str, 18, barPos.x-textWidth+1, barPos.y+4, 0xFF000000)
    	DrawText(str, 18, barPos.x-textWidth, barPos.y+3, 0xFFFFFFFF)
    else
    	DrawText(str, 18, barPos.x-textWidth+1, barPos.y+7, 0xFF000000)
   		DrawText(str, 18, barPos.x-textWidth, barPos.y+6, 0xFFFFFFFF)
   	end
   	UpdateWindow()
end

-- Credits to Jorj for the bar position
function GetAbilityFramePos(unit)
  local barPos = GetUnitHPBarPos(unit)
  local barOffset = GetUnitHPBarOffset(unit)

  do -- For some reason the x offset never exists
    local t = {
      ["Darius"] = -0.05,
      ["Renekton"] = -0.05,
      ["Sion"] = -0.05,
      ["Thresh"] = 0.03,
    }
    barOffset.x = t[unit.charName] or 0
  end
  return Point(barPos.x - 69 + barOffset.x * 150, barPos.y + barOffset.y * 50 + 12.5)
end
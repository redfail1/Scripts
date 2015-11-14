-- __  ___       _
-- \ \/ (_)_   _(_) __ _
--  \  /| \ \ / / |/ _` |
--  /  \| |\ V /| | (_| |
-- /_/\_\_| \_/ |_|\__,_|
--
-- Xawareness FREE

-- Scriptstatus
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("OBEEBEJBGFG")

local scriptVersion = 1.134
local enemyHeroes = { }
local allyHeroes = { }
local towers = { }
local enemyCount
local allyCount
local towerCount
local heroSprites = { }
local summonerSprites = { }
local frameSprites = { }
local sightWards = { }
local visionWards = { }
local updated = false
local loadedChamps = false
local colorTable = { [1] = 0x90ECFF00, [2] = 0x9000FBE9, [3] = 0x90FF6F00, [4] = 0x90C008FB, [5] = 0x90FFFFFF }

local JungleTroys = {
    Baron = {
        troyName    = "SRU_Baron_Death.troy", -- Credits to RedPrince for the troy names
        startTime   = 1200,
        spawnTime   = 420,
        currentTime = 0,
        minimapX    = 0,
        minimapY    = 0},
    Dragon = {
        troyName    = "SRU_JungleBuff_Dragon_Activation_Buf.troy", -- Credits to RedPrince for the troy names
        startTime   = 150,
        spawnTime   = 360,
        currentTime = 0,
        minimapX    = 0,
        minimapY    = 0},
}

-- math
local ceil, floor, round = math.ceil, math.floor, math.round

-- Made by Nebelwolfi to make classes local and not global
function Class(name)
    _ENV[name] = { }
    _ENV[name].__index = _ENV[name]
    local mt = { __call = function(self, ...) local b = { } setmetatable(b, _ENV[name]) b:__init(...) return b end }
    setmetatable(_ENV[name], mt)
end

DelayAction( function() if not _G.XawarenessLoaded then Xawareness() end end, 0.05)

class "Xawareness"
function Xawareness:__init(cfg)
    if _G.XawarenessLoaded then return end
    _G.givenConfig = cfg
    _G.XawarenessLoaded = true
    self:Load()
    AddMsgCallback( function(a, b) self:WndMsg(a, b) end)
    AddDrawCallback( function() self:Draw() end)
    AddUnloadCallback( function() self:Unload() end)
    AddCreateObjCallback( function(obj) self:OnNewObject(obj) end)
    AddDeleteObjCallback( function(obj) self:OnDelObject(obj) end)
end

function Xawareness:Load()
    local ToUpdate = { }
    ToUpdate.Version = scriptVersion
    ToUpdate.UseHttps = true
    ToUpdate.Host = "raw.githubusercontent.com"
    ToUpdate.VersionPath = "/justh1n10/Scripts/master/xawareness/Xawareness.version"
    ToUpdate.ScriptPath = "/justh1n10/Scripts/master/xawareness/Xawareness.lua"
    ToUpdate.SavePath = SCRIPT_PATH .. "/" .. _ENV.FILE_NAME
    ToUpdate.CallbackUpdate = function(NewVersion, OldVersion) _Tech:AddPrint("Welcome, Script updated to " .. NewVersion .. ". Double tap F9") end
    ToUpdate.CallbackNoUpdate = function(OldVersion) _Tech:AddPrint("Welcome, no updates found, current version " .. ToUpdate.Version .. ".") end
    ToUpdate.CallbackNewVersion = function(NewVersion) _Tech:AddPrint("Welcome, new version found (" .. NewVersion .. "). Please wait until its downloaded") end
    ToUpdate.CallbackError = function(NewVersion) _Tech:AddPrint("Error while Downloading. Please try again.") end
    ScriptUpdate(ToUpdate.Version, ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, function() end, function() end, function() end, function() end)
    ScriptUpdate(ToUpdate.Version, ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, LIB_PATH .. "/xawareness.lua", ToUpdate.CallbackUpdate, ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion, ToUpdate.CallbackError)
    self:ActualOnLoad()
end

function Xawareness:ActualOnLoad()
    self:LocaliseTable()
    _Tech:LoadSprites()

    enemyCount = #enemyHeroes
    allyCount = #allyHeroes

    _Tech:LoadMenu()
    _Tech:AddTurrets()
    towerCount = #towers

    self:LoadJungleMinimap()
end

-- We're localising the table because other scripts might manipulaite their table causing weird issues.
function Xawareness:LocaliseTable()
    for _, enemy in pairs(GetEnemyHeroes()) do
        table.insert(enemyHeroes, enemy)
    end

    for _, enemy in pairs(GetAllyHeroes()) do
        table.insert(allyHeroes, enemy)
    end
end

function Xawareness:Draw()
    if not _Tech.Conf then return end
    if updated == false then return end

    if _Tech.Conf.TimeSettings.TimeOn then _Draw:Time() end
    if _Tech.Conf.hpSettings.drawHP then _Draw:newHPBar() end
    if _Tech.Conf.HUDSettings.ShowHud then _Draw:enemyHUD() end
    if _Tech.Conf.TowerSettings.TowerOn then _Draw:TurretRange() end
    if _Tech.Conf.enemyWards.showWards then _Draw:Wards() end

    for i = 1, enemyCount do
        local unit = enemyHeroes[i]
        if _Tech.Conf.enemyPath.showPath then _Draw:EnemyPath(unit) end
        if _Tech.Conf.GAlertSettings.GankAlertOn then _Draw:GankAlert(unit, i) end

        if _Tech.Conf.ArrowSettings.UseArrow and _Tech.Conf.ArrowSettings["Show" .. unit.charName] then
            _Draw:ArrowInfo(unit, i)
        end

        if _Tech.Conf.miaSettings.miaOn then _Draw:Missing(unit, i) end

        _Draw:EnemyTarget(unit, i)
    end

    _Draw:JungleTimers()
end

function Xawareness:WndMsg(a, b)
    if not _Tech.Conf then return end
    if (enemyCount + allyCount) > 0 then
        if enemyCount > 0 then
            if _Tech.Conf.hpSettings.extraSettings.resetHUD and updated == true then
                for i = 1, enemyCount do
                    local unit = enemyHeroes[i]
                    _Tech.Conf.hpSettings.extraSettings[unit.charName] = 0
                end
            end
        end

        if allyCount > 0 then
            if _Tech.Conf.hpSettings.extraSettings.resetHUD and updated == true then
                for i = 1, allyCount do
                    local unit = allyHeroes[i]
                    _Tech.Conf.hpSettings.extraSettings[unit.charName] = 0
                end
            end
        end

        _Tech.Conf.hpSettings.extraSettings.resetHUD = false
    end

    if _Tech.Conf.SpriteSettings.UpdateSprites and updated == true then
        _Tech:AddPrint("Loaded sprites.")
        _Tech:ReloadSprites()
        _Tech.Conf.SpriteSettings.UpdateSprites = false
    end
end

function Xawareness:Unload()
    for i = 1, #summonerSprites do
        summonerSprites[i]:Release();
    end

    for i = 1, #frameSprites do
        frameSprites[i]:Release();
    end

    for i = 1, #heroSprites do
        heroSprites[i]:Release();
    end
end

function Xawareness:LoadJungleMinimap()
    JungleTroys.Baron.minimapX, JungleTroys.Baron.minimapY = GetMinimapX(4550), GetMinimapY(10700)
    JungleTroys.Dragon.minimapX, JungleTroys.Dragon.minimapY = GetMinimapX(9400), GetMinimapY(4900)
end
function Xawareness:OnDelObject(obj)
    _Tech:DeleteWard(obj)
end

function Xawareness:OnNewObject(obj)
    _Tech:AddWards(obj)
    _Tech:CheckJungleBuff(obj)
end

Class("_Tech")
function _Tech:LoadMenu()
    self.Conf = givenConfig or scriptConfig("[xAwareness]", "AwarenessMenu")

    self.Conf:addSubMenu("> HUD", "HUDSettings")
    self.Conf.HUDSettings:addParam("ShowHud", "Show HUD", SCRIPT_PARAM_ONOFF, true)
    self.Conf.HUDSettings:addParam("WidthPos", "Horizontal position", SCRIPT_PARAM_SLICE,(WINDOW_W - 160), 1,(WINDOW_W - 160), 0)
    self.Conf.HUDSettings:addParam("HeighthPos", "Vertical position", SCRIPT_PARAM_SLICE, 10, 1,(WINDOW_H - 350), 0)
    self.Conf.HUDSettings:addParam("empty", "", 5, "")
    self.Conf.HUDSettings:addParam("extraInfo1", "These settings only apply for the side HUD.", 5, "")

    self.Conf:addSubMenu("> HP Bar", "hpSettings")
    self.Conf.hpSettings:addParam("drawHP", "Show cooldowns", SCRIPT_PARAM_ONOFF, true)
    self.Conf.hpSettings:addParam("drawAlly", "Show ally cooldowns", SCRIPT_PARAM_ONOFF, true)
    self.Conf.hpSettings:addParam("hideCool", "Hide text timers", SCRIPT_PARAM_ONOFF, false)

    -- Generates a few sliders in the menu to move enemy hpbar offsets
    if (enemyCount + allyCount) > 0 then
        self.Conf.hpSettings:addSubMenu("> Customization", "extraSettings")

        if enemyCount > 0 then
            self.Conf.hpSettings.extraSettings:addParam("empty1", "Enemy Team", 5, "")
            for i = 1, enemyCount do
                local unit = enemyHeroes[i]
                self.Conf.hpSettings.extraSettings:addParam(unit.charName, "Height " .. unit.charName, SCRIPT_PARAM_SLICE, 0, -100, 100, 1)
            end
            self.Conf.hpSettings.extraSettings:addParam("empty2", "", 5, "")
        end
        if allyCount > 0 then
            self.Conf.hpSettings.extraSettings:addParam("empty3", "Ally Team", 5, "")
            for i = 1, allyCount do
                local unit = allyHeroes[i]
                self.Conf.hpSettings.extraSettings:addParam(unit.charName, "Height " .. unit.charName, SCRIPT_PARAM_SLICE, 0, -100, 100, 1)
            end
        end
        self.Conf.hpSettings.extraSettings:addParam("empty4", "", 5, "")
        self.Conf.hpSettings.extraSettings:addParam("resetHUD", "Reset positions", SCRIPT_PARAM_ONOFF, false)
    end

    self.Conf:addSubMenu("> Enemy waypoint", "enemyPath")
    self.Conf.enemyPath:addParam("showPath", "Show enemy waypoints", SCRIPT_PARAM_ONOFF, true)
    self.Conf.enemyPath:addParam("showTime", "Show time to reach waypoint", SCRIPT_PARAM_ONOFF, true)
    self.Conf.enemyPath:addParam("showTriangle", "Show triangle", SCRIPT_PARAM_ONOFF, true)

    self.Conf:addSubMenu("> Gank alert", "GAlertSettings")

    -- Generates a few buttons in the menu that show the enemy names
    if enemyCount > 0 then
        self.Conf.GAlertSettings:addSubMenu("> Whitelist", "IgnoreSettings")
        for i = 1, enemyCount do
            local unit = enemyHeroes[i]
            self.Conf.GAlertSettings.IgnoreSettings:addParam("Show" .. unit.charName, "Show " .. unit.charName, SCRIPT_PARAM_ONOFF, true)
        end
    end

    self.Conf:addSubMenu("> Arrow information", "ArrowSettings")
    self.Conf.ArrowSettings:addParam("UseArrow", "Enable/Disable Arrow information", SCRIPT_PARAM_ONOFF, true)
    self.Conf.ArrowSettings:addParam("advancedPath", "Use advanced calculation (accurate data)", SCRIPT_PARAM_ONOFF, false)
    self.Conf.ArrowSettings:addParam("extraInfo", "Advanced calculations are FPS heavy.", 5, "")
    self.Conf.ArrowSettings:addParam("Info", "_____________________", 5, "")

    -- Generates a few buttons in the menu that show the enemy names
    if enemyCount > 0 then
        self.Conf.ArrowSettings:addParam("Info", "Champions:", 5, "")
        for i = 1, enemyCount do
            local unit = enemyHeroes[i]
            self.Conf.ArrowSettings:addParam("Show" .. unit.charName, "Show " .. unit.charName, SCRIPT_PARAM_ONOFF, false)
        end
    else
        self.Conf.ArrowSettings:addParam("extraInfo", "No enemies found.", 5, "")
    end

    self.Conf:addSubMenu("> Enemy targeting", "TargetSettings")
    self.Conf.TargetSettings:addParam("extraInfo", "This will draw a line from the enemy", 5, "")
    self.Conf.TargetSettings:addParam("extraInfo", "to the enemy target. This is usefull", 5, "")
    self.Conf.TargetSettings:addParam("extraInfo", "to deny their last hitting or check", 5, "")
    self.Conf.TargetSettings:addParam("extraInfo", "Who they're focussing.", 5, "")
    self.Conf.TargetSettings:addParam("Info", "_____________________", 5, "")
    if enemyCount > 0 then
        self.Conf.TargetSettings:addParam("Info", "Champions:", 5, "")
        for i = 1, enemyCount do
            local unit = enemyHeroes[i]
            self.Conf.TargetSettings:addParam("Show" .. unit.charName, "Show for " .. unit.charName, SCRIPT_PARAM_ONOFF, false)
        end
    else
        self.Conf.TargetSettings:addParam("extraInfo", "No enemies found.", 5, "")
    end

    self.Conf:addSubMenu("> Missing in action", "miaSettings")
    self.Conf.miaSettings:addParam("miaOn", "Missing in action", SCRIPT_PARAM_ONOFF, true)
    self.Conf.miaSettings:addParam("miaTimeOn", "Show timers", SCRIPT_PARAM_ONOFF, true)

    self.Conf.GAlertSettings:addParam("GankAlertOn", "Gank alert", SCRIPT_PARAM_ONOFF, true)
    self.Conf.GAlertSettings:addParam("GankAlertDistance", "Maximal detection radius", SCRIPT_PARAM_SLICE, 3600, 500, 10000, 0)
    self.Conf.GAlertSettings:addParam("GankAlertMinDistance", "Minimal detection radius", SCRIPT_PARAM_SLICE, 1200, 300, 1750, 0)
    self.Conf.GAlertSettings:addParam("GankTextSize", "Text alert size", SCRIPT_PARAM_SLICE, 18, 14, 50, 0)
    self.Conf.GAlertSettings:addParam("empty", "", 5, "")
    self.Conf.GAlertSettings:addParam("extraInfo1", "Default Max Detection radius: 3600", 5, "")
    self.Conf.GAlertSettings:addParam("extraInfo1", "Default Min Detection radius: 1200", 5, "")
    self.Conf.GAlertSettings:addParam("extraInfo2", "Default text size: 18", 5, "")

    self.Conf:addSubMenu("> Jungle timers", "JungleSettings")
    self.Conf.JungleSettings:addParam("DragOn", "Show Dragon timer", SCRIPT_PARAM_ONOFF, true)
    self.Conf.JungleSettings:addParam("BarOn", "Show Baron timer", SCRIPT_PARAM_ONOFF, true)

    self.Conf:addSubMenu("> Enemy wards", "enemyWards")
    self.Conf.enemyWards:addParam("showWards", "Show enemy wards", SCRIPT_PARAM_ONOFF, true)
    self.Conf.enemyWards:addParam("wardQual", "Circle quality", SCRIPT_PARAM_SLICE, 8, 4, 16, 0)

    self.Conf:addSubMenu("> Time/Date", "TimeSettings")
    self.Conf.TimeSettings:addParam("TimeOn", "Show real time and date", SCRIPT_PARAM_ONOFF, false)
    self.Conf.TimeSettings:addParam("WidthPos", "Horizontal position", SCRIPT_PARAM_SLICE, 10, 1,(WINDOW_W - 250), 0)
    self.Conf.TimeSettings:addParam("HeighthPos", "Vertical position", SCRIPT_PARAM_SLICE, 10, 1, WINDOW_H, 0)
    self.Conf.TimeSettings:addParam("textSize", "Text size", SCRIPT_PARAM_SLICE, 16, 1, 30, 0)

    self.Conf:addSubMenu("> Tower range indicator", "TowerSettings")
    self.Conf.TowerSettings:addParam("TowerOn", "Show tower range", SCRIPT_PARAM_ONOFF, true)
    self.Conf.TowerSettings:addParam("TowerQual", "Circle quality", SCRIPT_PARAM_SLICE, 18, 10, 32, 0)
    self.Conf.TowerSettings:addParam("TowerColor", "Circle color", SCRIPT_PARAM_LIST, 5, { "Red", "Green", "Blue", "Yellow", "Purple", "White" })

    self.Conf:addSubMenu("> Sprites", "SpriteSettings")
    self.Conf.SpriteSettings:addParam("UpdateSprites", "Reload sprites", SCRIPT_PARAM_ONOFF, false)

    self.Conf:addParam("Info", "_____________________", 5, "")
    self.Conf:addParam("Info", "Author: Xivia", 5, "")
    self.Conf:addParam("Info", "Patch: " .. GetGameVersion():sub(1, 4), 5, "")
    self.Conf:addParam("Info", "Version: " .. scriptVersion, 5, "")

end

function _Tech:AddPrint(msg)
    PrintChat("<font color = \"#0078FF\">[xAwareness] </font><font color = \"#FFFFFF\">" .. msg .. "</font>")
end

function _Tech:RenameSums(str)
    local summoners = {
        ["summonerhaste"] = 1,
        ["summonerflash"] = 2,
        ["summonerbarrier"] = 3,
        ["summonerboost"] = 4,
        ["summonerteleport"] = 5,
        ["summonerdot"] = 6,
        ["summonerodingarrison"] = 7,
        ["summmonerclairvoyance"] = 8,
        ["summonermana"] = 9,
        ["s5_summonersmiteduel"] = 10,
        ["s5_summonersmitequick"] = 11,
        ["s5_summonersmiteplayerganker"] = 12,
        ["itemsmiteaoe"] = 13,
        ["summonersmite"] = 14,
        ["summonerexhaust"] = 15,
        ["summonersnowball"] = 16,
        ["summonerheal"] = 18
    }
    return summoners[str] or 17
end

function _Tech:LoadSprites()
    updated = false

    for _, k in pairs( { "", "Hero_round", "Hero_round_grey", "others", "Summoner_spells" }) do
        if not DirectoryExist(SPRITE_PATH .. "Xawareness//" .. k) then
            CreateDirectory(SPRITE_PATH .. "Xawareness//" .. k)
        end
    end

    self:ImportHeroSprites()
end

function _Tech:LoadOtherSprites()
    -- Load frame
    for i = 1, 9 do
        -- We have 7 sprites so we run it 7 times
        if FileExist(SPRITE_PATH .. "Xawareness//others//" .. i .. ".png") then
            table.insert(frameSprites, createSprite(SPRITE_PATH .. "\\Xawareness\\others\\" .. i .. ".png"))
        else
            self:AddPrint("Downloading missing sprite in folder: Others " .. i .. " / 9, DO NOT RELOAD THE SCRIPT!")
            DownloadFile("https://raw.githubusercontent.com/justh1n10/Scripts/master/xawareness/others/" .. i .. ".png?no-cache=" .. math.random(1, 25000), SPRITE_PATH .. "Xawareness//others//" .. i .. ".png", function() DelayAction( function() self:LoadOtherSprites() end, 0.15) end)
            frameSprites = { }
            return;
        end
    end

    -- Load summoner spell icons
    for i = 1, 18 do
        -- We have 18 sprites so we run it 18 times
        if FileExist(SPRITE_PATH .. "Xawareness//Summoner_spells//" .. i .. ".png") then
            table.insert(summonerSprites, createSprite(SPRITE_PATH .. "\\Xawareness\\Summoner_spells\\" .. i .. ".png"))
        else
            self:AddPrint("Downloading missing sprite in folder: Summoner_spells " .. i .. " / 18, DO NOT RELOAD THE SCRIPT!")
            DownloadFile("https://raw.githubusercontent.com/justh1n10/Scripts/master/xawareness/Summoner_spells/" .. i .. ".png?no-cache=" .. math.random(1, 25000), SPRITE_PATH .. "Xawareness//Summoner_spells//" .. i .. ".png", function() DelayAction( function() self:LoadOtherSprites() end, 0.15) end)
            summonerSprites = { }
            return;
        end
    end
    updated = true
end

function _Tech:ImportHeroSprites()
    -- Import hero color icons
    for i, v in pairs(enemyHeroes) do
        if FileExist(SPRITE_PATH .. "Xawareness//Hero_round//" .. v.charName .. ".png") then
            table.insert(heroSprites, createSprite(SPRITE_PATH .. "\\Xawareness\\Hero_round\\" .. v.charName .. ".png"))
        else
            self:AddPrint("Downloading missing sprite in folder: Hero_round " .. v.charName .. ", DO NOT RELOAD THE SCRIPT!")
            DownloadFile("https://raw.githubusercontent.com/justh1n10/Scripts/master/xawareness/Hero_round/" .. v.charName .. ".png?no-cache=" .. math.random(1, 25000), SPRITE_PATH .. "Xawareness//Hero_round//" .. v.charName .. ".png", function() DelayAction( function() self:ImportHeroSprites() end, 0.15) end)
            heroSprites = { }
            return;
        end
    end

    -- Imports hero grey icons
    for i, v in pairs(enemyHeroes) do
        if FileExist(SPRITE_PATH .. "Xawareness//Hero_round_grey//" .. v.charName .. ".png") then
            table.insert(heroSprites, createSprite(SPRITE_PATH .. "\\Xawareness\\Hero_round_grey\\" .. v.charName .. ".png"))
        else
            self:AddPrint("Downloading missing sprite in folder: Hero_round_grey " .. v.charName .. ", DO NOT RELOAD THE SCRIPT!")
            DownloadFile("https://raw.githubusercontent.com/justh1n10/Scripts/master/xawareness/Hero_round_grey/" .. v.charName .. ".png?no-cache=" .. math.random(1, 25000), SPRITE_PATH .. "Xawareness//Hero_round_grey//" .. v.charName .. ".png", function() DelayAction( function() self:ImportHeroSprites() end, 0.15) end)
            heroSprites = { }
            return;
        end
    end

    self:LoadOtherSprites()
end

-- Credits to Jorj
function _Tech:GetAbilityFramePos(unit)
    local barPos = GetUnitHPBarPos(unit)
    local barOffset = GetUnitHPBarOffset(unit)

    do
        -- For some reason the x and y offset never exists
        local t = {
            ["Darius"] = - 0.05,
            ["Renekton"] = - 0.05,
            ["Sion"] = - 0.05,
            ["Thresh"] = - 0.03,
        }
        barOffset.x = t[unit.charName] or barOffset.x

        local r = {
            ["XinZhao"] = 1,
            ["Velkoz"] = - 2.65,
            ["Darius"] = - 0.33,
        }
        barOffset.y = r[unit.charName] or barOffset.y
    end

    return D3DXVECTOR2(barPos.x + barOffset.x * 150 - 70, barPos.y + barOffset.y * 50 + 13)
end

function _Tech:ReloadSprites()
    if updated == false then return end

    for i = 1, #summonerSprites do
        summonerSprites[i]:Release();
    end
    summonerSprites = { }

    for i = 1, #frameSprites do
        frameSprites[i]:Release();
    end
    frameSprites = { }

    for i = 1, #heroSprites do
        heroSprites[i]:Release();
    end
    heroSprites = { }

    self:LoadSprites()
end

function _Tech:AddTurrets()
    for i = 1, objManager.iCount do
        local turret = objManager:getObject(i)
        if turret and turret.valid and turret.team == TEAM_ENEMY and turret.type == "obj_AI_Turret" and not string.find(turret.name, "TurretShrine") then
            table.insert(towers, turret)
        end
    end
end

function _Tech:AddWards(Obj)
    if Obj and Obj.valid and Obj.name then
        if Obj.team == TEAM_ENEMY and(Obj.name == "SightWard" or Obj.name == "VisionWard" or Obj.name == "YellowTrinket" or Obj.name:find("Trinket")) and Obj.maxMana >= 60 and Obj.mana > 5 then
            sightWards[#sightWards + 1] = { Pos = Obj.pos, Time = ceil(Obj.mana + GetInGameTimer()), obj = Obj }
        elseif Obj.team == TEAM_ENEMY and Obj.name == "VisionWard" then
            visionWards[#visionWards + 1] = { Pos = Obj.pos, obj = Obj }
        end
    end
end

function _Tech:DeleteWard(Obj)
    if Obj and Obj.valid and Obj.name then
        if Obj.team == TEAM_ENEMY and((Obj.name:find("ward") or Obj.name:find("Trinket")) and not Obj.name:find("Idle")) then
            if (Obj.name:find("Sight") or Obj.name:find("Trinket")) or(Obj.name:find("Vision") and Obj.maxMana == 180) then
                for i = 1, #sightWards do
                    local ward = sightWards[i]
                    if ward and ward.obj.valid and Obj == ward.obj then
                        sightWards[i] = nil
                    end
                end
            end
        elseif Obj.team == TEAM_ENEMY and Obj.name:find("Vision") then
            for i = 1, #visionWards do
                local ward = visionWards[i]
                if ward and ward.obj.valid and Obj == ward.obj then
                    visionWards[i] = nil
                end
            end
        end
    end
end

function _Tech:DrawCircle3D(x, y, z, radius, width, color, chordlength)
    local vPos1 = Vector(x, y, z)
    local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
    local tPos = vPos1 -(vPos1 - vPos2):normalized() * radius
    local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
    if OnScreen( { x = sPos.x, y = sPos.y }, { x = sPos.x, y = sPos.y }) then
        self:DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
    end
end

function _Tech:DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
    local quality = chordlength
    radius = radius or 300
    quality = 2 * math.pi / quality
    radius = radius * .92
    local points = { }
    for theta = 0, 2 * math.pi + quality, quality do
        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
    end
    DrawLines2(points, width or 1, color or 4294967295)
end

-- _Draw:Arrow made by Bilbao <3
function _Tech:Arrow(pStart, pEnd, distToRot, distToLine, lineWidth, color)
    local pSV, pEV = Vector(pStart), Vector(pEnd)
    local pAVM = pEV +(Vector(pSV) - pEV):normalized() * distToRot
    local V = Vector(pAVM) - Vector(pSV)
    local P = V:perpendicular2():normalized()
    local x, y, z = P:unpack()

    local pAV_L = Vector(pAVM.x +(x * distToLine), pAVM.y +(y * distToLine), pAVM.z +(z * distToLine))
    local pAV_R = Vector(pAVM.x -(x * distToLine), pAVM.y -(y * distToLine), pAVM.z -(z * distToLine))

    DrawLine3D(pSV.x, pSV.y, pSV.z, pEV.x, pEV.y, pEV.z, lineWidth, color)
    DrawLine3D(pAV_L.x, pAV_L.y, pAV_L.z, pEV.x, pEV.y, pEV.z, lineWidth, color)
    DrawLine3D(pAV_R.x, pAV_R.y, pAV_R.z, pEV.x, pEV.y, pEV.z, lineWidth, color)
end

function _Tech:CheckJungleBuff(obj)
    if obj.name == JungleTroys.Baron.troyName then
        JungleTroys.Baron.currentTime = ceil(GetInGameTimer() + JungleTroys.Baron.spawnTime)
    elseif obj.name == JungleTroys.Dragon.troyName then
        JungleTroys.Dragon.currentTime = ceil(GetInGameTimer() + JungleTroys.Dragon.spawnTime)
    end
end

Class("_Draw")
function _Draw:enemyHUD()
    local textPostx = _Tech.Conf.HUDSettings.WidthPos
    local textPosty = _Tech.Conf.HUDSettings.HeighthPos

    for i = 1, enemyCount do
        if heroSprites[i + enemyCount] == nil or heroSprites[i] == nil and updated then
            updated = false
            _Tech:AddPrint("Missing sprites, reloading sprites.")
            _Tech:ReloadSprites()
        end

        local unit = enemyHeroes[i]
        if unit then
            textPosty = textPosty + 60
            local sum1cd = unit:GetSpellData(4).currentCd
            local sum2cd = unit:GetSpellData(5).currentCd

            if unit.dead or not unit.visible and heroSprites[i + enemyCount] ~= nil then
                heroSprites[i + enemyCount]:SetScale(1, 1)
                heroSprites[i + enemyCount]:Draw(textPostx + 20, textPosty + 6, 255)
            elseif heroSprites[i] ~= nil then
                heroSprites[i]:Draw(textPostx + 20, textPosty + 6, 255)
            else
                return
            end

            -- Summoner spell icons
            summonerSprites[_Tech:RenameSums(unit:GetSpellData(4).name)]:Draw(textPostx + 6, textPosty + 7, 255)
            summonerSprites[_Tech:RenameSums(unit:GetSpellData(5).name)]:Draw(textPostx + 6, textPosty + 34, 255)

            if sum1cd > 0 then
                local textWdith =(GetTextArea("" .. ceil(sum1cd), 12).x / 2)
                frameSprites[5]:Draw(textPostx + 6, textPosty + 7, 255)

                if sum1cd < 10 then
                    textWdith = textWdith + 12
                elseif sum1cd < 100 then
                    textWdith = textWdith + 6
                end
                DrawText("" .. ceil(sum1cd), 12, textPostx + textWdith, textPosty + 12, 0xFFFFFFFF)
            end

            if sum2cd > 0 then
                local textWdith =(GetTextArea("" .. ceil(sum2cd), 12).x * .5)
                frameSprites[5]:Draw(textPostx + 6, textPosty + 34, 255)

                if sum2cd < 10 then
                    textWdith = textWdith + 12
                elseif sum2cd < 100 then
                    textWdith = textWdith + 6
                end
                DrawText("" .. ceil(sum2cd), 12, textPostx + textWdith, textPosty + 39, 0xFFFFFFFF)
            end

            -- Outside frame + Hp and Mana bar.
            local widthPos1 =(GetTextArea(ceil(unit.mana) .. " / " .. ceil(unit.maxMana), 11).x * .5)
            local widthPos2 =(GetTextArea(ceil(unit.health) .. " / " .. ceil(unit.maxHealth), 11).x * .5)

            frameSprites[4]:Draw(textPostx + 72, textPosty + 24, 255)
            frameSprites[2]:SetScale((unit.health / unit.maxHealth), 1)
            frameSprites[2]:Draw(textPostx + 72, textPosty + 24, 255)
            DrawText(ceil(unit.health) .. " / " .. ceil(unit.maxHealth), 11, textPostx + 67 + widthPos1, textPosty + 22, 0xFFFFFFFF)
            frameSprites[3]:SetScale((unit.mana / unit.maxMana), 1)
            frameSprites[3]:Draw(textPostx + 72, textPosty + 34, 255)
            DrawText(ceil(unit.mana) .. " / " .. ceil(unit.maxMana), 11, textPostx + 67 + widthPos2, textPosty + 32, 0xFFFFFFFF)

            frameSprites[1]:Draw(textPostx, textPosty, 255)
        end
    end
end

function _Draw:newHPBar()
    local function championCount()
        return 0 +(_Tech.Conf.hpSettings.drawAlly and allyCount or 0) + enemyCount
    end

    for i = 1, championCount() do
        local unit = enemyHeroes[i] or allyHeroes[i - enemyCount]

        if unit and not unit.dead and unit.visible and _Tech.Conf.hpSettings.extraSettings[unit.charName] then
            local framePos = _Tech:GetAbilityFramePos(unit)
            framePos.y = framePos.y - 30 + _Tech.Conf.hpSettings.extraSettings[unit.charName]


            if OnScreen(framePos, framePos) then
                local sum1 = unit:GetSpellData(4)
                local sum2 = unit:GetSpellData(5)

                summonerSprites[_Tech:RenameSums(sum1.name)]:Draw(framePos.x + 142.5, framePos.y + 1, 255)
                summonerSprites[_Tech:RenameSums(sum2.name)]:Draw(framePos.x + 142.5, framePos.y + 28, 255)

                if sum1.currentCd > 0 then
                    local textWdith =(GetTextArea("" .. ceil(sum1.currentCd), 12).x * .5)
                    frameSprites[5]:Draw(framePos.x + 142.5, framePos.y + 1, 255)

                    if sum1.currentCd < 10 then
                        textWdith = textWdith + 12
                    elseif sum1.currentCd < 100 then
                        textWdith = textWdith + 6
                    end
                    DrawText("" .. ceil(sum1.currentCd), 12, framePos.x + textWdith + 136, framePos.y + 6, 0xFFFFFFFF)
                end

                if sum2.currentCd > 0 then
                    local textWdith =(GetTextArea("" .. ceil(sum2.currentCd), 12).x * .5)
                    frameSprites[5]:Draw(framePos.x + 142.5, framePos.y + 28, 255)

                    if sum2.currentCd < 10 then
                        textWdith = textWdith + 12
                    elseif sum2.currentCd < 100 then
                        textWdith = textWdith + 6
                    end
                    DrawText("" .. ceil(sum2.currentCd), 12, framePos.x + textWdith + 136, framePos.y + 33, 0xFFFFFFFF)
                end

                frameSprites[6]:Draw(framePos.x, framePos.y, 255)
                for i = 0, 3 do
                    local spell = unit:GetSpellData(i)
                    local ccd = spell.currentCd
                    if ccd > 0 then
                        frameSprites[7]:SetScale((ccd / - spell.cd), 1)
                        frameSprites[7]:Draw(framePos.x + 30 + 26 * i, framePos.y + 30, 255)
                        if not _Tech.Conf.hpSettings.hideCool then
                            DrawText("" .. ceil(ccd), 14, framePos.x + 13 + 27 * i, framePos.y + 40, 0xFFFFFFFF)
                        end
                    elseif spell.level < 1 then
                        frameSprites[7]:SetScale(1, 1)
                        frameSprites[7]:Draw(framePos.x + 5 + 26 * i, framePos.y + 30, 255)
                    end
                end
            end
        end
    end
end

function _Draw:EnemyPath(unit)
    if unit and not unit.dead and unit.visible and unit.hasMovePath and unit.path.count > 1 then
        local path = unit.path:Path(2)
        local endLinePosition = WorldToScreen(D3DXVECTOR3(path.x, path.y, path.z))
        if OnScreen(endLinePosition.x, endLinePosition.y) then
            local unitMoveSpeed = unit.ms
            local distance = GetDistance(unit, path)

            DrawLine3D(unit.x, unit.y, unit.z, path.x, path.y, path.z, 3, 0xFFCCFFF6)
            if _Tech.Conf.enemyPath.showTriangle then
                _Tech:DrawCircle3D(path.x, path.y, path.z, 20, 2, 0xFFCCFFF6, 3)
            end

            if _Tech.Conf.enemyPath.showTime then
                local delay = round((distance / unitMoveSpeed) * 10) * 0.1

                DrawText(unit.charName .. " " .. delay, 14, endLinePosition.x, endLinePosition.y + 14, 0xFFCCFFF6)
            else
                DrawText(unit.charName .. "", 14, endLinePosition.x, endLinePosition.y + 14, 0xFFCCFFF6)
            end
        end
    end
end

function _Draw:GankAlert(unit, i)
    local function DrawAlert(unit, i)
        DrawText("Possible gank: " .. unit.charName, _Tech.Conf.GAlertSettings.GankTextSize, WINDOW_W / 2 - 150, WINDOW_H / 5 +(i * _Tech.Conf.GAlertSettings.GankTextSize + 3), 0xFF2AFF00)
    end

    if unit and unit.valid and not unit.dead and unit.visible and unit.hasMovePath and _Tech.Conf.GAlertSettings.IgnoreSettings["Show" .. unit.charName] then
        local enemyDistance = GetDistance(myHero, unit)
        if enemyDistance <= _Tech.Conf.GAlertSettings.GankAlertDistance and enemyDistance >= _Tech.Conf.GAlertSettings.GankAlertMinDistance then
            if unit.path.count > 1 then
                local enemyWayDistance = GetDistance(myHero, unit.path:Path(2))
                if enemyWayDistance < enemyDistance then
                    DrawAlert(unit, i)
                end
            end
        end
    end
end

function _Draw:Time()
    local currentDate = os.date("%c")
    DrawText("" .. currentDate, _Tech.Conf.TimeSettings.textSize, _Tech.Conf.TimeSettings.WidthPos, _Tech.Conf.TimeSettings.HeighthPos, 0xFFFFFFFF)
end

function _Draw:TurretRange()
    local newColor
    if _Tech.Conf.TowerSettings.TowerColor == 1 then
        newColor = 0xFFFF0000
    elseif _Tech.Conf.TowerSettings.TowerColor == 2 then
        newColor = 0xFF219C00
    elseif _Tech.Conf.TowerSettings.TowerColor == 3 then
        newColor = 0xFF00BAFF
    elseif _Tech.Conf.TowerSettings.TowerColor == 4 then
        newColor = 0xFFFFFF00
    elseif _Tech.Conf.TowerSettings.TowerColor == 5 then
        newColor = 0xFF8A00FF
    else
        newColor = 0xFFFFFFFF
    end

    for i = 1, towerCount do
        local towerObj = towers[i]

        if towerObj and towerObj.valid and towerObj.health > 0 then
            local screenPos = WorldToScreen(towerObj.pos)
            if OnScreen(screenPos, screenPos) then
                _Tech:DrawCircle3D(towerObj.x, towerObj.y, towerObj.z, 965, 2, newColor, _Tech.Conf.TowerSettings.TowerQual)
            end
        end
    end
end

function _Draw:Wards()
    local function DrawSightWards(ward)

        if ward == nil or not ward.obj.valid then return end
        if ward.obj.health > 5 or ward.obj.health <= 0 or ward.Time < 0 then return end

        local screenPos = WorldToScreen(ward.Pos)
        if OnScreen(screenPos, screenPos) then
            _Tech:DrawCircle3D(ward.Pos.x, ward.Pos.y, ward.Pos.z, 75, 2, 0xFF00FF00, _Tech.Conf.enemyWards.wardQual)
            DrawText("Sight ward", 12, screenPos.x - 25, screenPos.y, 0xFFFFFFFF)
            DrawText("" .. ceil(ward.Time - GetInGameTimer()), 12, screenPos.x - 10, screenPos.y + 10, 0xFFFFFFFF)
        end
        frameSprites[8]:Draw(GetMinimapX(ward.Pos.x) -5, GetMinimapY(ward.Pos.z) -6, 255)
    end

    local function DrawVisionWard(ward)
        if ward == nil or not ward.obj.valid then return end
        if ward.obj.health > 5 or ward.obj.health <= 0 then return end

        local screenPos = WorldToScreen(ward.Pos)
        if OnScreen(screenPos, screenPos) then
            _Tech:DrawCircle3D(ward.Pos.x, ward.Pos.y, ward.Pos.z, 75, 2, 0xFFFF00FF, _Tech.Conf.enemyWards.wardQual)
            DrawText("Vision ward", 12, screenPos.x - 25, screenPos.y, 0xFFFFFFFF)
        end
        frameSprites[9]:Draw(GetMinimapX(ward.Pos.x) -8, GetMinimapY(ward.Pos.z) -4, 255)
    end

    for i = 1, #sightWards do
        DrawSightWards(sightWards[i])
    end

    for i = 1, #visionWards do
        DrawVisionWard(visionWards[i])
    end
end

function _Draw:ArrowInfo(unit, i)
    local function GetDisTime(unit)
        local lastPath
        local currentPath
        local travelTime
        local totalDistance = 0
        local distance
        local newPath = CalculatePath(myHero, unit.pos)
        local pathCount = newPath.count

        for i = 1, pathCount do
            if pathCount >= 1 then
                if lastPath == nil then lastPath = myHero.pos end

                currentPath = newPath:Path(i)
                distance = GetDistance(currentPath, lastPath)
                totalDistance = round(totalDistance + distance)
                travelTime = round((totalDistance / unit.ms) * 10) * .1
                lastPath = currentPath
            end
        end

        return totalDistance, travelTime
    end

    if _Tech.Conf.ArrowSettings["Show" .. unit.charName] then
        if not unit or not unit.valid or not unit.visible or unit.dead or myHero.dead then return end
        local newPoint = Vector(myHero) +(Vector(unit.pos) - Vector(myHero.pos)):normalized() * 500
        local endLinePosition = WorldToScreen(D3DXVECTOR3(newPoint.x, newPoint.y, newPoint.z))

        if OnScreen(endLinePosition.x, endLinePosition.y) then
            local distance, delay

            if _Tech.Conf.ArrowSettings.advancedPath then
                distance, delay = GetDisTime(unit)
            else
                distance = round(GetDistance(unit, myHero.pos))
                delay = round((distance / unit.ms) * 10) * 0.1
            end

            if distance < 1000 then return end
            _Tech:Arrow(myHero.pos, newPoint, 75, 50, 3, colorTable[i])
            DrawText("Seconds: " .. delay .. " " .. unit.charName .. "\nDistance: " .. distance .. " units", 14, endLinePosition.x - 100, endLinePosition.y + 30, colorTable[i])
        end
    end
end

local miaTable = { }
function _Draw:Missing(unit, i)
    if not unit.valid or unit.dead then return end
    local currentID = i + enemyCount
    local unitID = unit.networkID

    if miaTable[unitID] == nil then miaTable[unitID] = { mia = false, lastSeen = 0 } end
    if not unit.visible then
        if heroSprites[currentID] ~= nil then
            local miniMapX, miniMapY = GetMinimapX(unit.pos.x), GetMinimapY(unit.pos.z)
            if miaTable[unitID].mia == false then
                miaTable[unitID].lastSeen = GetInGameTimer()
                miaTable[unitID].mia = true
            end

            heroSprites[currentID]:SetScale(0.47, 0.47)
            heroSprites[currentID]:Draw((miniMapX - 16),(miniMapY - 11), 255)

            if _Tech.Conf.miaSettings.miaTimeOn then
                DrawText("" .. ceil(GetInGameTimer() - miaTable[unitID].lastSeen), 14,(miniMapX - 10),(miniMapY - 5), 0xFFFFFF00)
            end
        end
    elseif unit.visible and miaTable[unitID].mia then
        miaTable[unitID].mia = false
    end
end

function _Draw:JungleTimers()
    local GameTime = GetInGameTimer()

    if _Tech.Conf.JungleSettings.BarOn then
        if GameTime < JungleTroys.Baron.startTime then
            JungleTroys.Baron.currentTime = ceil(JungleTroys.Baron.startTime - GameTime)
            DrawText("" .. JungleTroys.Baron.currentTime , 11, JungleTroys.Baron.minimapX, JungleTroys.Baron.minimapY, 0xFFFFFFFF)
        elseif JungleTroys.Baron.currentTime > GameTime then
            local displayCount = ceil(GameTime - JungleTroys.Baron.currentTime)
            DrawText("" .. displayCount , 11, JungleTroys.Baron.minimapX, JungleTroys.Baron.minimapY, 0xFFFFFFFF)
        end
    end

    if _Tech.Conf.JungleSettings.DragOn then
        if GameTime < JungleTroys.Dragon.startTime then
            JungleTroys.Dragon.currentTime = ceil(JungleTroys.Dragon.startTime - GameTime)
            DrawText("" .. JungleTroys.Dragon.currentTime , 11, JungleTroys.Dragon.minimapX, JungleTroys.Dragon.minimapY, 0xFFFFFFFF)
        elseif JungleTroys.Dragon.currentTime > GameTime then
            local displayCount = ceil(GameTime - JungleTroys.Dragon.currentTime)
            DrawText("" .. displayCount , 11, JungleTroys.Dragon.minimapX, JungleTroys.Dragon.minimapY, 0xFFFFFFFF)
        end
    end
end

function _Draw:EnemyTarget(unit, i)
    if not unit.valid or unit.dead or not unit.visible then return end

    if _Tech.Conf.TargetSettings["Show" .. unit.charName] and unit.spell then
        local unitTarget = unit.spell.target

        if unitTarget ~= nil then
            local endDrawPos = WorldToScreen(unitTarget.pos)
            if OnScreen(endDrawPos.x, endDrawPos.y) then
                DrawLine3D(unit.pos.x, unit.pos.y, unit.pos.z, unitTarget.pos.x, unitTarget.pos.y, unitTarget.pos.z, 2, colorTable[i])
                _Tech:DrawCircle3D(unitTarget.pos.x, unitTarget.pos.y, unitTarget.pos.z, 60, 2, colorTable[i], 8)
            end
        end
    end
end

-- Auto update stuff made by Aroc
Class("ScriptUpdate")
function ScriptUpdate:__init(LocalVersion, UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion, CallbackError)
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript' ..(UseHttps and '5' or '6') .. '.php?script=' .. self:Base64Encode(self.Host .. VersionPath) .. '&rand=' .. math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript' ..(UseHttps and '5' or '6') .. '.php?script=' .. self:Base64Encode(self.Host .. ScriptPath) .. '&rand=' .. math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    AddDrawCallback( function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback( function() self:GetOnlineVersion() end)
end

function ScriptUpdate:print(str)
    print('<font color="#FFFFFF">' .. os.clock() .. ': ' .. str)
end

function ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)' then
        DrawText('Download Status: ' ..(self.DownloadStatus or 'Unknown'), 50, 10, 50, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
    end
end

function ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.LuaSocket = require("socket")
    self.Socket = self.LuaSocket.tcp()
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.Socket:connect('sx-bol.eu', 80)
    self.Url = url
    self.Started = false
    self.LastPrint = ""
    self.File = ""
end

function ScriptUpdate:Base64Encode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return((data:gsub('.', function(x)
        local r, b = '', x:byte()
        for i = 8, 1, -1 do r = r ..(b % 2 ^ i - b % 2 ^(i - 1) > 0 and '1' or '0') end
        return r;
    end ) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c = 0
        for i = 1, 6 do c = c +(x:sub(i, i) == '1' and 2 ^(6 - i) or 0) end
        return b:sub(c + 1, c + 1)
    end ) ..( { '', '==', '=' })[#data % 3 + 1])
end

function ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET " .. self.Url .. " HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or(#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File ..(self.Receive or self.Snipped)
    if self.File:find('</s' .. 'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si' .. 'ze>') + 6, self.File:find('</si' .. 'ze>') -1))
        end
        if self.File:find('<scr' .. 'ipt>') then
            local _, ScriptFind = self.File:find('<scr' .. 'ipt>')
            local ScriptEnd = self.File:find('</scr' .. 'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind + 1, ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading VersionInfo (' .. round(100 / self.Size * DownloadedSize, 2) .. '%)'
        end
    end
    if self.File:find('</scr' .. 'ipt>') then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local a, b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a, -1)
        self.NewFile = ''
        for line, content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.File:find('<scr' .. 'ipt>')
        local ContentEnd, _ = self.File:find('</sc' .. 'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion =(Base64Decode(self.File:sub(ContentStart + 1, ContentEnd - 1)))
            self.OnlineVersion = tonumber(self.OnlineVersion)
            if self.OnlineVersion > self.LocalVersion then
                if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                    self.CallbackNewVersion(self.OnlineVersion, self.LocalVersion)
                end
                self:CreateSocket(self.ScriptPath)
                self.DownloadStatus = 'Connect to Server for ScriptDownload'
                AddTickCallback( function() self:DownloadUpdate() end)
            else
                if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                    self.CallbackNoUpdate(self.LocalVersion)
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET " .. self.Url .. " HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or(#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File ..(self.Receive or self.Snipped)
    if self.File:find('</si' .. 'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si' .. 'ze>') + 6, self.File:find('</si' .. 'ze>') -1))
        end
        if self.File:find('<scr' .. 'ipt>') then
            local _, ScriptFind = self.File:find('<scr' .. 'ipt>')
            local ScriptEnd = self.File:find('</scr' .. 'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind + 1, ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script (' .. round(100 / self.Size * DownloadedSize, 2) .. '%)'
        end
    end
    if self.File:find('</scr' .. 'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a, b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a, -1)
        self.NewFile = ''
        for line, content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc' .. 'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr' .. 'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart + 1, ContentEnd - 1)
            local newf = newf:gsub('\r', '')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath, "w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion, self.LocalVersion)
                end
            end
        end
        self.GotScriptUpdate = true
    end
end
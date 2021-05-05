_addon.name = 'SloneFrames'
_addon.author = 'Ritual'
_addon.version = '1.0.0'
_addon.language = 'English'

images = require('images')
texts = require('texts')
table = require('table')

require('Utility')
require('UnitFrame/UnitFrameDefaults')
require('UnitFrame/UnitFrame')
require('UnitFrame/UnitFrameSetters')
require('UnitFrame/UnitFrameColors')
require('UnitFrame/UnitFrameVisibility')
require('UnitFrame/UnitFrameMP')
require('UnitFrame/UnitFramePositioning')

player_id = 0
debug_string = ''

windower.register_event('load', function()
    if windower.ffxi.get_info().logged_in then
        player_id = windower.ffxi.get_player().id
    end
end)

--[[ CONFIGURE PLAYER FRAME ]]
PlayerFrame = UnitFrame:new()
PlayerFrame:setUnit('player')
PlayerFrame:setXY(windower.get_windower_settings().x_res / 2 - 300 - 100, 700)
PlayerFrame:setHW(50, 300)
PlayerFrame:create()

--[[ CONFIGURE TARGET FRAME ]]--
TargetFrame = UnitFrame:new()
TargetFrame:setUnit('target')
TargetFrame:setXY(windower.get_windower_settings().x_res / 2 + 100, 700)
TargetFrame:setHW(50, 300)
TargetFrame:create()


--[[ CONFIGURE PARTY MEMBER FRAMES ]]--
-- If you change the party height it will make the spacing janky so you'll have to tweak that
local party_start_x = 300
local party_start_y = 400
local party_height = 55 -- this is actually the height + spacing you want, so bar height 25 + 10 spac

for i = 1, 5, 1 do
  pt_pos_y = party_start_y + (party_height * i)
  _G['p'..i] = UnitFrame:new()
  _G['p'..i]:setUnit('p'..i)
  _G['p'..i]:setXY(party_start_x, pt_pos_y)
  _G['p'..i]:setHW(35, 200)
  _G['p'..i]:create()
end


target_change = function(index)
  if index == 0 then
        visible = false
        hasTarget = false
    else
        visible = true
        hasTarget = true
  end
end

windower.register_event('target change', target_change)

windower.register_event('logout', function(...)
    -- This is a super cheap fix, but it works.
    windower.send_command("input //lua r target");
end)

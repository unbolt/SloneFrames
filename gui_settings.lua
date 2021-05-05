targetBarHeight = 50
targetBarWidth = 0
center_screen = 0
hideKey = 70

local LOGIN_ZONE_PACKET = 0x0A
local ZONE_OUT_PACKET = 0x0B

visible = false
hasTarget = false
is_hidden_by_key = false
is_hidden_by_cutscene = false
is_hidden_by_macro = false
is_hidden_by_zoning = false

windower.register_event('status change', function(new_status_id)
    if (new_status_id == 4)  and (hasTarget == true) and (is_hidden_by_key == false) and (is_hidden_by_macro == false) then
        visible = false
        is_hidden_by_cutscene = true
    elseif new_status_id ~= 4 then
        is_hidden_by_cutscene = false
    end
end)

windower.register_event('incoming chunk',function(id,org,_modi,_is_injected,_is_blocked)
    if (id == LOGIN_ZONE_PACKET) then
        is_hidden_by_zoning = false
        visible = true
    elseif (id == ZONE_OUT_PACKET) then
        is_hidden_by_zoning = true
        visible = false
    end
end)

windower.register_event('keyboard', function(dik, flags, blocked)
  if not is_hidden_by_zoning then
    if (dik == hideKey) and (flags == true) and (hasTarget == true) and (visible == true) and (is_hidden_by_cutscene == false) then
      visible = false
      is_hidden_by_key = true
    elseif (dik == hideKey) and (flags == true) and (hasTarget == true) and (visible == false) and (is_hidden_by_cutscene == false) then
      is_hidden_by_key = false
      visible = true
    end

    if (dik == settings.macroBar.ctrlKey and flags) or (dik == settings.macroBar.altKey and flags) then
        if (settings.macroBar.hide.enabled) then
            visible = false
            is_hidden_by_macro = true
        end
    elseif (dik == settings.macroBar.ctrlKey and flags == false) or (dik == settings.macroBar.altKey and flags == false) then
        if (settings.macroBar.hide.enabled and is_hidden_by_key == false) then
            visible = true
            is_hidden_by_macro = false
        end
    end
  end
end)

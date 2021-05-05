UnitFrame = {
    bg_cap_path = windower.addon_path.. 'bg_cap.png',
    bg_body_path = windower.addon_path.. 'bg_body.png',
    fg_body_path = windower.addon_path.. 'fg_body.png',
    watch = nil,
    unit = nil,
    pos_x = 500,
    pos_y = 500,
    height = 100,
    width = 300
}

function UnitFrame:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function UnitFrame:create()
    self:drawUnit()
    self:refresh()
end

function UnitFrame:drawUnit()

    -- Set up the UnitFrame

    -- Set up the texts
    -- Name
    self.unit_name_settings = table.copy(unitframe_text_defaults)
    self.unit_name_settings.pos.y = self:determineNameYPositionByUnitType() + (self.unit_name_settings.text.size / 2)
    self.unit_name_settings.pos.x = self.pos_x - (self.unit_name_settings.text.size / 2)
    self.unit_name = texts.new('${name|Name}', self.unit_name_settings)
    -- HPP
    self.unit_hpp_settings = table.copy(unitframe_text_defaults)
    self.unit_hpp_settings.pos.y = self.pos_y + ((self.height - self.unit_name_settings.text.size) / 2) - 2 -- old: hpp below the unit - self.pos_y + self.height + 2
    self.unit_hpp_settings.pos.x = self.pos_x + self.width - 50 -- 50 is a guess, seems to work fine
    self.unit_hpp = texts.new('${hpp|0}%', self.unit_hpp_settings)

    -- Draw the bar elements
    -- Bar BG
    self.bg_settings = table.copy(unitframe_image_defaults)
    self.bg_settings.pos.y = self.pos_y
    self.bg_settings.pos.x = self.pos_x
    self.bg_settings.texture.path = self.bg_body_path
    self.bg_settings.size.height = self.height
    self.bg = images.new(self.bg_settings)
    
    -- Bar FG growth
    self.fgg_settings = table.copy(self.bg_settings)
    self.fgg_settings.texture.path = self.fg_body_path
    self.fgg = images.new(self.fgg_settings)

    -- Bar FG
    self.fg_settings = table.copy(self.bg_settings)
    self.fg_settings.texture.path = self.fg_body_path
    self.fg = images.new(self.fg_settings)

    -- Caps
    self.cap_settings = table.copy(unitframe_image_defaults)
    self.cap_settings.pos.y = self.pos_y
    self.cap_settings.texture.path = self.bg_cap_path
    self.cap_left = images.new(self.cap_settings)
    self.cap_right = images.new(self.cap_settings)
    self.cap_left:pos_x(self.pos_x - 1)
    self.cap_right:pos_x(self.pos_x + self.width)

    -- If this is the player frame then we want to add MP and TP
    self:appendPlayerAdditionalData()

    -- Register the prerender event watcher 
    -- to refresh this unitframe
    windower.register_event('prerender', function()
        self:refresh()
    end)

    self:resizeUnit()
    self:show()
    
end

function UnitFrame:appendPlayerAdditionalData()
    if self.watch == 'player' then 
        self:appendMpBarToUnit()
    end
end

--[[
    For some reason unless this is done here it doesn't
    seem to update the dimensions when the initial image is drawn
    Doing this seems fine, dunno...
]]--
function UnitFrame:resizeUnit()
    self.cap_left:height(self.height) -- like seriously why is this needed? someone tell me!
    self.cap_right:height(self.height)
    self.bg:width(self.width)

    --[[
        Update the bar widths
    ]]--
    if self.unit ~= nil then 
        self:updateFgWidths()
    end
end

function UnitFrame:updateFgWidths()

    local i = self.unit.hpp / 100
    local new_width = math.floor(self.width * i)
    local old_width = self.fgg:width()


    if (self.old_unit ~= nil and self.unit.id == self.old_unit.id) and new_width ~= nil and new_width > 0 then
        if new_width < old_width then
            local x = old_width + math.floor(((new_width - old_width) * 0.1))
            self.fgg:width(x)
            self.fg:width(new_width)
        elseif new_width >= old_width then
            local zx = old_width + math.ceil(((new_width - old_width) * 0.1))
            self.fg:width(zx)
            self.fgg:width(new_width)
        end
    else
        self.fgg:width(new_width)
        self.fg:width(new_width)
    end

end

function UnitFrame:refresh()
    -- If this UnitFrame has no watch property then it hasn't been 
    -- created properly yet so we won't do anything at this time 
    -- other than hide it incase something weird is going on
    if self.watch ~= nil then 

        -- Refresh the unit information
        if self.watch == 'target' then
            
            if self.unit ~= nil then
                self.old_unit = self.unit
            end

            self.unit = windower.ffxi.get_mob_by_target('t')
        end

        if self.watch == 'player' then
            self.unit = windower.ffxi.get_mob_by_target('me')
        end

        if self.watch == 'p1' or self.watch == 'p2' or self.watch == 'p3' or self.watch == 'p4' or self.watch == 'p5' then 
            self.unit = windower.ffxi.get_mob_by_target(self.watch)
        end

        if self.unit ~= nil then 
            self.unit_name.name = self.unit.name -- string.upper(self.unit.name)
            self.unit_hpp.hpp = self.unit.hpp
    
            self:updateColors()
            self:resizeUnit()
            self:show()
        else 
            self:hide()
        end

    else
        self:hide()
    end
end



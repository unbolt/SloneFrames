function UnitFrame:setUnit (unit)

    self.watch = unit or self.watch

    if unit == 'player' then
        self.unit = windower.ffxi.get_mob_by_target('me')
    elseif unit == 'target' then 
        self.unit = windower.ffxi.get_mob_by_target('t')
    elseif unit == 'p1' or unit == 'p2' or unit == 'p3' or unit == 'p4' or unit == 'p5' then
        self.unit = windower.ffxi.get_mob_by_target(unit)
    end
end

function UnitFrame:setXY (x, y)
    self.pos_x = x
    self.pos_y = y
end

function UnitFrame:setHW (h, w)
    self.height = h
    self.width = w
end
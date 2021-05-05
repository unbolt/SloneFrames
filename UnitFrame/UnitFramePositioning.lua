function UnitFrame:determineNameYPositionByUnitType ()
    --if self.watch == 'p1' or self.watch == 'p2' or self.watch == 'p3' or self.watch == 'p4' or self.watch == 'p5' then 
    --    return self.pos_y + ((self.height - self.unit_name_settings.text.size) / 2)
    --else 
        return self.pos_y - self.unit_name_settings.text.size - (self.unit_name_settings.text.size / 3) - 2
    --end
end
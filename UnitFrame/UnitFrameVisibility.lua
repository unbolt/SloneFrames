function UnitFrame:show()
    self.cap_left:show()
    self.cap_right:show()
    self.bg:show()
    self.fg:show()
    self.fgg:show()
    self.unit_name:show()
 
    if self.watch == 'player' or self.watch == 'target' then
        self.unit_hpp:show()
    end
end

function UnitFrame:hide()
    self.cap_left:hide()
    self.cap_right:hide()
    self.bg:hide()
    self.fg:hide()
    self.fgg:hide()
    self.unit_name:hide()
    self.unit_hpp:hide()
end
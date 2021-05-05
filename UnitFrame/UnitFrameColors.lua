function UnitFrame:updateColors()
    --Check claim_id with player and party_id
    if self.unit.spawn_type == 2 or self.unit.spawn_type == 34 then
        --npc
        self.cap_left:color(26,151,58)
        self.cap_right:color(26,151,58)
        self.bg:color(26,151,58)
        self.fg:color(56,201,88)
        self.fgg:color(26,151,58)
        self.unit_hpp:stroke_color(33,39,29,200)
        self.unit_hpp:color(200,255,200)
    elseif self.unit.spawn_type == 16 then
        --monster
        if check_claim(self.unit.claim_id,player_id) then
            self.cap_left:color(255,64,65)
            self.cap_right:color(255,64,65)
            self.bg:color(255,64,65)
            self.fg:color(255,103,127)
            self.fgg:color(215,63,87)
            self.unit_hpp:stroke_color(49,17,19,200)
            self.unit_hpp:color(255,143,138)
        elseif self.unit.claim_id ~= 0 then
            self.cap_left:color(81,80,178)
            self.cap_right:color(81,80,178)
            self.bg:color(81,80,178)
            self.fg:color(245,122,245)
            self.fgg:color(81,80,178)
            self.unit_hpp:stroke_color(44,19,44,200)
            self.unit_hpp:color(255,132,255)
        else
            self.cap_left:color(181,131,59)
            self.cap_right:color(181,131,59)
            self.bg:color(181,131,59)
            self.fg:color(252,232,166)
            self.fgg:color(212,192,126)
            self.unit_hpp:stroke_color(51,47,38,200)
            self.unit_hpp:color(255,255,193)
        end
    else
        --pc
        if self.unit.in_party == true and self.unit.id ~= player_id then
            self.cap_left:color(52, 200, 200)
            self.cap_right:color(52, 200, 200)
            self.bg:color(52, 200, 200)
            self.fg:color(128, 255, 255)
            self.fgg:color(88, 215, 215)
            self.unit_hpp:stroke_color(38,43,46,200)
            self.unit_hpp:color(201, 255, 255)
        else
            self.cap_left:color(0, 100, 166)
            self.cap_right:color(0, 100, 166)
            self.bg:color(0, 100, 166)
            self.fg:color(163, 209, 245)
            self.fgg:color(123, 189, 205)
            self.unit_hpp:stroke_color(50,50,50,200)
            self.unit_hpp:color(255, 255, 255)
        end
    end
end
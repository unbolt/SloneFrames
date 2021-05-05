function UnitFrame:updateColors()

    -- MP IS YELLAH FOR ALL
    if self.mp_bar_bg ~= nil then
        self.mp_bar_bg:color(80,70,30)
        self.mp_bar_fg:color(180,150,40)
    end

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

        -- Color player and party names based on TP if we can
        if self.player ~= nil then 
            if self.watch == 'player' then 
                if self.player.vitals.tp ~= nil then 
                    self.unit_name:color(self:selectColorBasedOnTP(self.player.vitals.tp))
                end
            else
                --print(self.player.tp)  
                self.unit_name:color(self:selectColorBasedOnTP(self.player.tp))
            end
        end

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

function UnitFrame:selectColorBasedOnTP(tp)
    if tp ~= nil then 
        if tp >= 0 and tp < 1000 then
            return 255,255,255 -- white
        elseif tp >= 1000 and tp < 2000 then 
            return 125,180,40 -- green
        elseif tp >= 2000 and tp < 3000 then 
            return 180,120,40 -- orange
        else
            return 180,50,40 -- red
        end
    end
end
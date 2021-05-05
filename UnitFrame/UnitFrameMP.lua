--[[
    Add an MP bar to this UnitFrame
]]--
function UnitFrame:appendMpBarToUnit()

        -- Bar BG
        self.mp_bg_settings = table.copy(unitframe_image_defaults)
        self.mp_bg_settings.pos.y = self.pos_y + self.height - 10
        self.mp_bg_settings.pos.x = self.pos_x + 5
        self.mp_bg_settings.texture.path = self.bg_body_path
        self.mp_bg_settings.size.height = 5
        self.mp_bg_settings.size.width = self.width - 10
        self.mp_bar_bg = images.new(self.mp_bg_settings)

        self.mp_fg_settings = table.copy(self.mp_bg_settings)
        self.mp_fg_settings.texture.path = self.fg_body_path
        self.mp_bar_fg = images.new(self.mp_fg_settings)

        
        -- Text
        self.mp_bar_text_settings = table.copy(unitframe_text_defaults)
        self.mp_bar_text_settings.pos.y = self.pos_y + self.height - 20
        self.mp_bar_text_settings.pos.x = self.pos_x + 10
        self.mp_bar_text_settings.text.size = 8
        self.mp_bar_text_settings.text.stroke.width = 1
        self.mp_bar_text = texts.new('${mp|0}/${max_mp|0}', self.mp_bar_text_settings)


end
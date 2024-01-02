local xPosNow = 0
local commands = {
    ActorFrame = nil,
    AftContainer = nil,
    Font = "_r bold 30px",
    Width = 579,
    Height = 40,
    SpeedFactor = 200,
    SetText = function(this,newStr)
        if newStr == this.AftContainer:GetChild("TextContainer"):GetChild("Main"):GetText() then return end
		this.Text = newStr,
		this.ActorFrame:playcommand("UpdateText",{Text=newStr})
	end,
    Create = function(this)
        local t = Def.ActorFrame{
            InitCommand=function(self) this.ActorFrame = self end,
            UpdateTextCommand=function(self,params)
                if params.Text then
					local ctn = this.AftContainer:GetChild("TextContainer"):GetChildren()
                    ctn.Main:settext(params.Text):x(2)
                    ctn.Second:settext(params.Text):visible(true)
					this.SpeedFactor = string.len( params.Text ) / 2.75
					xPosNow = ctn.Main:GetWidth()
					ctn.Second:x(ctn.Main:GetWidth())
                end
            end
        }

        local function ScrollerUpdate(self,delta)
            local widthItem = self:GetChild("TextContainer"):GetChild("Main"):GetWidth()
            if (xPosNow) >= (widthItem) then xPosNow = 0 end
            xPosNow = xPosNow+(delta*this.SpeedFactor)
            self:GetChild("TextContainer"):x(this.Width-xPosNow)
        end

        t[#t+1] = Def.ActorFrameTexture{
            Name="AFT",
            InitCommand=function(self)
                this.AftContainer = self
                self:SetWidth(SCREEN_WIDTH):SetHeight(this.Height):EnableAlphaBuffer(true):Create():SetUpdateFunction(ScrollerUpdate)
            end,
            Def.ActorFrame{
                Name="TextContainer",
                InitCommand=function(self)
                    self:GetChild("Main"):x( 2 )
                    self:RunCommandsRecursively(
                        function(self)
                            if self.settext then
                                self:y(this.Height*.5):zoom(1):halign(0):shadowlength(4)
                            end
                        end
                    )
                    self:playcommand("AdjustTextPosition")
                end,
                AdjustTextPositionCommand=function(self) self:GetChild("Second"):x(self:GetChild("Main"):GetWidth()) end,
                Def.BitmapText{Font=this.Font,Text="text",Name="Main"},
                Def.BitmapText{Font=this.Font,Text="text",Name="Second"}
            }
        }
        t[#t+1] = Def.Sprite{
            Name="Render",
            OnCommand=function(self) self:SetTexture(self:GetParent():GetChild("AFT"):GetTexture()):playcommand("Change") end,
            ChangeCommand=function(self) self:stoptweening():cropleft(0.5-((this.Width/SCREEN_WIDTH)*.5)):cropright(0.5-((this.Width/SCREEN_WIDTH)*.5)) end
        }

        return t
    end
}

return setmetatable(commands,{
    __call = function(this,Attr)
        this.Width = Attr.Width or 300
        this.Height = Attr.Height or 42
        this.SpeedFactor = Attr.SpeedFactor or 100
        this.Font = Attr.Font or "Common Normal"
        return this
    end
})
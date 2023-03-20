local commands = {
	Font = "Common Bold",
	Width = 100,
	Height = 32,
	Text = "",
	SpeedFactor = 0.2,
	SleepBeforeStart = 2,
	OverflowSpacing = 32,
	SideFade = 0.02,
	SprHandler = nil,
	handler = nil,
	ActorFrame = nil,
	sechandler = nil,
	SlideLength = 0,
	UseAbsZoom = nil,
	AbsZoom = function(this)
		return this.UseAbsZoom or this.Width*2
	end,
	SetText = function(this, newStr, altText)
		if newStr == this.handler:GetText() then return end

		this.Text = newStr,
		this.ActorFrame:playcommand("UpdateText",{Text=newStr,AltText=altText})
		this.SprHandler:playcommand("CheckSizeForSideFades")
	end,
	SetWidth = function(this, newWidth)
		this.Width = newWidth
		this.ActorFrame:playcommand("UpdateText",{Text=this.handler:GetText()})
		this.SprHandler:playcommand("CheckSizeForSideFades")
	end,
	ApplyToText = function(this, func)
		func(this.handler)
		func(this.sechandler)
	end,
	GetTextSlideLength = function(this)
		return this.SlideLength
	end,
	IsTextScrollable = function(this)
		return this:IsOverflowing( this.ActorFrame:GetChild("Main") )
	end,
	IsOverflowing = function(this, text)
		return text:GetZoomedWidth() > this:AbsZoom()
	end,
	Create = function(this)
		local AFT = Def.ActorFrameTexture{
			Name="AFT",
			InitCommand=function(self)
				self:SetWidth( this.Width*2 ):SetHeight( this.Height*2 ):EnableAlphaBuffer(true):Create()
			end,
			Def.ActorFrame{
				Name="TextContainer",
				InitCommand=function(self)
					this.ActorFrame = self
					self:GetChild("Main"):x( (this.Width + 2) )
					self:RunCommandsRecursively(
						function(self)
							if self.settext then
								self:y(this.Height*2*.5)
								:zoom(2):halign(0)
							end
						end
					)
					self:GetChild("Second"):x(
						(this.Width + 2) + self:GetChild("Main"):GetZoomedWidth() + this.OverflowSpacing
					)
				end,
				UpdateTextCommand=function(self,params)
					self:finishtweening()
					self:GetChild("Main"):settext( params.Text, params.AltText or params.Text )
					self:GetChild("Second"):settext( params.Text, params.AltText or params.Text )
					:x(
						(this.Width + 2) + self:GetChild("Main"):GetZoomedWidth() + this.OverflowSpacing
					)
					local IsOverflowing = this:IsOverflowing( self:GetChild("Main") )
					self:GetChild("Second"):visible(IsOverflowing)
					if IsOverflowing then self:playcommand("BeginSlide") end
				end,
				BeginSlideCommand=function(self)
					local slideLength = string.len( self:GetChild("Main"):GetText() ) * this.SpeedFactor
					local returnSpeedRate = clamp( slideLength*.25, 2, slideLength )
					this.SlideLength = slideLength + this.SleepBeforeStart
					self:sleep(this.SleepBeforeStart):linear( slideLength )
					:x( (this.Width + 2) - self:GetChild("Main"):GetZoomedWidth() - (this.OverflowSpacing - 2) )
					:sleep(0):x((this.Width + 2) + 2):queuecommand("BeginSlide")
				end,
				Def.BitmapText{
					Font=this.Font,
					Text=this.Text,
					Name="Main",
					InitCommand=function(self) this.handler = self end
				},
				Def.BitmapText{
					Font=this.Font,
					Text=this.Text,
					Name="Second",
					InitCommand=function(self) this.sechandler = self end
				}
			}
		}

		local t = Def.ActorFrame{}

		t[#t+1] = AFT
		t[#t+1] = Def.Sprite{
			Name="Sprite",
			InitCommand=function(self) this.SprHandler = self end,
			OnCommand=function(self) self:SetTexture( self:GetParent():GetChild("AFT"):GetTexture() ):zoom(.5) end,
			CheckSizeForSideFadesCommand=function(self)
				local side = 0
				if this.handler:GetZoomedWidth() > this.Width*2 then side = this.SideFade end
				self:fadeleft(side):faderight(side)
			end
		}

		return t
	end
}

return setmetatable( commands, {
	__call = function(this, Attr)
		this.Text = Attr.Text or ""
		this.Font = Attr.Font or "Common Bold"
		this.Width = Attr.Width or 100
		this.Height = Attr.Height or 32
		this.SpeedFactor = Attr.SpeedFactor or 0.2
		this.SleepBeforeStart = Attr.SleepBeforeStart or 2
		this.OverflowSpacing = Attr.OverflowSpacing or 32
		this.SideFade = Attr.SideFade or 0.02
		this.UseAbsZoom = Attr.AbsZoom or nil
		return this
	end
}  )

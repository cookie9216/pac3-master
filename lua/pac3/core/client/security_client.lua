-- change by cookie9216

if not CLIENT then return end

local lastDeny = 0

local function denyMessage()
	if CurTime() - lastDeny < 3 then return end
	lastDeny = CurTime()
	local privilege = pac.Security.GetString("Editor", "PrivilegeName", "pac3.open_editor")
	local msg = pac.Security.Phrase("editor_restricted", LocalPlayer(), privilege)
	if chat and chat.AddText then
		chat.AddText(Color(255, 120, 120), "[PAC3] ", color_white, msg)
	end
end

hook.Add("PrePACEditorOpen", "pac3_security_editor_acl", function(ply)
	if pac.Security.PlayerCanOpenEditor(ply or LocalPlayer()) then
		-- change by cookie9216
		if not timer.Exists("pac3_security_editor_acl_close") then
			timer.Create("pac3_security_editor_acl_close", 2, 0, function()
				if not pac.Security.LimitsEnabled() then return end
				if not pac.Security.GetBool("Editor", "RestrictOpen", true) then
					timer.Remove("pac3_security_editor_acl_close")
					return
				end
				if not pace or not pace.IsActive or not pace.IsActive() then
					timer.Remove("pac3_security_editor_acl_close")
					return
				end
				if pac.Security.PlayerCanOpenEditor(LocalPlayer()) then return end
				if pace.CloseEditor then pace.CloseEditor() end
				denyMessage()
			end)
		end
		return
	end
	denyMessage()
	return false
end)

hook.Add("CreateEntityRagdoll", "pac3_security_ttt_corpse", function(_, rag)
	if not pac.Security.KeepTTTCorpsesVisible() then return end
	timer.Simple(0, function()
		if not IsValid(rag) then return end
		if not pac.Security.IsTTTPlayerCorpse(rag) then return end
		rag:SetNoDraw(false)
		rag:DrawShadow(true)
		local c = rag:GetColor()
		if c.a ~= 255 then
			c.a = 255
			rag:SetColor(c)
		end
		rag:SetRenderMode(RENDERMODE_NORMAL)
	end)
end)


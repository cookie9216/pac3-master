-- change by cookie9216

--[[
	PAC3 security configuration.

	Edit values here. The addon works without changes: every field has a
	safe default, and invalid/missing values fall back instead of disabling
	protection.

	Structural checks (IsValid, types, table shape) cannot be turned off.
	PAC3_SECURITY.Enabled only gates configurable limits and policy flags.
]]

PAC3_SECURITY = PAC3_SECURITY or {}

-- Master switch for configurable limits and policy. Structural validation stays on.
PAC3_SECURITY.Enabled = true

PAC3_SECURITY.Network = {
	Enabled = true,

	-- Maximum accepted outfit payload in bytes (JSON of the submit table).
	MaxPayloadBytes = 262144,

	-- pac_submit rate limit window (matches original pac.RatelimitPlayer window).
	MaxRequestsPerWindow = 8,
	WindowSeconds = 5,

	-- Minimum seconds between successful outfit apply attempts per player.
	WearCooldownSeconds = 2,

	-- Minimum net.ReadStream length in bits-equivalent bytes already gated by wear.lua (len < 64).
	MinSubmitLength = 64,
}

PAC3_SECURITY.Parts = {
	-- Recommended public-server defaults: tighter than unlimited original,
	-- with headroom over the previous hardcoded 40-part live cap.
	MaxPartsCount = 64,
	MaxDepthCount = 12,
	MaxModelsCount = 24,
	MaxMaterialOpsCount = 48,
	MaxTrailsCount = 6,
	MaxBonesCount = 32,
	MaxStringLengthChars = 4096,

	TrailMaxSize = 48,
	TrailMaxDurationSeconds = 12,
	BoneScaleMin = 0.2,
	BoneScaleMax = 3,
	BodygroupIndexMax = 64,
}

PAC3_SECURITY.URL = {
	Enabled = true,
	MaxLengthChars = 2048,
	BlockRemoteModelUrls = true,
}

PAC3_SECURITY.Policy = {
	-- Default ON: public-server hardened policy. Set false to restore vanilla PAC3 combat/editor.
	RestrictToSafeCosmetics = true,
	BlockPlayerModelRewrite = true,
	BlockPlayerResize = true,
	ForceDisableCombat = true,
	ForceDisableMovement = true,
	ForceDisablePropOutfits = true,
	NotifyBlocked = true,
	LogBlocked = true,
}

PAC3_SECURITY.Editor = {
	-- Default ON: only SuperAdmin or the configured privilege may open the editor.
	-- Wear/submit of outfits is not blocked by this flag.
	RestrictOpen = true,
	PrivilegeName = "pac3.open_editor",
	AllowSuperAdmin = true,
}

PAC3_SECURITY.Compatibility = {
	-- Default ON, but only acts when TTT (or CORPSE) is detected.
	KeepTTTCorpsesVisible = true,
}

-- Allowed part classes when RestrictToSafeCosmetics is true.
-- material_* prefixes are also allowed at runtime.
PAC3_SECURITY.SafeParts = {
	group = true,
	model = true,
	model2 = true,
	bone = true,
	bodygroup = true,
	material = true,
	submaterial = true,
	trail2 = true,
}

-- Explicitly rejected classes (also covered by the safe-list when restriction is on).
PAC3_SECURITY.BlockedParts = {
	animation = true,
	beam = true,
	camera = true,
	censor = true,
	clip = true,
	command = true,
	custom_animation = true,
	damage_zone = true,
	decal = true,
	effect = true,
	event = true,
	faceposer = true,
	flex = true,
	fog = true,
	force = true,
	gesture = true,
	halo = true,
	health_modifier = true,
	hitscan = true,
	holdtype = true,
	info = true,
	interpolated_multibone = true,
	jiggle = true,
	light = true,
	link = true,
	lock = true,
	motion_blur = true,
	movement = true,
	particles = true,
	physics = true,
	player_config = true,
	poseparameter = true,
	projected_texture = true,
	projectile = true,
	proxy = true,
	script = true,
	shake = true,
	sound = true,
	sprite = true,
	sunbeams = true,
	text = true,
}

PAC3_SECURITY.Cache = {
	ValidationTtlSeconds = 45,
	ValidationMaxEntries = 256,
}


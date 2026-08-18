# PAC3 Security Config

Source of truth: `lua/pac3/core/shared/security_config.lua`

Structural checks (`IsValid`, types, table shape) always run. `PAC3_SECURITY.Enabled` and `pac_security_enabled` only gate configurable limits and policy.

Invalid, missing, or out-of-range values fall back to the defaults below. Bad values never disable protection.

## Enabled

Type: boolean  
Standard: true  

Master switch for limits and policy. Structural validation stays on.

Zu niedrig / false: combat, editor ACL, part caps, and cosmetic restriction turn off.  
Zu hoch: n/a.

## Network.MaxPayloadBytes

Type: number (bytes)  
Standard: 262144  

Maximum JSON size of an accepted outfit submit.

Zu niedrig: large legitimate outfits are rejected.  
Zu hoch: memory and net load increase.

## Network.MaxRequestsPerWindow

Type: number (count)  
Standard: 8  

Applied to original `pac_submit_limit` when policy is enabled (window: `WindowSeconds`, default 5).

## Network.WearCooldownSeconds

Type: number (seconds)  
Standard: 2  

Minimum delay between outfit apply attempts per player. Floor 0.25.

## Parts.MaxPartsCount

Type: number (count)  
Standard: 64  

Recommended public-server default. Previous live hardcode was 40 (too tight for some cosmetic outfits). Original PAC3 had no cap.

## Parts.MaxDepthCount

Type: number (count)  
Standard: 12  

Maximum nesting depth of the part tree.

## Parts.MaxModelsCount / MaxMaterialOpsCount / MaxTrailsCount / MaxBonesCount

Type: number  
Standard: 24 / 48 / 6 / 32  

Per-outfit resource caps.

## Parts.TrailMaxSize / TrailMaxDurationSeconds / BoneScaleMin / BoneScaleMax / BodygroupIndexMax

Type: number  
Standard: 48 / 12 / 0.2 / 3 / 64  

Physical range clamps for trail and bone parts.

## URL.MaxLengthChars

Type: number (chars)  
Standard: 2048  

Maximum HTTP URL and path string length.

## URL.BlockRemoteModelUrls

Type: boolean  
Standard: true  

Blocks `http(s)://` model paths and related remote schemes.

## Policy.RestrictToSafeCosmetics

Type: boolean  
Standard: true  

Only `SafeParts` (plus `material_*`) are accepted when wearing.

## Policy.BlockPlayerModelRewrite / BlockPlayerResize / ForceDisableCombat / ForceDisableMovement / ForceDisablePropOutfits

Type: boolean  
Standard: true  

Public-server policy. Set false to restore the corresponding original PAC3 cvars/behavior.

## Editor.RestrictOpen

Type: boolean  
Standard: true  

Editor open requires SuperAdmin (if `AllowSuperAdmin`) or `Editor.PrivilegeName` (`pac3.open_editor`) via ULX/CAMI. Wear is not blocked.

## Compatibility.KeepTTTCorpsesVisible

Type: boolean  
Standard: true  

Only acts when TTT/`CORPSE` is detected. Skips PAC death-hide on player corpses.

## Optional ConVar

`pac_security_enabled` — same meaning as `PAC3_SECURITY.Enabled`. Do not add a ConVar per limit.

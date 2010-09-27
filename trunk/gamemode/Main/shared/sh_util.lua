--This code is a mess but its basicly a dump for useful functions we cant live with out.
local Entity = FindMetaTable("Entity")
local Player = FindMetaTable("Player")

function StringatizeVector(vecVector)
	local tblVector = {}
	tblVector[1] = math.Round(vecVector.x * 100) / 100
	tblVector[2] = math.Round(vecVector.y * 100) / 100
	tblVector[3] = math.Round(vecVector.z * 100) / 100
	return table.concat(tblVector, "!")
end

function VectortizeString(strVectorString)
	local tblDecodeTable = string.Explode("!", strVectorString)
	return Vector(tblDecodeTable[1], tblDecodeTable[2], tblDecodeTable[3])
end

function math.Mid(a, b, d)
	return (b - a) * d + a
end

function ColorCopy(clrToCopy, intAlpha)
	return Color(clrToCopy.r, clrToCopy.g, clrToCopy.b, intAlpha or clrToCopy.a)
end

randseed = 1337
function math.pSeedRand(fSeed)
	randseed = fSeed
end
function math.pRand()
    randseed = ((8253729 * randseed) + 2396403)
	randseed = randseed - math.floor(randseed / 32767) * 32767
    return randseed / 32767
end

if SERVER then
	function SendUsrMsg(strName, plyTarget, tblArgs)
		umsg.Start(strName, plyTarget)
		for _, value in pairs(tblArgs or {}) do
			if type(value) == "string" then umsg.String(value)
			elseif type(value) == "number" then umsg.Long(value)
			elseif type(value) == "boolean" then umsg.Bool(value)
			elseif type(value) == "Entity" or type(value) == "Player" then umsg.Entity(value)
			elseif type(value) == "Vector" then umsg.Vector(value)
			elseif type(value) == "Angle" then umsg.Angle(value)
			elseif type(value) == "table" then umsg.String(glon.encode(value)) end
		end
		umsg.End()
	end
	
	function GM:RemoveAll(strClass, intTime)
		table.foreach(ents.FindByClass(strClass .. "*"), function(_, ent) SafeRemoveEntityDelayed(ent, intTime or 0) end)
	end
end
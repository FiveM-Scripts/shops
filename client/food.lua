local coordinates = {
    {x=28.463, y=-1353.033, z=29.340},
    {x=-54.937, y=-1759.108, z=29.005},
    {x=375.858, y=320.097, z=103.433},
    {x=1143.813, y=-980.601, z=46.205},
    {x=1695.284, y=4932.052, z=42.078},
    {x=2686.051, y=3281.089, z=55.241},
    {x=1967.648, y=3735.871, z=32.221},
    {x=-2977.137, y=390.652, z=15.024},
    {x=1160.269, y=-333.137, z=68.783},
    {x=-1492.784, y=-386.306, z=39.798},
    {x=-1229.355, y=-899.230, z=12.263},
    {x=-712.091, y=-923.820, z=19.014},
    {x=-1816.544, y=782.072, z=137.600},
    {x=1729.689, y=6405.970, z=34.453},
    {x=2565.705, y=385.228, z=108.463}

}

local foodPeds = {
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-46.313, y=-1757.504, z=29.421, a=46.395},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=24.376, y=-1345.558, z=29.421, a=267.940},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=1134.182, y=-982.477, z=46.416, a=275.432},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=373.015, y=328.332, z=103.566, a=257.309},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=2676.389, y=3280.362, z=55.241, a=332.305},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=1958.960, y=3741.979, z=32.344, a=303.196},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-2966.391, y=391.324, z=15.043, a=88.867},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-1698.542, y=4922.583, z=42.064, a=324.021},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=1164.565, y=-322.121, z=69.205, a=100.492},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-1486.530, y=-377.768, z=40.163, a=147.669},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-1221.568, y=-908.121, z=12.326, a=31.739},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-706.153, y=-913.464, z=19.216, a=82.056},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-1820.230, y=794.369, z=138.089, a=130.327},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=2555.474, y=380.909, z=108.623, a=355.737},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=1728.614, y=6416.729, z=35.037, a=247.369}
}


local function storeBlips()
	for k,v in ipairs(coordinates) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Store")
		EndTextCommandSetBlipName(blip)

		SetBlipSprite(blip, 52)
		SetBlipAsShortRange(blip, true)
	end
end


Citizen.CreateThread(function()
	storeBlips()


	for k,v in ipairs(foodPeds) do
		RequestModel(GetHashKey(v.model))
		while not HasModelLoaded(GetHashKey(v.model)) do
			Wait(0)
		end

		local storePed = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.a, false, false)
		SetBlockingOfNonTemporaryEvents(storePed, true)
		SetAmbientVoiceName(storePed, v.voice)
		TaskStartScenarioInPlace(storePed, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, 0)

		SetModelAsNoLongerNeeded(GetHashKey(v.model))
	end
end)

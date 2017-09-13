local clothingBlips = {
    {x=88.291, y=-1391.929, z=29.200},
    {x=-718.985, y=-158.059, z=36.996},
    {x=-151.204, y=-306.837, z=38.724},
    {x=414.646, y=-807.452, z=29.338},
    {x=-815.193, y=-1083.333, z=11.022},
    {x=-1208.098, y=-782.020, z=17.163},
    {x=-1457.954, y=-229.426, z=49.185},
    {x=-2.777, y=6518.491, z=31.533},
    {x=1681.586, y=4820.133, z=42.046},
    {x=130.216, y=-202.940, z=54.505},
    {x=618.701, y=2740.564, z=41.905},
    {x=1199.169, y=2694.895, z=37.866},
    {x=-3164.172, y=1063.927, z=20.674},
    {x=-1091.373, y=2702.356, z=19.422}
  }

local clothingPeds = {
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=73.883, y=-1392.551, z=29.376, heading=258.693},
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=-708.705, y=-152.150, z=37.415, heading=118.490},
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=-164.849, y=-302.719, z=39.733, heading=249.119},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=126.824, y=-224.512, z=54.558, heading=71.926},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=427.069, y=-806.280, z=29.491, heading=84.203},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-822.872 , y=-1072.162, z=11.328, heading=203.007},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-1193.691, y=-766.863, z=17.316, heading=216.273},
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=-1448.901, y=-238.138, z=49.814, heading=48.307},
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=5.809, y=6511.428, z=31.878 , heading=40.329},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=1695.387, y=4823.019, z=42.063, heading=96.539},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=613.015, y=2762.577, z=42.088, heading=277.766},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=1196.435, y=2711.634, z=38.223, heading=179.040},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-3169.260, y=1043.606, z=20.863, heading=57.917},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-1102.184, y=2711.799, z=19.108, heading=223.387},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-0.381, y=6510.237, z=31.878, heading=310.662}
  }

  local function ClothingCoords()
    for k,v in ipairs(clothingBlips) do
      local blip = AddBlipForCoord(v.x, v.y, v.z)    
      SetBlipSprite(blip, 73)
      SetBlipAsShortRange(blip, true)
    end
  end

  Citizen.CreateThread(function()
    ClothingCoords()
    for k,v in ipairs(clothingPeds) do
      RequestModel(GetHashKey(v.model))
      while not HasModelLoaded(GetHashKey(v.model)) do
        Wait(0)
      end

      local shopOwner = CreatePed(5, GetHashKey(v.model), v.x, v.y, v.z, v.heading, false, false)
      SetBlockingOfNonTemporaryEvents(shopOwner, true)
      SetAmbientVoiceName(shopOwner, v.voice)
      SetModelAsNoLongerNeeded(GetHashKey(v.model))
    end
  end)
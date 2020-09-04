-- AryenN tarafından geliştirilmiştir 
-- Developed by AryenN
-- Dinamik iklimi etkinleştirin / Dinamik iklimi etkinleştirin
local DynamicWeather = true
-- İklim Türleri
local AvailableWeatherTypes = {
    'EXTRASUNNY',
    'CLEAR',
    'NEUTRAL',
    'SMOG',
    'FOGGY',
    'OVERCAST',
    'CLOUDS',
    'CLEARING',
    'RAIN',
    'THUNDER',
    'SNOW',
    'BLIZZARD',
    'SNOWLIGHT',
    'XMAS',
    'HALLOWEEN',
}
-- Bugün
local CurrentWeather = "EXTRASUNNY"
local Time = {}
-- Saat Dilimi (Burada Saat Dilimini değiştirirseniz .js dosyasını değiştirmeyi unutmayın) / Saat Dilimi (Bunu değiştirirseniz javascript'te de değiştirmeyi unutmayın.)
local timezone = -3
-- İklimin değişeceği aralığı dakika cinsinden ayarlayın (120m = 2saat) / Sunucunun iklimini değiştirmek için aralığı dakika cinsinden ayarlayın (thx vSync).
local newWeatherTimer = 120
-- Fonksiyonlar
function atualizarHora()
  -- Sunucunun zamanını çekin (Artık dahili bir saat kullanmadığı için bunun gibi daha yüksek performans ve zamanda hassasiyet)
  -- Sunucunun zamanını öğrenin (Performans ve hassasiyet için daha iyidir)
  Time.h = tonumber(os.date("%H", os.time() + timezone * 60 * 60))
  Time.m = tonumber(os.date("%M"))
  Time.s = tonumber(os.date("%S"))
  Time.y = tonumber(os.date("%Y"))
  Time.me = tonumber(os.date("%m"))
  Time.d = tonumber(os.date("%d"))
  -- Burada bir maaş günü aramak için bunu kullanın / Zaman zaman bir ödeme günü tetiklemek için bunu kullanın.
  if Time.s == 0 and Time.m == 0 then
   -- TriggerEvent("vRP:BPAPayday")
  end
end

-- Tarihi her saniye günceller (Yani doğru ayı ve yılı değiştirir) / Ayı daha sonra değiştirebilmesi için her saniye tarihi kontrol eder.
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        atualizarHora()
    end
end)

-- İklimleri dinamik olarak değiştirmek için ayarlanmış vSnc işlevi / vSync'e dayalı işlev, böylece iklimi değiştirebilir.
function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("JNS:requestSync")
end

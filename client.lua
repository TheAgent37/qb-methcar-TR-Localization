local QBCore = exports['qb-core']:GetCoreObject()

local started = false
local progress = 0
local pause = false
local quality = 0

RegisterNetEvent('qb-methcar:stop')
AddEventHandler('qb-methcar:stop', function()
	LastVehicle = QBCore.Functions.GetClosestVehicle()
	started = false
	progress = 0
	QBCore.Functions.Notify("Üretim durdu...", "error")
	FreezeEntityPosition(LastVehicle, false)
end)

RegisterNetEvent('qb-methcar:notify')
AddEventHandler('qb-methcar:notify', function(message)
	QBCore.Functions.Notify(message)
end)

RegisterNetEvent('qb-methcar:startprod')
AddEventHandler('qb-methcar:startprod', function()
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	started = true
	pause = false
	FreezeEntityPosition(CurrentVehicle, true)
	QBCore.Functions.Notify("Üretim başladı", "success")
end)

RegisterNetEvent('qb-methcar:smoke')
AddEventHandler('qb-methcar:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", posx, posy, posz + 1.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.9)
		Citizen.Wait(60000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

-------------------------------------------------------EVENTS NEGATIVE
RegisterNetEvent('qb-methcar:boom', function()
	playerPed = (PlayerPedId())
	local pos = GetEntityCoords((PlayerPedId()))
	pause = false
	Citizen.Wait(500)
	started = false
	Citizen.Wait(500)
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	TriggerServerEvent('qb-methcar:blow', pos.x, pos.y, pos.z)
	TriggerEvent('qb-methcar:stop')
end)

RegisterNetEvent('qb-methcar:blowup')
AddEventHandler('qb-methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)	
end)

RegisterNetEvent('qb-methcar:drugged')
AddEventHandler('qb-methcar:drugged', function()
	local pos = GetEntityCoords((PlayerPedId()))
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur((PlayerPedId()), true)
	SetPedMovementClipset((PlayerPedId()), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk((PlayerPedId()), true)
	quality = quality - 3
	pause = false
	Citizen.Wait(90000)
	ClearTimecycleModifier()
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q-1police', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('police:server:policeAlert', 'Kişi garip bir koku alıyor!')
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q-1', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q-3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 3
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q-5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 5
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

-------------------------------------------------------EVENTS POSITIVE
RegisterNetEvent('qb-methcar:q2', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 2
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 3
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:q5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:gasmask', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	SetPedPropIndex(playerPed, 1, 26, 7, true)
	quality = quality + 2
	pause = false
	TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('qb-methcar:cook', function()
	local pos = GetEntityCoords((PlayerPedId()))
	playerPed = (PlayerPedId())
	local CurrentVehicle = QBCore.Functions.GetClosestVehicle()
	if IsVehicleSeatFree(CurrentVehicle, 3) and IsVehicleSeatFree(CurrentVehicle, -1) and IsVehicleSeatFree(CurrentVehicle, 0) and IsVehicleSeatFree(CurrentVehicle, 1)and IsVehicleSeatFree(CurrentVehicle, 2) then
		TaskWarpPedIntoVehicle(PlayerPedId(), CurrentVehicle, 3)
		SetVehicleDoorOpen(CurrentVehicle, 2)
		Wait(300)
		TriggerServerEvent('qb-methcar:start')
		TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
		Wait(1000)
		quality = 0
	else
		QBCore.Functions.Notify('Arabada başka birsi mi var?!', "error")
	end
end)

---------EVENTS------------------------------------------------------

RegisterNetEvent('qb-methcar:proses', function()
	--
	--   EVENT 1
	--
	if progress > 9 and progress < 11 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Gaz tankı sızıyor... Napcaz?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Bantla",
				params = {
					event = "qb-methcar:q-3",
					args = {
						message = "Galiba işe yaradı, yani umarım?!"
					}
				}
			},
			{
				header = "🔴 Çakmak yak.",
				params = {
					event = "qb-methcar:boom",
					args = {
						message = "UÇUYORUZ!"
					}
				}
			},
			{
				header = "🔴 Tüpü değiştir",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Tüpü değiştirmek iyi fikirdi!"
					}
				}
			},
		})
	end
	--
	--   EVENT 2
	--
	if progress > 19 and progress < 21 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Yere birazcık aseton döktün...Napcaz?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Camı aç",
				params = {
					event = "qb-methcar:q-1police",
					args = {
						message = "Bu leş koku hâlâ insanların dikkatini çekiyor!"
					}
				}
			},
			{
				header = "🔴 İçine çeeek...",
				params = {
					event = "qb-methcar:drugged"
				}
			},
			{
				header = "🔴 Gaz maskesi tak",
				params = {
					event = "qb-methcar:gasmask",
					args = {
						message = "Eh, mantıklısı da buydu zaten."
					}
				}
			},
		})
	end
	--
	--   EVENT 3
	--
	if progress > 29 and progress < 31 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Meth aşırı hızlı pişti... Ne yapıyoruz!?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Biraz daha ısıt",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Yüksek ısı güzelce dengeledi!"
					}
				}
			},
			{
				header = "🔴 Basınç ekle",
				params = {
					event = "qb-methcar:q-3",
					args = {
						message = "Basın aşırı düzeye geldi..."
					}
				}
			},
			{
				header = "🔴 Basıncı düşür",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "İşte şimdi sıçtın!"
					}
				}
			},
		})
	end
	--
	--   EVENT 4
	--
	if progress > 39 and progress < 41 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Çok fazla aseton ekledin,Ne yapacaksın?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Bi' şey yapma :D",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "Meth leş gibi aseton kokuyor"
					}
				}
			},
			{
				header = "🔴 Pipetle çek",
				params = {
					event = "qb-methcar:drugged",
					args = {
						message = "Abicim çok iyi oldu yiaa"
					}
				}
			},
			{
				header = "🔴 Dengelemek için lityum ekle",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Akıllıca"
					}
				}
			},
		})
	end
	--
	--   EVENT 5
	--
	if progress > 49 and progress < 51 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Böyle garip mavi bi' şey buldun,Ne yapacaksın?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Karışıma ekle!",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Akıllıca, insanlar bunu sevecek!"
					}
				}
			},
			{
				header = "🔴 Çöpe at",
				params = {
					event = "qb-methcar:q-1",
					args = {
						message = "Yaratıcılık hiç yok değil mi?"
					}
				}
			},
		})
	end
	--
	--   EVENT 6
	--
	if progress > 59 and progress < 61 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Filtre tozlanmış,ne yapalım?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Kompresör ile üfüttür!",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "Her şey toza bulandı,Yyapacağın işe sıçayım!"
					}
				}
			},
			{
				header = "🔴 Filtreyi değiştir!",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "En iyi seçenek buydu!"
					}
				}
			},
			{
				header = "🔴 Fırça ile temizle",
				params = {
					event = "qb-methcar:q-1",
					args = {
						message = "Pek işe yaramadı!"
					}
				}
			},
		})
	end
	--
	--   EVENT 7
	--
	if progress > 69 and progress < 71 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Çok fazla lityum eklemişssin,Ne yapacaksın?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Pipetle em",
				params = {
					event = "qb-methcar:drugged"
				}
			},
			{
				header = "🔴 Aseton ile dengele",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "İyi seçim"
					}
				}
			},
			{
				header = "🔴 Hiçbir şey yapma",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "En azından bi' şey yapabilirdin!"
					}
				}
			},
		})
	end
	--
	--   EVENT 8
	--
	if progress > 79 and progress < 81 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Propan borusu sızdırıyor,Ne yapacaksın?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Bi' sigara yak.",
				params = {
					event = "qb-methcar:boom"
				}
			},
			{
				header = "🔴 bantla!",
				params = {
					event = "qb-methcar:q-3",
					args = {
						message = "Gaaliba işe yaradı sanki?!"
					}
				}
			},
			{
				header = "🔴 Boruyu değiştir",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "En iyi çözüm buydu!"
					}
				}
			},
		})
	end
	--
	--   EVENT 9
	--
	if progress > 89 and progress < 91 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Çok acil sıçman lazım,ne yapacaksın?",
				txt = "Aşağıdan cevabını seç. İlerleme: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Biraz dayaaan!",
				params = {
					event = "qb-methcar:q5",
					args = {
						message = "Afferim!"
					}
				}
			},
			{
				header = "🔴 Araçtan in ve sıç!",
				params = {
					event = "qb-methcar:q-1police",
					args = {
						message = "Hassiktir, biri seni gördü!"
					}
				}
			},
			{
				header = "🔴 İçeri sıç!",
				params = {
					event = "qb-methcar:q-5",
					args = {
						message = "Eveeet, şimdi her şeyin içine sıçtın!"
					}
				}
			},
		})
	end
	--
	--   DONE
	--	
	if progress > 99 and progress < 101 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Pişirme bitti 🎉",
				txt = "" .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Ödülünü topla!",
				params = {
					event = "qb-methcar:done",
					args = {
						message = "Kısa günün kârı."
					}
				}
			}
		})
	end
end)

RegisterNetEvent('qb-methcar:done', function()
	quality = quality + 5
	started = false
	TriggerEvent('qb-methcar:stop')
	TriggerServerEvent('qb-methcar:finish', quality)
	SetPedPropIndex(playerPed, 1, 0, 0, true)
end)

-----THREADS------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)
		if started == true then
			if pause == false and IsPedInAnyVehicle(playerPed) then
				Citizen.Wait(250)
				progress = progress +  1
				quality = quality + 1
				QBCore.Functions.Notify('Meth üretimi: ' .. progress .. '%')
				TriggerEvent('qb-methcar:proses')
				Citizen.Wait(2000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if IsPedInAnyVehicle((PlayerPedId())) then
		else
			if started then
				playerPed = (PlayerPedId())
				CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
				pause = true
				started = false
				TriggerEvent('qb-methcar:stop')
				SetPedPropIndex(playerPed, 1, 0, 0, true)
				FreezeEntityPosition(CurrentVehicle, false)
			end
		end
	end
end)





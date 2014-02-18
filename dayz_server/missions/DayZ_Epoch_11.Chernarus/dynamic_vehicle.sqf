private["_multiplier"];

_multiplier = 5;

AllowedVehiclesList = [
["AH6X_DZ",2 * _multiplier],
["AN2_DZ",2 * _multiplier],
["ArmoredSUV_PMC_DZE",1 * _multiplier],
["ATV_CZ_EP1",2 * _multiplier],
["ATV_US_EP1",2 * _multiplier],
["C130J_US_EP1",1 * _multiplier],
["car_hatchback",2 * _multiplier],
["car_sedan",2 * _multiplier],
["CH_47F_EP1_DZE",1 * _multiplier],
["CSJ_GyroC",2 * _multiplier],
["CSJ_GyroCover",2 * _multiplier],
["CSJ_GyroP",2 * _multiplier],
["datsun1_civil_1_open",2 * _multiplier],
["datsun1_civil_2_covered",2 * _multiplier],
["datsun1_civil_3_open",2 * _multiplier],
["Fishing_Boat",2 * _multiplier],
["GAZ_Vodnik_DZE",1 * _multiplier],
["GAZ_Vodnik_MedEvac",1 * _multiplier],
["GLT_M300_LT",2 * _multiplier],
["GLT_M300_ST",2 * _multiplier],
["GNT_C185",1 * _multiplier],
["GNT_C185C",1 * _multiplier],
["GNT_C185R",1 * _multiplier],
["GNT_C185U",1 * _multiplier],
["hilux1_civil_1_open",2 * _multiplier],
["hilux1_civil_2_covered",2 * _multiplier],
["hilux1_civil_3_open_EP1",2 * _multiplier],
["HMMWV_Ambulance",1 * _multiplier],
["HMMWV_Ambulance_CZ_DES_EP1",1 * _multiplier],
["HMMWV_DES_EP1",2 * _multiplier],
["HMMWV_DZ",2 * _multiplier],
["HMMWV_M1035_DES_EP1",1 * _multiplier],
["HMMWV_M1151_M2_CZ_DES_EP1_DZE",1 * _multiplier],
["HMMWV_M998A2_SOV_DES_EP1_DZE",1 * _multiplier],
["Ikarus",2 * _multiplier],
["Ikarus_TK_CIV_EP1",2 * _multiplier],
["JetSkiYanahui_Case_Blue",1 * _multiplier],
["JetSkiYanahui_Case_Green",1 * _multiplier],
["JetSkiYanahui_Case_Red",1 * _multiplier],
["JetSkiYanahui_Case_Yellow",1 * _multiplier],
["Kamaz",2 * _multiplier],
["KamazRefuel_DZ",1 * _multiplier],
["Lada1",2 * _multiplier],
["Lada1_TK_CIV_EP1",2 * _multiplier],
["Lada2",2 * _multiplier],
["Lada2_TK_CIV_EP1",2 * _multiplier],
["LadaLM",2 * _multiplier],
["LandRover_CZ_EP1",2 * _multiplier],
["LandRover_MG_TK_EP1_DZE",1 * _multiplier],
["LandRover_Special_CZ_EP1_DZE",1 * _multiplier],
["LandRover_TK_CIV_EP1",2 * _multiplier],
["M1030_US_DES_EP1",2 * _multiplier],
["MH6J_DZ",2 * _multiplier],
["Mi17_Civilian_DZ",2 * _multiplier],
["Mi17_DZE",2 * _multiplier],
["MMT_Civ",11 * _multiplier],
["MtvrRefuel_DES_EP1_DZ",1 * _multiplier],
["MTVR_DES_EP1",2 * _multiplier],
["MV22_DZ",1 * _multiplier],
["Offroad_DSHKM_Gue_DZE",2 * _multiplier],
["Old_bike_TK_INS_EP1",2 * _multiplier],
["Old_moto_TK_Civ_EP1",2 * _multiplier],
["PBX",2 * _multiplier],
["Pickup_PK_GUE_DZE",2 * _multiplier],
["Pickup_PK_INS_DZE",2 * _multiplier],
["Pickup_PK_TK_GUE_EP1_DZE",2 * _multiplier],
["RHIB",2 * _multiplier],
["S1203_ambulance_EP1",2 * _multiplier],
["S1203_TK_CIV_EP1",2 * _multiplier],
["Skoda",2 * _multiplier],
["SkodaBlue",2 * _multiplier],
["SkodaGreen",2 * _multiplier],
["SkodaRed",2 * _multiplier],
["Smallboat_1",2 * _multiplier],
["Smallboat_2",2 * _multiplier],
["SUV_Blue",1 * _multiplier],
["SUV_Camo",1 * _multiplier],
["SUV_Charcoal",1 * _multiplier],
["SUV_Green",1 * _multiplier],
["SUV_Orange",1 * _multiplier],
["SUV_Pink",1 * _multiplier],
["SUV_Red",1 * _multiplier],
["SUV_Silver",1 * _multiplier],
["SUV_TK_CIV_EP1",1 * _multiplier],
["SUV_White",1 * _multiplier],
["SUV_Yellow",1 * _multiplier],
["tractor",2 * _multiplier],
["TT650_Civ",2 * _multiplier],
["TT650_Ins",2 * _multiplier],
["TT650_TK_CIV_EP1",2 * _multiplier],
["UAZ_CDF",2 * _multiplier],
["UAZ_INS",2 * _multiplier],
["UAZ_MG_TK_EP1_DZE",2 * _multiplier],
["UAZ_RU",2 * _multiplier],
["UAZ_Unarmed_TK_CIV_EP1",2 * _multiplier],
["UAZ_Unarmed_TK_EP1",2 * _multiplier],
["UAZ_Unarmed_UN_EP1",2 * _multiplier],
["UH1H_DZE",1 * _multiplier],
["UH1Y_DZE",1 * _multiplier],
["UH60M_EP1_DZE",1 * _multiplier],
["UralRefuel_TK_EP1_DZ",1 * _multiplier],
["Ural_CDF",2 * _multiplier],
["Ural_TK_CIV_EP1",2 * _multiplier],
["Ural_UN_EP1",2 * _multiplier],
["V3S_Open_TK_CIV_EP1",2 * _multiplier],
["V3S_Open_TK_EP1",2 * _multiplier],
["V3S_Refuel_TK_GUE_EP1_DZ",1 * _multiplier],
["VolhaLimo_TK_CIV_EP1",2 * _multiplier],
["Volha_1_TK_CIV_EP1",2 * _multiplier],
["Volha_2_TK_CIV_EP1",2 * _multiplier],
["VWGolf",2 * _multiplier],
["Zodiac",2 * _multiplier]
];
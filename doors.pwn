stock CreateDynamicDoor(doorid)
{
	if(IsValidDynamicPickup(DDoorsInfo[doorid][ddPickupID])) DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID]);
	if(IsValidDynamicPickup(DDoorsInfo[doorid][ddPickupID_int])) DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID_int]);
	if(IsValidDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID]);
	if(IsValidDynamicArea(DDoorsInfo[doorid][ddAreaID])) DestroyDynamicArea(DDoorsInfo[doorid][ddAreaID]);
	if(IsValidDynamicArea(DDoorsInfo[doorid][ddAreaID_int])) DestroyDynamicArea(DDoorsInfo[doorid][ddAreaID_int]);
	if(DDoorsInfo[doorid][ddExteriorX] == 0.0) return 1;
	new string[128];
	format(string, sizeof(string), "%s", DDoorsInfo[doorid][ddDescription]);

	switch(DDoorsInfo[doorid][ddColor])
	{
	    case -1:{ /* Disable 3d Textdraw */ }
	    case 1:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWWHITE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 2:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWPINK, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 3:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWRED, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 4:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWBROWN, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 5:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWGRAY, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 6:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWOLIVE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 7:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWPURPLE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 8:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWORANGE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 9:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWAZURE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 10:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWGREEN, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 11:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWBLUE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 12:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWBLACK, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		default:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	}

	switch(DDoorsInfo[doorid][ddPickupModel])
	{
	    case -1: { /* Disable Pickup */ }
		case 1:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1210, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 2:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1212, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 3:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1239, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 4:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1240, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 5:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1241, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 6:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1242, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 7:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1247, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 8:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1248, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 9:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1252, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 10:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1253, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 11:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1254, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 12:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1313, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 13:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1272, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 14:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1273, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 15:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1274, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 16:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1275, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 17:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1276, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 18:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1277, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 19:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1279, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 20:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1314, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 21:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1316, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 22:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1317, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 23:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1559, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 24:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1582, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
		case 25:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(2894, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);}
	    default:
	    {
			DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1318, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);
	    }
	}

	DDoorsInfo[doorid][ddPickupID_int] = CreateDynamicPickup(1559, 23, DDoorsInfo[doorid][ddInteriorX], DDoorsInfo[doorid][ddInteriorY], DDoorsInfo[doorid][ddInteriorZ], DDoorsInfo[doorid][ddInteriorVW]);
	DDoorsInfo[doorid][ddAreaID] = CreateDynamicSphere(DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], 2.5, .worldid = DDoorsInfo[doorid][ddExteriorVW], .interiorid = DDoorsInfo[doorid][ddExteriorInt]);
	DDoorsInfo[doorid][ddAreaID_int] = CreateDynamicSphere(DDoorsInfo[doorid][ddInteriorX], DDoorsInfo[doorid][ddInteriorY], DDoorsInfo[doorid][ddInteriorZ], 2.5, .worldid = DDoorsInfo[doorid][ddInteriorVW], .interiorid = DDoorsInfo[doorid][ddInteriorInt]);

	Streamer_SetIntData(STREAMER_TYPE_AREA, DDoorsInfo[doorid][ddAreaID], E_STREAMER_EXTRA_ID, doorid);
	Streamer_SetIntData(STREAMER_TYPE_AREA, DDoorsInfo[doorid][ddAreaID_int], E_STREAMER_EXTRA_ID, doorid);
	return 1;
}

stock SaveDynamicDoor(doorid)
{
	new string[1024];

	mysql_format(g_SQL, string, sizeof(string), "UPDATE `ddoors` SET \
		`Description`='%e', \
		`CustomInterior`=%d, \
		`ExteriorVW`=%d, \
		`ExteriorInt`=%d, \
		`InteriorVW`=%d, \
		`InteriorInt`=%d, \
		`ExteriorX`=%f, \
		`ExteriorY`=%f, \
		`ExteriorZ`=%f, \
		`ExteriorA`=%f, \
		`InteriorX`=%f, \
		`InteriorY`=%f, \
		`InteriorZ`=%f, \
		`InteriorA`=%f,",
		DDoorsInfo[doorid][ddDescription],
		DDoorsInfo[doorid][ddCustomInterior],
		DDoorsInfo[doorid][ddExteriorVW],
		DDoorsInfo[doorid][ddExteriorInt],
		DDoorsInfo[doorid][ddInteriorVW],
		DDoorsInfo[doorid][ddInteriorInt],
		DDoorsInfo[doorid][ddExteriorX],
		DDoorsInfo[doorid][ddExteriorY],
		DDoorsInfo[doorid][ddExteriorZ],
		DDoorsInfo[doorid][ddExteriorA],
		DDoorsInfo[doorid][ddInteriorX],
		DDoorsInfo[doorid][ddInteriorY],
		DDoorsInfo[doorid][ddInteriorZ],
		DDoorsInfo[doorid][ddInteriorA]
	);

	mysql_format(g_SQL, string, sizeof(string), "%s \
		`CustomExterior`=%d, \
		`VIP`=%d, \
		`Admin`=%d, \
		`VehicleAble`=%d, \
		`Color`=%d, \
		`PickupModel`=%d \
		WHERE `id`=%d",
		string,
		DDoorsInfo[doorid][ddCustomExterior],
		DDoorsInfo[doorid][ddVIP],
		DDoorsInfo[doorid][ddAdmin],
		DDoorsInfo[doorid][ddVehicleAble],
		DDoorsInfo[doorid][ddColor],
		DDoorsInfo[doorid][ddPickupModel],
		doorid+1
	); // Array starts from zero, MySQL starts at 1 (this is why we are adding one).
	mysql_tquery(g_SQL, string);
	
}

stock LoadDynamicDoor(doorid)
{
	new string[128];
	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM `ddoors` WHERE `id`=%d", doorid+1); // Array starts at zero, MySQL starts at 1.
	mysql_tquery(g_SQL, string, "OnLoadDynamicDoor", "i", doorid);
}

stock LoadDynamicDoors()
{
	printf("[LoadDynamicDoors] Loading data from database...");
	mysql_tquery(g_SQL, "SELECT * FROM `ddoors`", "OnLoadDynamicDoors", "");
}

forward OnLoadDynamicDoor(index);
public OnLoadDynamicDoor(index)
{
	
	new rows;
	cache_get_row_count(rows);

	for(new row; row < rows; row++)
	{
		cache_get_value_name_int(row, "id", DDoorsInfo[index][ddSQLId]);
		cache_get_value_name(row, "Description", DDoorsInfo[index][ddDescription], 128);
		cache_get_value_name_int(row, "CustomExterior", DDoorsInfo[index][ddCustomExterior]);
		cache_get_value_name_int(row, "CustomInterior", DDoorsInfo[index][ddCustomInterior]);
		cache_get_value_name_int(row, "ExteriorVW", DDoorsInfo[index][ddExteriorVW]); 
		cache_get_value_name_int(row, "ExteriorInt", DDoorsInfo[index][ddExteriorInt]); 
		cache_get_value_name_int(row, "InteriorVW", DDoorsInfo[index][ddInteriorVW]); 
		cache_get_value_name_int(row, "InteriorInt", DDoorsInfo[index][ddInteriorInt]);
		cache_get_value_name_float(row, "ExteriorX", DDoorsInfo[index][ddExteriorX]);
		cache_get_value_name_float(row, "ExteriorY", DDoorsInfo[index][ddExteriorY]);
		cache_get_value_name_float(row, "ExteriorZ", DDoorsInfo[index][ddExteriorZ]);
		cache_get_value_name_float(row, "ExteriorA", DDoorsInfo[index][ddExteriorA]);
		cache_get_value_name_float(row, "InteriorX", DDoorsInfo[index][ddInteriorX]);
		cache_get_value_name_float(row, "InteriorY", DDoorsInfo[index][ddInteriorY]);
		cache_get_value_name_float(row, "InteriorZ", DDoorsInfo[index][ddInteriorZ]);
		cache_get_value_name_float(row, "InteriorA", DDoorsInfo[index][ddInteriorA]);
		cache_get_value_name_int(row, "VIP", DDoorsInfo[index][ddVIP]); 
		cache_get_value_name_int(row, "Admin", DDoorsInfo[index][ddAdmin]); 
		cache_get_value_name_int(row, "VehicleAble", DDoorsInfo[index][ddVehicleAble]); 
		cache_get_value_name_int(row, "Color", DDoorsInfo[index][ddColor]); 
		cache_get_value_name_int(row, "PickupModel", DDoorsInfo[index][ddPickupModel]); 
		if(DDoorsInfo[index][ddExteriorX] != 0.0) CreateDynamicDoor(index);
	}
	
	return 1;
}


forward OnLoadDynamicDoors();
public OnLoadDynamicDoors()
{
	new i, rows;
	cache_get_row_count(rows);

	
	while(i < rows)
	{
		LoadDynamicDoor(i);
		i++;
	}
	
	if(i > 0) printf("[Dynamic Doors] %d doors rehashed/loaded.", i);
	else printf("[Dynamic Doors] Failed to load any doors.");
	return 1;
}

stock SaveDynamicDoors()
{
	for(new i = 0; i < MAX_DDOORS; i++)
	{
		SaveDynamicDoor(i);
	}
	return 1;
}

stock RehashDynamicDoor(doorid)
{
	DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID]);
	if(IsValidDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID]);
	DDoorsInfo[doorid][ddSQLId] = -1;
	DDoorsInfo[doorid][ddCustomInterior] = 0;
	DDoorsInfo[doorid][ddExteriorVW] = 0;
	DDoorsInfo[doorid][ddExteriorInt] = 0;
	DDoorsInfo[doorid][ddInteriorVW] = 0;
	DDoorsInfo[doorid][ddInteriorInt] = 0;
	DDoorsInfo[doorid][ddExteriorX] = 0.0;
	DDoorsInfo[doorid][ddExteriorY] = 0.0;
	DDoorsInfo[doorid][ddExteriorZ] = 0.0;
	DDoorsInfo[doorid][ddExteriorA] = 0.0;
	DDoorsInfo[doorid][ddInteriorX] = 0.0;
	DDoorsInfo[doorid][ddInteriorY] = 0.0;
	DDoorsInfo[doorid][ddInteriorZ] = 0.0;
	DDoorsInfo[doorid][ddInteriorA] = 0.0;
	DDoorsInfo[doorid][ddCustomExterior] = 0;
	DDoorsInfo[doorid][ddVIP] = 0;
	DDoorsInfo[doorid][ddAdmin] = 0;
	DDoorsInfo[doorid][ddVehicleAble] = 0;
	DDoorsInfo[doorid][ddColor] = 0;
	DDoorsInfo[doorid][ddPickupModel] = 0;
	LoadDynamicDoor(doorid);
}

stock RehashDynamicDoors()
{
	printf("[RehashDynamicDoors] Deleting dynamic doors from server...");
	for(new i = 0; i < MAX_DDOORS; i++)
	{
		RehashDynamicDoor(i);
	}
}

CMD:goindoor(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] >= 4)
	{
		new string[48], doornum;
		if(sscanf(params, "d", doornum)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /goindoor [doornumber]");

		if(doornum <= 0 || doornum >= MAX_DDOORS)
		{
			format(string, sizeof(string), "Door ID must be between 1 and %d.", MAX_DDOORS - 1);
			return SendClientMessage(playerid, COLOR_GREY, string);
		}

		SetPlayerInterior(playerid,DDoorsInfo[doornum][ddInteriorInt]);
		SetPlayerPos(playerid,DDoorsInfo[doornum][ddInteriorX],DDoorsInfo[doornum][ddInteriorY],DDoorsInfo[doornum][ddInteriorZ]);
		SetPlayerFacingAngle(playerid,DDoorsInfo[doornum][ddInteriorA]);
		AccountInfo[playerid][pInterior] = DDoorsInfo[doornum][ddInteriorInt];
		AccountInfo[playerid][pVW] = DDoorsInfo[doornum][ddInteriorVW];
		SetPlayerVirtualWorld(playerid, DDoorsInfo[doornum][ddInteriorVW]);
		if(DDoorsInfo[doornum][ddCustomInterior]) Player_StreamPrep(playerid, DDoorsInfo[doornum][ddInteriorX],DDoorsInfo[doornum][ddInteriorY],DDoorsInfo[doornum][ddInteriorZ], FREEZE_TIME);
	}
	return 1;
}

CMD:gotodoor(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] >= 4)
	{
		new string[48], doornum;
		if(sscanf(params, "d", doornum)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gotodoor [doornumber]");

		if(doornum <= 0 || doornum >= MAX_DDOORS)
		{
			format(string, sizeof(string), "Door ID must be between 1 and %d.", MAX_DDOORS - 1);
			return SendClientMessage(playerid, COLOR_GREY, string);
		}

		SetPlayerInterior(playerid,DDoorsInfo[doornum][ddExteriorInt]);
		SetPlayerPos(playerid,DDoorsInfo[doornum][ddExteriorX],DDoorsInfo[doornum][ddExteriorY],DDoorsInfo[doornum][ddExteriorZ]);
		SetPlayerFacingAngle(playerid,DDoorsInfo[doornum][ddExteriorA]);
		AccountInfo[playerid][pInterior] = DDoorsInfo[doornum][ddExteriorInt];
		SetPlayerVirtualWorld(playerid, DDoorsInfo[doornum][ddExteriorVW]);
		AccountInfo[playerid][pVW] = DDoorsInfo[doornum][ddExteriorVW];
		if(DDoorsInfo[doornum][ddCustomExterior]) Player_StreamPrep(playerid, DDoorsInfo[doornum][ddExteriorX],DDoorsInfo[doornum][ddExteriorY],DDoorsInfo[doornum][ddExteriorZ], FREEZE_TIME);
	}
	return 1;
}

CMD:ddstatus(playerid, params[])
{
	new doorid;
	if(sscanf(params, "i", doorid))
	{
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /ddstatus [doorid]");
		return 1;
	}
	if (AccountInfo[playerid][pAdmin] >= 4)
	{
		new string[128];
		format(string,sizeof(string),"|___________ Door Status (ID: %d · Name: %s) ___________|", doorid, DDoorsInfo[doorid][ddDescription]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		format(string, sizeof(string), "(Ext) X: %f | Y: %f | Z: %f | (Int) X: %f | Y: %f | Z: %f", DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddInteriorX], DDoorsInfo[doorid][ddInteriorY], DDoorsInfo[doorid][ddInteriorZ]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Pickup ID: %d | Custom Int: %d | Custom Ext: %d | Exterior VW: %d | Exterior Int: %d | Interior VW: %d | Interior Int: %d", DDoorsInfo[doorid][ddPickupID], DDoorsInfo[doorid][ddCustomInterior], DDoorsInfo[doorid][ddCustomExterior], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], DDoorsInfo[doorid][ddInteriorVW], DDoorsInfo[doorid][ddInteriorInt]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "VIP: %d | Admin: %d | Vehicle-Able: %d", DDoorsInfo[doorid][ddVIP], DDoorsInfo[doorid][ddAdmin], DDoorsInfo[doorid][ddVehicleAble]);
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	else
	{
		SendClientMessage(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	}
	return 1;
}

CMD:ddnear(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] >= 4)
	{
		new option;
		if(!sscanf(params, "d", option)) 
		{
			new string[64];
			format(string, sizeof(string), "* Listing all dynamic doors within 30 meters of you in VW %d...", option);
			SendClientMessage(playerid, COLOR_RED, string);
			for(new i, szMessage[128]; i < MAX_DDOORS; i++)
			{
				if(strcmp(DDoorsInfo[i][ddDescription], "None", true) != 0)
				{
					if(option == -1)
					{
						if(IsPlayerInRangeOfPoint(playerid, 30, DDoorsInfo[i][ddInteriorX], DDoorsInfo[i][ddInteriorY], DDoorsInfo[i][ddInteriorZ]))
						{
							format(szMessage, sizeof(szMessage), "(Interior) DDoor ID %d | %f from you | Interior: %d", i, GetPlayerDistanceFromPoint(playerid, DDoorsInfo[i][ddInteriorX], DDoorsInfo[i][ddInteriorY], DDoorsInfo[i][ddInteriorZ]), DDoorsInfo[i][ddInteriorInt]);
							SendClientMessage(playerid, COLOR_WHITE, szMessage);
						}
						if(IsPlayerInRangeOfPoint(playerid, 30, DDoorsInfo[i][ddExteriorX], DDoorsInfo[i][ddExteriorY], DDoorsInfo[i][ddExteriorZ]))
						{
							format(szMessage, sizeof(szMessage), "(Exterior) DDoor ID %d | %f from you | Interior: %d", i, GetPlayerDistanceFromPoint(playerid, DDoorsInfo[i][ddExteriorX], DDoorsInfo[i][ddExteriorY], DDoorsInfo[i][ddExteriorZ]), DDoorsInfo[i][ddExteriorInt]);
							SendClientMessage(playerid, COLOR_WHITE, szMessage);
						}
					}
					else
					{
						if(IsPlayerInRangeOfPoint(playerid, 30, DDoorsInfo[i][ddInteriorX], DDoorsInfo[i][ddInteriorY], DDoorsInfo[i][ddInteriorZ]) && DDoorsInfo[i][ddInteriorVW] == option)
						{
							format(szMessage, sizeof(szMessage), "(Interior) DDoor ID %d | %f from you | Interior: %d", i, GetPlayerDistanceFromPoint(playerid, DDoorsInfo[i][ddInteriorX], DDoorsInfo[i][ddInteriorY], DDoorsInfo[i][ddInteriorZ]), DDoorsInfo[i][ddInteriorInt]);
							SendClientMessage(playerid, COLOR_WHITE, szMessage);
						}
						if(IsPlayerInRangeOfPoint(playerid, 30, DDoorsInfo[i][ddExteriorX], DDoorsInfo[i][ddExteriorY], DDoorsInfo[i][ddExteriorZ]) && DDoorsInfo[i][ddExteriorVW] == option)
						{
							format(szMessage, sizeof(szMessage), "(Exterior) DDoor ID %d | %f from you | Interior: %d", i, GetPlayerDistanceFromPoint(playerid, DDoorsInfo[i][ddExteriorX], DDoorsInfo[i][ddExteriorY], DDoorsInfo[i][ddExteriorZ]), DDoorsInfo[i][ddExteriorInt]);
							SendClientMessage(playerid, COLOR_WHITE, szMessage);
						}
					}
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "* Listing all dynamic doors within 30 meters of you...");
			for(new i, szMessage[128]; i < MAX_DDOORS; i++)
			{
				if(strcmp(DDoorsInfo[i][ddDescription], "None", true) != 0)
				{
					if(IsPlayerInRangeOfPoint(playerid, 30, DDoorsInfo[i][ddInteriorX], DDoorsInfo[i][ddInteriorY], DDoorsInfo[i][ddInteriorZ]) && DDoorsInfo[i][ddInteriorVW] == GetPlayerVirtualWorld(playerid))
					{
						format(szMessage, sizeof(szMessage), "(Interior) DDoor ID %d | %f from you | Virtual World: %d | Interior: %d", i, GetPlayerDistanceFromPoint(playerid, DDoorsInfo[i][ddInteriorX], DDoorsInfo[i][ddInteriorY], DDoorsInfo[i][ddInteriorZ]), DDoorsInfo[i][ddInteriorVW], DDoorsInfo[i][ddInteriorInt]);
						SendClientMessage(playerid, COLOR_WHITE, szMessage);
					}
					if(IsPlayerInRangeOfPoint(playerid, 30, DDoorsInfo[i][ddExteriorX], DDoorsInfo[i][ddExteriorY], DDoorsInfo[i][ddExteriorZ]) && DDoorsInfo[i][ddExteriorVW] == GetPlayerVirtualWorld(playerid))
					{
						format(szMessage, sizeof(szMessage), "(Exterior) DDoor ID %d | %f from you | Virtual World: %d | Interior: %d", i, GetPlayerDistanceFromPoint(playerid, DDoorsInfo[i][ddExteriorX], DDoorsInfo[i][ddExteriorY], DDoorsInfo[i][ddExteriorZ]), DDoorsInfo[i][ddExteriorVW], DDoorsInfo[i][ddExteriorInt]);
						SendClientMessage(playerid, COLOR_WHITE, szMessage);
					}
				}
			}
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GRAD2, "You are not authorized to use that command.");
	}
	return 1;
}

CMD:ddnext(playerid, params[])
{
    if(AccountInfo[playerid][pAdmin] >= 4)
	{
		SendClientMessage(playerid, COLOR_RED, "* Listing next available dynamic door...");
		for(new x;x<MAX_DDOORS;x++)
		{
		    if(DDoorsInfo[x][ddExteriorX] == 0.0) // If the door is at blueberry!
		    {
		        new string[128];
		        format(string, sizeof(string), "%d is available to use.", x);
		        SendClientMessage(playerid, COLOR_WHITE, string);
		        break;
			}
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GRAD2, "You are not authorized to use that command.");
		return 1;
	}
	return 1;
}

CMD:ddname(playerid, params[]) {
	if(AccountInfo[playerid][pAdmin] >= 4)
	{
		new
			szName[128],
			iDoorID;

		if(sscanf(params, "ds[128]", iDoorID, szName)) {
			return SendClientMessage(playerid, COLOR_GREY, "USAGE: /ddname [doorid] [name]");
		}
		else if(!(0 <= iDoorID <= MAX_DDOORS)) {
			return SendClientMessage(playerid, COLOR_GREY, "Invalid door specified.");
		}
		else if(strfind(szName, "\r") != -1 || strfind(szName, "\n") != -1) {
			return SendClientMessage(playerid, COLOR_GREY, "Newline characters are forbidden.");
		}
		//strcat((DDoorsInfo[iDoorID][ddDescription][0] = 0, DDoorsInfo[iDoorID][ddDescription]), szName, 128);
		DDoorsInfo[iDoorID][ddDescription] = szName;
		SendClientMessage(playerid, COLOR_WHITE, "You have successfully changed the name of this door.");

		DestroyDynamicPickup(DDoorsInfo[iDoorID][ddPickupID]);
		if(IsValidDynamic3DTextLabel(DDoorsInfo[iDoorID][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[iDoorID][ddTextID]);
		CreateDynamicDoor(iDoorID);
		SaveDynamicDoor(iDoorID);
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You are not authorized to use that command.");
	return 1;
}

CMD:ddedit(playerid, params[])
{
 	if(AccountInfo[playerid][pAdmin] >= 4)
	{
		new string[128], choice[32], doorid, amount;
		if(sscanf(params, "s[32]dD", choice, doorid, amount))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /ddedit [name] [doorid] [amount]");
			SendClientMessage(playerid, COLOR_GREY, "Available names: Exterior, Interior, CustomInterior, CustomExterior, VIP");
			SendClientMessage(playerid, COLOR_GREY, "Admin, VehicleAble, Color, PickupModel, Delete");
			return 1;
		}

		if(doorid >= MAX_DDOORS)
		{
			SendClientMessage( playerid, COLOR_WHITE, "Invalid Door ID!");
			return 1;
		}

		if(strcmp(choice, "interior", true) == 0)
		{
			GetPlayerPos(playerid, DDoorsInfo[doorid][ddInteriorX], DDoorsInfo[doorid][ddInteriorY], DDoorsInfo[doorid][ddInteriorZ]);
			GetPlayerFacingAngle(playerid, DDoorsInfo[doorid][ddInteriorA]);
			DDoorsInfo[doorid][ddInteriorInt] = GetPlayerInterior(playerid);
			DDoorsInfo[doorid][ddInteriorVW] = GetPlayerVirtualWorld(playerid);
			SendClientMessage(playerid, COLOR_WHITE, "You have changed the interior!");
			SaveDynamicDoor(doorid);
			CreateDynamicDoor(doorid);
			return 1;
		}
		else if(strcmp(choice, "custominterior", true) == 0)
		{
			if(DDoorsInfo[doorid][ddCustomInterior] == 0)
			{
				DDoorsInfo[doorid][ddCustomInterior] = 1;
				SendClientMessage(playerid, COLOR_WHITE, "Door set to custom interior!");
			}
			else
			{
				DDoorsInfo[doorid][ddCustomInterior] = 0;
				SendClientMessage(playerid, COLOR_WHITE, "Door set to normal (not custom) interior!");
			}
			SaveDynamicDoor(doorid);
			return 1;
		}
		else if(strcmp(choice, "customexterior", true) == 0)
		{
			if(DDoorsInfo[doorid][ddCustomExterior] == 0)
			{
				DDoorsInfo[doorid][ddCustomExterior] = 1;
				SendClientMessage(playerid, COLOR_WHITE, "Door set to custom exterior!");
			}
			else
			{
				DDoorsInfo[doorid][ddCustomExterior] = 0;
				SendClientMessage(playerid, COLOR_WHITE, "Door set to normal (not custom) exterior!");
			}
			SaveDynamicDoor(doorid);
			CreateDynamicDoor(doorid);
			return 1;
		}
		else if(strcmp(choice, "exterior", true) == 0)
		{
			GetPlayerPos(playerid, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]);
			GetPlayerFacingAngle(playerid, DDoorsInfo[doorid][ddExteriorA]);
			DDoorsInfo[doorid][ddExteriorVW] = GetPlayerVirtualWorld(playerid);
			DDoorsInfo[doorid][ddExteriorInt] = GetPlayerInterior(playerid);
			SendClientMessage(playerid, COLOR_WHITE, "You have changed the exterior!");
			DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID]);
			if(IsValidDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID]);
			SaveDynamicDoor(doorid);
			CreateDynamicDoor(doorid);
		}
		else if(strcmp(choice, "vip", true) == 0)
		{
			DDoorsInfo[doorid][ddVIP] = amount;

			format(string, sizeof(string), "You have changed the VIP Level to %d.", amount);
			SendClientMessage(playerid, COLOR_WHITE, string);

			SaveDynamicDoor(doorid);
			return 1;
		}
		else if(strcmp(choice, "admin", true) == 0)
		{
			DDoorsInfo[doorid][ddAdmin] = amount;

			format(string, sizeof(string), "You have changed the Admin Level to %d.", amount);
			SendClientMessage(playerid, COLOR_WHITE, string);

			SaveDynamicDoor(doorid);
			return 1;
		}
		else if(strcmp(choice, "vehicleable", true) == 0)
		{
			DDoorsInfo[doorid][ddVehicleAble] = amount;

			format(string, sizeof(string), "You have changed the VehicleAble to %d.", amount);
			SendClientMessage(playerid, COLOR_WHITE, string);

			SaveDynamicDoor(doorid);
			return 1;
		}
		else if(strcmp(choice, "color", true) == 0)
		{
			DDoorsInfo[doorid][ddColor] = amount;

			format(string, sizeof(string), "You have changed the Color to %d.", amount);
			SendClientMessage(playerid, COLOR_WHITE, string);

			DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID]);
			if(IsValidDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID]);

			SaveDynamicDoor(doorid);
			CreateDynamicDoor(doorid);
			return 1;
		}
		else if(strcmp(choice, "pickupmodel", true) == 0)
		{
			DDoorsInfo[doorid][ddPickupModel] = amount;

			format(string, sizeof(string), "You have changed the PickupModel to %d.", amount);
			SendClientMessage(playerid, COLOR_WHITE, string);

			DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID]);
			if(IsValidDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID]);

			SaveDynamicDoor(doorid);
			CreateDynamicDoor(doorid);
			return 1;
		}
		else if(strcmp(choice, "delete", true) == 0)
		{
			if(strcmp(DDoorsInfo[doorid][ddDescription], "None", true) == 0) {
				format(string, sizeof(string), "DoorID %d does not exist.", doorid);
				SendClientMessage(playerid, COLOR_WHITE, string);
				return 1;
			}
			if(IsValidDynamicPickup(DDoorsInfo[doorid][ddPickupID])) DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID]);
			if(IsValidDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID]);
			DDoorsInfo[doorid][ddDescription] = 0;
			DDoorsInfo[doorid][ddCustomInterior] = 0;
			DDoorsInfo[doorid][ddExteriorVW] = 0;
			DDoorsInfo[doorid][ddExteriorInt] = 0;
			DDoorsInfo[doorid][ddInteriorVW] = 0;
			DDoorsInfo[doorid][ddInteriorInt] = 0;
			DDoorsInfo[doorid][ddExteriorX] = 0;
			DDoorsInfo[doorid][ddExteriorY] = 0;
			DDoorsInfo[doorid][ddExteriorZ] = 0;
			DDoorsInfo[doorid][ddExteriorA] = 0;
			DDoorsInfo[doorid][ddInteriorX] = 0;
			DDoorsInfo[doorid][ddInteriorY] = 0;
			DDoorsInfo[doorid][ddInteriorZ] = 0;
			DDoorsInfo[doorid][ddInteriorA] = 0;
			DDoorsInfo[doorid][ddCustomExterior] = 0;
			DDoorsInfo[doorid][ddVIP] = 0;
			DDoorsInfo[doorid][ddAdmin] = 0;
			DDoorsInfo[doorid][ddVehicleAble] = 0;
			DDoorsInfo[doorid][ddColor] = 0;
			SaveDynamicDoor(doorid);
			format(string, sizeof(string), "You have deleted DoorID %d.", doorid);
			SendClientMessage(playerid, COLOR_WHITE, string);
			return 1;
		}
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You are not authorized to use that command.");
	return 1;
}

CMD:ddmove(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this command.");
	new doorid, choice[16];
	if(sscanf(params, "s[16]dudd", choice, doorid))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ddmove <Choice> <DoorID>");
		SendClientMessage(playerid, COLOR_GREY, "Choice: Exterior | Interior");
		return 1;
	}
	if(doorid >= MAX_DDOORS) return SendClientMessage( playerid, COLOR_WHITE, "Invalid Door ID!");
	if(strcmp(choice, "interior", true) == 0)
	{
		GetPlayerPos(playerid, DDoorsInfo[doorid][ddInteriorX], DDoorsInfo[doorid][ddInteriorY], DDoorsInfo[doorid][ddInteriorZ]);
		GetPlayerFacingAngle(playerid, DDoorsInfo[doorid][ddInteriorA]);
		DDoorsInfo[doorid][ddInteriorInt] = GetPlayerInterior(playerid);
		DDoorsInfo[doorid][ddInteriorVW] = GetPlayerVirtualWorld(playerid);
		SendClientMessage(playerid, COLOR_WHITE, "You have changed the interior!");
		SaveDynamicDoor(doorid);
	}
	else if(strcmp(choice, "exterior", true) == 0)
	{
		GetPlayerPos(playerid, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]);
		GetPlayerFacingAngle(playerid, DDoorsInfo[doorid][ddExteriorA]);
		DDoorsInfo[doorid][ddExteriorVW] = GetPlayerVirtualWorld(playerid);
		DDoorsInfo[doorid][ddExteriorInt] = GetPlayerInterior(playerid);
		SendClientMessage(playerid, COLOR_WHITE, "You have changed the exterior!");
		DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID]);
		if(IsValidDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID]);
		SaveDynamicDoor(doorid);
	}
	CreateDynamicDoor(doorid);

	return 1;
}

forward DeleteDynamicDoor(doorid, adminid);
public DeleteDynamicDoor(doorid, adminid)
{
	format(DDoorsInfo[doorid][ddDescription], 128, "None");
	if(IsValidDynamicPickup(DDoorsInfo[doorid][ddPickupID])) DestroyDynamicPickup(DDoorsInfo[doorid][ddPickupID]), DDoorsInfo[doorid][ddPickupID] = -1;
	if(IsValidDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID])) DestroyDynamic3DTextLabel(DDoorsInfo[doorid][ddTextID]), DDoorsInfo[doorid][ddTextID] = Text3D:-1;
	DDoorsInfo[doorid][ddCustomInterior] = 0;
	DDoorsInfo[doorid][ddExteriorVW] = 0;
	DDoorsInfo[doorid][ddExteriorInt] = 0;
	DDoorsInfo[doorid][ddInteriorVW] = 0;
	DDoorsInfo[doorid][ddInteriorInt] = 0;
	DDoorsInfo[doorid][ddExteriorX] = 0.0;
	DDoorsInfo[doorid][ddExteriorY] = 0.0;
	DDoorsInfo[doorid][ddExteriorZ] = 0.0;
	DDoorsInfo[doorid][ddExteriorA] = 0.0;
	DDoorsInfo[doorid][ddInteriorX] = 0.0;
	DDoorsInfo[doorid][ddInteriorY] = 0.0;
	DDoorsInfo[doorid][ddInteriorZ] = 0.0;
	DDoorsInfo[doorid][ddInteriorA] = 0.0;
	DDoorsInfo[doorid][ddCustomExterior] = 0;
	DDoorsInfo[doorid][ddVIP] = 0;
	DDoorsInfo[doorid][ddAdmin] = 0;
	DDoorsInfo[doorid][ddVehicleAble] = 0;
	DDoorsInfo[doorid][ddColor] = 0;
	DDoorsInfo[doorid][ddPickupModel] = 0;
	SaveDynamicDoor(doorid);
	return 1;
}

/*Types of Weapon
Noob Stuff (Under Level 19)
T1 (Level 20 to 29)
T2 (Level 30 to 40)

PVP Weapon
Noob Stuff (Under Level 20)
T1 (Level 20 to 30)
T2 (Level 30 to 40)*/

#define     MAX_WEAPONS       	1000

enum E_WEAPON_INFO
{
	WeaponID,
	WeaponName[64],
	WeaponClass,
	WeaponType,
	WeaponLevel,
	WeaponBinding,
	WeaponReqLevel,
	WeaponValue,
	WeaponIsSetPart,
	WeaponSet,
	WeaponDescription[124],
	WeaponQuality,
	WeaponCritStrike,
	WeaponPen,
	WeaponDefense,
	WeaponLifeSteal,
	WeaponMaxHP,
	WeaponPower,
	WeaponRecovery,
	WeaponDeflection,
	WeaponRegen,
	WeaponMovement,
	WeaponTenacity,
	WeaponLifeSpan,
	WeaponModel
};
new WeaponInfo[MAX_WEAPONS][E_WEAPON_INFO];

/*switch(AccountInfo[playerid][pLevel])
{
	case 1 .. 19
	{
		SendClientMessage(playerid, "You may use Basic Level Weapon");
	}
	case 20 .. 29
	{
		SendClientMessage(playerid, "You may use Tier One Weapon");
	}
	case 30 .. 40
	{
		SendClientMessage(playerid, "You may use Tier Two Weapon");
	}
}

//PVE Weapon
if(AccountInfo[playerid][pWeaponLevel] >= 1 && AccountInfo[playerid][pWeaponLevel] <= 19 && WeaponInfo[pWeaponClass] = 1)
{
	SendClientMessage(playerid, "You've got weapon for levels 1 to 20!");
	SendClientMessage(playerid, "This type of Gear is Considered basic level Weapon.");
}
else if(AccountInfo[playerid][pWeaponLevel] >= 20 && AccountInfo[playerid][pWeaponLevel] <= 29 && WeaponInfo[pWeaponClass] = 1)
{
	SendClientMessage(playerid, "You've got weapon for levels 20 to 29!");
	SendClientMessage(playerid, "This type of Gear is Considered Teir 1 Weapon.");
}
else if(AccountInfo[playerid][pWeaponLevel] >= 30 && AccountInfo[playerid][pWeaponLevel] <= 40 && WeaponInfo[pWeaponClass] = 1)
{
	SendClientMessage(playerid, "You've got weapon for levels 30 to 40!");
	SendClientMessage(playerid, "This type of Gear is Considered Teir 2 Weapon. This is the max level weapon.");
}

//PVP Weapon
if(AccountInfo[playerid][pWeaponLevel] >= 1 && AccountInfo[playerid][pWeaponLevel] <= 19 && WeaponInfo[pWeaponClass] = 2)
{
	SendClientMessage(playerid, "You've got weapon for levels 1 to 20!");
	SendClientMessage(playerid, "This type of Gear is Considered basic level Weapon.");
}
else if(AccountInfo[playerid][pWeaponLevel] >= 20 && AccountInfo[playerid][pWeaponLevel] <= 29 && WeaponInfo[pWeaponClass] = 2)
{
	SendClientMessage(playerid, "You've got weapon for levels 20 to 29!");
	SendClientMessage(playerid, "This type of Gear is Considered Teir 1 Weapon.");
}
else if(AccountInfo[playerid][pWeaponLevel] >= 30 && AccountInfo[playerid][pWeaponLevel] <= 40 && WeaponInfo[pWeaponClass] = 2)
{
	SendClientMessage(playerid, "You've got weapon for levels 30 to 40!");
	SendClientMessage(playerid, "This type of Gear is Considered Teir 2 Weapon. This is the max level weapon.");
}*/

stock SaveWeapon(weaponid)
{
	new string[1024];

	mysql_format(g_SQL, string, sizeof(string), "UPDATE `weaponsystem` SET \
		`name`='%e', \
		`class`=%d, \
		`type`='%d', \
		`level`=%d, \
		`binding`=%d, \
		`reqlevel`=%d, \
		`value`=%d, \
		`issetpart`=%d, \
		`wepset`=%d, \
		`description`=%e, \
		`quality`=%d, \
		`critstrike`=%d, \
		`weppen`=%d, \
		`defense`=%d, \
		`lifesteal`=%d, \
		`maxhp`=%d,",
		WeaponInfo[weaponid][WeaponName],
		WeaponInfo[weaponid][WeaponClass],
		WeaponInfo[weaponid][WeaponType],
		WeaponInfo[weaponid][WeaponLevel],
		WeaponInfo[weaponid][WeaponBinding],
		WeaponInfo[weaponid][WeaponReqLevel],
		WeaponInfo[weaponid][WeaponValue],
		WeaponInfo[weaponid][WeaponIsSetPart],
		WeaponInfo[weaponid][WeaponSet],
		WeaponInfo[weaponid][WeaponDescription],
		WeaponInfo[weaponid][WeaponQuality],
		WeaponInfo[weaponid][WeaponCritStrike],
		WeaponInfo[weaponid][WeaponPen],
		WeaponInfo[weaponid][WeaponDefense],
		WeaponInfo[weaponid][WeaponLifeSteal],
		WeaponInfo[weaponid][WeaponMaxHP]
	);

	mysql_format(g_SQL, string, sizeof(string), "%s \
		`power`=%d, \
		`recovery`=%d, \
		`deflection`=%d, \
		`regen`=%d, \
		`move`=%d, \
		`tenacity`=%d, \
		`lifespan`=%d, \
		`modelid`=%d, \
		WHERE `id`=%d",
		string,
		WeaponInfo[weaponid][WeaponPower],
		WeaponInfo[weaponid][WeaponRecovery],
		WeaponInfo[weaponid][WeaponDeflection],
		WeaponInfo[weaponid][WeaponRegen],
		WeaponInfo[weaponid][WeaponMovement],
		WeaponInfo[weaponid][WeaponTenacity],
		WeaponInfo[weaponid][WeaponLifeSpan],
		WeaponInfo[weaponid][WeaponModel],
		WeaponInfo[weaponid][WeaponID],
		weaponid+1
	);

	mysql_tquery(g_SQL, string);
}

stock LoadWeapon(weaponid)
{
	new string[128];
	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM `weaponsystem` WHERE `id`=%d", weaponid+1); // Array starts at zero, MySQL starts at 1.
	mysql_tquery(g_SQL, string, "OnLoadWeapon", "i", weaponid);
}

stock LoadWeapons()
{
	printf("[Weapon System]: Loading weapon data from the database...");
	mysql_tquery(g_SQL, "SELECT * FROM `weaponsystem`", "OnLoadWeapons", "");
}

forward OnLoadWeapon(index);
public OnLoadWeapon(index)
{
	new rows;
	cache_get_row_count(rows);

	for(new row; row < rows; row++)
	{
		cache_get_value_name_int(row, "id", WeaponInfo[index][WeaponID]);
		cache_get_value_name(row, "name", WeaponInfo[index][WeaponName], 128);
		cache_get_value_name_int(row, "class", WeaponInfo[index][WeaponClass]);
		cache_get_value_name_int(row, "type", WeaponInfo[index][WeaponType]);
		cache_get_value_name_int(row, "level", WeaponInfo[index][WeaponLevel]);
		cache_get_value_name_int(row, "binding", WeaponInfo[index][WeaponBinding]);
		cache_get_value_name_int(row, "reqlevel", WeaponInfo[index][WeaponReqLevel]);
		cache_get_value_name_int(row, "value", WeaponInfo[index][WeaponValue]);
		cache_get_value_name_int(row, "issetpart", WeaponInfo[index][WeaponIsSetPart]);
		cache_get_value_name_int(row, "wepset", WeaponInfo[index][WeaponSet]);
		cache_get_value_name(row, "description", WeaponInfo[index][WeaponDescription], 256);
		cache_get_value_name_int(row, "quality", WeaponInfo[index][WeaponQuality]);
		cache_get_value_name_int(row, "critstrike", WeaponInfo[index][WeaponCritStrike]);//
		cache_get_value_name_int(row, "weppen", WeaponInfo[index][WeaponPen]);//
		cache_get_value_name_int(row, "defense", WeaponInfo[index][WeaponDefense]);//
		cache_get_value_name_int(row, "lifesteal", WeaponInfo[index][WeaponLifeSteal]);//
		cache_get_value_name_int(row, "maxhp", WeaponInfo[index][WeaponMaxHP]);//
		cache_get_value_name_int(row, "power", WeaponInfo[index][WeaponPower]);//
		cache_get_value_name_int(row, "recovery", WeaponInfo[index][WeaponRecovery]);//
		cache_get_value_name_int(row, "deflection", WeaponInfo[index][WeaponDeflection]);
		cache_get_value_name_int(row, "regen", WeaponInfo[index][WeaponRegen]);
		cache_get_value_name_int(row, "move", WeaponInfo[index][WeaponMovement]);
		cache_get_value_name_int(row, "tenacity", WeaponInfo[index][WeaponTenacity]);
		cache_get_value_name_int(row, "lifespan", WeaponInfo[index][WeaponLifeSpan]);
		cache_get_value_name_int(row, "modelid", WeaponInfo[index][WeaponModel]);
	}
	return 1;
}


forward OnLoadWeapons();
public OnLoadWeapons()
{
	new i, rows;
	cache_get_row_count(rows);

	while(i < rows)
	{
		LoadWeapon(i);
		i++;
	}
	if(i > 0) printf("[Weapon System]: A total of %d weapons have been Rehashed or Loaded.", i);
	else printf("[Weapon System]: Failed to load any Weapon Data.");
	return 1;
}

stock SaveWeapons()
{
	for(new i = 0; i < MAX_WEAPONS; i++)
	{
		SaveWeapon(i);
	}
	return 1;
}

CMD:weapondata(playerid, params[])
{
	if (AccountInfo[playerid][pAdmin] >= 4)
	{
		new weaponid;
		if(sscanf(params, "i", weaponid))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /weapondata [weaponid]");
			return 1;
		}
		new string[128];
		format(string,sizeof(string),"|___________ Weapon Data (ID: %d - Name: %s) ___________|", weaponid, WeaponInfo[weaponid][WeaponName]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		format(string, sizeof(string), "Class: %d | Type: %d | Level: %d | Binding: %s | Required Level: %d", WeaponInfo[weaponid][WeaponClass], WeaponInfo[weaponid][WeaponType], WeaponInfo[weaponid][WeaponLevel], GetBindText(WeaponInfo[weaponid][WeaponBinding]), WeaponInfo[weaponid][WeaponReqLevel]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Value: %d | Part of Set: %s | Weapon Set: %d | Quality: %s | Crit Strike: %d", WeaponInfo[weaponid][WeaponValue], IsSetPart(WeaponInfo[weaponid][WeaponIsSetPart]), WeaponInfo[weaponid][WeaponSet], GetQualityNames(WeaponInfo[weaponid][WeaponQuality]), WeaponInfo[weaponid][WeaponCritStrike]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Penetration: %d | Defense: %d | Life Steal: %d | Max HP: %d | Power: %d", WeaponInfo[weaponid][WeaponPen], WeaponInfo[weaponid][WeaponDefense], WeaponInfo[weaponid][WeaponLifeSteal], WeaponInfo[weaponid][WeaponMaxHP], WeaponInfo[weaponid][WeaponPower]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Recovery: %d | Deflection: %d | Regeneration: %d | Movement: %d | Tenacity: %d", WeaponInfo[weaponid][WeaponRecovery], WeaponInfo[weaponid][WeaponDeflection], WeaponInfo[weaponid][WeaponRegen], WeaponInfo[weaponid][WeaponMovement], WeaponInfo[weaponid][WeaponTenacity]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Weapon Life Span: %d | Current Weapon Model: %d", WeaponInfo[weaponid][WeaponLifeSpan], WeaponInfo[weaponid][WeaponModel]);
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	else
	{
		SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
	}
	return 1;
}

CMD:createwepdata(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] >= 4)
	{
		for(new x;x<MAX_WEAPONS;x++)
		{
		    if(WeaponInfo[x][WeaponClass] == 0)
		    {
		        OnCreateWeaponData(playerid, x);
		        break;
			}
		}
	}
	return 1;
}

stock OnCreateWeaponData(playerid, weaponid)
{
	new string[100];
    format(string, sizeof(string), "Create a new Weapon | Weapon ID: %d", weaponid);
	GameTextForPlayer(playerid, "Welcome to the ~n~Weapon Creator!", 5, 1);
	ShowPlayerDialog(playerid, WEPCREATE_MAIN, DIALOG_STYLE_LIST, string, "Name\nClass\nType\nLevel\nBinding\n{FFFFFF}Required Level\nValue\nPart of Set\n{FFFFFF}Set\n{FFFFFF}Description\n{FFFFFF}Quality\nModel\n{FFFFFF}Life Span\n{FFFFFF}[Stat]: Critical Strike\n{FFFFFF}[Stat]: Armor Penetration\n{FFFFFF}[Stat]: Defense\n{FFFFFF}[Stat]: Life Steal\n{FFFFFF}[Stat]: Max HP\n{FFFFFF}[Stat]: Power\n{FFFFFF}[Stat]: Recovery\n{FFFFFF}[Stat]: Deflection\n{FFFFFF}[Stat]: Regeneration\n{FFFFFF}[Stat]: Movement\n{FFFFFF}[Stat]: Tenacity\n", "Select", "Cancel");
}

















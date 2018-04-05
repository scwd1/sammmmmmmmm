/*Types of Armor
Noob Stuff (Under Level 19)
T1 (Level 20 to 29)
T2 (Level 30 to 40)

PVP Armor
Noob Stuff (Under Level 20)
T1 (Level 20 to 30)
T2 (Level 30 to 40)*/

#define     MAX_ARMORS       	1000

enum E_ARMOR_INFO
{
	ArmorID,
	ArmorName[64],
	ArmorClass,
	ArmorType,
	ArmorLevel,
	ArmorBinding,
	ArmorReqLevel,
	ArmorValue,
	ArmorIsSetPart,
	ArmorSet,
	ArmorDescription[124],
	ArmorQuality,
	ArmorCritStrike,
	ArmorPen,
	ArmorDefense,
	ArmorLifeSteal,
	ArmorMaxHP,
	ArmorPower,
	ArmorRecovery,
	ArmorDeflection,
	ArmorRegen,
	ArmorMovement,
	ArmorTenacity,
	ArmorLifeSpan,
	ArmorPiece
};
new ArmorInfo[MAX_ARMORS][E_ARMOR_INFO];

/*switch(AccountInfo[playerid][pLevel])
{
	case 1 .. 19
	{
		SendClientMessage(playerid, "You may use Basic Level Armor");
	}
	case 20 .. 29
	{
		SendClientMessage(playerid, "You may use Tier One Armor");
	}
	case 30 .. 40
	{
		SendClientMessage(playerid, "You may use Tier Two Armor");
	}
}

//PVE Armor
if(AccountInfo[playerid][pArmorLevel] >= 1 && AccountInfo[playerid][pArmorLevel] <= 19 && ArmorInfo[pArmorClass] = 1)
{
	SendClientMessage(playerid, "You've got armor for levels 1 to 20!");
	SendClientMessage(playerid, "This type of Gear is Considered basic level Armor.");
}
else if(AccountInfo[playerid][pArmorLevel] >= 20 && AccountInfo[playerid][pArmorLevel] <= 29 && ArmorInfo[pArmorClass] = 1)
{
	SendClientMessage(playerid, "You've got armor for levels 20 to 29!");
	SendClientMessage(playerid, "This type of Gear is Considered Teir 1 Armor.");
}
else if(AccountInfo[playerid][pArmorLevel] >= 30 && AccountInfo[playerid][pArmorLevel] <= 40 && ArmorInfo[pArmorClass] = 1)
{
	SendClientMessage(playerid, "You've got armor for levels 30 to 40!");
	SendClientMessage(playerid, "This type of Gear is Considered Teir 2 Armor. This is the max level armor.");
}

//PVP Armor
if(AccountInfo[playerid][pArmorLevel] >= 1 && AccountInfo[playerid][pArmorLevel] <= 19 && ArmorInfo[pArmorClass] = 2)
{
	SendClientMessage(playerid, "You've got armor for levels 1 to 20!");
	SendClientMessage(playerid, "This type of Gear is Considered basic level Armor.");
}
else if(AccountInfo[playerid][pArmorLevel] >= 20 && AccountInfo[playerid][pArmorLevel] <= 29 && ArmorInfo[pArmorClass] = 2)
{
	SendClientMessage(playerid, "You've got armor for levels 20 to 29!");
	SendClientMessage(playerid, "This type of Gear is Considered Teir 1 Armor.");
}
else if(AccountInfo[playerid][pArmorLevel] >= 30 && AccountInfo[playerid][pArmorLevel] <= 40 && ArmorInfo[pArmorClass] = 2)
{
	SendClientMessage(playerid, "You've got armor for levels 30 to 40!");
	SendClientMessage(playerid, "This type of Gear is Considered Teir 2 Armor. This is the max level armor.");
}*/

stock SaveArmor(armorid)
{
	new string[1024];

	mysql_format(g_SQL, string, sizeof(string), "UPDATE `armorsystem` SET \
		`name`='%e', \
		`class`=%d, \
		`type`='%d', \
		`level`=%d, \
		`binding`=%d, \
		`reqlevel`=%d, \
		`value`=%d, \
		`issetpart`=%d, \
		`armset`=%d, \
		`description`=%e, \
		`quality`=%d, \
		`critstrike`=%d, \
		`armpen`=%d, \
		`defense`=%d, \
		`lifesteal`=%d, \
		`maxhp`=%d,",
		ArmorInfo[armorid][ArmorName],
		ArmorInfo[armorid][ArmorClass],
		ArmorInfo[armorid][ArmorType],
		ArmorInfo[armorid][ArmorLevel],
		ArmorInfo[armorid][ArmorBinding],
		ArmorInfo[armorid][ArmorReqLevel],
		ArmorInfo[armorid][ArmorValue],
		ArmorInfo[armorid][ArmorIsSetPart],
		ArmorInfo[armorid][ArmorSet],
		ArmorInfo[armorid][ArmorDescription],
		ArmorInfo[armorid][ArmorQuality],
		ArmorInfo[armorid][ArmorCritStrike],
		ArmorInfo[armorid][ArmorPen],
		ArmorInfo[armorid][ArmorDefense],
		ArmorInfo[armorid][ArmorLifeSteal],
		ArmorInfo[armorid][ArmorMaxHP]
	);

	mysql_format(g_SQL, string, sizeof(string), "%s \
		`power`=%d, \
		`recovery`=%d, \
		`deflection`=%d, \
		`regen`=%d, \
		`move`=%d, \
		`tenacity`=%d, \
		`lifespan`=%d, \
		`piece`=%d, \
		WHERE `id`=%d",
		string,
		ArmorInfo[armorid][ArmorPower],
		ArmorInfo[armorid][ArmorRecovery],
		ArmorInfo[armorid][ArmorDeflection],
		ArmorInfo[armorid][ArmorRegen],
		ArmorInfo[armorid][ArmorMovement],
		ArmorInfo[armorid][ArmorTenacity],
		ArmorInfo[armorid][ArmorLifeSpan],
		ArmorInfo[armorid][ArmorPiece],
		ArmorInfo[armorid][ArmorID],
		armorid+1
	);

	mysql_tquery(g_SQL, string);
}

stock LoadArmor(armorid)
{
	new string[128];
	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM `armorsystem` WHERE `id`=%d", armorid+1); // Array starts at zero, MySQL starts at 1.
	mysql_tquery(g_SQL, string, "OnLoadArmor", "i", armorid);
}

stock LoadArmors()
{
	printf("[Armor System]: Loading armor data from the database...");
	mysql_tquery(g_SQL, "SELECT * FROM `armorsystem`", "OnLoadArmors", "");
}

forward OnLoadArmor(index);
public OnLoadArmor(index)
{
	new rows;
	cache_get_row_count(rows);

	for(new row; row < rows; row++)
	{
		cache_get_value_name_int(row, "id", ArmorInfo[index][ArmorID]);
		cache_get_value_name(row, "name", ArmorInfo[index][ArmorName], 128);
		cache_get_value_name_int(row, "class", ArmorInfo[index][ArmorClass]);
		cache_get_value_name_int(row, "type", ArmorInfo[index][ArmorType]);
		cache_get_value_name_int(row, "level", ArmorInfo[index][ArmorLevel]);
		cache_get_value_name_int(row, "binding", ArmorInfo[index][ArmorBinding]);
		cache_get_value_name_int(row, "reqlevel", ArmorInfo[index][ArmorReqLevel]);
		cache_get_value_name_int(row, "value", ArmorInfo[index][ArmorValue]);
		cache_get_value_name_int(row, "issetpart", ArmorInfo[index][ArmorIsSetPart]);
		cache_get_value_name_int(row, "armset", ArmorInfo[index][ArmorSet]);
		cache_get_value_name(row, "description", ArmorInfo[index][ArmorDescription], 256);
		cache_get_value_name_int(row, "quality", ArmorInfo[index][ArmorQuality]);
		cache_get_value_name_int(row, "critstrike", ArmorInfo[index][ArmorCritStrike]);//
		cache_get_value_name_int(row, "armpen", ArmorInfo[index][ArmorPen]);//
		cache_get_value_name_int(row, "defense", ArmorInfo[index][ArmorDefense]);//
		cache_get_value_name_int(row, "lifesteal", ArmorInfo[index][ArmorLifeSteal]);//
		cache_get_value_name_int(row, "maxhp", ArmorInfo[index][ArmorMaxHP]);//
		cache_get_value_name_int(row, "power", ArmorInfo[index][ArmorPower]);//
		cache_get_value_name_int(row, "recovery", ArmorInfo[index][ArmorRecovery]);//
		cache_get_value_name_int(row, "deflection", ArmorInfo[index][ArmorDeflection]);
		cache_get_value_name_int(row, "regen", ArmorInfo[index][ArmorRegen]);
		cache_get_value_name_int(row, "move", ArmorInfo[index][ArmorMovement]);
		cache_get_value_name_int(row, "tenacity", ArmorInfo[index][ArmorTenacity]);
		cache_get_value_name_int(row, "lifespan", ArmorInfo[index][ArmorLifeSpan]);
		cache_get_value_name_int(row, "piece", ArmorInfo[index][ArmorPiece]);
	}
	return 1;
}


forward OnLoadArmors();
public OnLoadArmors()
{
	new i, rows;
	cache_get_row_count(rows);

	while(i < rows)
	{
		LoadArmor(i);
		i++;
	}
	if(i > 0) printf("[Armor System]: A total of %d armors have been Rehashed or Loaded.", i);
	else printf("[Armor System]: Failed to load any Armor Data.");
	return 1;
}

stock SaveArmors()
{
	for(new i = 0; i < MAX_ARMORS; i++)
	{
		SaveArmor(i);
	}
	return 1;
}

stock GetBindText(data)
{
	new btext[60];
	switch(data)
	{
		case 1: btext = "Binds on Pickup";
		case 2: btext = "Binds to Account on Equip";
		case 3: btext = "Binds to Account on Pickup";
		case 4: btext = "Binds to Character on Equip";
		case 5: btext = "Binds to Character on Pickup";
		default: btext = "Binds on Equip";
	}
	return btext;
}

stock GetQualityNames(data)
{
	new name[20];
	switch(data)
	{
		case 1: name = "Quest Item";
		case 2: name = "Common";
		case 3: name = "Uncommon";
		case 4: name = "Rare";
		case 5: name = "Epic";
		case 6: name = "Legendary";
		case 7: name = "Mythic"; // There should seriously be only a handful of these.
		default: name = "Junk";
	}
	return name;
}

stock IsSetPart(data)
{
	new name[20];
	switch(data)
	{
		case 0: name = "No";
		case 1: name = "Yes";
		default: name = "No";
	}
	return name;
}

stock GetPieceName(data)
{
	new name[20];
	switch(data)
	{
		case 0: name = "Head";
		case 1: name = "Arm";
		case 2: name = "Chest";
		case 3: name = "Leg";
		case 4: name = "Neck";
		default: name = "Head";
	}
	return name;
}

CMD:armordata(playerid, params[])
{
	if (AccountInfo[playerid][pAdmin] >= 4)
	{
		new armorid;
		if(sscanf(params, "i", armorid))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /armordata [armorid]");
			return 1;
		}
		new string[128];
		format(string,sizeof(string),"|___________ Armor Data (ID: %d - Name: %s) ___________|", armorid, ArmorInfo[armorid][ArmorName]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		format(string, sizeof(string), "Class: %d | Type: %d | Level: %d | Binding: %s | Required Level: %d", ArmorInfo[armorid][ArmorClass], ArmorInfo[armorid][ArmorType], ArmorInfo[armorid][ArmorLevel], GetBindText(ArmorInfo[armorid][ArmorBinding]), ArmorInfo[armorid][ArmorReqLevel]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Value: %d | Part of Set: %s | Armor Set: %d | Quality: %s | Crit Strike: %d", ArmorInfo[armorid][ArmorValue], IsSetPart(ArmorInfo[armorid][ArmorIsSetPart]), ArmorInfo[armorid][ArmorSet], GetQualityNames(ArmorInfo[armorid][ArmorQuality]), ArmorInfo[armorid][ArmorCritStrike]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Penetration: %d | Defense: %d | Life Steal: %d | Max HP: %d | Power: %d", ArmorInfo[armorid][ArmorPen], ArmorInfo[armorid][ArmorDefense], ArmorInfo[armorid][ArmorLifeSteal], ArmorInfo[armorid][ArmorMaxHP], ArmorInfo[armorid][ArmorPower]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Recovery: %d | Deflection: %d | Regeneration: %d | Movement: %d | Tenacity: %d", ArmorInfo[armorid][ArmorRecovery], ArmorInfo[armorid][ArmorDeflection], ArmorInfo[armorid][ArmorRegen], ArmorInfo[armorid][ArmorMovement], ArmorInfo[armorid][ArmorTenacity]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Armor Life Span: %d | Armor Piece: %s", ArmorInfo[armorid][ArmorLifeSpan], GetPieceName(ArmorInfo[armorid][ArmorPiece]));
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	else
	{
		SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
	}
	return 1;
}

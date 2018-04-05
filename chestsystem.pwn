#define 	MAX_CHESTS   		500
#define     CHEST_MAIN          20
#define     CHEST_POSX  		21
#define     CHEST_POSY  		22
#define     CHEST_POSZ  		23
#define     CHEST_ROTX    		24
#define     CHEST_ROTY  		25
#define     CHEST_ROTZ  		26
#define     CHEST_MODELID  		27
#define     CHEST_VW  			28
#define     CHEST_INT  			29
#define     CHEST_MULTIRWD   	30
#define     CHEST_CASHCHANCE    31
#define     CHEST_EXPCHANCE  	32
#define     CHEST_ITEMCHANCE    33
#define     CHEST_ITEMTYPE      34
#define     CHEST_SPECIAL       35

enum E_CHEST_INFO
{
	rID,
	Float:rPosX,
	Float:rPosY,
	Float:rPosZ,
	Float:rRotX,
	Float:rRotY,
	Float:rRotZ,
	rModelID,
	rVW,
	rInt,
	rMultiReward,
	rCashChance,
	rExpChance,
	rItemChance,
	rItemType,
	rSpecial,
	rCHEST
};
new ChestInfo[MAX_CHESTS][E_CHEST_INFO];

stock SaveChest(chestid)
{
	new string[1024];
	mysql_format(g_SQL, string, sizeof(string), "UPDATE `chestsystem` SET \
		`posx`='%f', \
		`posy`=%f, \
		`posz`='%f', \
		`rotx`=%f, \
		`roty`=%f, \
		`rotz`=%f, \
		`modelid`=%d, \
		`vw`=%d, \
		`int`=%d, \
		`multireward`=%d, \
		`cashchance`=%d, \
		`expchance`=%d, \
		`itemchance`=%d, \
		`itemtype`=%d, \
		`special`=%d, \
		WHERE `id`=%d",
		ChestInfo[chestid][rPosX],
		ChestInfo[chestid][rPosY],
		ChestInfo[chestid][rPosZ],
		ChestInfo[chestid][rRotX],
		ChestInfo[chestid][rRotY],
		ChestInfo[chestid][rRotZ],
		ChestInfo[chestid][rModelID],
		ChestInfo[chestid][rVW],
		ChestInfo[chestid][rInt],
		ChestInfo[chestid][rMultiReward],
		ChestInfo[chestid][rCashChance],
		ChestInfo[chestid][rExpChance],
		ChestInfo[chestid][rItemChance],
		ChestInfo[chestid][rItemType],
		ChestInfo[chestid][rSpecial],
		chestid+1
	);
	mysql_tquery(g_SQL, string);
}

stock LoadChest(chestid)
{
	new string[128];
	mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM `chestsystem` WHERE `id`=%d", chestid+1); // Array starts at zero, MySQL starts at 1.
	mysql_tquery(g_SQL, string, "OnLoadChest", "i", chestid);
}

stock LoadChests()
{
	printf("[Chest System]: Loading chest data from the database...");
	mysql_tquery(g_SQL, "SELECT * FROM `chestsystem`", "OnLoadChests", "");
}

forward OnLoadChest(index);
public OnLoadChest(index)
{
	new rows;
	cache_get_row_count(rows);

	for(new row; row < rows; row++)
	{
		cache_get_value_name_int(row, "id", ChestInfo[index][rID]);
		cache_get_value_name_float(row, "posx", ChestInfo[index][rPosX]);
		cache_get_value_name_float(row, "posy", ChestInfo[index][rPosY]);
		cache_get_value_name_float(row, "posz", ChestInfo[index][rPosZ]);
		cache_get_value_name_float(row, "rotx", ChestInfo[index][rRotX]);
		cache_get_value_name_float(row, "roty", ChestInfo[index][rRotY]);
		cache_get_value_name_float(row, "rotz", ChestInfo[index][rRotZ]);
		cache_get_value_name_int(row, "modelid", ChestInfo[index][rModelID]);
		cache_get_value_name_int(row, "vw", ChestInfo[index][rVW]);
		cache_get_value_name_int(row, "int", ChestInfo[index][rInt]);
		cache_get_value_name_int(row, "multireward", ChestInfo[index][rMultiReward]);//
		cache_get_value_name_int(row, "cashchance", ChestInfo[index][rCashChance]);//
		cache_get_value_name_int(row, "expchance", ChestInfo[index][rExpChance]);//
		cache_get_value_name_int(row, "itemchance", ChestInfo[index][rItemChance]);//
		cache_get_value_name_int(row, "itemtype", ChestInfo[index][rItemType]);//
		cache_get_value_name_int(row, "spcial", ChestInfo[index][rSpecial]);//
	}
	return 1;
}


forward OnLoadChests();
public OnLoadChests()
{
	new i, rows;
	cache_get_row_count(rows);

	while(i < rows)
	{
		LoadChest(i);
		i++;
	}
	if(i > 0) printf("[Chest System]: A total of %d chests have been Rehashed or Loaded.", i);
	else printf("[Chest System]: Failed to load any Chest Data.");
	return 1;
}

stock SaveChests()
{
	for(new i = 0; i < MAX_CHESTS; i++)
	{
		SaveChest(i);
	}
	return 1;
}

CMD:createchest(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] >= 4)
	{
		for(new x;x<MAX_CHESTS;x++)
		{
		    if(ChestInfo[x][rPosX] == 0.0)
		    {
		        OnCreateChestData(playerid, x);
		        break;
			}
		}
	}
	return 1;
}

stock OnCreateChestData(playerid, chestid)
{
	new string[100], cstring[524], specialstr[5], multrwdstr[5];
    format(string, sizeof(string), "Create a new Chest | Chest ID: %d", chestid);
    switch(ChestInfo[chestid][rSpecial])
    {
        case 0: specialstr = "No";
        case 1: specialstr = "Yes";
        default: specialstr = "No";
    }
    switch(ChestInfo[chestid][rMultiReward])
    {
        case 0: multrwdstr = "No";
        case 1: multrwdstr = "Yes";
        default: multrwdstr = "No";
    }
    format(cstring, sizeof(cstring), "Position X\t%d\n\
	Position Y\t%d\n\
	Position Z\t%d\n\
	Rotation X\t%d\n\
	Rotation Y\t%d\n\
	Rotation Z\t%d\n\
	Model ID\t%d\n\
	Virtual World\t%d\n\
	Interior\t%d\n\
	Multiple Rewards\t%s\n\
	Cash Chance\t%d Percent\n\
	Exp Chance\t%d Percent\n\
	Item Chance\t%d Percent\n\
	Item Type\t%d\n\
	Special?\t%s",
	ChestInfo[chestid][rPosX], ChestInfo[chestid][rPosY], ChestInfo[chestid][rPosZ],
	ChestInfo[chestid][rRotX], ChestInfo[chestid][rRotY], ChestInfo[chestid][rRotZ],
	ChestInfo[chestid][rModelID], ChestInfo[chestid][rVW], ChestInfo[chestid][rInt],
	multrwdstr, ChestInfo[chestid][rCashChance], ChestInfo[chestid][rExpChance],
	ChestInfo[chestid][rItemChance], ChestInfo[chestid][rItemType], specialstr);
	GameTextForPlayer(playerid, "Welcome to the ~n~Chest Creator!", 5, 1);
	SetPVarInt(playerid, "ChestID", chestid);
	ShowPlayerDialog(playerid, CHEST_MAIN, DIALOG_STYLE_TABLIST, string, cstring, "Select", "Close");
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new chestid = GetPVarInt(playerid, "ChestID");
	if(dialogid == CHEST_MAIN)
	{
	    switch(listitem)
	    {
	        case 0: {
	            ShowPlayerDialog(playerid, CHEST_POSX, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest X Position\n\nCurrent Position:\n\nPlease enter a valid X Position\nYou may press cancel and it will autofill with your current X Position.", "Okay", "Cancel");
	        }
	        case 1: {
	            ShowPlayerDialog(playerid, CHEST_POSY, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Y Position\n\nCurrent Position:\n\nPlease enter a valid Y Position\nYou may press cancel and it will autofill with your current Y Position.", "Okay", "Cancel");
	        }
	        case 2: {
	            ShowPlayerDialog(playerid, CHEST_POSZ, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Z Position\n\nCurrent Position:\n\nPlease enter a valid Z Position\nYou may press cancel and it will autofill with your current Z Position.", "Okay", "Cancel");
	        }
	        case 3: {
	            ShowPlayerDialog(playerid, CHEST_ROTX, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest X Rotation\n\nCurrent Rotation:\n\nPlease enter a valid X Rotation", "Okay", "Cancel");
	        }
	        case 4: {
	            ShowPlayerDialog(playerid, CHEST_ROTY, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Y Rotation\n\nCurrent Rotation:\n\nPlease enter a valid Y Rotation", "Okay", "Cancel");
	        }
	        case 5: {
	            ShowPlayerDialog(playerid, CHEST_ROTZ, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Z Rotation\n\nCurrent Rotation:\n\nPlease enter a valid Z Rotation", "Okay", "Cancel");
	        }
	        case 6: {
	            ShowPlayerDialog(playerid, CHEST_MODELID, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Object Model ID\n\nCurrent Model ID:\n\nPlease enter a valid Object Model ID\nDefault: 9965 (Small Wooden Crate)", "Okay", "Cancel");
	        }
	        case 7: {
	            ShowPlayerDialog(playerid, CHEST_VW, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Virtual World\n\nCurrent Virtual World:\n\nPlease enter a valid Virtual World\nDefault: 0\n\nYou may press cancel and it will autofill with your current Virtual World.", "Okay", "Cancel");
			}
	        case 8: {
	            ShowPlayerDialog(playerid, CHEST_INT, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Interior\n\nCurrent Interior:\n\nPlease enter a valid Interior\nDefault: 0\n\nYou may press cancel and it will autofill with your current Interior.", "Okay", "Cancel");
			}
	        case 9: {
	            ShowPlayerDialog(playerid, CHEST_MULTIRWD, DIALOG_STYLE_LIST, "Slum Lords Online Chest Editor", "Yes\nNo", "Okay", "Cancel");
			}
	        case 10: {
	            ShowPlayerDialog(playerid, CHEST_CASHCHANCE, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Cash Chance rate\n\nCurrent Rate: 10 Percent\n\nPlease enter a valid cash chance rate\n\nRemember, this is the chance that a person will recieve Cash over other items.\nThe higher the rate, the higher chance for cash.", "Okay", "Cancel");
			}
	        case 11: {
	            ShowPlayerDialog(playerid, CHEST_EXPCHANCE, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Experience Point Chance rate\n\nCurrent Rate: 10 Percent\n\nPlease enter a valid experience point chance rate\n\nRemember, this is the chance that a person will recieve Experience Points over other items.\nThe higher the rate, the higher chance for experience points.", "Okay", "Cancel");
	        }
	        case 12: {
	            ShowPlayerDialog(playerid, CHEST_ITEMCHANCE, DIALOG_STYLE_INPUT, "Slum Lords Online Chest Editor", "Edit Chest Item Chance rate\n\nCurrent Rate: 10 Percent\n\nPlease enter a valid item chance rate\n\nRemember, this is the chance that a person will recieve items over other rewards.\nThe higher the rate, the higher chance for items.", "Okay", "Cancel");
	        }
	        case 13: {
	            ShowPlayerDialog(playerid, CHEST_ITEMTYPE, DIALOG_STYLE_LIST, "Slum Lords Online Chest Editor", "Weapon\nArmor\nVehicle", "Select", "Cancel");
	        }
	        case 14: {
	            ShowPlayerDialog(playerid, CHEST_SPECIAL, DIALOG_STYLE_LIST, "Slum Lords Online Chest Editor", "Enable Special\nDisable Special", "Select", "Cancel");
	        }
	        case 15: {
	            CreateChest(chestid);
	            SaveChest(chestid);
	        }
	    }
	
	}
	else if(dialogid == CHEST_POSX)
	{
 		new Float: arr_fPlayerPos[3];
		GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
		switch(response)
		{
		    case 0:	ChestInfo[chestid][rPosX] = arr_fPlayerPos[0];
			case 1: ChestInfo[chestid][rPosX] = strval(inputtext);
		}
		ShowMainChestDialog(playerid);
	}
	else if(dialogid == CHEST_POSY)
	{
 		new Float: arr_fPlayerPos[3];
		GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
		switch(response)
		{
		    case 0:	ChestInfo[chestid][rPosY] = arr_fPlayerPos[1];
			case 1: ChestInfo[chestid][rPosY] = strval(inputtext);
		}
		ShowMainChestDialog(playerid);
	}
	else if(dialogid == CHEST_POSZ)
	{
 		new Float: arr_fPlayerPos[3];
		GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
		switch(response)
		{
		    case 0:	ChestInfo[chestid][rPosZ] = arr_fPlayerPos[2];
			case 1: ChestInfo[chestid][rPosZ] = strval(inputtext);
		}
		ShowMainChestDialog(playerid);
	}
	else if(dialogid == CHEST_ROTX)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
				ChestInfo[chestid][rRotX] = strval(inputtext);
				ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_ROTY)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
				ChestInfo[chestid][rRotY] = strval(inputtext);
				ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_ROTZ)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
				ChestInfo[chestid][rRotZ] = strval(inputtext);
				ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_MODELID)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
				ChestInfo[chestid][rModelID] = strval(inputtext);
				ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_VW)
	{
		switch(response)
		{
		    case 0:
			{
				ChestInfo[chestid][rVW] = GetPlayerVirtualWorld(playerid);
				ShowMainChestDialog(playerid);
			}
		    case 1:
			{
				ChestInfo[chestid][rVW] = strval(inputtext);
				ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_INT)
	{
		switch(response)
		{
		    case 0:
			{
				ChestInfo[chestid][rInt] = GetPlayerInterior(playerid);
				ShowMainChestDialog(playerid);
			}
		    case 1:
			{
				ChestInfo[chestid][rInt] = strval(inputtext);
				ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_MULTIRWD)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
				switch(listitem)
				{
				    case 0: ChestInfo[chestid][rMultiReward] = 1;
				    case 1: ChestInfo[chestid][rMultiReward] = 0;
				}
				ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_CASHCHANCE)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
                ChestInfo[chestid][rCashChance] = strval(inputtext);
                ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_EXPCHANCE)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
                ChestInfo[chestid][rExpChance] = strval(inputtext);
                ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_ITEMCHANCE)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
                ChestInfo[chestid][rItemChance] = strval(inputtext);
                ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_ITEMTYPE)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
				switch(listitem)
				{
				    case 0: ChestInfo[chestid][rItemType] = 1;
				    case 1: ChestInfo[chestid][rItemType] = 2;
				    case 2: ChestInfo[chestid][rItemType] = 3;
				}
				ShowMainChestDialog(playerid);
			}
		}
	}
	else if(dialogid == CHEST_SPECIAL)
	{
		switch(response)
		{
		    case 0: ShowMainChestDialog(playerid);
		    case 1:
			{
				switch(listitem)
				{
				    case 0: ChestInfo[chestid][rItemType] = 1;
				    case 1: ChestInfo[chestid][rItemType] = 0;
				}
				ShowMainChestDialog(playerid);
			}
		}
	}
	return 1;
}

ShowMainChestDialog(playerid)
{
	new string[100], cstring[524], specialstr[5], multrwdstr[5];
	new chestid = GetPVarInt(playerid, "ChestID");
    format(string, sizeof(string), "Create a new Chest | Chest ID: %d", chestid);
    switch(ChestInfo[chestid][rSpecial])
    {
        case 0: specialstr = "No";
        case 1: specialstr = "Yes";
        default: specialstr = "No";
    }
    switch(ChestInfo[chestid][rMultiReward])
    {
        case 0: multrwdstr = "No";
        case 1: multrwdstr = "Yes";
        default: multrwdstr = "No";
    }
    format(cstring, sizeof(cstring), "Position X\t%d\n\
	Position Y\t%d\n\
	Position Z\t%d\n\
	Rotation X\t%d\n\
	Rotation Y\t%d\n\
	Rotation Z\t%d\n\
	Model ID\t%d\n\
	Virtual World\t%d\n\
	Interior\t%d\n\
	Multiple Rewards\t%s\n\
	Cash Chance\t%d Percent\n\
	Exp Chance\t%d Percent\n\
	Item Chance\t%d Percent\n\
	Item Type\t%d\n\
	Special?\t%s\n\n\
	Save and Create Chest",
	ChestInfo[chestid][rPosX], ChestInfo[chestid][rPosY], ChestInfo[chestid][rPosZ],
	ChestInfo[chestid][rRotX], ChestInfo[chestid][rRotY], ChestInfo[chestid][rRotZ],
	ChestInfo[chestid][rModelID], ChestInfo[chestid][rVW], ChestInfo[chestid][rInt],
	multrwdstr, ChestInfo[chestid][rCashChance], ChestInfo[chestid][rExpChance],
	ChestInfo[chestid][rItemChance], ChestInfo[chestid][rItemType], specialstr);
	GameTextForPlayer(playerid, "Welcome to the ~n~Chest Creator!", 5, 1);
	if(GetPVarInt(playerid, "ChestID") == 0) { SetPVarInt(playerid, "ChestID", chestid); }
	ShowPlayerDialog(playerid, CHEST_MAIN, DIALOG_STYLE_TABLIST, string, cstring, "Select", "Close");
	return 1;
}

CreateChest(chestid) {
	if(IsValidDynamicObject(ChestInfo[chestid][rCHEST])) DestroyDynamicObject(ChestInfo[chestid][rCHEST]);
	ChestInfo[chestid][rCHEST] = CreateDynamicObject(ChestInfo[chestid][rModelID], ChestInfo[chestid][rPosX], ChestInfo[chestid][rPosY], ChestInfo[chestid][rPosZ], ChestInfo[chestid][rRotX], ChestInfo[chestid][rRotY], ChestInfo[chestid][rRotZ], ChestInfo[chestid][rVW], ChestInfo[chestid][rInt], -1, 200.0);
}












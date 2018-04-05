forward OnPlayerDataLoaded(playerid, race_check);
public OnPlayerDataLoaded(playerid, race_check)
{
    if(IsPlayerNPC(playerid))
	{
		return 1;
	}
	if (race_check != g_MysqlRaceCheck[playerid]) return Kick(playerid);
	if(cache_num_rows() > 0)
	{
		cache_get_value(0, "password", AccountInfo[playerid][pPassword], 65);
		cache_get_value(0, "salt", AccountInfo[playerid][pSalt], 17);

		AccountInfo[playerid][pCache_ID] = cache_save();
        ShowMainMenuDialog(playerid, 1);
		AccountInfo[playerid][pLoginTimer] = SetTimerEx("OnLoginTimeout", SECONDS_TO_LOGIN * 1000, false, "d", playerid);
	}
	else
	{
        ShowMainMenuDialog(playerid, 2);
	}
	return 1;
}

forward OnLoginTimeout(playerid);
public OnLoginTimeout(playerid)
{
    if(IsPlayerNPC(playerid))
	{
		return 1;
	}
	// reset the variable that stores the timerid
	AccountInfo[playerid][pLoginTimer] = 0;

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been kicked for taking too long to login to your account.", "Okay", "");
	DelayedKick(playerid);
	return 1;
}

/*forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
    if(IsPlayerNPC(playerid)) { return 1; }
	for(new i;i<24;i++) { TextDrawHideForPlayer(playerid, TitleTD[i]); }
	AccountInfo[playerid][pID] = cache_insert_id();

	AccountInfo[playerid][pX_Pos] = DEFAULT_POS_X;
	AccountInfo[playerid][pY_Pos] = DEFAULT_POS_Y;
	AccountInfo[playerid][pZ_Pos] = DEFAULT_POS_Z;
	AccountInfo[playerid][pA_Pos] = DEFAULT_POS_A;

	IsRegistering[playerid] = false; // No longer registering, set to false.
	IsInTutorial[playerid] = true;
	AccountInfo[playerid][pIsLoggedIn] = true;
	AccountInfo[playerid][pInterior] = 0;
	AccountInfo[playerid][pVW] = GetVW(playerid);

	SetPVarInt(playerid, "JustRegistered", 1);
	//StartCharacterCreation(playerid);

	TogglePlayerSpectating(playerid, 0);
	SetSpawnInfo(playerid, 0, 299, DEFAULT_POS_X, DEFAULT_POS_Y, DEFAULT_POS_Z, DEFAULT_POS_A, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	SetPlayerVirtualWorld(playerid, 1000);
	SetPlayerSkin(playerid, GetPlayerSkin(playerid));
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	SetCameraBehindPlayer(playerid);
	return 1;
}*/

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
    if(IsPlayerNPC(playerid)) { return 1; }
	for(new i;i<24;i++) { TextDrawHideForPlayer(playerid, TitleTD[i]); }
	AccountInfo[playerid][pID] = cache_insert_id();

	AccountInfo[playerid][pX_Pos] = DEFAULT_POS_X;
	AccountInfo[playerid][pY_Pos] = DEFAULT_POS_Y;
	AccountInfo[playerid][pZ_Pos] = DEFAULT_POS_Z;
	AccountInfo[playerid][pA_Pos] = DEFAULT_POS_A;

	AccountInfo[playerid][pIsLoggedIn] = true;
	AccountInfo[playerid][pInterior] = 0;
	AccountInfo[playerid][pVW] = 1000;
	
	AccountInfo[playerid][pChatChannel1] = 1;
	
	TogglePlayerSpectating(playerid, 0);
	SetSpawnInfo(playerid, 0, 299, DEFAULT_POS_X, DEFAULT_POS_Y, DEFAULT_POS_Z, DEFAULT_POS_A, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	SetPlayerVirtualWorld(playerid, 1000);
	SetPlayerSkin(playerid, GetPlayerSkin(playerid));
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	SetCameraBehindPlayer(playerid);
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(IsInTutorial[playerid] == true && TutStep[playerid] > 1)
	{
		//TutorialStep(playerid);
	}
	return 1;
}

forward _KickPlayerDelayed(playerid);
public _KickPlayerDelayed(playerid)
{
	Kick(playerid);
	return 1;
}
//-----------------------------------------------------

AssignPlayerData(playerid)
{
	cache_get_value_int(0, "id", AccountInfo[playerid][pID]);

	cache_get_value_int(0, "kills", AccountInfo[playerid][pKills]);
	cache_get_value_int(0, "deaths", AccountInfo[playerid][pDeaths]);

	cache_get_value_float(0, "x", AccountInfo[playerid][pX_Pos]);
	cache_get_value_float(0, "y", AccountInfo[playerid][pY_Pos]);
	cache_get_value_float(0, "z", AccountInfo[playerid][pZ_Pos]);
	cache_get_value_float(0, "angle", AccountInfo[playerid][pA_Pos]);
	cache_get_value_int(0, "interior", AccountInfo[playerid][pInterior]);
	cache_get_value_int(0, "AdminLevel", AccountInfo[playerid][pAdmin]);
	cache_get_value_int(0, "SecKey", AccountInfo[playerid][pSecKey]);
	cache_get_value_float(0, "Health", AccountInfo[playerid][pHealth]);
	cache_get_value_float(0, "Armor", AccountInfo[playerid][pArmor]);
	cache_get_value_int(0, "Cash", AccountInfo[playerid][pCash]);
	cache_get_value_int(0, "Skin", AccountInfo[playerid][pSkin]);
	cache_get_value_int(0, "Level", AccountInfo[playerid][pLevel]);
	cache_get_value_int(0, "headgear", AccountInfo[playerid][pHeadGear]);
	cache_get_value_int(0, "armorgear", AccountInfo[playerid][pArmorGear]);
	cache_get_value_int(0, "armgear", AccountInfo[playerid][pArmGear]);
	cache_get_value_int(0, "feetarmor", AccountInfo[playerid][pFeetArmor]);
	cache_get_value_int(0, "neckarmor", AccountInfo[playerid][pNeckArmor]);
	cache_get_value_int(0, "rightring", AccountInfo[playerid][pRightRing]);
	cache_get_value_int(0, "leftring", AccountInfo[playerid][pLeftRing]);
	cache_get_value_int(0, "waistgear", AccountInfo[playerid][pWaistGear]);
	cache_get_value_int(0, "shirt", AccountInfo[playerid][pShirt]);
	cache_get_value_int(0, "pants", AccountInfo[playerid][pPants]);
	cache_get_value_int(0, "phase", AccountInfo[playerid][pPhase]);
	
	cache_get_value_int(0, "cchan1", AccountInfo[playerid][pChatChannel1]);
	cache_get_value_int(0, "cchan2", AccountInfo[playerid][pChatChannel2]);
	cache_get_value_int(0, "cchan3", AccountInfo[playerid][pChatChannel3]);
	cache_get_value_int(0, "cchan4", AccountInfo[playerid][pChatChannel4]);
	cache_get_value_int(0, "cchan5", AccountInfo[playerid][pChatChannel5]);
	cache_get_value_int(0, "cchan6", AccountInfo[playerid][pChatChannel6]);
	cache_get_value_int(0, "cchan7", AccountInfo[playerid][pChatChannel7]);
	cache_get_value_int(0, "cchan8", AccountInfo[playerid][pChatChannel8]);
	cache_get_value_int(0, "cchan9", AccountInfo[playerid][pChatChannel9]);
	cache_get_value_int(0, "cchan10", AccountInfo[playerid][pChatChannel10]);
	
    AccountInfo[playerid][pPhase] = 1;
	return 1;
}

DelayedKick(playerid, time = 500)
{
	SetTimerEx("_KickPlayerDelayed", time, false, "d", playerid);
	return 1;
}

SetupPlayerTable()
{
	mysql_tquery(g_SQL, "CREATE TABLE IF NOT EXISTS `players` (`id` int(11) NOT NULL AUTO_INCREMENT,`username` varchar(24) NOT NULL,`password` char(64) NOT NULL,`salt` char(16) NOT NULL,`kills` mediumint(8) NOT NULL DEFAULT '0',`deaths` mediumint(8) NOT NULL DEFAULT '0',`x` float NOT NULL DEFAULT '0',`y` float NOT NULL DEFAULT '0',`z` float NOT NULL DEFAULT '0',`angle` float NOT NULL DEFAULT '0',`interior` tinyint(3) NOT NULL DEFAULT '0', PRIMARY KEY (`id`), UNIQUE KEY `username` (`username`))");
	return 1;
}

UpdatePlayerData(playerid, reason)
{
	if (AccountInfo[playerid][pIsLoggedIn] == false) return 0;
	if (reason == 1)
	{
		GetPlayerPos(playerid, AccountInfo[playerid][pX_Pos], AccountInfo[playerid][pY_Pos], AccountInfo[playerid][pZ_Pos]);
		GetPlayerFacingAngle(playerid, AccountInfo[playerid][pA_Pos]);
	}
	new string[1024];
	
	mysql_format(g_SQL, string, sizeof(string), "UPDATE `players` SET \
		`x` = %f,\
		`y` = %f,\
		`z` = %f,\
		`angle` = %f,\
		`interior` = %d,\
		`AdminLevel` = %d,\
		`SecKey` = %d,\
		`Health` = %f,\
		`Armor` = %f,\
		`Cash` = %d,\
		`Skin` = %d,\
		`Level` = %d, \
		`headgear` = %d, \
		`armorgear` = %d, \
		`armgear` = %d, \
		`feetarmor` = %d, \
		`neckarmor` = %d, \
		`rightring` = %d, \
		`leftring` = %d, \
		`waistgear` = %d, \
		`shirt` = %d, \
		`pants` = %d, \
		`phase` = %d, \
		`cchan1` = %d, \
		`cchan2` = %d, \
		`cchan3` = %d, \
		`cchan4` = %d, \
		`cchan5` = %d, \
		`cchan6` = %d, \
		`cchan7` = %d, \
		`cchan8` = %d, \
		`cchan9` = %d, \
		`cchan10` = %d \
	 	WHERE `id` = %d LIMIT 1",
		AccountInfo[playerid][pX_Pos],
		AccountInfo[playerid][pY_Pos],
		AccountInfo[playerid][pZ_Pos],
		AccountInfo[playerid][pA_Pos],
		GetPlayerInterior(playerid),
		AccountInfo[playerid][pAdmin],
		AccountInfo[playerid][pSecKey],
		AccountInfo[playerid][pHealth],
		AccountInfo[playerid][pArmor],
		AccountInfo[playerid][pCash],
		AccountInfo[playerid][pSkin],
		AccountInfo[playerid][pLevel],
		AccountInfo[playerid][pHeadGear],
		AccountInfo[playerid][pArmorGear],
		AccountInfo[playerid][pArmGear],
		AccountInfo[playerid][pFeetArmor],
		AccountInfo[playerid][pNeckArmor],
		AccountInfo[playerid][pRightRing],
		AccountInfo[playerid][pLeftRing],
		AccountInfo[playerid][pWaistGear],
		AccountInfo[playerid][pShirt],
		AccountInfo[playerid][pPants],
		AccountInfo[playerid][pPhase],
		AccountInfo[playerid][pChatChannel1],
		AccountInfo[playerid][pChatChannel2],
		AccountInfo[playerid][pChatChannel3],
		AccountInfo[playerid][pChatChannel4],
		AccountInfo[playerid][pChatChannel5],
		AccountInfo[playerid][pChatChannel6],
		AccountInfo[playerid][pChatChannel7],
		AccountInfo[playerid][pChatChannel8],
		AccountInfo[playerid][pChatChannel9],
		AccountInfo[playerid][pChatChannel10],
		AccountInfo[playerid][pID]
	);
	
	mysql_tquery(g_SQL, string);
	print(string);
	return 1;
}

UpdatePlayerDeaths(playerid)
{
	if (AccountInfo[playerid][pIsLoggedIn] == false) return 0;

	AccountInfo[playerid][pDeaths]++;

	new query[70];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `deaths` = %d WHERE `id` = %d LIMIT 1", AccountInfo[playerid][pDeaths], AccountInfo[playerid][pID]);
	mysql_tquery(g_SQL, query);
	return 1;
}

UpdatePlayerKills(killerid)
{
	if (killerid == INVALID_PLAYER_ID) return 0;
	if (AccountInfo[killerid][pIsLoggedIn] == false) return 0;

	AccountInfo[killerid][pKills]++;

	new query[70];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `kills` = %d WHERE `id` = %d LIMIT 1", AccountInfo[killerid][pKills], AccountInfo[killerid][pID]);
	mysql_tquery(g_SQL, query);
	return 1;
}

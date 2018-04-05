#include <YSI\y_hooks>

new PlayerText:HUDTD[3][MAX_PLAYERS];
new bool:IsInHUD[MAX_PLAYERS] = false;
new HUDPlayerCount;
new Text:HUDSideBar[14];
new Text:CharMenu[15];

// HOLDING(keys)
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))

OpenHUD(playerid)
{
	PlayerTextDrawShow(playerid, HUDTD[1][playerid]);
	TogglePlayerControllable(playerid, false);
	SelectTextDraw(playerid, 0x00FF00FF);
	HUDPlayerCount++;
	IsInHUD[playerid] = true;
	return 1;
}

CloseHUD(playerid)
{
	PlayerTextDrawHide(playerid, HUDTD[1][playerid]);
	TogglePlayerControllable(playerid, true);
	HUDPlayerCount--;
	IsInHUD[playerid] = false;
	return 1;
}

hook OnGameModeInit()
{
    HUDSideBar[0] = TextDrawCreate(622.799987, 405.197784, "usebox");
	TextDrawLetterSize(HUDSideBar[0], 0.000000, -18.679134);
	TextDrawTextSize(HUDSideBar[0], 638.399963, 0.000000);
	TextDrawAlignment(HUDSideBar[0], 1);
	TextDrawColor(HUDSideBar[0], 0);
	TextDrawUseBox(HUDSideBar[0], true);
	TextDrawBoxColor(HUDSideBar[0], 102);
	TextDrawSetShadow(HUDSideBar[0], 0);
	TextDrawSetOutline(HUDSideBar[0], 0);
	TextDrawFont(HUDSideBar[0], 0);
	TextDrawSetSelectable(HUDSideBar[0], true);

	HUDSideBar[1] = TextDrawCreate(623.199707, 247.402236, "usebox");
	TextDrawLetterSize(HUDSideBar[1], 0.000000, 2.227531);
	TextDrawTextSize(HUDSideBar[1], 639.599853, 0.000000);
	TextDrawAlignment(HUDSideBar[1], 1);
	TextDrawColor(HUDSideBar[1], 0);
	TextDrawUseBox(HUDSideBar[1], true);
	TextDrawBoxColor(HUDSideBar[1], 102);
	TextDrawSetShadow(HUDSideBar[1], 0);
	TextDrawSetOutline(HUDSideBar[1], 0);
	TextDrawFont(HUDSideBar[1], 0);
	TextDrawSetSelectable(HUDSideBar[1], true);

	HUDSideBar[2] = TextDrawCreate(642.799804, 276.771118, "usebox");
	TextDrawLetterSize(HUDSideBar[2], 0.000000, 2.393456);
	TextDrawTextSize(HUDSideBar[2], 619.599792, 0.000000);
	TextDrawAlignment(HUDSideBar[2], 1);
	TextDrawColor(HUDSideBar[2], 0);
	TextDrawUseBox(HUDSideBar[2], true);
	TextDrawBoxColor(HUDSideBar[2], 102);
	TextDrawSetShadow(HUDSideBar[2], 0);
	TextDrawSetOutline(HUDSideBar[2], 0);
	TextDrawFont(HUDSideBar[2], 0);
	TextDrawSetSelectable(HUDSideBar[2], true);

	HUDSideBar[3] = TextDrawCreate(642.800659, 307.633514, "usebox");
	TextDrawLetterSize(HUDSideBar[3], 0.000000, 2.399381);
	TextDrawTextSize(HUDSideBar[3], 619.600524, 0.000000);
	TextDrawAlignment(HUDSideBar[3], 1);
	TextDrawColor(HUDSideBar[3], 0);
	TextDrawUseBox(HUDSideBar[3], true);
	TextDrawBoxColor(HUDSideBar[3], 102);
	TextDrawSetShadow(HUDSideBar[3], 0);
	TextDrawSetOutline(HUDSideBar[3], 0);
	TextDrawFont(HUDSideBar[3], 0);
	TextDrawSetSelectable(HUDSideBar[3], true);

	HUDSideBar[4] = TextDrawCreate(642.400024, 241.428909, "usebox");
	TextDrawLetterSize(HUDSideBar[4], 0.000000, -3.303333);
	TextDrawTextSize(HUDSideBar[4], 620.000061, 0.000000);
	TextDrawAlignment(HUDSideBar[4], 1);
	TextDrawColor(HUDSideBar[4], 0);
	TextDrawUseBox(HUDSideBar[4], true);
	TextDrawBoxColor(HUDSideBar[4], 102);
	TextDrawSetShadow(HUDSideBar[4], 0);
	TextDrawSetOutline(HUDSideBar[4], 0);
	TextDrawFont(HUDSideBar[4], 0);

	HUDSideBar[5] = TextDrawCreate(642.000000, 338.993377, "usebox");
	TextDrawLetterSize(HUDSideBar[5], 0.000000, 2.368761);
	TextDrawTextSize(HUDSideBar[5], 619.599853, 0.000000);
	TextDrawAlignment(HUDSideBar[5], 1);
	TextDrawColor(HUDSideBar[5], 0);
	TextDrawUseBox(HUDSideBar[5], true);
	TextDrawBoxColor(HUDSideBar[5], 102);
	TextDrawSetShadow(HUDSideBar[5], 0);
	TextDrawSetOutline(HUDSideBar[5], 0);
	TextDrawFont(HUDSideBar[5], 0);
	TextDrawSetSelectable(HUDSideBar[5], true);

	HUDSideBar[6] = TextDrawCreate(643.599975, 369.855590, "usebox");
	TextDrawLetterSize(HUDSideBar[6], 0.000000, 2.433456);
	TextDrawTextSize(HUDSideBar[6], 619.599853, 0.000000);
	TextDrawAlignment(HUDSideBar[6], 1);
	TextDrawColor(HUDSideBar[6], 0);
	TextDrawUseBox(HUDSideBar[6], true);
	TextDrawBoxColor(HUDSideBar[6], 102);
	TextDrawSetShadow(HUDSideBar[6], 0);
	TextDrawSetOutline(HUDSideBar[6], 0);
	TextDrawFont(HUDSideBar[6], 0);
	TextDrawSetSelectable(HUDSideBar[6], true);

	HUDSideBar[7] = TextDrawCreate(642.000000, 240.931106, "usebox");
	TextDrawLetterSize(HUDSideBar[7], 0.000000, -3.288024);
	TextDrawTextSize(HUDSideBar[7], 619.599975, 0.000000);
	TextDrawAlignment(HUDSideBar[7], 1);
	TextDrawColor(HUDSideBar[7], 0);
	TextDrawUseBox(HUDSideBar[7], true);
	TextDrawBoxColor(HUDSideBar[7], 102);
	TextDrawSetShadow(HUDSideBar[7], 0);
	TextDrawSetOutline(HUDSideBar[7], 0);
	TextDrawFont(HUDSideBar[7], 3);

	HUDSideBar[8] = TextDrawCreate(624.799926, 212.551162, "QM");
	TextDrawLetterSize(HUDSideBar[8], 0.231999, 2.700088);
	TextDrawAlignment(HUDSideBar[8], 1);
	TextDrawColor(HUDSideBar[8], -1);
	TextDrawSetShadow(HUDSideBar[8], 0);
	TextDrawSetOutline(HUDSideBar[8], 1);
	TextDrawBackgroundColor(HUDSideBar[8], 51);
	TextDrawFont(HUDSideBar[8], 2);
	TextDrawSetProportional(HUDSideBar[8], 1);

	HUDSideBar[9] = TextDrawCreate(624.799987, 252.373291, "hud:radar_tshirt");
	TextDrawTextSize(HUDSideBar[9], 12.400017, 12.444452);
	TextDrawAlignment(HUDSideBar[9], 1);
	TextDrawColor(HUDSideBar[9], -1);
	TextDrawSetShadow(HUDSideBar[9], 0);
	TextDrawSetOutline(HUDSideBar[9], 0);
	TextDrawFont(HUDSideBar[9], 4);
	TextDrawSetSelectable(HUDSideBar[9], true);

	HUDSideBar[10] = TextDrawCreate(625.600036, 280.746612, "hud:radar_triads");
	TextDrawTextSize(HUDSideBar[10], 11.199954, 13.937757);
	TextDrawAlignment(HUDSideBar[10], 1);
	TextDrawColor(HUDSideBar[10], -1);
	TextDrawSetShadow(HUDSideBar[10], 0);
	TextDrawSetOutline(HUDSideBar[10], 0);
	TextDrawFont(HUDSideBar[10], 4);
	TextDrawSetSelectable(HUDSideBar[10], true);

	HUDSideBar[11] = TextDrawCreate(625.199951, 311.608917, "hud:radar_cash");
	TextDrawTextSize(HUDSideBar[11], 12.399960, 15.928873);
	TextDrawAlignment(HUDSideBar[11], 1);
	TextDrawColor(HUDSideBar[11], -1);
	TextDrawSetShadow(HUDSideBar[11], 0);
	TextDrawSetOutline(HUDSideBar[11], 0);
	TextDrawFont(HUDSideBar[11], 4);
	TextDrawSetSelectable(HUDSideBar[11], true);

	HUDSideBar[12] = TextDrawCreate(625.599975, 341.973358, "hud:radar_qmark");
	TextDrawTextSize(HUDSideBar[12], 10.399963, 15.928863);
	TextDrawAlignment(HUDSideBar[12], 1);
	TextDrawColor(HUDSideBar[12], -1);
	TextDrawSetShadow(HUDSideBar[12], 0);
	TextDrawSetOutline(HUDSideBar[12], 0);
	TextDrawFont(HUDSideBar[12], 4);
	TextDrawSetSelectable(HUDSideBar[12], true);

	HUDSideBar[13] = TextDrawCreate(626.799987, 375.822204, "hud:radar_savegame");
	TextDrawTextSize(HUDSideBar[13], 10.400011, 11.946693);
	TextDrawAlignment(HUDSideBar[13], 1);
	TextDrawColor(HUDSideBar[13], -1);
	TextDrawSetShadow(HUDSideBar[13], 0);
	TextDrawSetOutline(HUDSideBar[13], 0);
	TextDrawFont(HUDSideBar[13], 4);
	TextDrawSetSelectable(HUDSideBar[13], true);
	
	CharMenu[0] = TextDrawCreate(398.800018, 117.980003, "usebox");
	TextDrawLetterSize(CharMenu[0], 0.000000, 24.770248);
	TextDrawTextSize(CharMenu[0], 248.000015, 0.000000);
	TextDrawAlignment(CharMenu[0], 1);
	TextDrawColor(CharMenu[0], 0);
	TextDrawUseBox(CharMenu[0], true);
	TextDrawBoxColor(CharMenu[0], 102);
	TextDrawSetShadow(CharMenu[0], 0);
	TextDrawSetOutline(CharMenu[0], 0);
	TextDrawFont(CharMenu[0], 0);

	CharMenu[1] = TextDrawCreate(393.600006, 156.308898, "usebox");
	TextDrawLetterSize(CharMenu[1], 0.000000, 1.950987);
	TextDrawTextSize(CharMenu[1], 252.800003, 0.000000);
	TextDrawAlignment(CharMenu[1], 1);
	TextDrawColor(CharMenu[1], 0);
	TextDrawUseBox(CharMenu[1], true);
	TextDrawBoxColor(CharMenu[1], 102);
	TextDrawSetShadow(CharMenu[1], 0);
	TextDrawSetOutline(CharMenu[1], 0);
	TextDrawFont(CharMenu[1], 0);

	CharMenu[2] = TextDrawCreate(393.600006, 184.184524, "usebox");
	TextDrawLetterSize(CharMenu[2], 0.000000, 1.950987);
	TextDrawTextSize(CharMenu[2], 253.600006, 0.000000);
	TextDrawAlignment(CharMenu[2], 1);
	TextDrawColor(CharMenu[2], 0);
	TextDrawUseBox(CharMenu[2], true);
	TextDrawBoxColor(CharMenu[2], 102);
	TextDrawSetShadow(CharMenu[2], 0);
	TextDrawSetOutline(CharMenu[2], 0);
	TextDrawFont(CharMenu[2], 0);

	CharMenu[3] = TextDrawCreate(393.600219, 215.040039, "usebox");
	TextDrawLetterSize(CharMenu[3], 0.000000, 2.086295);
	TextDrawTextSize(CharMenu[3], 253.600265, 0.000000);
	TextDrawAlignment(CharMenu[3], 1);
	TextDrawColor(CharMenu[3], 0);
	TextDrawUseBox(CharMenu[3], true);
	TextDrawBoxColor(CharMenu[3], 102);
	TextDrawSetShadow(CharMenu[3], 0);
	TextDrawSetOutline(CharMenu[3], 0);
	TextDrawFont(CharMenu[3], 0);

	CharMenu[4] = TextDrawCreate(393.600006, 244.913345, "usebox");
	TextDrawLetterSize(CharMenu[4], 0.000000, 2.006292);
	TextDrawTextSize(CharMenu[4], 253.599990, 0.000000);
	TextDrawAlignment(CharMenu[4], 1);
	TextDrawColor(CharMenu[4], 0);
	TextDrawUseBox(CharMenu[4], true);
	TextDrawBoxColor(CharMenu[4], 102);
	TextDrawSetShadow(CharMenu[4], 0);
	TextDrawSetOutline(CharMenu[4], 0);
	TextDrawFont(CharMenu[4], 0);

	CharMenu[5] = TextDrawCreate(393.599975, 275.277770, "usebox");
	TextDrawLetterSize(CharMenu[5], 0.000000, 2.012224);
	TextDrawTextSize(CharMenu[5], 253.599990, 0.000000);
	TextDrawAlignment(CharMenu[5], 1);
	TextDrawColor(CharMenu[5], 0);
	TextDrawUseBox(CharMenu[5], true);
	TextDrawBoxColor(CharMenu[5], 102);
	TextDrawSetShadow(CharMenu[5], 0);
	TextDrawSetOutline(CharMenu[5], 0);
	TextDrawFont(CharMenu[5], 0);

	CharMenu[6] = TextDrawCreate(390.399993, 334.015563, "usebox");
	TextDrawLetterSize(CharMenu[6], 0.000000, -2.031235);
	TextDrawTextSize(CharMenu[6], 255.199981, 0.000000);
	TextDrawAlignment(CharMenu[6], 1);
	TextDrawColor(CharMenu[6], 0);
	TextDrawUseBox(CharMenu[6], true);
	TextDrawBoxColor(CharMenu[6], 102);
	TextDrawSetShadow(CharMenu[6], 0);
	TextDrawSetOutline(CharMenu[6], 0);
	TextDrawFont(CharMenu[6], 0);

	CharMenu[7] = TextDrawCreate(286.800018, 320.071197, "Return to Game");
	TextDrawLetterSize(CharMenu[7], 0.261599, 1.007644);
	TextDrawTextSize(CharMenu[7], 369.599945, 10.884447);
	TextDrawAlignment(CharMenu[7], 1);
	TextDrawColor(CharMenu[7], -1);
	TextDrawSetShadow(CharMenu[7], 0);
	TextDrawSetOutline(CharMenu[7], 1);
	TextDrawBackgroundColor(CharMenu[7], 51);
	TextDrawFont(CharMenu[7], 1);
	TextDrawSetProportional(CharMenu[7], 1);
	TextDrawSetSelectable(CharMenu[7], true);

	CharMenu[8] = TextDrawCreate(260.399993, 129.920043, "Character Menu");
	TextDrawLetterSize(CharMenu[8], 0.226399, 1.948444);
	TextDrawAlignment(CharMenu[8], 1);
	TextDrawColor(CharMenu[8], -1);
	TextDrawSetShadow(CharMenu[8], 0);
	TextDrawSetOutline(CharMenu[8], 1);
	TextDrawBackgroundColor(CharMenu[8], 51);
	TextDrawFont(CharMenu[8], 2);
	TextDrawSetProportional(CharMenu[8], 1);

	CharMenu[9] = TextDrawCreate(390.800140, 146.353302, "usebox");
	TextDrawLetterSize(CharMenu[9], 0.000000, -0.310740);
	TextDrawTextSize(CharMenu[9], 344.799987, 0.000000);
	TextDrawAlignment(CharMenu[9], 1);
	TextDrawColor(CharMenu[9], 0);
	TextDrawUseBox(CharMenu[9], true);
	TextDrawBoxColor(CharMenu[9], -16776961);
	TextDrawSetShadow(CharMenu[9], 0);
	TextDrawSetOutline(CharMenu[9], 0);
	TextDrawFont(CharMenu[9], 0);

	CharMenu[10] = TextDrawCreate(277.599914, 157.795532, "View Character");
	TextDrawTextSize(CharMenu[10], 369.599945, 17.884447);
	TextDrawLetterSize(CharMenu[10], 0.351999, 1.555200);
	TextDrawAlignment(CharMenu[10], 1);
	TextDrawColor(CharMenu[10], -1);
	TextDrawSetShadow(CharMenu[10], 0);
	TextDrawSetOutline(CharMenu[10], 1);
	TextDrawBackgroundColor(CharMenu[10], 51);
	TextDrawFont(CharMenu[10], 1);
	TextDrawSetProportional(CharMenu[10], 1);
	TextDrawSetSelectable(CharMenu[10], true);

	CharMenu[11] = TextDrawCreate(304.000061, 186.168930, "Mail");
	TextDrawLetterSize(CharMenu[11], 0.429999, 1.321244);
	TextDrawTextSize(CharMenu[11], 335.600036, 17.920000);
	TextDrawAlignment(CharMenu[11], 1);
	TextDrawColor(CharMenu[11], -1);
	TextDrawSetShadow(CharMenu[11], 0);
	TextDrawSetOutline(CharMenu[11], 1);
	TextDrawBackgroundColor(CharMenu[11], 51);
	TextDrawFont(CharMenu[11], 1);
	TextDrawSetProportional(CharMenu[11], 1);
	TextDrawSetSelectable(CharMenu[11], true);

	CharMenu[12] = TextDrawCreate(297.599945, 217.031066, "Social");
	TextDrawLetterSize(CharMenu[12], 0.433199, 1.440711);
	TextDrawTextSize(CharMenu[12], 340.600036, 17.920000);
	TextDrawAlignment(CharMenu[12], 1);
	TextDrawColor(CharMenu[12], -1);
	TextDrawSetShadow(CharMenu[12], 0);
	TextDrawSetOutline(CharMenu[12], 1);
	TextDrawBackgroundColor(CharMenu[12], 51);
	TextDrawFont(CharMenu[12], 1);
	TextDrawSetProportional(CharMenu[12], 1);
	TextDrawSetSelectable(CharMenu[12], true);

	CharMenu[13] = TextDrawCreate(300.400054, 246.399993, "Gang");
	TextDrawLetterSize(CharMenu[13], 0.427199, 1.435732);
	TextDrawTextSize(CharMenu[13], 335.600036, 17.920000);
	TextDrawAlignment(CharMenu[13], 1);
	TextDrawColor(CharMenu[13], -1);
	TextDrawSetShadow(CharMenu[13], 0);
	TextDrawSetOutline(CharMenu[13], 1);
	TextDrawBackgroundColor(CharMenu[13], 51);
	TextDrawFont(CharMenu[13], 1);
	TextDrawSetProportional(CharMenu[13], 1);
	TextDrawSetSelectable(CharMenu[13], true);

	CharMenu[14] = TextDrawCreate(268.399902, 277.760009, "Change Character");
	TextDrawLetterSize(CharMenu[14], 0.376800, 1.316266);
	TextDrawTextSize(CharMenu[14], 385.599945, 17.884447);
	TextDrawAlignment(CharMenu[14], 1);
	TextDrawColor(CharMenu[14], -1);
	TextDrawSetShadow(CharMenu[14], 0);
	TextDrawSetOutline(CharMenu[14], 1);
	TextDrawBackgroundColor(CharMenu[14], 51);
	TextDrawFont(CharMenu[14], 1);
	TextDrawSetProportional(CharMenu[14], 1);
	TextDrawSetSelectable(CharMenu[14], true);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	HUDTD[0][playerid] = CreatePlayerTextDraw(playerid, 261.599914, 224.000076, "Press LALT to return to game");
	PlayerTextDrawLetterSize(playerid, HUDTD[0][playerid], 0.183199, 0.962844);
	PlayerTextDrawAlignment(playerid, HUDTD[0][playerid], 1);
	PlayerTextDrawColor(playerid, HUDTD[0][playerid], -1);
	PlayerTextDrawSetShadow(playerid, HUDTD[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, HUDTD[0][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, HUDTD[0][playerid], 51);
	PlayerTextDrawFont(playerid, HUDTD[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid, HUDTD[0][playerid], 1);

	HUDTD[1][playerid] = CreatePlayerTextDraw(playerid, 641.599975, 1.997777, "usebox");
	PlayerTextDrawLetterSize(playerid, HUDTD[1][playerid], 0.000000, 49.350494);
	PlayerTextDrawTextSize(playerid, HUDTD[1][playerid], -2.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, HUDTD[1][playerid], 1);
	PlayerTextDrawColor(playerid, HUDTD[1][playerid], 0);
	PlayerTextDrawUseBox(playerid, HUDTD[1][playerid], true);
	PlayerTextDrawBoxColor(playerid, HUDTD[1][playerid], 102);
	PlayerTextDrawSetShadow(playerid, HUDTD[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, HUDTD[1][playerid], 0);
	PlayerTextDrawFont(playerid, HUDTD[1][playerid], 0);

	HUDTD[2][playerid] = CreatePlayerTextDraw(playerid, 359.200012, 225.997772, "usebox");
	PlayerTextDrawLetterSize(playerid, HUDTD[2][playerid], 0.000000, 0.623579);
	PlayerTextDrawTextSize(playerid, HUDTD[2][playerid], 258.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, HUDTD[2][playerid], 1);
	PlayerTextDrawColor(playerid, HUDTD[2][playerid], 0);
	PlayerTextDrawUseBox(playerid, HUDTD[2][playerid], true);
	PlayerTextDrawBoxColor(playerid, HUDTD[2][playerid], 102);
	PlayerTextDrawSetShadow(playerid, HUDTD[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, HUDTD[2][playerid], 0);
	PlayerTextDrawFont(playerid, HUDTD[2][playerid], 0);
	for(new i;i<14;i++)
	{
		TextDrawShowForPlayer(playerid, HUDSideBar[i]);
	}
	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == HUDSideBar[9])
 	{
		for(new i;i<15;i++)
		{
			TextDrawShowForPlayer(playerid, CharMenu[i]);
		}
		return 1;
	}
	else if(clickedid == HUDSideBar[10])
 	{
		SendClientMessage(playerid, 0xFFFFFFAA, "You clicked on the Triads Symbols.");
		CancelSelectTextDraw(playerid);
		return 1;
	}
	else if(clickedid == HUDSideBar[11])
 	{
		SendClientMessage(playerid, 0xFFFFFFAA, "You clicked on the Money.");
		CancelSelectTextDraw(playerid);
		return 1;
	}
	else if(clickedid == HUDSideBar[12])
 	{
		SendClientMessage(playerid, 0xFFFFFFAA, "You clicked on the Question Mark.");
		CancelSelectTextDraw(playerid);
		return 1;
	}
	else if(clickedid == HUDSideBar[13])
 	{
		SendClientMessage(playerid, 0xFFFFFFAA, "You clicked on the Save Disk.");
		CancelSelectTextDraw(playerid);
		return 1;
	}
	else if(clickedid == CharMenu[7])
 	{
 	    //SetPVarString(playerid, "HudArea", "Closed");
 	    //GetPVarString(playerid, "HudArea",
 	    CloseHUD(playerid);
		for(new i;i<15;i++)
		{
			TextDrawHideForPlayer(playerid, CharMenu[i]);
		}
		CancelSelectTextDraw(playerid);
		return 1;
	}
    return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_WALK)
	{
		if (!(oldkeys & KEY_JUMP))
		{
		    if(!IsInHUD[playerid])
		    {
				OpenHUD(playerid);
			}
			else
			{
			    CloseHUD(playerid);
			}
		}
	}
	return 1;
}

CMD:hudusers(playerid, params[])
{
	new string[128];
	if(AccountInfo[playerid][pAdmin] >= 1)
	{
		format(string, sizeof(string), "There are currently %d users in their HUD Menus.", HUDPlayerCount);
		SendClientMessage(playerid, COLOR_GRAD1, string);
	}
	return 1;
}

CMD:closehud(playerid, params[])
{
	if(IsInHUD[playerid])
	{
		CloseHUD(playerid);
	}
	return 1;
}

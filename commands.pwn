//This is the list of commands.

/////////////////////////////////

//Description:
//Parameters:
CMD:(playerid, params[])
{
	return 1;
}

/////////////////////////////////

//Description: 1: Numerical display of frame rate on top right corner of the screen. 0: Hides frame rate
//Parameters: 1 or 0
//Alternate names: None
CMD:showfps(playerid, params[])
{
	return 1;
}

//__________________________________________________
//________________[Status Commands]_________________
//Description: These commands change your online status.
//__________________________________________________

//Description: Changes search visibility for you to "Invisible"
//Parameters: None
//Alternate names: None
CMD:hide(playerid, params[])
{
	return 1;
}

//Description: Changes search visibility for you to "Visible To All"
//Parameters: None
//Alternate names: None
CMD:unhide(playerid, params[])
{
	return 1;
}

//Description: Changes search visibility for you to "Friends Only"
//Parameters: None
//Alternate names: None
CMD:friendsonly(playerid, params[])
{
	return 1;
}

//Description: Marks you as "Away" and using the specified string as your "away message". (Ex: /away "Outside having a cigarette.") Enter the command again to clear the away status and message, or use the /unaway command.
//Parameters: <string>
//Alternate names: /afk
CMD:away(playerid, params[])
{
    new afkstring[128];
	if(AFKStatus[playerid] == false)
	{
		AFKPlayerCount++;
		format(afkstring, sizeof(afkstring), "(%s)", params);
	    SendClientMessage(playerid, COLOR_RED, "You have been marked as away from the keyboard.");
	    SendClientMessage(playerid, COLOR_RED, afkstring);
		AFKStatus[playerid] = true;
	}
	else
	{
		AFKPlayerCount--;
	    SendClientMessage(playerid, COLOR_RED, "You are no longer marked as away.");
		AFKStatus[playerid] = false;
	}
	return 1;
}

//Description: Marks you as "Away" and using the specified string as your "away message". (Ex: /away "Outside having a cigarette.") Enter the command again to clear the away status and message, or use the /unaway command.
//Parameters: <string>
//Alternate names: /away
CMD:afk(playerid, params[]) {
	return cmd_away(playerid, params);
}

//Description: Unmarks you as "Away".
//Parameters: None
//Alternate names: /afk or /away
CMD:unaway(playerid, params[])
{
	AFKPlayerCount--;
	SendClientMessage(playerid, COLOR_RED, "You are no longer marked as away.");
	AFKStatus[playerid] = false;
	return 1;
}

//__________________________________________________
//_________________[Team Commands]__________________
//Description: These commands manage team interactions.
//__________________________________________________

//Description:
//Parameters: <string>
//Alternate names: None
CMD:team(playerid, params[])
{
	return 1;
}

//Description:
//Parameters: None
//Alternate names: None
CMD:team_acceptinvite(playerid, params[])
{
	return 1;
}

//Description: Accept an invitation to join a party
//Parameters: <int>
//Alternate names: None
CMD:team_acceptrequest(playerid, params[])
{
	return 1;
}

//Description:
//Parameters: None
//Alternate names: None
CMD:team_cancelinvite(playerid, params[])
{
	return 1;
}

//Description: Decline an invitation to join a party.
//Parameters: None
//Alternate names: None
CMD:team_declineinvite(playerid, params[])
{
	return 1;
}

//Description:
//Parameters: <int>
//Alternate names: None
CMD:team_declinerequest(playerid, params[])
{
	return 1;
}

//Description:
//Parameters: None
//Alternate names: None
CMD:team_cancelrequest(playerid, params[])
{
	return 1;
}

//Description: Invite a new party member.
//Parameters: <string>
//Alternate names: None
CMD:team_invite(playerid, params[])
{
	new
		iTargetID,
		string[124];

	if(sscanf(params, "u", iTargetID)) {
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /team_invite [player]");
 	}
 	else if(iTargetID == playerid)
 	{
		SendClientMessage(playerid, COLOR_RED, "[PARTY]: You can't invite yourself.");
 	}
 	else if(PTeamID[playerid] >= 1)
 	{
 	    if(IsTeamLeader[playerid] == true)
 	    {
			format(string, sizeof(string), "[PARTY]: You've invited %s to join your party! | Party ID: %d", GetPlayerNameEx(iTargetID), PTeamID[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), "[PARTY]: You've been invited to join %s's party! [/team_acceptrequest to join.]", GetPlayerNameEx(playerid));
			SendClientMessage(iTargetID, COLOR_GREEN, string);
 	    }
 	    else
 	    {
 	        SendClientMessage(playerid, COLOR_RED, "[PARTY]: You're not the Team Leader! Ask them to invite this person.");
 	    }
 	}
 	else if(PTeamID[playerid] == 0)
 	{
 	    if(PTeamID[iTargetID] == 0)
 	    {
			if(IsPlayerConnected(iTargetID))
			{
				PTeamID[playerid] = random(999999) + playerid;
				IsTeamLeader[playerid] = true;
				format(string, sizeof(string), "[PARTY]: You've invited %s to join your party! | Party ID: %d", GetPlayerNameEx(iTargetID), PTeamID[playerid]);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string), "[PARTY]: You've been invited to join %s's party! [/team_acceptrequest to join.]", GetPlayerNameEx(playerid));
				SendClientMessage(iTargetID, COLOR_GREEN, string);
			}
		}
  		else
  		{
  		    SendClientMessage(playerid, COLOR_RED, "[PARTY]: This person is already in a party!");
  		}
	}
	return 1;
}

//Description: Kick someone from the party.
//Parameters: <string>
//Alternate names: None
CMD:team_kick(playerid, params[])
{
	new
		iTargetID,
		string[124];

	if(sscanf(params, "u", iTargetID)) {
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /team_kick [player]");
 	}
 	else if(iTargetID == playerid)
 	{
		SendClientMessage(playerid, COLOR_RED, "[PARTY]: You can't kick yourself. Promote someone else to Leader or disband it.");
 	}
 	else if(PTeamID[playerid] >= 1 && PTeamID[iTargetID] >= 1)
 	{
 	    if(PTeamID[playerid] == PTeamID[iTargetID])
 	    {
	 	    if(IsTeamLeader[playerid] == true)
	 	    {
				format(string, sizeof(string), "[PARTY]: You've kicked %s from your party.", GetPlayerNameEx(iTargetID), PTeamID[playerid]);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string), "[PARTY]: You've been kicked from %s's party.", GetPlayerNameEx(playerid));
				SendClientMessage(iTargetID, COLOR_GREEN, string);
				PTeamID[iTargetID] = 0;
				//CREATE A MESSAGE TO THE PARTY HERE.
	 	    }
	 	    else
	 	    {
	 	        SendClientMessage(playerid, COLOR_RED, "[PARTY]: You're not the Team Leader! Ask them to kick this person.");
	 	    }
 	    }
 	    else
 	    {
 	        SendClientMessage(playerid, COLOR_RED, "[PARTY]: This person is not in your party.");
 	    }
 	}
	return 1;
}

//Description: Leave your party.
//Parameters: None
//Alternate names: None
CMD:team_leave(playerid, params[])
{
	//new string[124];
 	if(PTeamID[playerid] >= 1)
 	{
		if(IsTeamLeader[playerid] == false)
		{
			SendClientMessage(playerid, COLOR_GREEN, "[PARTY]: You've left your party.");
			PTeamID[playerid] = 0;
    	}
    	else
		 	SendClientMessage(playerid, COLOR_RED, "[PARTY]: You're the party leader, promote someone first or disband the party.");
 	}
 	else
 		SendClientMessage(playerid, COLOR_RED, "[PARTY]: You're not in a party.");
 		
	return 1;
}

//Description:
//Parameters: <string>
//Alternate names: None
CMD:team_mode(playerid, params[])
{
	return 1;
}

//Description: Promote a member to Party leader.
//Parameters: <string>
//Alternate names: None
CMD:team_promote(playerid, params[])
{
	new
		iTargetID,
		string[124];

	if(sscanf(params, "u", iTargetID)) {
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /team_promote [player]");
 	}
 	else if(iTargetID == playerid)
 	{
		SendClientMessage(playerid, COLOR_RED, "[PARTY]: You can't promote yourself.");
 	}
 	else if(PTeamID[playerid] >= 1 && PTeamID[iTargetID] >= 1)
 	{
 	    if(PTeamID[playerid] == PTeamID[iTargetID])
 	    {
	 	    if(IsTeamLeader[playerid] == true)
	 	    {
				format(string, sizeof(string), "[PARTY]: You've promoted %s to be the party leader.", GetPlayerNameEx(iTargetID));
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string), "[PARTY]: You've been promoted to party leader by %s.", GetPlayerNameEx(playerid));
				SendClientMessage(iTargetID, COLOR_GREEN, string);
				IsTeamLeader[playerid] = false;
				IsTeamLeader[iTargetID] = true;
				//CREATE A MESSAGE TO THE PARTY HERE.
	 	    }
	 	    else
				SendClientMessage(playerid, COLOR_RED, "[PARTY]: You're not the Team Leader.");
 	    }
 	    else
 	    	SendClientMessage(playerid, COLOR_RED, "[PARTY]: This person is not in your party.");
 	}
	return 1;
}

//Description:
//Parameters: <string>
//Alternate names: None
CMD:team_request(playerid, params[])
{
	return 1;
}

//Description:
//Parameters: <string>
//Alternate names: None
CMD:team_setlootmode(playerid, params[])
{
	return 1;
}

//Description:
//Parameters: <string>
//Alternate names: None
CMD:team_setlootmodequality(playerid, params[])
{
	return 1;
}

//Description:
//Parameters: <int>
//Alternate names: None
CMD:team_setsidekicking(playerid, params[])
{
	return 1;
}

//__________________________________________________
//__________________[VIP Commands]__________________
//Description: These commands call the VIP functions.
//__________________________________________________

//Description: Opens the root VIP menu
//Parameters: None
//Alternate names: None
CMD:vip_activate(playerid, params[])
{
	return 1;
}

//Description: Summons the mailbox post
//Parameters: None
//Alternate names: None
CMD:vipaction_mailbox(playerid, params[])
{
	return 1;
}

//Description: Summons the Bank Portal
//Parameters: None
//Alternate names: None
CMD:vipaction_bankvendor(playerid, params[])
{
	return 1;
}

//Description: Summons the Profession vendor
//Parameters: None
//Alternate names: None
CMD:vipaction_profession(playerid, params[])
{
	return 1;
}

//Description: Teleport to the Main Land
//Parameters: None
//Alternate names: None
CMD:vipaction_mainland(playerid, params[])
{
	return 1;
}

//Description: Summons the Salvaging Anvil
//Parameters: None
//Alternate names: None
CMD:vipaction_salvager(playerid, params[])
{
	return 1;
}

//__________________________________________________
//_________________[Misc Commands]__________________
//Description: These commands have yet to be categorized in one of the above categories or put in a new one.
//__________________________________________________

//Description: Shows the user their license.
//Parameters: None
CMD:licenseshow_me(playerid, params[])
{
	new string[128];
	format(string, sizeof(string), "[ME]: %s takes out their license and looks at it.", GetPlayerNameEx(playerid));
	ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE);
	//ShowLicense(playerid);
	return 1;
}

//Description: Shows the users license to another user.
//Parameters: <int>
CMD:licenseshow_to(playerid, params[])
{
	new iTargetID;
	if(sscanf(params, "u", iTargetID)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /licenseshow_to [playerid]");
	new string[128];
	format(string, sizeof(string), "[ME]: %s takes out their license and shows it to %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(iTargetID));
	ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE);
	return 1;
}

//Description: Hides the users license.
//Parameters: None
CMD:licensehide(playerid, params[])
{
	new string[128];
	format(string, sizeof(string), "[ME]: %s puts away their license.", GetPlayerNameEx(playerid));
	ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE);
	//HideLicense(playerid);
	return 1;
}

//Description: Changes the max  fpsto specified setting.
//Parameters: None
//Alternate names: <int>
CMD:fpslimit(playerid, params[])
{
	return 1;
}

//Description:Attempts to move you slightly in the event that you are stuck.
//Parameters: None
//Alternate names: /unstuck
CMD:stuck(playerid, params[])
{
	return 1;
}

//Description: Commit suicide - intended to be used in the event that /stuck repeatedly does not help.
//Parameters: None
//Alternate names: None
CMD:killme(playerid, params[])
{
	return 1;
}

//Description: Opens your inventory (default keybind is UNDEFINED)
//Parameters: None
//Alternate names: None
CMD:inventory(playerid, params[])
{
	return 1;
}

//Description: Your character will walk instead of run. If 1: You will walk very slow. If 0: is specified, you will move at standard speed. Default is 0.
//Parameters: 1 or 0
//Alternate names: None
CMD:walk(playerid, params[])
{
	return 1;
}

//Description: Your X, Y, and Z coordinates are printed to the chat window.
//Parameters: None
//Alternate names: None
CMD:loc_vec(playerid, params[])
{
    new string[128], Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    format(string, sizeof(string), "[SYSTEM]: Your position is: %f, %f, %f", x, y, z);
    SendClientMessage(playerid, COLOR_WHITE, string);
    return 1;
}

//Description: Go to character selecting screen without the need to enter login informations again.
//Parameters: None
//Alternate names: None
CMD:gotocharacterselect(playerid, params[])
{
	return 1;
}

//Description: If set to 1, log combat activity to chat. WARNING: Can be very spammy! Displays current setting when used without a parameter.
//Parameters: 1 or 0
//Alternate names: None
CMD:combatlog(playerid, params[])
{
	return 1;
}

//__________________________________________________
//_________________[Etc Commands]__________________
//Description: These commands are just here. I have not yet categorized them.
//__________________________________________________

//Description: Accepts a friend request from a specific player.
//Parameters: <string>
//Alternate names: None
CMD:acceptfriend(playerid, params[])
{
	return 1;
}

//Description: Alias for the friend command. Adds a player as a friend.
//Parameters: <string>
//Alternate names: /friendadd
CMD:addfriend(playerid, params[])
{
	return 1;
}

//Description: No comment provided
//Parameters:
//Alternate names: None
CMD:chatfriendsonly(playerid, params[])
{
	return 1;
}

//Description: No comment provided (Does a friend request)
//Parameters:
//Alternate names: None
CMD:friend(playerid, params[])
{
	return 1;
}

//Description: Show/hide friend UI.
//Parameters: None
//Alternate names: None
CMD:friends(playerid, params[])
{
	return 1;
}

//Description: No comment provided
//Parameters: <string>
//Alternate names: None
CMD:rejectfriend(playerid, params[])
{
	return 1;
}

//Description: No comment provided
//Parameters: <string>
//Alternate names: /unfriend
CMD:removefriend(playerid, params[])
{
	return 1;
}

//__________________________________________________
//__________________[Chat Commands]_________________
//Description: The most basic chat commands and channels are listed below.
//__________________________________________________

//Description: Sends a message to the players near you.
//Channel: Say
//Alternate names: /s, /chat
CMD:say(playerid, params[])
{
	new string[128];
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /say [text]");
	new Float: f_playerPos[3];
	GetPlayerPos(playerid, f_playerPos[0], f_playerPos[1], f_playerPos[2]);
	foreach(new i: Player)
	{
		if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
		{
			if(IsPlayerInRangeOfPoint(i, 20.0 / 16, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				format(string, sizeof(string), "%s %s: %s", GetChannelTag(1), GetPlayerNameEx(playerid), params);
				SendClientMessage(i, COLOR_FADE1, string);
			}
			else if(IsPlayerInRangeOfPoint(i, 20.0 / 8, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				format(string, sizeof(string), "%s %s: %s", GetChannelTag(1), GetPlayerNameEx(playerid), params);
				SendClientMessage(i, COLOR_FADE2, string);
			}
			else if(IsPlayerInRangeOfPoint(i, 20.0 / 4, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				format(string, sizeof(string), "%s %s: %s", GetChannelTag(1), GetPlayerNameEx(playerid), params);
				SendClientMessage(i, COLOR_FADE3, string);
			}
			else if(IsPlayerInRangeOfPoint(i, 20.0 / 2, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				format(string, sizeof(string), "%s %s: %s", GetChannelTag(1), GetPlayerNameEx(playerid), params);
				SendClientMessage(i, COLOR_FADE4, string);
			}
			else if(IsPlayerInRangeOfPoint(i, 20.0, f_playerPos[0], f_playerPos[1], f_playerPos[2])) {
				format(string, sizeof(string), "%s %s: %s", GetChannelTag(1), GetPlayerNameEx(playerid), params);
				SendClientMessage(i, COLOR_FADE5, string);
			}
		}
	}
	SetPlayerChatBubble(playerid,params,COLOR_WHITE,20.0,5000);
	return 1;
}

//Description: Sends a message to the players near you.
//Channel: Say
//Alternate names: /s, /say
CMD:chat(playerid, params[]) {
	return cmd_say(playerid, params);
}

//Description: Sends a message to the players near you.
//Channel: Say
//Alternate names: /chat, /say
CMD:s(playerid, params[]) {
	return cmd_say(playerid, params);
}

//Description: Sends a message to the entire zone.
//Channel: Zone
//Alternate names: /z, /Yell, /y
CMD:zone(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /zone [message]");
	SendChannelMessage(playerid, 2, params);
	return 1;
}

//Description: Sends a message to players looking to trade goods and services.
//Channel: Trade
//Alternate names: None
CMD:trade(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /trade [message]");
	SendChannelMessage(playerid, 3, params);
	return 1;
}

//Description: Sends a private message to the identified player.
//Channel: None
//Alternate names: /w, /t
CMD:whisper(playerid, params[])
{
	new iTargetID, szMessage[256], string[256];
	if(sscanf(params, "us[256]", iTargetID, szMessage)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /pm [id] [message]");
	if(IsPlayerConnected(iTargetID))
	{
		//if(ID == playerid) return SendClientMessage(playerid, COLOR_RED, "You can't whisper to yourself!");
		format(string, sizeof(string), "[WHISPER]: %s: %s", GetPlayerNameEx(iTargetID), szMessage);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof(string), "[WHISPER]: %s: %s", GetPlayerNameEx(playerid), szMessage);
		SendClientMessage(iTargetID, COLOR_YELLOW, string);
		LastWhisper[iTargetID] = playerid;
	}
	return 1;
}

//Description: Sends a private message to the identified player.
//Channel: None
//Alternate names: /whisper, /t
CMD:w(playerid, params[]) {
	return cmd_whisper(playerid, params);
}

//Description: Sends a private message to the identified player.
//Channel: None
//Alternate names: /whisper, /w
CMD:t(playerid, params[]) {
	return cmd_whisper(playerid, params);
}

//Description: Sends a private message to the last player to send one to you.
//Channel: None
//Alternate names: /r
CMD:reply(playerid, params[])
{
	new string[256], iTargetID = LastWhisper[iTargetID];
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /reply [message]");
	if(IsPlayerConnected(iTargetID))
	{
		//if(ID == playerid) return SendClientMessage(playerid, COLOR_RED, "You can't whisper to yourself!");
		format(string, sizeof(string), "[WHISPER]: %s: %s", GetPlayerNameEx(iTargetID), params);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof(string), "[WHISPER]: %s: %s", GetPlayerNameEx(playerid), params);
		SendClientMessage(iTargetID, COLOR_YELLOW, string);
		LastWhisper[iTargetID] = playerid;
	}
	return 1;
}

//Description: Sends a private message to the last player to send one to you.
//Channel: None
//Alternate names: /reply
CMD:r(playerid, params[]) {
	return cmd_reply(playerid, params);
}

//Description: Sends a message to the players in your group.
//Channel: Group
//Alternate names: /Group, /p
CMD:party(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /party [message]");
	SendChannelMessage(playerid, 4, params);
	return 1;
}

//Description: Sends a message to the players in your group.
//Channel: Group
//Alternate names: /party, /p
CMD:group(playerid, params[]) {
	return cmd_party(playerid, params);
}

//Description: Sends a message to the players in your group.
//Channel: Group
//Alternate names: /party, /group
CMD:p(playerid, params[]) {
	return cmd_party(playerid, params);
}

//Description: Sends a message to the players in your raid group.
//Channel: Raid
//Alternate names: None
CMD:raid(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /raid [message]");
	SendChannelMessage(playerid, 5, params);
	return 1;
}

//Description: Sends a message to the players in your queue group.
//Channel: Queue Group
//Alternate names: None
CMD:queue(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /queue [message]");
	SendChannelMessage(playerid, 6, params);
	return 1;
}

//Description: Sends a message to the players in your match group.
//Channel: Match
//Alternate names: /m
CMD:match(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /match [message]");
	SendChannelMessage(playerid, 7, params);
	return 1;
}

//Description: Sends a message to the players in your match group.
//Channel: Match
//Alternate names: /match
CMD:m(playerid, params[]) {
	return cmd_match(playerid, params);
}

//Description: Sends a message to players who are looking for a group.
//Channel: Looking For Group
//Alternate names: /lfg
CMD:lookingforgroup(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /lookingforgroup [message]");
	SendChannelMessage(playerid, 8, params);
	return 1;
}

//Description: Sends a message to players who are looking for a group.
//Channel: Looking For Group
//Alternate names: /lookingforgroup
CMD:lfg(playerid, params[]) {
	return cmd_lookingforgroup(playerid, params);
}

//Description: Sends a message to the online players who are officers in your gang.
//Channel: Gang Officer
//Alternate names: /o
CMD:officer(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /officer [message]");
	SendChannelMessage(playerid, 9, params);
	return 1;
}

//Description: Sends a message to the online players who are officers in your gang.
//Channel: Gang Officer
//Alternate names: /officer
CMD:o(playerid, params[]) {
	return cmd_officer(playerid, params);
}

//Description: Sends a message to the online players in your gang.
//Channel: Gang
//Alternate names: /g
CMD:gang(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gang [message]");
	SendChannelMessage(playerid, 10, params);
	return 1;
}

//Description: Sends a message to the online players in your gang.
//Channel: Gang
//Alternate names: /gang
CMD:g(playerid, params[]) {
	return cmd_gang(playerid, params);
}

//Description: Sends a message to the specified channel.
//Channel: <channel>
//Alternate names: /<channel name>
CMD:chan(playerid, params[])
{
	new choice[32], szMessage[64];
	if(sscanf(params, "s[32]s[64]", choice, szMessage))
	{
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /chan [channel] [message]");
		SendClientMessage(playerid, COLOR_GREY, "Available names: Say, Zone, Trade, Group, Raid, Queue, Match, LFG, Officer, Gang");
		return 1;
	}
	if(isnull(szMessage))
	{
		SendClientMessage(playerid, COLOR_WHITE, "You must include a message to send.");
		return 1;
	}
	if(strcmp(choice, "say", true) == 0)
	{
		SendChannelMessage(playerid, 1, szMessage);
	}
	else if(strcmp(choice, "zone", true) == 0)
	{
		SendChannelMessage(playerid, 2, szMessage);
	}
	else if(strcmp(choice, "trade", true) == 0)
	{
		SendChannelMessage(playerid, 3, szMessage);
	}
	else if(strcmp(choice, "group", true) == 0)
	{
		SendChannelMessage(playerid, 4, szMessage);
	}
	else if(strcmp(choice, "raid", true) == 0)
	{
		SendChannelMessage(playerid, 5, szMessage);
	}
	else if(strcmp(choice, "queue", true) == 0)
	{
		SendChannelMessage(playerid, 6, szMessage);
	}
	else if(strcmp(choice, "match", true) == 0)
	{
		SendChannelMessage(playerid, 7, szMessage);
	}
	else if(strcmp(choice, "lfg", true) == 0)
	{
		SendChannelMessage(playerid, 8, szMessage);
	}
	else if(strcmp(choice, "officer", true) == 0)
	{
		SendChannelMessage(playerid, 9, szMessage);
	}
	else if(strcmp(choice, "gang", true) == 0)
	{
		SendChannelMessage(playerid, 10, szMessage);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GRAD4, "Invalid choice!");
	}
	return 1;
}

/*
//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}

//Description:
//Parameters:
//Alternate names:
CMD:(playerid, params[])
{
	return 1;
}
*/

























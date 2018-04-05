/*============================================================================
*		          _____                    _____           _______
		         /\    \                  /\    \         /::\    \
		        /::\    \                /::\____\       /::::\    \
		       /::::\    \              /:::/    /      /::::::\    \
		      /::::::\    \            /:::/    /      /::::::::\    \
		     /:::/\:::\    \          /:::/    /      /:::/~~\:::\    \
		    /:::/__\:::\    \        /:::/    /      /:::/    \:::\    \
		    \:::\   \:::\    \      /:::/    /      /:::/    / \:::\    \
		  ___\:::\   \:::\    \    /:::/    /      /:::/____/   \:::\____\
		 /\   \:::\   \:::\    \  /:::/    /      |:::|    |     |:::|    |
		/::\   \:::\   \:::\____\/:::/____/       |:::|____|     |:::|    |
		\:::\   \:::\   \::/    /\:::\    \        \:::\    \   /:::/    /
		 \:::\   \:::\   \/____/  \:::\    \        \:::\    \ /:::/    /
		  \:::\   \:::\    \       \:::\    \        \:::\    /:::/    /
		   \:::\   \:::\____\       \:::\    \        \:::\__/:::/    /
		    \:::\  /:::/    /        \:::\    \        \::::::::/    /
		     \:::\/:::/    /          \:::\    \        \::::::/    /
		      \::::::/    /            \:::\    \        \::::/    /
		       \::::/    /              \:::\____\        \::/____/
		        \::/    /                \::/    /         ~~
		         \/____/                  \/____/

*
*   						Begin Mission System by Natsumi
*   					   Copyright 2018 Slum Lords Online.
*   							   All right reserved.
*
*
*   You are not under ANY circumstances allowed
*   to reproduce or re-distribute this document
*   without the express written consent of the
*   the creator.
*
*   Legal action will be taken on anyone who
*   does not comply with the above stated information.
*
*============================================================================*/
//define mission steps
#define MAX_STEPS 9

new Step[MAX_STEPS];

CheckStep(playerid, step)
{
	if(step == AccountInfo[playerid][pMiss1Step])
	    return 1;
	else
	    return 0;
}

forward BeginMission(playerid, mission, titletext[], lifepath);
public BeginMission(playerid, mission, titletext[], lifepath)
{
	string[124];
    format(string, sizeof(string), "~y~Mission:~n~~g~%s", titletext);
	GameTextForPlayer(playerid, string, 8000, 1);
	SetPlayerMissionData(playerid, mission, 1); //playerid, mission, step
	ShowCutscene(playerid, mission, 1);
	
	return 1;
}

SetPlayerMissionData(playerid, mission, step, lifepath) {
	AccountInfo[playerid][pMission] = mission;
	AccountInfo[playerid][pStep] = step;
	return 1;
}

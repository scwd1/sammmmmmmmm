#define		TUT_XPOS    		950.6982
#define		TUT_YPOS    		-2392.4575
#define		TUT_ZPOS    		8.6577

#define 	MAX_DIALOG_LINES    3

new CutScenePosition[MAX_PLAYERS] = 0;
new Actor_Darren;
new Actor_Crew[3];

hook OnPlayerConnect(playerid)
{
	TutStep[playerid] = 0;
	return 1;
}

hook OnGameModeInit()
{
    Actor_Darren = CreateDynamicActor(230, 1226.9176,-811.2573,1084.0078,145.7431);
    Actor_Crew[0] = CreateDynamicActor(230, 1226.5718,-812.8746,1084.0078,330.9014);
    Actor_Crew[1] = CreateDynamicActor(230, 1225.3668,-812.0951,1084.0078,289.3961);
    Actor_Crew[2] = CreateDynamicActor(230, 1226.0903,-813.7460,1084.0078,345.9417);
    Actor_Crew[3] = CreateDynamicActor(230, 1227.4506,-813.6615,1084.0078,345.9417);
	return 1;
}

SetupCutscene(playerid, posx, posy, posz)
{
	TextDrawShowForPlayer(playerid, WIDESCREEN_TOP);
	TextDrawShowForPlayer(playerid, WIDESCREEN_BOTTOM);
    Streamer_UpdateEx(playerid, posx, posy, posz);
	SetPlayerPos(playerid, posx, posy, posz);
}

/*CutsceneDialog(playerid, dialog[], actor, line)
{
	switch(actor)
	{
	    case 1: {
			switch(line) {
				case 1:	TextDrawSetString(ACTOR1_DIALOG[0], dialog);
				case 2:	TextDrawSetString(ACTOR1_DIALOG[1], dialog);
				case 3:	TextDrawSetString(ACTOR1_DIALOG[2], dialog);
				default: printf("Cutscene Dialog error! Max lines is %d. Please change this in the script.", MAX_DIALOG_LINES);
			}
	    }
	    case 2: {
			switch(line) {
				case 1:	TextDrawSetString(ACTOR2_DIALOG[0], dialog);
				case 2:	TextDrawSetString(ACTOR2_DIALOG[1], dialog);
				case 3:	TextDrawSetString(ACTOR2_DIALOG[2], dialog);
				default: printf("Cutscene Dialog error! Max lines is %d. Please change this in the script.", MAX_DIALOG_LINES);
			}
	    }
	}
	return 1;
}*/

ShowLoadScreen(playerid)
{
	SetPVarInt(playerid, "LoadScreenActive", 1);
    //new LSTime = max(5000, 20000);
	//TextDrawShowForPlayer(playerid, LOAD_SCREEN);
	//SetTimerEx("CloseLoadScreen", LSTime, false, "i", playerid);
	return 1;
}

StartTutorial(playerid) //This sets up the beginning of the tut.
{
	if(GetPVarInt(playerid, "JustRegistered") == 1)
	{
	    SetupCutscene(playerid);
	    ShowLoadScreen(playerid); // Loading screen to get the position setup and what not
	    TogglePlayerControllable(playerid, 0); // Freeze them, no moving.
	    SetPlayerPos(playerid, TUT_XPOS, TUT_YPOS, TUT_ZPOS); // Set their position to the set tut positions
	    SetTimerEx("AdvanceCutscene", 10000, false, "i", playerid); // This will start the cutscenes
	}
	return 1;
}

AdvanceTutorial(playerid, step)
{
	TutStep[playerid]++;
	if(TutStep[playerid] > 0)
	{
		switch(TutStep[playerid])
		{
		    case 1: {
		    

      		}
		    case 2: {

		    }
		    case 3: {

		    }
		    case 4: {

		    }
		}
	}
	return 1;
}

EndTutorial(playerid)
{
	return 1;
}

forward AdvanceCutscene(playerid); // This will start a cutscene
public AdvanceCutscene(playerid)
{
	CutScenePosition[playerid]++; // This advances the cutscene to the next one in the series
	if(TutStep[playerid] > 0) // Checks if the player is in the Tutorial or not and which step.
	{
		switch(CutScenePosition[playerid]) // This checks which cutscene spot they are on in the series.
		{
		    case 1: { // spot 1, player lock picking door for 'Darrens' house.
		        SetPlayerPos(playerid, TUT_XPOS, TUT_YPOS, TUT_ZPOS);
		        //InterpolatePlayerCamera(playerid, 1297.449218, -802.154724, 85.040519, 1298.515869, -797.425109, 83.818641, 1302.898071, -799.176757, 84.861015, 1298.183471, -797.776550, 83.959716, 10000);
		        //PlayAnimEx(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1); // washhands anim
				SetTimerEx("PerformAnims", 10000, false, "i", playerid);
		    }
		    case 2: { // spot 2, darren interacting with his crew
		    
		    }
		    case 3: { // spot 3, darren walking to the safe
		    
		    }
		    case 4: { // spot 4, darren opening and closing the safe
				//PlayAnimEx(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 0, 0, 1); // Bomb type of anim
		    }
		    case 5: { // spot 5, you walk in front door
		    
		    }
		    case 6: { // spot 6, End Cutscene (you say you need that cash) and Advance Tutorial
		        
		    }
		}
	}
	return 1;
}

forward PerformAnims(playerid);
public PerformAnims(playerid)
{
	if(GetPlayerAnimationIndex(playerid))
	{
	    new animlib[32], animname[32], msg[128];
	    GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
	    if(!strcmp(animname, "BOM_Plant_Loop", true)) {
	        if(TutStep[playerid] == 0) {
		    	//PlayAnim(playerid, "MISC", "Plunger_01", 4.1, 0, 1, 1, 1, 1, 1); // Breaking lock and opening type of anim
		    	SetTimerEx("PerformAnims", 10000, false, "i", playerid);
	    	}
		}
	    else if(!strcmp(animname, "Plunger_01", true)) {
	        if(TutStep[playerid] == 0) SetTimerEx("AdvanceCutscene", 5000, false, "i", playerid); // This will advance the cutscene to Darren & his crew
		}
	}
	return 1;
}
forward CloseLoadScreen(playerid);
public CloseLoadScreen(playerid)
{
	if(TutStep[playerid] > 0)
	{
	
	}
	return 1;
}


















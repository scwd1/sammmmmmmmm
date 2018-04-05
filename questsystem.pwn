//Quest Types
//1.) Tutorial (Level 1)
//2.) Character Progression (Level 1 - 70)
//3.) Mainland (Level 4- 70)
//4.) Adventure Zone (Level 6 - 70)
//5.) Class (Level 8 - 60)


//Level | Quest Name | How Start | How Finish | Zone
//Objective
//Summary
//Steps
//Dialog
//Completion
//Items Gained

enum E_QUEST_DATA
{
	qName[64],
	qObjective[128],
	qSummary[128],
	qZone,
	qLevelReq,
	qType,
	qQuestGiver,
	qVW,
	qInt,
	Float:qStartPosX,
	Float:qStartPosY,
	Float:qStartPosZ,
	qIDStep[10],
	Float:qSPosXStep[10],
	Float:qSPosYStep[10],
	Float:qSPosZStep[10],
	Float:qEPosXStep[10],
	Float:qEPosYStep[10],
	Float:qEPosZStep[10],
	qRewardItem[5],
	qRewardGold,
	/*qStep1Item2,
	qStep1Item3,
	qStep1Item4,
	qStep1Item5,
	qStep1Item6,
	qStep1Item7,
	qStep1Item8,
	qStep1Item9,
	qStep1Item10,*/
}
new QuestData[MAX_QUESTS][E_QUEST_DATA];

CreateQuest(objective[], summary[], steps, dialogs, completion, itemsgained)
{

	return 1;
}

GetQuestType(questid)
{
	switch(questid)
	{
	    case 1: {

	    }
	    case 2: {

	    }
	    case 3: {

	    }
	    case 4: {

	    }
	    case 5: {

	    }
	    case 6: {

	    }
	    case 7: {

	    }
	}
	return 1;
}































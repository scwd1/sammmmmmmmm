/*Instance = Different VW's of Maps
Zones    = Different Maps*/

#include <a_samp>
#include <sscanf2>
#include <YSI\y_ini>
#include <YSI\y_hooks>
#include <YSI\y_timers>
#include <zcmd>
#include <a_mysql>
#include <streamer>
#include <colandreas>
#include <hudlesscam>
#include <attacking_npc>
#include <AFW>

#define NOTADMIN "{F81414}[SYSTEM]: This is not a recognized command."

#define COLOR_TWWHITE 		0xFFFFFFAA
#define COLOR_TWYELLOW 		0xFFFF00AA
#define COLOR_TWPINK 		0xE75480AA
#define COLOR_TWRED 		0xFF0000AA
#define COLOR_TWBROWN 		0x654321AA
#define COLOR_TWGRAY 		0x808080AA
#define COLOR_TWOLIVE 		0x808000AA
#define COLOR_TWPURPLE 		0x800080AA
#define COLOR_TWTAN 		0xD2B48CAA
#define COLOR_TWAQUA 		0x00FFFFAA
#define COLOR_TWORANGE 		0xFF8C00AA
#define COLOR_TWAZURE 		0x007FFFAA
#define COLOR_TWGREEN 		0x008000AA
#define COLOR_TWBLUE 		0x0000FFAA
#define COLOR_TWBLACK 		0x000000AA
#define COLOR_ORANGE 		0xFF8000FF
#define COL_WHITE 			"{FFFFFF}"
#define COL_YELLOW 			"{F3FF02}"
#define COL_RED 			"{F81414}"
#define COLOR_BITEM 		0xE1B0B0FF
#define COLOR_GRAD1 		0xB4B5B7FF
#define COLOR_GRAD2 		0xBFC0C2FF
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_RED 			0xAA3333AA
#define COLOR_BLACK         0x000001FF
#define COLOR_BLUE 			0x007BD0FF
#define COLOR_LIGHTORANGE 	0xFFA100FF
#define COLOR_FLASH 		0xFF000080
#define COLOR_LIGHTRED 		0xFF6347AA
#define COLOR_LIGHTBLUE 	0x33CCFFAA
#define COLOR_LIGHTGREEN 	0x9ACD32AA
#define COLOR_YELLOW 		0xFFFF00AA
#define COLOR_LIGHTYELLOW	0xFFFF91FF
#define COLOR_YELLOW2 		0xF5DEB3AA
#define COLOR_WHITE 		0xFFFFFFAA
#define COLOR_FADE1 		0xE6E6E6E6
#define COLOR_FADE2 		0xC8C8C8C8
#define COLOR_FADE3 		0xAAAAAAAA
#define COLOR_FADE4 		0x8C8C8C8C
#define COLOR_FADE5 		0x6E6E6E6E
#define COLOR_PURPLE 		0xC2A2DAAA
#define COLOR_DBLUE 		0x2641FEAA
#define COLOR_DOC 			0xFF8282AA
#define COLOR_DCHAT 		0xF0CC00FF
#define COLOR_NEWS 			0xFFA500AA
#define COLOR_OOC 			0xE0FFFFAA
#define TEAM_BLUE_COLOR 	0x8D8DFF00
#define TEAM_GROVE_COLOR 	0x00AA00FF
#define TEAM_AZTECAS_COLOR 	0x01FCFFC8
#define NEWBIE_COLOR 		0x7DAEFFFF
#define SAMP_COLOR			0xAAC4E5FF


#define			MAX_ZONE_NAME		28
#define 		ADMIN_JUNIOR 		2
#define 		ADMIN_GENERAL		3
#define 		ADMIN_SENIOR 		4
#define 		ADMIN_HEAD			1337
#define 		ADMIN_EXECUTIVE 	99999

#define 		MAX_CLASSES     	5
#define     	BASE_CHAR_CLASSES   3

#define         MAX_B_WORLDS        5 //Total number of base worlds
#define         MAX_NB_WORLDS       2004

#define         MAX_LIFE_PATHS      7
#define 		MAX_DDOORS			(3000)
#define 		FREEZE_TIME			2000

//Begin Dialog Defines
#define 		WEPCREATE_MAIN      2
#define         GANGCREATION1       10
#define			GANGCREATIONNAME    11



// Types of Punishments
#define PUNISH_KICK         0
#define PUNISH_BAN 			1
#define PUNISH_AJ         	2
#define PUNISH_BLOCK   		3
#define PUNISH_WARN         4
#define PUNISH_GAME_SCORE	5
#define PUNISH_BLOCK_VEH	6
#define PUNISH_BLOCK_RUN	7
#define PUNISH_BLOCK_OOC	8
#define PUNISH_BLOCK_DMG	9

// Types of Stores
#define PLACE_TYPE_BANK			1
#define PLACE_TYPE_HOTEL		2
#define PLACE_TYPE_SHOP			3
#define PLACE_TYPE_VICTIM		4
#define PLACE_TYPE_PHARMACY		5
#define PLACE_TYPE_CARDEALER	6
#define PLACE_TYPE_AMMUNATION	7
#define PLACE_TYPE_TOOLSHOP		8

//new MessageString[128];
//#define SendClientMessageFt(%0,%1,%2,%3) (format(MessageString, sizeof(MessageString), %2, %3), SendClientMessage(%0, %1, MessageString))

new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];

//Fowards
forward split(const strsrc[], strdest[][], delimiter);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward ProxDetectorS(Float:radi, playerid, targetid);

//-------------------------------------
//Variables
//new IsInPVPArena[MAX_PLAYERS];
new IsInMount[MAX_PLAYERS];
new bool:AFKStatus[MAX_PLAYERS];
new seconds[MAX_PLAYERS] = 15;
new PTeamID[MAX_PLAYERS];
new bool:IsTeamLeader[MAX_PLAYERS];
new LastWhisper[MAX_PLAYERS];
new LastUsedChannel[MAX_PLAYERS];
new bool:IsInDeath[MAX_PLAYERS];
new bool:IsInMission[MAX_PLAYERS];
new bool:IsInTutorial[MAX_PLAYERS];
new bool:IsLoggingIn[MAX_PLAYERS];
new bool:IsRegistering[MAX_PLAYERS];
new TutStep[MAX_PLAYERS] = 0;
new CreatedCars[100] = INVALID_VEHICLE_ID;
new Text3D:NameTag[MAX_PLAYERS];
new ActorNoob;
new ShotPlayer[MAX_PLAYERS][MAX_PLAYERS];
new LastShot[MAX_PLAYERS];
new aLastShot[MAX_PLAYERS];
new CurrentVehicle[MAX_PLAYERS];
new CurrentVehicleSeat[MAX_PLAYERS];
new PlayerText:LicenseP[11][MAX_PLAYERS];
new Text:License[27];

//--------------------------
//| Chat Channels          |
//|                        |
//| 1.) Say                |
//| 2.) Zone               |
//| 3.) Trade              |
//| 4.) Group(Party)       |
//| 5.) Raid               |
//| 6.) Queue              |
//| 7.) Match              |
//| 8.) Looking for Group  |
//| 9.) Gang Officer       |
//| 10.) Gang              |
//|                        |
//--------------------------
//--------------------------
//| Character Roles        |
//|                        |
//| 1.) Defender           |
//| 2.) Leader             |
//| 3.) Controller         |
//| 4.) Striker            |
//|                        |
//--------------------------

new PlayerText:Textdraw[18][MAX_PLAYERS];
new Text:TitleTD[24];
new Text:WIDESCREEN_TOP;
new Text:WIDESCREEN_BOTTOM;
new DeathCDT[MAX_PLAYERS];
new AFKPlayerCount;
new CurrentMission[MAX_PLAYERS];

new SskinData[][] = { //Starter Skins
//  ID  	//Gender    	//Race
	{0,		"Male",			"White"},
	{1, 	"Herbalist", 	"Healer", 		"Leader"},
	{2, 	"Ranger", 		"DPS", 			"Striker"},
	{3, 	"Brute", 		"Tank", 		"Defender"},
	{4, 	"Illusionist", 	"Controller", 	"Controller"}
};

enum E_CLASS_DATA {
	cID,
	cName[25],
	cClass[25],
	cRole[25]
};

new clsDta[MAX_CLASSES][E_CLASS_DATA] = {
//  ID  	//Class Name    //Class 		//Role
	{0,		"(null)",		"(null)",		"(null)"}, //Placeholder to prevent issues
	{1, 	"Herbalist", 	"Healer", 		"Leader"},
	{2, 	"Ranger", 		"DPS", 			"Striker"},
	{3, 	"Brute", 		"Tank", 		"Defender"},
	{4, 	"Illusionist", 	"Controller", 	"Controller"}
};

enum E_WORLDID_DATA {
	wID,
	wStatus, //Check to see if this world is open/available.
	wNumMin, //The Virtual World ID.
	wNumMax,
	wSpecial //Check to see if this is a 'special' world.
};

//Instance Informations
new wldIDDta[MAX_B_WORLDS][E_WORLDID_DATA] = {
//  ID  	//Status    //NumMin 		//NumMax	//Special
	{0,		0,			0,				0,			0}, //Will serve as default world (If someone is in this, check for bugged or hacks)
	{1, 	1, 			1000, 			1005,		0}, //Tutorial and Login/Register (Specific to tutorial and Login/Register)
	{2, 	1,			2000,			2000,		0}, //Main world (Will never change from 2000(Always this if in main world)
	{3, 	1,			3000,			3999,		0}, //Missions (3000 - 3999) [Allows for up to 1k Mission Interiors]
	{4, 	1,			4000,			4999,		0}  //Non-Mission and other worlds. (4000 - 4999) [Allows for up to 1k Non-Mission Interiors]
};

GetVW(playerid)
{
	new playervw;
	if(IsInMission[playerid] == true) {
		playervw = wldIDDta[3][wNumMin] + CurrentMission[playerid];
	}
	else if(IsInTutorial[playerid] == true) {//Tutorial
	    playervw = wldIDDta[1][wNumMin];
	}
	else if(IsRegistering[playerid] == true) {//Registering
	    playervw = wldIDDta[1][wNumMin] + 1;
	}
	else if(IsLoggingIn[playerid] == true) {//Logging In
	    playervw = wldIDDta[1][wNumMin] + 2;
	}
	//Non-Mission and other worlds here.
	else {
        playervw = wldIDDta[2][wNumMin];
	}
	return playervw;
}

/*enum Cdt_Scores { //Max Credit score is 850
	cPayHist,   //Percentage of payments completed. [35% of score]
	cUse,       //Percent of Credit used (Loans etc) [30% of score]
	cLength,    //Length of Credit history [15% of score]
	cNewCred,   //Any new credit history [20% of score]
	cTotalScore
};
new Credit[MAX_PLAYERS][Cdt_Scores];

CalculateCreditScore(playerid)
{
	return 1;
}

CalculatePayHistory(playerid)
{
	new totalpays = AccountInfo[playerid][pCompletePays] + AccountInfo[playerid][pIncompletePays];
	new complate = AccountInfo[playerid][pCompletePays];
	new Float:fPercentage = (complete/totalpays) * 100.0;
	new percentage = floatround(fPercentage, floatround_round);
	return percentage;
}*/

//You've made a total of 15 completed payments
//You've missed a total of 15 payments
//Your total payments is 30
//You've completed 50% of your payments

enum SAZONE_MAIN { //Betamaster
	SAZONE_NAME[28],
	Float:SAZONE_AREA[6]
};

enum MAIN_ZONES { //Betamaster
	SAZONE_NAME[28],
	Float:SAZONE_AREA[6]
}

new const gSAZones[][SAZONE_MAIN] = {  // Majority of names and area coordinates adopted from Mabako's 'Zones Script' v0.2
	//	NAME                            AREA (Xmin,Ymin,Zmin,Xmax,Ymax,Zmax)
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Crate Cave",                  {-2500.00,-2000.00,11000.00,-1500.00,-1400.00,12000.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Donahue Acres",               {-1599.56,-1306.60,-89.00,-1219.82,-866.31,300.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Gov. Weapon Facility",        {-1391.87,4087.72,-89.00,-883.24,4966.63,300.00}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Mile High Club",              {1590.00,1370.00,1120.00,1830.00,1550.00,1190.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Main Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}},
	{"San Andreas",                 {-10000.00,-10000.00,-242.90,10000.00,10000.00,900.00}}
};


new const gMainZones[][MAIN_ZONES] = {  // Majority of names and area coordinates adopted from Mabako's 'Zones Script' v0.2
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}},
	{"San Andreas",                 {-10000.00,-10000.00,-242.90,10000.00,10000.00,900.00}}
};

stock GetPlayer2DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock GetPlayer3DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock Get3DZone(Float:x, Float:y, Float:z, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock IsPlayerInZone(playerid, zone[]) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new TmpZone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, TmpZone, sizeof(TmpZone));
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(strfind(TmpZone, zone, true) != -1)
			return 1;
	}
	return 0;
}

stock GetPlayerMainZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gMainZones); i++ )
 	{
		if(x >= gMainZones[i][SAZONE_AREA][0] && x <= gMainZones[i][SAZONE_AREA][3] && y >= gMainZones[i][SAZONE_AREA][1] && y <= gMainZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gMainZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

//-----------------------------


// MySQL configuration
#define		MYSQL_HOST 			"127.0.0.1"
#define		MYSQL_USER 			"root"
#define		MYSQL_PASSWORD 		""
#define		MYSQL_DATABASE 		"sampslo"

// how many seconds until it kicks the player for taking too long to login
#define		SECONDS_TO_LOGIN 	30

// default spawn point: Los Santos (Mad Dogg's Mansion)
#define 	DEFAULT_POS_X 		1298.5625
#define 	DEFAULT_POS_Y 		-798.5397
#define 	DEFAULT_POS_Z 		84.1406
#define 	DEFAULT_POS_A 		2.5283

// MySQL connection handle
new MySQL: g_SQL;
// player data
enum E_PLAYERS
{
	pID,
	pName[MAX_PLAYER_NAME],
	pPassword[65], // the output of SHA256_PassHash function (which was added in 0.3.7 R1 version) is always 256 bytes in length, or the equivalent of 64 Pawn cells
	pSalt[17],
	pKills,
	pDeaths,
	Float: pX_Pos,
	Float: pY_Pos,
	Float: pZ_Pos,
	Float: pA_Pos,
	pInterior,
    pVW,
    pAdmin,
    pSecKey,
	Float:pHealth,
	Float:pArmor,
    pCash,
    pSkin,
    pLevel,
    //Begin Alllllll the funs
    pHeadGear,
    pArmorGear,
    pArmGear,
    pFeetArmor,
    pNeckArmor,
    pRightRing,
    pLeftRing,
    pWaistGear,
    pShirt,
    pPants,
	pBirthM,
	pBirthD,
	pBirthY,
	pLicenseIssued,
	pLicenseFIssued,
    //End Allllll the funs
    pPhase,
    pClassID,
    pCharPath,
    pScore,
    pVIP,
	pRMuted,
	//----[ChatVariables]----
    pChatChannel1,
    pChatChannel2,
    pChatChannel3,
    pChatChannel4,
    pChatChannel5,
    pChatChannel6,
    pChatChannel7,
    pChatChannel8,
    pChatChannel9,
    pChatChannel10,
    //--[EndChatVariables]--
	Cache: pCache_ID,
	bool: pIsLoggedIn,
	pLoginAttempts,
	pLoginTimer
};
new AccountInfo[MAX_PLAYERS][E_PLAYERS];

new g_MysqlRaceCheck[MAX_PLAYERS];

// dialog data
enum
{
	DIALOG_UNUSED,

	DIALOG_LOGIN,
	DIALOG_REGISTER
};

enum ddInfo
{
	ddSQLId,
	ddDescription[128],
	ddPickupID,
	ddPickupID_int,
	ddAreaID,
	ddAreaID_int,
	Text3D: ddTextID,
	ddCustomInterior,
	ddExteriorVW,
	ddExteriorInt,
	ddInteriorVW,
	ddInteriorInt,
	Float: ddExteriorX,
	Float: ddExteriorY,
	Float: ddExteriorZ,
	Float: ddExteriorA,
	Float: ddInteriorX,
	Float: ddInteriorY,
	Float: ddInteriorZ,
	Float: ddInteriorA,
	ddCustomExterior,
	ddVIP,
	ddAdmin,
	ddVehicleAble,
	ddColor,
	ddPickupModel,
};
new DDoorsInfo[MAX_DDOORS][ddInfo];

#include "sqldata.pwn"
#include "armorsystem.pwn"
#include "weaponsystem.pwn"
#include "chestsystem.pwn"
#include "doors.pwn"
#include "hudsystem.pwn"
//#include "tutorial.pwn"
#include "./admin/vehiclespawn.pwn"
//#include "chatsystem.pwn"

new ablScr[][7]=
{
//  Pri    Sec 	 A 	 B 	 C 	 Ttl
	{18, 13, 13, 10, 10, 8,  72},
	{18, 13, 13, 10, 8,  10, 72},
	{18, 13, 13, 8,  10, 10, 72},
	{17, 14, 13, 10, 10, 10, 74},
	{17, 13, 14, 10, 10, 10, 74},
	{17, 13, 13, 11, 11, 10, 75},
	{17, 13, 13, 11, 10, 11, 75},
	{16, 16, 12, 10, 10, 10, 74},
	{16, 15, 13, 11, 11, 9,  75},
	{16, 14, 14, 11, 10, 10, 75},
	{16, 13, 15, 11, 11, 9,  75},
	{16, 12, 16, 10, 10, 10, 74},
	{15, 15, 13, 12, 11, 10, 76},
	{15, 15, 13, 11, 10, 12, 76},
	{15, 14, 13, 12, 12, 11, 77},
	{15, 13, 15, 12, 11, 10, 76},
	{15, 13, 15, 11, 10, 12, 76},
	{15, 13, 14, 12, 12, 11, 77}
};

stock _GivePlayerMoney(playerid, money)
{
	AccountInfo[playerid][pCash] += money;
	GivePlayerMoney(playerid, AccountInfo[playerid][pCash] - GetPlayerMoney(playerid));
}
#define GivePlayerMoney(%0,%1) _GivePlayerMoney(%0,%1)

stock _SetPlayerVirtualWorld(playerid, vw)
{
	//OnPlayerVirtualWorldChange(playerid, vw);
	SetPlayerVirtualWorld(playerid, vw);
}
#define SetPlayerVirtualWorld(%0,%1) _SetPlayerVirtualWorld(%0, %1)

stock _SetPlayerHealth(playerid, Float:health)
{
	AccountInfo[playerid][pHealth] = health;
	SetPlayerHealth(playerid, floatround(AccountInfo[playerid][pHealth]));
}
#define SetPlayerHealth(%0,%1) _SetPlayerHealth(%0,%1)

stock _SetPlayerArmour(playerid, Float:armour)
{
	AccountInfo[playerid][pArmor] = armour;
	SetPlayerArmour(playerid, floatround(AccountInfo[playerid][pArmor]));
}
#define SetPlayerArmour(%0,%1) _SetPlayerArmour(%0, %1)

public ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				new playerworld, player2world;
				playerworld = GetPlayerVirtualWorld(playerid);
				player2world = GetPlayerVirtualWorld(i);
				if(playerworld == player2world)
				{
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}
	return 1;
}

public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

//(Don't actually use stocks, however, its still here for a search term)
//STOCKS & functions
stock SetAllWeaponSkills(playerid, skill)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL,			100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED,	skill);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE,		skill);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN,			skill);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN,	100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN,	skill);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI,		100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5,				skill);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47,				skill);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4,				skill);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE,		skill);
}

stock RemovePlayerWeapon(playerid, weaponid)
{
	new weapondata[12][2];

	for(new i = 0; i < 12; i++)
	{
		GetPlayerWeaponData(playerid, i, weapondata[i][0], weapondata[i][1]);
		if(weapondata[i][0] == weaponid)weapondata[i][0] = 0;
	}

	ResetPlayerWeapons(playerid);

	for(new i = 0; i != 12; i++)
		GivePlayerWeapon(playerid, weapondata[i][0], weapondata[i][1]);
}

stock SendGuiInformation(playerid, caption[], text[])
{
	return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, caption, text, "OK", "");
}

stock GetStaffRank(playerid)
{
	new string[42];
	if(AccountInfo[playerid][pAdmin] == 1)
	{
		format(string, sizeof(string), "{FFFF00}Volunteer{FFFFFF}");
	}
	else if(AccountInfo[playerid][pAdmin] > 1)
	{
		switch(AccountInfo[playerid][pAdmin])
		{
			case 2: format(string, sizeof(string), "{00FF00}Intern{FFFFFF}");
			case 3: format(string, sizeof(string), "{00FF00}Staff{FFFFFF}");
			case 4: format(string, sizeof(string), "{F4A460}Assistant Manager{FFFFFF}");
			case 1337: format(string, sizeof(string), "{FF0000}General Manager{FFFFFF}");
			case 1338: format(string, sizeof(string), "{298EFF}Supervisor{FFFFFF}");
			case 99999: format(string, sizeof(string), "{298EFF}CEO{FFFFFF}");
			default: format(string, sizeof(string), "Undefined Staff (%d)", AccountInfo[playerid][pAdmin]);
		}
	}
	return string;
}

SendClientMessageEx(playerid, color, text[])
{

    SendClientMessage(playerid, color, text);
	return 1;
}

PutPlayerInVehicleEx(playerid, vehicleid, seatid)
{
	CurrentVehicle[playerid] = vehicleid;
	CurrentVehicleSeat[playerid] = seatid;
    PutPlayerInVehicle(playerid, vehicleid, seatid);
    return 1;
}

stock SetPlayerArmor(playerid, Float:amount)
{
	SetPlayerArmour(playerid, amount);
	return 1;
}

ProxDetectorWrap(playerid, string[], width, Float:wrap_radius, col1, col2, col3, col4, col5)
{
	if(strlen(string) > width)
	{
		new firstline[128], secondline[128];
		strmid(firstline, string, 0, 88);
		strmid(secondline, string, 88, 150);
		format(firstline, sizeof(firstline), "%s...", firstline);
		format(secondline, sizeof(secondline), "...%s", secondline);
		ProxDetector(wrap_radius, playerid, firstline, col1, col2, col3, col4, col5);
		ProxDetector(wrap_radius, playerid, secondline, col1, col2, col3, col4, col5);
	}
	else ProxDetector(wrap_radius, playerid, string, col1, col2, col3, col4, col5);
}

RewardPlayer(playerid, cash = 0, exp = 0)
{
	if(cash != 0)
	{
	    GivePlayerMoney(playerid, 8);
		format(szMessage, sizeof(szMessage), "You've been rewarded %d Cash!", cash);
	}
	if(exp != 0)
	{
		format(szMessage, sizeof(szMessage), "You've been rewarded %d Experience Points!", exp);
	}
	if(cash != 0 && exp != 0)
	{
		format(szMessage, sizeof(szMessage), "You've been rewarded %d Cash, and %d Experience Points!", cash, exp);
	}
	return 1;
}

CheckPointCheck(iTargetID) {
	if(GetPVarType(iTargetID, "Mission1CP") > 0) {
	    return 1;
	}
	return 0;
}

GetCharacterPath(playerid)
{
	switch(AccountInfo[playerid][pCharPath])
	{
	    case 1: return 1; //Normal Civilian
	    case 2: return 2; //Police
	    case 3: return 3; //Medical
	    case 4: return 4; //Transportation
	    case 5: return 5; //Government
	    case 6: return 6; //Judicial
	}
	return 0;
}

GetPathName(path)
{
	new pathname[50];
	switch(path)
	{
	    case 1: pathname = "Civilian"; //Normal Civilian
	    case 2: pathname = "Law Enforcement"; //Police
	    case 3: pathname = "Medical"; //Medical
	    case 4: pathname = "Transportation"; //Transportation
	    case 5: pathname = "Government"; //Government
	    case 6: pathname = "Judicial"; //Judicial
	}
	return pathname;
}

IsChannelActive(playerid, channel)
{
	switch(channel)
	{
	    case 1: { if(AccountInfo[playerid][pChatChannel1] == 1) { return true; } else { return false; } }
	    case 2: { if(AccountInfo[playerid][pChatChannel2] == 1) { return true; } else { return false; } }
	    case 3: { if(AccountInfo[playerid][pChatChannel3] == 1) { return true; } else { return false; } }
	    case 4: { if(AccountInfo[playerid][pChatChannel4] == 1) { return true; } else { return false; } }
	    case 5: { if(AccountInfo[playerid][pChatChannel5] == 1) { return true; } else { return false; } }
	    case 6: { if(AccountInfo[playerid][pChatChannel6] == 1) { return true; } else { return false; } }
	    case 7: { if(AccountInfo[playerid][pChatChannel7] == 1) { return true; } else { return false; } }
	    case 8: { if(AccountInfo[playerid][pChatChannel8] == 1) { return true; } else { return false; } }
	    case 9: { if(AccountInfo[playerid][pChatChannel9] == 1) { return true; } else { return false; } }
	    case 10: { if(AccountInfo[playerid][pChatChannel10] == 1) { return true; } else { return false; } }
	}
	return 1;
}

GetChannelTag(chan)
{
	new channeltag[60];
	switch(chan)
	{
	    case 1: channeltag = "{FFFFFF}[SAY]:";
	    case 2: channeltag = "{C2A2DA}[ZONE]:";
	    case 3: channeltag = "{FFFF91}[TRADE]:";
	    case 4: channeltag = "{E1B0B0}[PARTY]:";
	    case 5: channeltag = "{AAC4E5}[RAID]:";
	    case 6: channeltag = "{FF8282}[QUEUE]:";
	    case 7: channeltag = "{33CCFF}[MATCH]:";
	    case 8: channeltag = "{00AA00}[LFG]:";
	    case 9: channeltag = "{FFA100}[OFFICER]:";
	    case 10: channeltag = "{FFA100}[GANG]:";
	}
	return channeltag;
}

SendChannelMessage(playerid, channel, message[])
{
	new string[124];
	foreach(new i: Player)
	{
		if(IsChannelActive(playerid, channel) == 1)
		{
		    if(channel == 4 && PTeamID[playerid] != 0)
		    {
				if(PTeamID[i] == PTeamID[playerid]) {
					format(string, sizeof(string), "%s %s: %s", GetChannelTag(channel), GetPlayerNameEx(playerid), message);
					SendClientMessage(i, COLOR_RED, string);
				}
			}
		    else if(channel == 4 && PTeamID[playerid] == 0)
		    {
				format(string, sizeof(string), "%s %s: You're not in a party, you must join a party to send this message.", GetChannelTag(channel), GetPlayerNameEx(playerid));
				SendClientMessage(i, COLOR_WHITE, string);
			}
			else
			{
				format(string, sizeof(string), "%s %s: %s", GetChannelTag(channel), GetPlayerNameEx(playerid), message);
				SendClientMessage(i, COLOR_GREEN, string);
			}
		}
	}
	LastUsedChannel[playerid] = channel;
	return 1;
}

ABroadCast(hColor, szMessage[], iLevel) {
	new string[124];
	foreach(new i: Player)
	{
		if(AccountInfo[i][pAdmin] >= iLevel) {
			format(string, sizeof(string), "{%s}[ADMIN]: %s: %s", hColor, GetPlayerNameEx(i), szMessage);
			SendClientMessageEx(i, hColor, szMessage);
		}
	}
	return 1;
}

stock Float:frandom(Float:max, Float:m2 = 0.0, dp = 3)
{
    new Float:mn = m2;
    if(m2 > max) {
        mn = max,
        max = m2;
    }
    m2 = floatpower(10.0, dp);

    return floatadd(floatdiv(float(random(floatround(floatmul(floatsub(max, mn), m2)))), m2), mn);
}

stock ShowMainMenuDialog(playerid, frame)
{
	new titlestring[64];
	new string[512];

	switch(frame)
	{
		case 1:
		{
		    IsLoggingIn[playerid] = true;
			format(titlestring, sizeof(titlestring), "{3399FF}Login - %s", GetPlayerNameEx(playerid));
			format(string, sizeof(string), "{FFFFFF}Welcome to Slum Lords Online %s.\n\nCurrent Season is: Season 1\n\nThe name that you are using is registered, please enter your password to login:", GetPlayerNameEx(playerid));
			ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,titlestring,string,"Login","Exit");
		}
		case 2:
		{
		    IsRegistering[playerid] = true;
			format(titlestring, sizeof(titlestring), "{3399FF}Register - %s", GetPlayerNameEx(playerid));
			format(string, sizeof(string), "{FFFFFF}Welcome to Slum Lords Online %s.\n\nCurrent Season is: Season 1\n\n{FFFFFF}You may {AA3333}register {FFFFFF}an account by entering a desired password here:", GetPlayerNameEx(playerid));
			ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_PASSWORD,titlestring,string,"Register","Exit");
		}
		case 3:
		{
			format(titlestring, sizeof(titlestring), "{3399FF}Login - %s", GetPlayerNameEx(playerid));
			format(string, sizeof(string), "{FFFFFF}Invalid Password!\n\nWelcome to Slum Lords Online %s.\n\nCurrent Season is: Season 1\n\nThe name that you are using is registered, please enter a password to login:", GetPlayerNameEx(playerid));
			ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,titlestring,string,"Login","Exit");
		}
		case 4:
		{
			format(titlestring, sizeof(titlestring), "{3399FF}Account Locked - %s", GetPlayerNameEx(playerid));
			format(string, sizeof(string), "{FFFFFF}Our database indicates that %s is currently logged in, if this is a mistake please contact a tech administrator.", GetPlayerNameEx(playerid));
			ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_MSGBOX,titlestring,string,"Exit","");
		}
	}
}

stock ApplyPlayerAnimation(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
    ApplyAnimation(playerid, animlib, "null", fDelta, loop, lockx, locky, freeze, time, forcesync); // Pre-load animation library
    return ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
}

stock abs(value)
{
    return ((value < 0 ) ? (-value) : (value));
}

stock str_replace(sSearch[], sReplace[], const sSubject[], &iCount = 0)
{
	new
		iLengthTarget = strlen(sSearch),
		iLengthReplace = strlen(sReplace),
		iLengthSource = strlen(sSubject),
		iItterations = (iLengthSource - iLengthTarget) + 1;

	new
		sTemp[128],
		sReturn[128];

	strcat(sReturn, sSubject, 256);
	iCount = 0;

	for(new iIndex; iIndex < iItterations; ++iIndex)
	{
		strmid(sTemp, sReturn, iIndex, (iIndex + iLengthTarget), (iLengthTarget + 1));

		if(!strcmp(sTemp, sSearch, false))
		{
			strdel(sReturn, iIndex, (iIndex + iLengthTarget));
			strins(sReturn, sReplace, iIndex, iLengthReplace);

			iIndex += iLengthTarget;
			iCount++;
		}
	}
	return sReturn;
}

stock splits(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
		if(strsrc[i]==delimiter || i==strlen(strsrc)){
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return 1;
}

stock GetClosestPlayer(p1)
{
	new Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	foreach(new x: Player)
	{
		if(x != p1)
		{
			dis2 = GetDistanceBetweenPlayers(x,p1);
			if(dis2 < dis && dis2 != -1.00)
			{
				dis = dis2;
				player = x;
			}
		}
	}
	return player;
}

stock Float: FormatFloat(Float:number) {
    if(number != number) return 0.0;
    else return number;
}

stock GetPlayerNameExt(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock GetWeaponNameEx(weaponid)
{
	new name[MAX_PLAYER_NAME];
	GetWeaponName(weaponid, name, sizeof(name));
	return name;
}

stock GetPlayerNameEx(playerid) {

	new
		szName[MAX_PLAYER_NAME],
		iPos;

	GetPlayerName(playerid, szName, MAX_PLAYER_NAME);
	while ((iPos = strfind(szName, "_", false, iPos)) != -1) szName[iPos] = ' ';
	return szName;
}

stock GetPlayerIpEx(playerid)
{
    new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}

stock StripNewLine(string[])
{
  new len = strlen(string);
  if (string[0]==0) return ;
  if ((string[len - 1] == '\n') || (string[len - 1] == '\r'))
    {
      string[len - 1] = 0;
      if (string[0]==0) return ;
      if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
    }
}

stock StripColorEmbedding(string[])
{
 	new i, tmp[7];
  	while (i < strlen(string) - 7)
	{
	    if (string[i] == '{' && string[i + 7] == '}')
		{
		    strmid(tmp, string, i + 1, i + 7);
			if (ishex(tmp))
			{
				strdel(string, i, i + 8);
				i = 0;
				continue;
			}
		}
		i++;
  	}
}

stock strtoupper(string[])
{
        new retStr[128], i, j;
        while ((j = string[i])) retStr[i++] = chrtoupper(j);
        retStr[i] = '\0';
        return retStr;
}

stock wordwrap(string[], width, seperator[] = "\n", dest[], size = sizeof(dest))
{
    if (dest[0])
    {
        dest[0] = '\0';
    }
    new
        length,
        multiple,
        processed,
        tmp[192];

    strmid(tmp, string, 0, width);
    length = strlen(string);

    if (width > length || !width)
    {
        memcpy(dest, string, _, size * 4, size);
        return 0;
    }
    for (new i = 1; i < length; i ++)
    {
        if (tmp[0] == ' ')
        {
            strdel(tmp, 0, 1);
        }
        multiple = !(i % width);
        if (multiple)
        {
            strcat(dest, tmp, size);
            strcat(dest, seperator, size);
            strmid(tmp, string, i, width + i);
            if (strlen(tmp) < width)
            {
                strmid(tmp, string, (width * processed) + width, length);
                if (tmp[0] == ' ')
                {
                    strdel(tmp, 0, 1);
                }
                strcat(dest, tmp, size);
                break;
            }
            processed++;
            continue;
        }
        else if (i == length - 1)
        {
            strmid(tmp, string, (width * processed), length);
            strcat(dest, tmp, size);
            break;
        }
    }
    return 1;
}

stock IsAdminLevel(playerid, level, warning = 1) {

	if(AccountInfo[playerid][pAdmin] >= level) return 1;
	if(warning) SendClientMessage(playerid, COLOR_GRAD1, "{F81414}This is not a recognized command.");
	return 0;
}

stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock strreplace(string[], find, replace)
{
    for(new i=0; string[i]; i++)
    {
        if(string[i] == find)
        {
            string[i] = replace;
        }
    }
}
//--------------------------------------------------

main(){}

public OnGameModeInit()
{
	//ConnectNPC("Attack_NPC", "1");
	
    //ActorNoob = CreateActor(230, 709.0172, -1665.5713, 3.4375, 88.8829);
    //ApplyActorAnimation(ActorNoob, "BEACH", "ParkSit_M_loop", 4.1, 1, 0, 0, 0, 0); // Pay anim
    ActorNoob = CreateDynamicActor(230, 709.0172, -1665.5713, 3.4375, 88.8829);
    ApplyDynamicActorAnimation(ActorNoob, "BEACH", "ParkSit_M_loop", 4.1, 1, 0, 0, 0, 0);
    SetDynamicActorVirtualWorld(ActorNoob, 2000);
    Create3DTextLabel("Press 'F' to talk", 0x008080FF, 709.0172, -1665.5713, 3.4375, 5.0, 0, 0);
    Create3DTextLabel("Sam's Armory\n[Press 'F' to enter]", 0x008080FF, 987.2599, -1624.4000, 14.9297, 5.0, 0, 0);
	CreateObject(13724, 925.86420, -2355.73389, 10.47800,   0.00000, 0.00000, 297.65561);
	CreateObject(13744, 934.36060, -2371.81470, 10.85600,   0.00000, 0.00000, 297.65561);
	CreateObject(9833, 899.40259, -2342.47754, 11.86405,   0.00000, 0.00000, 0.75815);
	CreateObject(672, 896.98138, -2334.42163, 10.70010,   4.00000, 4.00000, 265.00000);
	CreateObject(717, 905.76178, -2347.04517, 7.97897,   0.00000, 0.00000, 0.00000);
	CreateObject(5296, 998.91931, -2308.45923, 10.80050,   0.00000, 0.00000, 26.70000);
	CreateObject(5442, 1010.50842, -2302.60034, 12.20500,   0.16000, 0.02000, 26.82000);
	CreateObject(3406, 938.97369, -2406.66772, -0.41590,   0.00000, 0.00000, 36.29050);
	CreateObject(3406, 940.16193, -2408.26929, -0.41590,   0.00000, 0.00000, 36.29050);
	CreateObject(3406, 934.48407, -2410.56030, -0.41590,   0.00000, 0.00000, 126.53050);
	CreateObject(3406, 935.69061, -2417.01025, -0.41590,   0.00000, 0.00000, 36.29050);
	CreateObject(3406, 929.27271, -2408.33350, -0.41590,   0.00000, 0.00000, 36.29050);
	CreateObject(3406, 940.89331, -2419.23755, -0.41590,   0.00000, 0.00000, 126.53050);
	CreateObject(3406, 942.09967, -2425.68848, -0.41590,   0.00000, 0.00000, 36.29050);
	CreateObject(8315, 1005.21619, -2270.27930, 12.25428,   0.00000, 0.00000, 169.13986);
	CreateObject(8315, 1027.19568, -2336.97119, 12.25428,   0.00000, 0.00000, 403.79947);
	CreateObject(987, 1011.79462, -2241.81323, 11.40000,   0.00000, 0.00000, 86.09996);
	CreateObject(3749, 1002.92761, -2306.56055, 17.93944,   0.00000, 0.00000, 295.72256);
	CreateObject(1616, 1006.98431, -2310.60596, 17.26050,   0.00000, 0.00000, 264.18201);
	CreateObject(1622, 1002.31842, -2300.67944, 17.22210,   0.00000, 0.36690, 152.35339);
	CreateObject(13757, 897.76099, -2366.40063, -12.10680,   0.00000, 0.00000, 297.65561);
	CreateObject(16120, 986.71411, -2391.08594, 2.87860,   0.00000, 0.00000, -11.70001);
	CreateObject(16120, 936.33575, -2304.71362, 0.13137,   0.00000, 0.00000, 358.87463);
	CreateObject(16120, 1014.88855, -2374.85229, -16.23298,   0.00000, 0.00000, 343.44852);
	CreateObject(16114, 992.83380, -2413.18335, -11.29681,   0.00000, 0.00000, 328.74802);
	CreateObject(16114, 1007.63110, -2411.36401, -17.76140,   0.00000, 0.00000, 149.88539);
	CreateObject(16114, 996.90234, -2429.53223, -16.88186,   0.00000, 0.00000, 155.78229);
	CreateObject(16114, 989.26276, -2431.06714, -19.44147,   0.00000, 0.00000, 165.44695);
	CreateObject(16127, 960.28680, -2428.06592, -7.40077,   0.00000, 0.00000, 31.41020);
	CreateObject(898, 944.85510, -2404.32568, -3.02305,   0.00000, 0.00000, 277.64871);
	CreateObject(898, 950.14880, -2397.98291, -2.09565,   0.00000, 0.00000, 276.15128);
	CreateObject(898, 944.76947, -2410.23340, -3.83090,   0.00000, 0.00000, 248.51805);
	CreateObject(898, 946.35602, -2417.58374, -5.17380,   0.00000, 0.00000, 435.88245);
	CreateObject(898, 950.28534, -2424.53857, -7.72639,   0.00000, 0.00000, 81.27853);
	CreateObject(16110, 979.77460, -2358.82007, 2.05287,   0.00000, 0.00000, 45.53738);
	CreateObject(16118, 967.52032, -2357.38110, -4.95497,   0.00000, 0.00000, 22.20535);
	CreateObject(16134, 971.32782, -2365.06665, 7.44584,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 961.89423, -2349.68848, 7.83812,   0.00000, 0.00000, 0.00000);
	CreateObject(16110, 968.94629, -2344.25098, -2.98465,   0.00000, 0.00000, 45.53738);
	CreateObject(16134, 951.11377, -2337.17065, 6.21886,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 946.07013, -2328.16919, 6.62490,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 953.21594, -2331.68262, 1.47764,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 968.82617, -2337.86646, -8.95231,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 959.20880, -2329.13257, -2.83005,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 964.98517, -2323.45972, -8.95231,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 926.82501, -2330.80688, 1.33663,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 936.71704, -2302.92383, 7.06063,   0.00000, 0.00000, 0.61520);
	CreateObject(16134, 939.74750, -2316.45752, 6.67156,   0.00000, 0.00000, 0.00000);
	CreateObject(16134, 923.20013, -2313.07837, 2.92216,   0.00000, 0.00000, 358.58807);
	CreateObject(16116, 923.54480, -2280.62500, -5.75321,   0.00000, 0.00000, 51.39423);
	CreateObject(16134, 934.69171, -2296.05493, 7.58531,   0.00000, 0.00000, 0.00628);
	CreateObject(16134, 951.22925, -2295.49536, -4.80566,   0.00000, 0.00000, 0.76573);
	CreateObject(16134, 942.64612, -2297.63257, 2.47958,   0.00000, 0.00000, 0.76573);
	CreateObject(16134, 928.08948, -2289.83691, 2.48445,   0.00000, 0.00000, 358.58807);
	CreateObject(16120, 992.06354, -2416.79858, -4.01925,   0.00000, 0.00000, 263.20587);
	CreateObject(16120, 969.21265, -2435.54712, -10.04115,   0.00000, 0.00000, 263.20587);
	CreateObject(16120, 963.83215, -2445.27783, -10.04115,   0.00000, 0.00000, 263.20587);
	CreateObject(16134, 975.63690, -2428.40454, -0.63515,   0.00000, 0.00000, 355.95740);
	CreateObject(16134, 998.15186, -2395.06348, 6.10879,   0.00000, 0.00000, 356.13199);
	CreateObject(16134, 988.04065, -2377.46729, 3.39062,   0.00000, 0.00000, 355.95740);
	CreateObject(16134, 973.89484, -2437.74805, -4.12464,   0.00000, 0.00000, 355.95740);
	CreateObject(16134, 966.60944, -2450.80420, -9.46718,   0.00000, 0.00000, 333.88354);
	CreateObject(16134, 975.58850, -2449.73560, -8.08624,   0.00000, 0.00000, 297.00400);
	CreateObject(16120, 948.77460, -2296.20923, -7.50131,   0.00000, 0.00000, 358.87463);
	CreateObject(16120, 999.42444, -2379.12549, -2.77730,   0.00000, 0.00000, -11.70000);
	CreateObject(16134, 1020.21857, -2383.16724, -8.30065,   0.00000, 0.00000, 129.40811);
	CreateObject(16134, 1012.67419, -2367.46631, -8.25234,   0.00000, 0.00000, 116.19948);
	CreateObject(16134, 1001.52167, -2361.39746, -8.25234,   0.00000, 0.00000, 227.71909);
	CreateObject(16134, 980.46619, -2440.89673, -8.08624,   0.00000, 0.00000, 297.00400);
	CreateObject(1536, 942.90210, -2353.18164, 15.54170,   0.00000, 0.00000, 27.79860);
	CreateObject(1536, 945.54968, -2351.75317, 15.54170,   0.00000, 0.00000, 207.40440);
	CreateObject(1536, 950.59851, -2390.89648, 7.64510,   0.00000, 0.00000, 297.65561);
	CreateObject(1536, 952.02472, -2393.55640, 7.64510,   0.00000, 0.00000, 477.43170);
	CreateObject(712, 868.87872, -2324.30615, 11.71276,   0.00000, 0.00000, 0.00000);
	CreateObject(712, 871.50305, -2337.18115, 8.60147,   0.00000, 0.00000, 0.00000);
	CreateObject(712, 882.04620, -2317.71582, 11.71276,   0.00000, 0.00000, 0.00000);
	CreateObject(712, 901.56604, -2309.93262, 14.32688,   0.00000, 0.00000, 1.04622);
	CreateObject(712, 924.65894, -2306.59692, 21.85303,   0.00000, 0.00000, 0.00000);
	CreateObject(1255, 907.72461, -2382.84937, 7.21700,   0.00000, 0.00000, 180.05997);
	CreateObject(1255, 918.27332, -2403.95215, 7.21700,   0.00000, 0.00000, 244.01981);
	CreateObject(3292, 908.52008, -2372.84790, 0.13601,   0.00000, 0.00000, 118.10510);
	CreateObject(3293, 903.89789, -2370.00317, 3.32900,   0.00000, 0.00000, 118.10510);
	CreateObject(1687, 972.14349, -2369.96069, 20.22750,   0.00000, 0.00000, -62.17420);
	CreateObject(1687, 970.33038, -2370.86450, 20.22750,   0.00000, 0.00000, -62.17420);
	CreateObject(1691, 950.99701, -2351.46704, 19.79350,   0.00000, 0.00000, 298.53015);
	CreateObject(1255, 903.90149, -2386.74512, 1.34570,   0.00000, 0.00000, 180.06000);
	CreateObject(1255, 911.87476, -2402.63062, 1.34570,   0.00000, 0.00000, 240.65991);
	CreateObject(2924, 907.76813, -2372.94849, 1.98240,   0.00000, 0.00000, 28.49710);
	CreateObject(1569, 909.84009, -2365.59985, 0.81370,   -0.97840, 0.00000, 298.07620);

	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true); // it automatically reconnects when losing connection to mysql server

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id); // AUTO_RECONNECT is enabled for this connection handle only
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("MySQL connection failed. Server is shutting down.");
		SendRconCommand("exit"); // close the server if there is no connection
		return 1;
	}

	print("MySQL connection is successful.");

	// if the table has been created, the "SetupPlayerTable" function does not have any purpose.
	//Only keep if you need to move the script to a new database and want it clean/fresh
	SetupPlayerTable();

	SetGameModeText("Revision 0.2.2");
    SetNameTagDrawDistance(0.0);
    AllowInteriorWeapons(1);
	UsePlayerPedAnims();
	ShowPlayerMarkers(0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
    ShowNameTags(0);
    //ManualVehicleEngineAndLights();

	CreateLicenseTDs();

    Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 500);
	
	AddPlayerClass(299, 0.0, 0.0, 0.0, 90.0, 0, 0, 0, 0, 0, 0);

	LoadArmors();
	LoadWeapons();
    LoadDynamicDoors();
	CreateTitleTD();
	return 1;
}

public OnGameModeExit()
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if (IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
 		CancelSelectTextDraw(i);
	}
	SaveWeapons();
	SaveArmors();
    SaveDynamicDoors();
	mysql_close(g_SQL);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
    
    
    // Textdraw creations!!!
    CreateLicensePlayerTDs(playerid);
    
    // Textdraw creations end

	RemoveBuildingForPlayer(playerid, 762, 1005.2109, -2273.3594, 16.0859, 0.25);
	NameTag[playerid] = Create3DTextLabel(GetPlayerNameEx(playerid), COLOR_WHITE, 0, 0, 0, 5.0, 0, 1);
	Attach3DTextLabelToPlayer(NameTag[playerid], playerid, 0.0, 0.0, 0.5);
	g_MysqlRaceCheck[playerid]++;

	// reset player data
	static const empty_player[E_PLAYERS];
	AccountInfo[playerid] = empty_player;
	
	IsInMount[playerid] = false;
	AFKStatus[playerid] = false;
	IsTeamLeader[playerid] = false;
	LastWhisper[playerid] = 0;
	LastUsedChannel[playerid] = 1;
	aLastShot[playerid] = INVALID_PLAYER_ID;

	GetPlayerNameEx(playerid);

	// send a query to recieve all the stored player data from the table
	new query[103];
	mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", GetPlayerNameEx(playerid));
	mysql_tquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);

	gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	
    TogglePlayerSpectating(playerid, 1);
	WIDESCREEN_TOP = TextDrawCreate(320.000000, 1.000000, "_");
	TextDrawAlignment(WIDESCREEN_TOP, 2);
	TextDrawBackgroundColor(WIDESCREEN_TOP, 255);
	TextDrawFont(WIDESCREEN_TOP, 1);
	TextDrawLetterSize(WIDESCREEN_TOP, 0.500000, 8.000000);
	TextDrawColor(WIDESCREEN_TOP, -1);
	TextDrawSetOutline(WIDESCREEN_TOP, 0);
	TextDrawSetProportional(WIDESCREEN_TOP, 1);
	TextDrawSetShadow(WIDESCREEN_TOP, 1);
	TextDrawUseBox(WIDESCREEN_TOP, 1);
	TextDrawBoxColor(WIDESCREEN_TOP, 255);
	TextDrawTextSize(WIDESCREEN_TOP, 0.000000, -660.000000);

	WIDESCREEN_BOTTOM = TextDrawCreate(320.000000, 381.000000, "_");
	TextDrawAlignment(WIDESCREEN_BOTTOM, 2);
	TextDrawBackgroundColor(WIDESCREEN_BOTTOM, 255);
	TextDrawFont(WIDESCREEN_BOTTOM, 1);
	TextDrawLetterSize(WIDESCREEN_BOTTOM, 0.500000, 8.000000);
	TextDrawColor(WIDESCREEN_BOTTOM, -1);
	TextDrawSetOutline(WIDESCREEN_BOTTOM, 0);
	TextDrawSetProportional(WIDESCREEN_BOTTOM, 1);
	TextDrawSetShadow(WIDESCREEN_BOTTOM, 1);
	TextDrawUseBox(WIDESCREEN_BOTTOM, 1);
	TextDrawBoxColor(WIDESCREEN_BOTTOM, 255);
	TextDrawTextSize(WIDESCREEN_BOTTOM, 0.000000, -660.000000);
	
 	Textdraw[0][playerid] = CreatePlayerTextDraw(playerid, 183.662261, 134.399948, ".");
	PlayerTextDrawLetterSize(playerid, Textdraw[0][playerid], 0.379999, 24.039827);
	PlayerTextDrawTextSize(playerid, Textdraw[0][playerid], 443.599975, -572.444702);
	PlayerTextDrawAlignment(playerid, Textdraw[0][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[0][playerid], 255);
	PlayerTextDrawUseBox(playerid, Textdraw[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[0][playerid], 255);
	PlayerTextDrawSetShadow(playerid, Textdraw[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[0][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[0][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw[0][playerid], 1);

	Textdraw[1][playerid] = CreatePlayerTextDraw(playerid, 194.400100, 143.360015, "Near Death!");
	PlayerTextDrawLetterSize(playerid, Textdraw[1][playerid], 0.223995, 2.117686);
	PlayerTextDrawTextSize(playerid, Textdraw[1][playerid], 443.600280, 261.333221);
	PlayerTextDrawAlignment(playerid, Textdraw[1][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[1][playerid], -16776961);
	PlayerTextDrawSetShadow(playerid, Textdraw[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid, Textdraw[1][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[1][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[1][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[1][playerid], 1);

	Textdraw[2][playerid] = CreatePlayerTextDraw(playerid, 249.599990, 261.831329, "Call for help");
	PlayerTextDrawLetterSize(playerid, Textdraw[2][playerid], 0.241595, 0.828441);
	PlayerTextDrawTextSize(playerid, Textdraw[2][playerid], 305.600219, 78.648681);
	PlayerTextDrawAlignment(playerid, Textdraw[2][playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw[2][playerid], -1);
	PlayerTextDrawUseBox(playerid, Textdraw[2][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[2][playerid], 41215);
	PlayerTextDrawSetShadow(playerid, Textdraw[2][playerid], 1);
	PlayerTextDrawSetOutline(playerid, Textdraw[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[2][playerid], 255);
	PlayerTextDrawFont(playerid, Textdraw[2][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[2][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Textdraw[2][playerid], true);

	Textdraw[3][playerid] = CreatePlayerTextDraw(playerid, 367.199890, 261.831176, "Give up hope");
	PlayerTextDrawLetterSize(playerid, Textdraw[3][playerid], 0.283598, 0.823463);
	PlayerTextDrawTextSize(playerid, Textdraw[3][playerid], 158.400238, 83.626579);
	PlayerTextDrawAlignment(playerid, Textdraw[3][playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw[3][playerid], -1);
	PlayerTextDrawUseBox(playerid, Textdraw[3][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[3][playerid], 41215);
	PlayerTextDrawSetShadow(playerid, Textdraw[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[3][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[3][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[3][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[3][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Textdraw[3][playerid], true);

	Textdraw[4][playerid] = CreatePlayerTextDraw(playerid, 433.199981, 161.784454, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw[4][playerid], 0.000000, -0.323579);
	PlayerTextDrawTextSize(playerid, Textdraw[4][playerid], 258.399993, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw[4][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[4][playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw[4][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[4][playerid], -16776961);
	PlayerTextDrawSetShadow(playerid, Textdraw[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[4][playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw[4][playerid], 0);

	Textdraw[5][playerid] = CreatePlayerTextDraw(playerid, 311.999816, 181.688873, "15");
	PlayerTextDrawLetterSize(playerid, Textdraw[5][playerid], 0.924399, 5.567286);
	PlayerTextDrawAlignment(playerid, Textdraw[5][playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[5][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[5][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[5][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[5][playerid], 1);

	Textdraw[6][playerid] = CreatePlayerTextDraw(playerid, 264.399993, 201.102233, "-");
	PlayerTextDrawLetterSize(playerid, Textdraw[6][playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw[6][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[6][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[6][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[6][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[6][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw[6][playerid], 1);

	Textdraw[7][playerid] = CreatePlayerTextDraw(playerid, 348.800018, 201.599960, "-");
	PlayerTextDrawLetterSize(playerid, Textdraw[7][playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw[7][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[7][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[7][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[7][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[7][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw[7][playerid], 1);

	Textdraw[8][playerid] = CreatePlayerTextDraw(playerid, 190.400131, 136.895599, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw[8][playerid], 0.000000, 23.393928);
	PlayerTextDrawTextSize(playerid, Textdraw[8][playerid], 184.399993, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw[8][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[8][playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw[8][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[8][playerid], -2139094785);
	PlayerTextDrawSetShadow(playerid, Textdraw[8][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[8][playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw[8][playerid], 0);

	Textdraw[9][playerid] = CreatePlayerTextDraw(playerid, 442.800018, 350.940002, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw[9][playerid], 0.000000, -0.860369);
	PlayerTextDrawTextSize(playerid, Textdraw[9][playerid], 184.399993, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw[9][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[9][playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw[9][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[9][playerid], -2139094785);
	PlayerTextDrawSetShadow(playerid, Textdraw[9][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[9][playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw[9][playerid], 0);

	Textdraw[10][playerid] = CreatePlayerTextDraw(playerid, 439.999969, 350.442230, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw[10][playerid], 0.000000, -23.767530);
	PlayerTextDrawTextSize(playerid, Textdraw[10][playerid], 439.600006, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw[10][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[10][playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw[10][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[10][playerid], -2139094785);
	PlayerTextDrawSetShadow(playerid, Textdraw[10][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[10][playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw[10][playerid], 0);

	Textdraw[11][playerid] = CreatePlayerTextDraw(playerid, 442.800018, 136.895553, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw[11][playerid], 0.000000, 0.067036);
	PlayerTextDrawTextSize(playerid, Textdraw[11][playerid], 185.199966, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw[11][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[11][playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw[11][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[11][playerid], -2139094785);
	PlayerTextDrawSetShadow(playerid, Textdraw[11][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[11][playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw[11][playerid], 0);

	Textdraw[12][playerid] = CreatePlayerTextDraw(playerid, 228.399810, 282.737884, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw[12][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw[12][playerid], 45.200012, 38.328887);
	PlayerTextDrawAlignment(playerid, Textdraw[12][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[12][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[12][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[12][playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw[12][playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw[12][playerid], true);

	Textdraw[13][playerid] = CreatePlayerTextDraw(playerid, 344.400054, 282.737792, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Textdraw[13][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Textdraw[13][playerid], 45.600013, 38.328899);
	PlayerTextDrawAlignment(playerid, Textdraw[13][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[13][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[13][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[13][playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw[13][playerid], 4);
	PlayerTextDrawSetSelectable(playerid, Textdraw[13][playerid], true);

	Textdraw[14][playerid] = CreatePlayerTextDraw(playerid, 231.999969, 321.564514, "Basic Healthpack");
	PlayerTextDrawLetterSize(playerid, Textdraw[14][playerid], 0.135599, 0.773688);
	PlayerTextDrawAlignment(playerid, Textdraw[14][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[14][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[14][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[14][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[14][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[14][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw[14][playerid], 1);

	Textdraw[15][playerid] = CreatePlayerTextDraw(playerid, 347.199981, 321.564483, "Advanced Healthpack");
	PlayerTextDrawLetterSize(playerid, Textdraw[15][playerid], 0.110798, 0.898132);
	PlayerTextDrawAlignment(playerid, Textdraw[15][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[15][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[15][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[15][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[15][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[15][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw[15][playerid], 1);

	Textdraw[16][playerid] = CreatePlayerTextDraw(playerid, 250.799926, 331.520172, "Buy");
	PlayerTextDrawLetterSize(playerid, Textdraw[16][playerid], 0.335999, 1.057420);
	PlayerTextDrawTextSize(playerid, Textdraw[16][playerid], 325.600158, 32.853328);
	PlayerTextDrawAlignment(playerid, Textdraw[16][playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw[16][playerid], -1);
	PlayerTextDrawUseBox(playerid, Textdraw[16][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[16][playerid], 41215);
	PlayerTextDrawSetShadow(playerid, Textdraw[16][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[16][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[16][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[16][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[16][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Textdraw[16][playerid], true);

	Textdraw[17][playerid] = CreatePlayerTextDraw(playerid, 367.199951, 332.515533, "BUY");
	PlayerTextDrawLetterSize(playerid, Textdraw[17][playerid], 0.336398, 0.903110);
	PlayerTextDrawTextSize(playerid, Textdraw[17][playerid], 138.399993, 34.844436);
	PlayerTextDrawAlignment(playerid, Textdraw[17][playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw[17][playerid], -1);
	PlayerTextDrawUseBox(playerid, Textdraw[17][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[17][playerid], 41215);
	PlayerTextDrawSetShadow(playerid, Textdraw[17][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[17][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[17][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[17][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[17][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Textdraw[17][playerid], true);
    ShowHideTitleTD(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Delete3DTextLabel(NameTag[playerid]);
	g_MysqlRaceCheck[playerid]++;
	UpdatePlayerData(playerid, reason);
	if (cache_is_valid(AccountInfo[playerid][pCache_ID]))
	{
		cache_delete(AccountInfo[playerid][pCache_ID]);
		AccountInfo[playerid][pCache_ID] = MYSQL_INVALID_CACHE;
	}
	if (AccountInfo[playerid][pLoginTimer])
	{
		KillTimer(AccountInfo[playerid][pLoginTimer]);
		AccountInfo[playerid][pLoginTimer] = 0;
	}
	AccountInfo[playerid][pIsLoggedIn] = false;
    return 1;
}

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		if(playerid == GetPlayerID("Attack_NPC")) SetTimer("AttackNPC", 5000, 0);
	}
	// spawn the player to their last saved position
	SetPlayerInterior(playerid,AccountInfo[playerid][pInterior]);
	SetPlayerVirtualWorld(playerid, AccountInfo[playerid][pVW]);
	SetPlayerPos(playerid, AccountInfo[playerid][pX_Pos], AccountInfo[playerid][pY_Pos], AccountInfo[playerid][pZ_Pos]);
	SetPlayerFacingAngle(playerid, AccountInfo[playerid][pA_Pos]);
	SetCameraBehindPlayer(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	for(new i;i<18;i++)
	{
	     PlayerTextDrawShow(playerid, Textdraw[i][playerid]);
	}
	SelectTextDraw(playerid, 0x00FF00FF);
  	DeathCDT[playerid] = SetTimerEx("DeathCountDown", 1000, true, "i", playerid);
  	IsInDeath[playerid] = true;
	UpdatePlayerDeaths(playerid);
	UpdatePlayerKills(killerid);
    return 1;
}

forward DeathCountDown(playerid);
public DeathCountDown(playerid)
{
	seconds[playerid]--;
	new string[178];
    format(string,sizeof(string),"%d",seconds);
    PlayerTextDrawSetString(playerid, Textdraw[5][playerid], string);

    if(seconds[playerid] == 0)
	{
    	PlayerTextDrawSetString(playerid, Textdraw[5][playerid], "15");
		seconds[playerid] = 15;
		KillTimer(DeathCDT[playerid]);
		for(new i;i<18;i++)
		{
			PlayerTextDrawHide(playerid, Textdraw[i][playerid]);
		}
  		CancelSelectTextDraw(playerid);
    }
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	SendChannelMessage(playerid, LastUsedChannel[playerid], text);
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	//Show them as in vehicle and set variables
	//IsInVehicle = 1
	//Set extra HP based on vehicle stats.
	if(ispassenger > 0)
	{
		for(new i = 0; i < 3; i++) {
		//Show Hint Textdraw
		//You may not enter another players' vehicle!
		}
	}
	OnPlayerEnterMount(playerid, vehicleid);
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	//Add a vehicle despawn so when they get off their mount
	//Vehicle goes poof. ALWAYS. No vehicles left around.
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(GetPVarType(playerid, "Mission1CP") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK))
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 709.0172, -1665.5713, 3.4375))
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Hello stranger, what brings you to my bridge?");
            SendClientMessage(playerid, COLOR_GRAD1, "No matter, I have a favor to ask you, mind helping out an old hobo?");
            SendClientMessage(playerid, COLOR_GRAD1, "You see, I need to get some 'special' armor, however, I can't walk well.");
            SendClientMessage(playerid, COLOR_GRAD1, "If you get it for me, i'll reward ya! Whadda ya say?");
		    SetPlayerCheckpoint(playerid, 987.2599,-1624.4000,14.9297, 3.0);
		    SetPVarInt(playerid, "Mission1CP", 1);
		    IsInMission[playerid] = true;
		    //Rewards: 20xp | $8
        }
	    for(new i = 0; i < sizeof(DDoorsInfo); i++) {
	        if (IsPlayerInRangeOfPoint(playerid,3.0,DDoorsInfo[i][ddExteriorX], DDoorsInfo[i][ddExteriorY], DDoorsInfo[i][ddExteriorZ]) && AccountInfo[playerid][pVW] == DDoorsInfo[i][ddExteriorVW]) {
	        	SendClientMessage(playerid, -1, "You entered the door");
	            if(DDoorsInfo[i][ddVIP] > 0 && AccountInfo[playerid][pVIP] < DDoorsInfo[i][ddVIP]) {
	                SendClientMessage(playerid, COLOR_GRAD2, "You can not enter, you are not a high enough VIP level.");
	                return 1;
	            }
	            if(DDoorsInfo[i][ddAdmin] > 0 && AccountInfo[playerid][pAdmin] < DDoorsInfo[i][ddAdmin]) {
	                SendClientMessage(playerid, COLOR_GRAD2, "You can not enter, you are not a high enough admin level.");
	                return 1;
	            }
	            SetPlayerInterior(playerid,DDoorsInfo[i][ddInteriorInt]);
	            AccountInfo[playerid][pInterior] = DDoorsInfo[i][ddInteriorInt];
	            AccountInfo[playerid][pVW] = DDoorsInfo[i][ddInteriorVW];
	            SetPlayerVirtualWorld(playerid, DDoorsInfo[i][ddInteriorVW]);
	            if(DDoorsInfo[i][ddVehicleAble] > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
	                SetVehiclePos(GetPlayerVehicleID(playerid), DDoorsInfo[i][ddInteriorX],DDoorsInfo[i][ddInteriorY],DDoorsInfo[i][ddInteriorZ]);
	                SetVehicleZAngle(GetPlayerVehicleID(playerid), DDoorsInfo[i][ddInteriorA]);
	                SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), DDoorsInfo[i][ddInteriorVW]);
	                LinkVehicleToInterior(GetPlayerVehicleID(playerid), DDoorsInfo[i][ddInteriorInt]);
	                foreach(new passenger: Player)
	                {
	                    if(passenger != playerid)
	                    {
		                    if(IsPlayerInVehicle(passenger, GetPlayerVehicleID(playerid)))
		                    {
			                    SetPlayerInterior(passenger,DDoorsInfo[i][ddInteriorInt]);
					            AccountInfo[passenger][pInterior] = DDoorsInfo[i][ddInteriorInt];
					            AccountInfo[passenger][pVW] = DDoorsInfo[i][ddInteriorVW];
					            SetPlayerVirtualWorld(passenger, DDoorsInfo[i][ddInteriorVW]);
		                    }
						}
	                }
	            }
	            else {
	                SetPlayerPos(playerid,DDoorsInfo[i][ddInteriorX],DDoorsInfo[i][ddInteriorY],DDoorsInfo[i][ddInteriorZ]);
	                SetPlayerFacingAngle(playerid,DDoorsInfo[i][ddInteriorA]);
	                SetCameraBehindPlayer(playerid);
	            }
				if(DDoorsInfo[i][ddCustomInterior]) Player_StreamPrep(playerid, DDoorsInfo[i][ddInteriorX],DDoorsInfo[i][ddInteriorY],DDoorsInfo[i][ddInteriorZ], FREEZE_TIME);
	            return 1;
	        }
	        if (IsPlayerInRangeOfPoint(playerid,3.0,DDoorsInfo[i][ddInteriorX], DDoorsInfo[i][ddInteriorY], DDoorsInfo[i][ddInteriorZ]) && AccountInfo[playerid][pVW] == DDoorsInfo[i][ddInteriorVW]) {
	            SetPlayerInterior(playerid,DDoorsInfo[i][ddExteriorInt]);
	            AccountInfo[playerid][pInterior] = DDoorsInfo[i][ddExteriorInt];
	            SetPlayerVirtualWorld(playerid, DDoorsInfo[i][ddExteriorVW]);
	            AccountInfo[playerid][pVW] = DDoorsInfo[i][ddExteriorVW];
	            if(DDoorsInfo[i][ddVehicleAble] > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
	                SetVehiclePos(GetPlayerVehicleID(playerid), DDoorsInfo[i][ddExteriorX],DDoorsInfo[i][ddExteriorY],DDoorsInfo[i][ddExteriorZ]);
	                SetVehicleZAngle(GetPlayerVehicleID(playerid), DDoorsInfo[i][ddExteriorA]);
	                SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), DDoorsInfo[i][ddExteriorVW]);
	                LinkVehicleToInterior(GetPlayerVehicleID(playerid), DDoorsInfo[i][ddExteriorInt]);
	                foreach(new passenger: Player)
	                {
	                    if(passenger != playerid)
	                    {
		                    if(IsPlayerInVehicle(passenger, GetPlayerVehicleID(playerid)))
		                    {
			                    SetPlayerInterior(passenger,DDoorsInfo[i][ddExteriorInt]);
					            AccountInfo[passenger][pInterior] = DDoorsInfo[i][ddExteriorInt];
					            AccountInfo[passenger][pVW] = DDoorsInfo[i][ddExteriorVW];
					            SetPlayerVirtualWorld(passenger, DDoorsInfo[i][ddExteriorVW]);
		                    }
						}
	                }
	            }
	            else {
	                SetPlayerPos(playerid,DDoorsInfo[i][ddExteriorX],DDoorsInfo[i][ddExteriorY],DDoorsInfo[i][ddExteriorZ]);
	                SetPlayerFacingAngle(playerid, DDoorsInfo[i][ddExteriorA]);
	                SetCameraBehindPlayer(playerid);
	            }
				if(DDoorsInfo[i][ddCustomExterior]) Player_StreamPrep(playerid, DDoorsInfo[i][ddExteriorX],DDoorsInfo[i][ddExteriorY],DDoorsInfo[i][ddExteriorZ], FREEZE_TIME);
	            return 1;
	        }
		}
    }
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new string[256];
	new titlestring[240];
	if(IsPlayerConnected(playerid))
	{
		if(dialogid == GANGCREATION1)
		{
			if(response)
			{
			    if(listitem == 0)//Gang Name Edit
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Gang Name");
					ShowPlayerDialog(playerid, GANGCREATIONNAME, DIALOG_STYLE_INPUT, "{FF0000}Name your Gang", "Please specify a name for your gang.\n\nName Rules:\n1. No inappropriate language\n2. No Gang Bashing\n(Making a name like another gang in a rude manor.)\n\n All Gang names are subject to review. If name is found to be against the rules,\nyour gang may be placed on hold/terminated without warning.\n You may change the gang name at the gang registrar.", "Submit", "Cancel");
				}
			    if(listitem == 1)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Description");
				}
			    if(listitem == 2)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Message Of The Day");
				}
			    if(listitem == 3)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Minimum Level Requirement");
				}
			    if(listitem == 4)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Website");
				}
			    if(listitem == 5)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Recruiting Message");
				}
			    if(listitem == 6)//
			    {
					format(titlestring, sizeof(titlestring), "Gang Creation: %s", inputtext);
					format(string, sizeof(string), "1 | Name\n2 | Description\n3 | MOTD\n4 | Minimum Level\n5 | Website\n6 | Recruiting Message\n======[ Search Tags ]======\n1 | Language\n2 | Play Style\n3 | Social Group\n4 | Gender\n5 | Race\n6 | Timezone", inputtext);
					ShowPlayerDialog(playerid,GANGCREATION1,DIALOG_STYLE_LIST,titlestring,string,"Ok","Cancel");
				}
			    if(listitem == 7)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Language Tags");
				}
			    if(listitem == 8)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Play Style Tags");
				}
			    if(listitem == 9)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Social Group Tags");
				}
			    if(listitem == 10)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Gender Tags");
				}
			    if(listitem == 11)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Race Tags");
				}
			    if(listitem == 12)//
			    {
			        SendClientMessage(playerid, COLOR_GREEN, "You're now editing the Timezone Tags");
				}
			}
		}
		if(dialogid == GANGCREATIONNAME)
		{
			if(response)
			{
				SetPVarString(playerid,"creategangname",inputtext);
				format(string, sizeof(string), "You've set the gang name to: %s", inputtext);
				SendClientMessage(playerid, COLOR_GREEN, string);

				format(titlestring, sizeof(titlestring), "Gang Creation: %s", inputtext);
				format(string, sizeof(string), "1 | Name\n2 | Description\n3 | MOTD\n4 | Minimum Level\n5 | Website\n6 | Recruiting Message\n======[ Search Tags ]======\n1 | Language\n2 | Play Style\n3 | Social Group\n4 | Gender\n5 | Race\n6 | Timezone", inputtext);
				ShowPlayerDialog(playerid,GANGCREATION1,DIALOG_STYLE_LIST,titlestring,string,"Ok","Cancel");
			}
		}
		switch (dialogid)
		{
			case DIALOG_UNUSED: return 1;

			case DIALOG_LOGIN:
			{
				if (!response) return Kick(playerid);

				new hashed_pass[65];
				SHA256_PassHash(inputtext, AccountInfo[playerid][pSalt], hashed_pass, 65);

				if (strcmp(hashed_pass, AccountInfo[playerid][pPassword]) == 0)
				{
					//ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been successfully logged in.", "Okay", "");
					cache_set_active(AccountInfo[playerid][pCache_ID]);
					AssignPlayerData(playerid);
					cache_delete(AccountInfo[playerid][pCache_ID]);
					AccountInfo[playerid][pCache_ID] = MYSQL_INVALID_CACHE;
					KillTimer(AccountInfo[playerid][pLoginTimer]);
					AccountInfo[playerid][pLoginTimer] = 0;
					AccountInfo[playerid][pIsLoggedIn] = true;
					IsLoggingIn[playerid] = false;
		            ResetPlayerWeapons(playerid);
					SetPlayerVirtualWorld(playerid, GetVW(playerid));
		            SetPlayerScore(playerid, AccountInfo[playerid][pScore]);
		            SetCameraBehindPlayer(playerid);
					SetSpawnInfo(playerid, NO_TEAM, 0, AccountInfo[playerid][pX_Pos], AccountInfo[playerid][pY_Pos], AccountInfo[playerid][pZ_Pos], AccountInfo[playerid][pA_Pos], 0, 0, 0, 0, 0, 0);
					TogglePlayerSpectating(playerid, 0);
					for(new i;i<24;i++)
					{
						TextDrawHideForPlayer(playerid, TitleTD[i]);
					}
					SpawnPlayer(playerid);
				}
				else
				{
					AccountInfo[playerid][pLoginAttempts]++;

					if (AccountInfo[playerid][pLoginAttempts] >= 3)
					{
						ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have mistyped your password too often (3 times).", "Okay", "");
						DelayedKick(playerid);
					}
					else ShowMainMenuDialog(playerid, 3);
				}
			}
			case DIALOG_REGISTER:
			{
				if (!response) return Kick(playerid);

				if (strlen(inputtext) <= 5)
				{
					format(titlestring, sizeof(titlestring), "{3399FF}Register - %s", GetPlayerNameEx(playerid));
					format(string, sizeof(string), "{FFFFFF}Welcome to Slum Lords Online %s.\n\nCurrent Season is: Season 1\n\n{F81414}Your password must be 5 Characters or longer!\n\n{FFFFFF}You may {AA3333}register {FFFFFF}an account by entering a desired password here:", GetPlayerNameEx(playerid));
					ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_PASSWORD,titlestring,string,"Register","Exit");
					return 1;
				}
				
				// 16 random characters from 33 to 126 (in ASCII) for the salt
				for (new i = 0; i < 16; i++) AccountInfo[playerid][pSalt][i] = random(94) + 33;
				SHA256_PassHash(inputtext, AccountInfo[playerid][pSalt], AccountInfo[playerid][pPassword], 65);

				new query[221];
				mysql_format(g_SQL, query, sizeof query, "INSERT INTO `players` (`username`, `password`, `salt`) VALUES ('%s', '%s', '%e')", GetPlayerNameEx(playerid), AccountInfo[playerid][pPassword], AccountInfo[playerid][pSalt]);
				print(query);
				mysql_tquery(g_SQL, query, "OnPlayerRegister", "d", playerid);
			}
			default: return 0; // dialog ID was not found, search in other scripts
		}
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(strfind(cmdtext, "|", true) != -1)
	{
		SendGuiInformation(playerid, "Error", "Detected an illegal character symbol.");
		return 0;
	}

	if(!AccountInfo[playerid][pIsLoggedIn]) return 0;
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success)
	{
		PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_RED, "This is not a recognized command.");
    }
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID) // If not self-inflicted
    {
	    ShotPlayer[issuerid][playerid] = gettime();
	    LastShot[playerid] = gettime();
		aLastShot[playerid] = issuerid;
        if(AccountInfo[playerid][pPhase] == 1)
        {
			SetPlayerHealth(playerid, AccountInfo[playerid][pHealth]);
		}
		else
		{
			AccountInfo[playerid][pHealth] -= amount;
			SetPlayerHealth(playerid, AccountInfo[playerid][pHealth]);
		}
    }
    return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(hittype == BULLET_HIT_TYPE_PLAYER) {
        new Float:rDist = frandom(-5.0, 6.0);
        if(rDist > 0.0) {
            new Float:vX, Float:vY, Float:vZ,
                Float:pX, Float:pY, Float:pZ;
            GetPlayerLastShotVectors(playerid, vX, vY, vZ, fX, fY, fZ);

            vX = fX - vX;
            vY = fY - vY;
            vZ = fZ - vZ;

            new Float:d = VectorSize(vX, vY, vZ);
            vX /= d;
            vY /= d;
            vZ /= d;

            vX *= rDist;
            vY *= rDist;
            vZ *= rDist;

            vX += fX + frandom(-0.5, 0.5);
            vY += fY + frandom(-0.5, 0.5);
            vZ += fZ + frandom(-0.5, 0.5);

            if(CA_RayCastLineNormal(fX, fY, fZ, vX, vY, vZ, pX, pY, pZ, pX, pY, pZ)) {
                rDist = frandom(0.005, 0.020, 4);
                pX *= rDist;
                pY *= rDist;
                pZ *= rDist;

                CA_RayCastLineAngle(fX, fY, fZ, vX, vY, vZ, fX, fY, fZ, vX, vY, vZ);

                new objectid = CreateDynamicObject(19836, fX + pX, fY + pY, fZ + pZ, vX, vY, vZ);
                if(IsValidDynamicObject(objectid)) {
                    SetDynamicObjectMaterial(objectid, 0, -1, "none", "none", 0xFFFF0000);

                    SetTimerEx("FadeBlood", 1500, false, "ii", objectid, 255);
                }
            }
        }
	}
	if(AccountInfo[playerid][pPhase] == 1) {
	 	return 0;
 	}
    return 1;
}

forward OnPlayerLoad(playerid);
public OnPlayerLoad(playerid)
{
	SetSpawnInfo(playerid, 0, 1, 2236.0210, -1069.4850, 41.5938, 1.0, -1, -1, -1, -1, -1, -1);
	TogglePlayerSpectating(playerid, 0);
	return 1;
}

forward ForceSpawn(playerid);
public ForceSpawn(playerid)
{
	SpawnPlayer(playerid);
	return 1;
}

forward KickEx(playerid);
public KickEx(playerid)
{
	Kick(playerid);
}

//Custom Callbacks

forward AttackNPC();
public AttackNPC()
{
	CreateAttackingNPC("Attack_NPC", 0.0, 0.0, 0.0);
	return 0;
}

forward Player_StreamPrep(iPlayer, Float: fPosX, Float: fPosY, Float: fPosZ, iTime);
public Player_StreamPrep(iPlayer, Float: fPosX, Float: fPosY, Float: fPosZ, iTime) {
	switch(GetPVarInt(iPlayer, "StreamPrep")) {
		case 0: {
			TogglePlayerControllable(iPlayer, false);
			SetPVarInt(iPlayer, "StreamPrep", 1);
			SetTimerEx("Player_StreamPrep", iTime / 2, false, "ifffi", iPlayer, fPosX, fPosY, fPosZ, iTime);
		}
		case 1: {

			if(GetPlayerState(iPlayer) == PLAYER_STATE_DRIVER)
				SetVehiclePos(GetPlayerVehicleID(iPlayer), fPosX, fPosY, fPosZ + 2.0);

			else
				SetPlayerPos(iPlayer, fPosX, fPosY, fPosZ + 0.5);

			SetPVarInt(iPlayer, "StreamPrep", 2);
			SetTimerEx("Player_StreamPrep", iTime / 2, false, "ifffi", iPlayer, fPosX, fPosY, fPosZ, iTime);
		}
		default: {
			TogglePlayerControllable(iPlayer, true);

			if(GetPlayerState(iPlayer) == PLAYER_STATE_DRIVER)
				SetVehiclePos(GetPlayerVehicleID(iPlayer), fPosX, fPosY, fPosZ);

			else
				SetPlayerPos(iPlayer, fPosX, fPosY, fPosZ);

			DeletePVar(iPlayer, "StreamPrep");
		}
	}
	SetCameraBehindPlayer(iPlayer);
	Streamer_UpdateEx(iPlayer, fPosX, fPosY, fPosZ);
	return 1;
}

forward OnPlayerOpenInventory(playerid);
public OnPlayerOpenInventory(playerid)
{
	return 1;
}

forward OnPlayerCloseInventory(playerid);
public OnPlayerCloseInventory(playerid)
{
	return 1;
}

forward OnPlayerKillMob(playerid, mobid);
public OnPlayerKillMob(playerid, mobid)
{
	return 1;
}

forward OnPlayerKillMobBoss(playerid, mobid);
public OnPlayerKillMobBoss(playerid, mobid)
{
	return 1;
}

forward OnPlayerEnterMount(playerid, mountid);
public OnPlayerEnterMount(playerid, mountid)
{
	IsInMount[playerid] = 1;
	SendClientMessage(playerid, COLOR_GREEN, "You've spawned your Mount!");
	return 1;
}

forward OnPlayerExitMount(playerid, mountid);
public OnPlayerExitMount(playerid, mountid)
{
    IsInMount[playerid] = 0;
	return 1;
}

CMD:changephase(playerid, params[])
{
	/*if(AccountInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_RED, "You're an admin and can't Phase Shift!");
	}*/
	OnPlayerChangePhase(playerid, AccountInfo[playerid][pPhase]);
	return 1;
}

forward OnPlayerChangePhase(playerid, phase);
public OnPlayerChangePhase(playerid, phase)
{
	if(AccountInfo[playerid][pPhase] == GetPVarInt(playerid,"PhaseSelection"))
	{
	    SetPVarInt(playerid,"PhaseSelection",AccountInfo[playerid][pPhase]);
	    SendClientMessage(playerid, COLOR_RED, "Oops, something went wrong! Try again.");
	    return 1;
	}
	switch(phase)
	{
	    case 1:
	    {
			AccountInfo[playerid][pPhase] = 2;
			SendClientMessage(playerid, COLOR_WHITE, "You've switched to PVP Phase, You will be able to be attacked in this mode!");
	    }
	    case 2:
	    {
			AccountInfo[playerid][pPhase] = 1;
			SendClientMessage(playerid, COLOR_WHITE, "You've switched to PVE Phase, You will not be able to be attacked in this mode.");
	    }
	}
	return 1;
}

forward FadeBlood(objectid, alpha);
public FadeBlood(objectid, alpha)
{
    alpha -= 5;

    if(alpha) {
        SetDynamicObjectMaterial(objectid, 0, -1, "none", "none", 0xFF0000 | (alpha << 24));
        SetTimerEx("FadeBlood", 50, false, "ii", objectid, alpha);
    }
    else {
        DestroyDynamicObject(objectid);
    }
}

CMD:givegun(playerid, params[])
{
    if (AccountInfo[playerid][pAdmin] >= 4) {
        new playa, gun, szMiscArray[124];

        if(sscanf(params, "udd", playa, gun)) {
            SendClientMessage(playerid, COLOR_GREY, "USAGE: /givegun [player] [weaponid]");
            SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
            SendClientMessage(playerid, COLOR_GRAD4, "(1)Brass Knuckles (2)Golf Club (3)Nite Stick (4)Knife (5)Baseball Bat (6)Shovel (7)Pool Cue (8)Katana (9)Chainsaw");
            SendClientMessage(playerid, COLOR_GRAD4, "(10)Purple Dildo (11)Small White Vibrator (12)Large White Vibrator (13)Silver Vibrator (14)Flowers (15)Cane (16)Frag Grenade");
            SendClientMessage(playerid, COLOR_GRAD3, "(17)Tear Gas (18)Molotov Cocktail (21)Jetpack (22)9mm (23)Silenced 9mm (24)Desert Eagle (25)Shotgun (26)Sawnoff Shotgun");
            SendClientMessage(playerid, COLOR_GRAD4, "(27)Combat Shotgun (28)Micro SMG (Mac 10) (29)SMG (MP5) (30)AK-47 (31)M4 (32)Tec9 (33)Rifle (34)Sniper Rifle");
            SendClientMessage(playerid, COLOR_GRAD4, "(35)Rocket Launcher (36)HS Rocket Launcher (37)Flamethrower (38)Minigun (39)Satchel Charge (40)Detonator");
            SendClientMessage(playerid, COLOR_GRAD4, "(41)Spraycan (42)Fire Extinguisher (43)Camera (44)Nightvision Goggles (45)Infared Goggles (46)Parachute");
            SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
            return 1;
        }

        format(szMiscArray, sizeof(szMiscArray), "You have given %s gun ID %d!", GetPlayerNameEx(playa), gun);
        if(gun < 1||gun > 47)
            { SendClientMessage(playerid, COLOR_GRAD1, "Invalid weapon ID!"); return 1; }
        if(IsPlayerConnected(playa))
		{
		    if(playa != INVALID_PLAYER_ID && gun <= 20 || gun >= 22) {
                GivePlayerWeapon(playa, gun, 9999999);
                SendClientMessage(playerid, COLOR_GRAD1, szMiscArray);
            }
            else if(playa != INVALID_PLAYER_ID && gun == 21) {
                SetPlayerSpecialAction(playa, SPECIAL_ACTION_USEJETPACK);
                SendClientMessage(playerid, COLOR_GRAD1, szMiscArray);
            }
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAD1, "{F81414}This is not a recognized command.");
    }
    return 1;
}

stock ShowHideTitleTD(playerid, bool:status = true)
{
	if(status == true) //Show the TD's
	{
		for(new i;i<24;i++)
		{
			 TextDrawShowForPlayer(playerid, TitleTD[i]);
			 
		}
	}
	else //Hide the TD's
	{
		for(new i;i<24;i++)
		{
			 TextDrawHideForPlayer(playerid, TitleTD[i]);
		}
	}
}

stock CreateTitleTD()
{
	TitleTD[0] = TextDrawCreate(54.800098, 367.857849, "SLUM LORDS ONLINE");
	TextDrawLetterSize(TitleTD[0], 1.659198, 8.095993);
	TextDrawAlignment(TitleTD[0], 1);
	TextDrawColor(TitleTD[0], -1);
	TextDrawSetShadow(TitleTD[0], 0);
	TextDrawSetOutline(TitleTD[0], 1);
	TextDrawBackgroundColor(TitleTD[0], 51);
	TextDrawFont(TitleTD[0], 3);
	TextDrawSetProportional(TitleTD[0], 1);

	TitleTD[1] = TextDrawCreate(641.599975, 1.500000, "usebox");
	TextDrawLetterSize(TitleTD[1], 0.000000, 49.504573);
	TextDrawTextSize(TitleTD[1], -1.600000, 0.000000);
	TextDrawAlignment(TitleTD[1], 1);
	TextDrawColor(TitleTD[1], 0);
	TextDrawUseBox(TitleTD[1], true);
	TextDrawBoxColor(TitleTD[1], 102);
	TextDrawSetShadow(TitleTD[1], 0);
	TextDrawSetOutline(TitleTD[1], 0);
	TextDrawFont(TitleTD[1], 0);

	TitleTD[2] = TextDrawCreate(641.599975, 1.500000, "usebox");
	TextDrawLetterSize(TitleTD[2], 0.000000, 49.405799);
	TextDrawTextSize(TitleTD[2], -2.000000, 0.000000);
	TextDrawAlignment(TitleTD[2], 1);
	TextDrawColor(TitleTD[2], 0);
	TextDrawUseBox(TitleTD[2], true);
	TextDrawBoxColor(TitleTD[2], 102);
	TextDrawSetShadow(TitleTD[2], 0);
	TextDrawSetOutline(TitleTD[2], 0);
	TextDrawFont(TitleTD[2], 0);

	TitleTD[3] = TextDrawCreate(641.599975, 1.500000, "usebox");
	TextDrawLetterSize(TitleTD[3], 0.000000, 49.405799);
	TextDrawTextSize(TitleTD[3], -2.000000, 0.000000);
	TextDrawAlignment(TitleTD[3], 1);
	TextDrawColor(TitleTD[3], 0);
	TextDrawUseBox(TitleTD[3], true);
	TextDrawBoxColor(TitleTD[3], 102);
	TextDrawSetShadow(TitleTD[3], 0);
	TextDrawSetOutline(TitleTD[3], 0);
	TextDrawFont(TitleTD[3], 0);

	TitleTD[4] = TextDrawCreate(468.400024, 118.471130, "SLO News");
	TextDrawLetterSize(TitleTD[4], 0.423999, 1.251554);
	TextDrawTextSize(TitleTD[4], 621.200256, 53.262207);
	TextDrawAlignment(TitleTD[4], 1);
	TextDrawColor(TitleTD[4], -1);
	TextDrawUseBox(TitleTD[4], true);
	TextDrawBoxColor(TitleTD[4], -2147483393);
	TextDrawSetShadow(TitleTD[4], 0);
	TextDrawSetOutline(TitleTD[4], 1);
	TextDrawBackgroundColor(TitleTD[4], 51);
	TextDrawFont(TitleTD[4], 2);
	TextDrawSetProportional(TitleTD[4], 1);

	TitleTD[5] = TextDrawCreate(20.000000, 117.475555, "Current Events");
	TextDrawLetterSize(TitleTD[5], 0.359999, 1.206755);
	TextDrawTextSize(TitleTD[5], 164.400177, 39.324447);
	TextDrawAlignment(TitleTD[5], 1);
	TextDrawColor(TitleTD[5], -1);
	TextDrawUseBox(TitleTD[5], true);
	TextDrawBoxColor(TitleTD[5], -2147483393);
	TextDrawSetShadow(TitleTD[5], 0);
	TextDrawSetOutline(TitleTD[5], 1);
	TextDrawBackgroundColor(TitleTD[5], 51);
	TextDrawFont(TitleTD[5], 2);
	TextDrawSetProportional(TitleTD[5], 1);

	TitleTD[6] = TextDrawCreate(167.600006, 132.415557, "usebox");
	TextDrawLetterSize(TitleTD[6], 0.000000, 17.296175);
	TextDrawTextSize(TitleTD[6], 16.799999, 0.000000);
	TextDrawAlignment(TitleTD[6], 1);
	TextDrawColor(TitleTD[6], 0);
	TextDrawUseBox(TitleTD[6], true);
	TextDrawBoxColor(TitleTD[6], -16776961);
	TextDrawSetShadow(TitleTD[6], 0);
	TextDrawSetOutline(TitleTD[6], 0);
	TextDrawFont(TitleTD[6], 0);

	TitleTD[7] = TextDrawCreate(24.799997, 134.904434, "usebox");
	TextDrawLetterSize(TitleTD[7], 0.000000, 16.718397);
	TextDrawTextSize(TitleTD[7], 18.799997, 0.000000);
	TextDrawAlignment(TitleTD[7], 1);
	TextDrawColor(TitleTD[7], 0);
	TextDrawUseBox(TitleTD[7], true);
	TextDrawBoxColor(TitleTD[7], -5963521);
	TextDrawSetShadow(TitleTD[7], 0);
	TextDrawSetOutline(TitleTD[7], 0);
	TextDrawFont(TitleTD[7], 0);

	TitleTD[8] = TextDrawCreate(164.799972, 134.904449, "usebox");
	TextDrawLetterSize(TitleTD[8], 0.000000, -0.018889);
	TextDrawTextSize(TitleTD[8], 19.999998, 0.000000);
	TextDrawAlignment(TitleTD[8], 1);
	TextDrawColor(TitleTD[8], 0);
	TextDrawUseBox(TitleTD[8], true);
	TextDrawBoxColor(TitleTD[8], -5963521);
	TextDrawSetShadow(TitleTD[8], 0);
	TextDrawSetOutline(TitleTD[8], 0);
	TextDrawFont(TitleTD[8], 0);

	TitleTD[9] = TextDrawCreate(161.599990, 138.388839, "usebox");
	TextDrawLetterSize(TitleTD[9], 0.000000, 16.355928);
	TextDrawTextSize(TitleTD[9], 161.599990, 0.000000);
	TextDrawAlignment(TitleTD[9], 1);
	TextDrawColor(TitleTD[9], 0);
	TextDrawUseBox(TitleTD[9], true);
	TextDrawBoxColor(TitleTD[9], -5963521);
	TextDrawSetShadow(TitleTD[9], 0);
	TextDrawSetOutline(TitleTD[9], 0);
	TextDrawFont(TitleTD[9], 0);

	TitleTD[10] = TextDrawCreate(163.999984, 289.215545, "usebox");
	TextDrawLetterSize(TitleTD[10], 0.000000, -0.906292);
	TextDrawTextSize(TitleTD[10], 18.799999, 0.000000);
	TextDrawAlignment(TitleTD[10], 1);
	TextDrawColor(TitleTD[10], 0);
	TextDrawUseBox(TitleTD[10], true);
	TextDrawBoxColor(TitleTD[10], -5963521);
	TextDrawSetShadow(TitleTD[10], 0);
	TextDrawSetOutline(TitleTD[10], 0);
	TextDrawFont(TitleTD[10], 0);

	TitleTD[11] = TextDrawCreate(624.400085, 134.400100, "usebox");
	TextDrawLetterSize(TitleTD[11], 0.000000, 17.412721);
	TextDrawTextSize(TitleTD[11], 465.199737, 0.000000);
	TextDrawAlignment(TitleTD[11], 1);
	TextDrawColor(TitleTD[11], 0);
	TextDrawUseBox(TitleTD[11], true);
	TextDrawBoxColor(TitleTD[11], -16776961);
	TextDrawSetShadow(TitleTD[11], 0);
	TextDrawSetOutline(TitleTD[11], 0);
	TextDrawFont(TitleTD[11], 0);

	TitleTD[12] = TextDrawCreate(473.600006, 136.397766, "usebox");
	TextDrawLetterSize(TitleTD[12], 0.000000, 16.884323);
	TextDrawTextSize(TitleTD[12], 467.199981, 0.000000);
	TextDrawAlignment(TitleTD[12], 1);
	TextDrawColor(TitleTD[12], 0);
	TextDrawUseBox(TitleTD[12], true);
	TextDrawBoxColor(TitleTD[12], -5963521);
	TextDrawSetShadow(TitleTD[12], 0);
	TextDrawSetOutline(TitleTD[12], 0);
	TextDrawFont(TitleTD[12], 0);

	TitleTD[13] = TextDrawCreate(620.799987, 136.397766, "usebox");
	TextDrawLetterSize(TitleTD[13], 0.000000, 0.005803);
	TextDrawTextSize(TitleTD[13], 468.400024, 0.000000);
	TextDrawAlignment(TitleTD[13], 1);
	TextDrawColor(TitleTD[13], 0);
	TextDrawUseBox(TitleTD[13], true);
	TextDrawBoxColor(TitleTD[13], -5963521);
	TextDrawSetShadow(TitleTD[13], 0);
	TextDrawSetOutline(TitleTD[13], 0);
	TextDrawFont(TitleTD[13], 0);

	TitleTD[14] = TextDrawCreate(621.200012, 292.202239, "usebox");
	TextDrawLetterSize(TitleTD[14], 0.000000, -0.869755);
	TextDrawTextSize(TitleTD[14], 467.200012, 0.000000);
	TextDrawAlignment(TitleTD[14], 1);
	TextDrawColor(TitleTD[14], 0);
	TextDrawUseBox(TitleTD[14], true);
	TextDrawBoxColor(TitleTD[14], -5963521);
	TextDrawSetShadow(TitleTD[14], 0);
	TextDrawSetOutline(TitleTD[14], 0);
	TextDrawFont(TitleTD[14], 0);

	TitleTD[15] = TextDrawCreate(618.000061, 136.895553, "usebox");
	TextDrawLetterSize(TitleTD[15], 0.000000, 16.773706);
	TextDrawTextSize(TitleTD[15], 618.000061, 0.000000);
	TextDrawAlignment(TitleTD[15], 1);
	TextDrawColor(TitleTD[15], 0);
	TextDrawUseBox(TitleTD[15], true);
	TextDrawBoxColor(TitleTD[15], -5963521);
	TextDrawSetShadow(TitleTD[15], 0);
	TextDrawSetOutline(TitleTD[15], 0);
	TextDrawFont(TitleTD[15], 0);

	TitleTD[16] = TextDrawCreate(28.399995, 140.871154, "Event1");
	TextDrawLetterSize(TitleTD[16], 0.449999, 1.600000);
	TextDrawAlignment(TitleTD[16], 1);
	TextDrawColor(TitleTD[16], -1);
	TextDrawSetShadow(TitleTD[16], 0);
	TextDrawSetOutline(TitleTD[16], 1);
	TextDrawBackgroundColor(TitleTD[16], 51);
	TextDrawFont(TitleTD[16], 1);
	TextDrawSetProportional(TitleTD[16], 1);

	TitleTD[17] = TextDrawCreate(156.000030, 154.808898, "ev1 0:00");
	TextDrawLetterSize(TitleTD[17], 0.449999, 1.600000);
	TextDrawAlignment(TitleTD[17], 3);
	TextDrawColor(TitleTD[17], -1);
	TextDrawSetShadow(TitleTD[17], 0);
	TextDrawSetOutline(TitleTD[17], 1);
	TextDrawBackgroundColor(TitleTD[17], 51);
	TextDrawFont(TitleTD[17], 3);
	TextDrawSetProportional(TitleTD[17], 1);

	TitleTD[18] = TextDrawCreate(28.000064, 187.662231, "Event2");
	TextDrawLetterSize(TitleTD[18], 0.449999, 1.600000);
	TextDrawAlignment(TitleTD[18], 1);
	TextDrawColor(TitleTD[18], -1);
	TextDrawSetShadow(TitleTD[18], 0);
	TextDrawSetOutline(TitleTD[18], 1);
	TextDrawBackgroundColor(TitleTD[18], 51);
	TextDrawFont(TitleTD[18], 1);
	TextDrawSetProportional(TitleTD[18], 1);

	TitleTD[19] = TextDrawCreate(27.999994, 235.946655, "Event3");
	TextDrawLetterSize(TitleTD[19], 0.449999, 1.600000);
	TextDrawAlignment(TitleTD[19], 1);
	TextDrawColor(TitleTD[19], -1);
	TextDrawSetShadow(TitleTD[19], 0);
	TextDrawSetOutline(TitleTD[19], 1);
	TextDrawBackgroundColor(TitleTD[19], 51);
	TextDrawFont(TitleTD[19], 1);
	TextDrawSetProportional(TitleTD[19], 1);

	TitleTD[20] = TextDrawCreate(85.199951, 209.066711, "EV2 0:00");
	TextDrawLetterSize(TitleTD[20], 0.449999, 1.600000);
	TextDrawAlignment(TitleTD[20], 1);
	TextDrawColor(TitleTD[20], -1);
	TextDrawSetShadow(TitleTD[20], 0);
	TextDrawSetOutline(TitleTD[20], 1);
	TextDrawBackgroundColor(TitleTD[20], 51);
	TextDrawFont(TitleTD[20], 3);
	TextDrawSetProportional(TitleTD[20], 1);

	TitleTD[21] = TextDrawCreate(84.800010, 260.835571, "EV3 0:00");
	TextDrawLetterSize(TitleTD[21], 0.449999, 1.600000);
	TextDrawAlignment(TitleTD[21], 1);
	TextDrawColor(TitleTD[21], -1);
	TextDrawSetShadow(TitleTD[21], 0);
	TextDrawSetOutline(TitleTD[21], 1);
	TextDrawBackgroundColor(TitleTD[21], 51);
	TextDrawFont(TitleTD[21], 3);
	TextDrawSetProportional(TitleTD[21], 1);

	TitleTD[22] = TextDrawCreate(476.800079, 141.866714, "All the news will be");
	TextDrawLetterSize(TitleTD[22], 0.374397, 1.595021);
	TextDrawAlignment(TitleTD[22], 1);
	TextDrawColor(TitleTD[22], -1);
	TextDrawSetShadow(TitleTD[22], 0);
	TextDrawSetOutline(TitleTD[22], 1);
	TextDrawBackgroundColor(TitleTD[22], 51);
	TextDrawFont(TitleTD[22], 1);
	TextDrawSetProportional(TitleTD[22], 1);

	TitleTD[23] = TextDrawCreate(478.000061, 162.275604, "placed in these spaces");
	TextDrawLetterSize(TitleTD[23], 0.345596, 1.435732);
	TextDrawAlignment(TitleTD[23], 1);
	TextDrawColor(TitleTD[23], -1);
	TextDrawSetShadow(TitleTD[23], 0);
	TextDrawSetOutline(TitleTD[23], 1);
	TextDrawBackgroundColor(TitleTD[23], 51);
	TextDrawFont(TitleTD[23], 1);
	TextDrawSetProportional(TitleTD[23], 1);
}

CMD:cmdlist(playerid, params[])
{
	SendClientMessage(playerid, COLOR_WHITE, "/afkusers | /partycheck | /toglfg | /showfps | /hide | /unhide | /friendsonly | /away | /afk | /unaway");
	SendClientMessage(playerid, COLOR_WHITE, "/team | /team_acceptinvite | team_acceptrequest | /team_cancelinvite | /team_declineinvite | /team_declinerequest");
	SendClientMessage(playerid, COLOR_WHITE, "/team_cancelrequest | /team_invite | /team_kick | /team_leave | /team_mode | /team_promote | /team_request");
	SendClientMessage(playerid, COLOR_WHITE, "/team_setlootmode | /team_setsidekicking | /vip_activate | /vipaction_mailbox | /vipaction_bankvendor");
	SendClientMessage(playerid, COLOR_WHITE, "/vipaction_profession | /vipaction_mainland | /vipaction_salvager | /fpslimit | /stuck | /killme | /inventory");
	SendClientMessage(playerid, COLOR_WHITE, "/walk | /loc_vec | /gotocharacterselect | /combatlog | /acceptfriend | /addfriend | /chatfriendsonly | /friend");
	SendClientMessage(playerid, COLOR_WHITE, "/friends | /rejectfriend | /removefriend | /say | /chat | /s | /zone | /z | /yell | /y | /trade | /whisper");
	SendClientMessage(playerid, COLOR_WHITE, "/w | /t | /reply | /r | /party | /group | /p | /raid | /queue | /match | /m | /lookingforgroup | /lfg");
	SendClientMessage(playerid, COLOR_WHITE, "/officer | /o | /gang | /g | /chan | /afkusers | /partycheck | /chooseclass | /toglfg | /currentclass");
	return 1;
}

CMD:usefirstaid(playerid, params[])
{
	//basic or advanced
	
	
	return 1;
}

CMD:afkusers(playerid, params[])
{
	new string[128];
	if(AccountInfo[playerid][pAdmin] >= 1)
	{
		format(string, sizeof(string), "There are currently %d AFK users.", AFKPlayerCount);
		SendClientMessage(playerid, COLOR_GRAD1, string);
	}
	return 1;
}

CMD:partycheck(playerid, params[])
{
	new string[124];
	if(PTeamID[playerid] >= 1)
	{
		format(string, sizeof(string), "[PARTY]: You are in a party, Current party ID: {FFF000}%d", PTeamID[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
	    
	    if(IsTeamLeader[playerid] == true)
	    	SendClientMessage(playerid, COLOR_GREEN, "You are the party leader!");

	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "You are NOT in a party!");
	}
	return 1;
}

/*timer TestTimer[500](playerid) //Every Half Second this is called
{

	return 1;
}*/

CMD:toglfg(playerid, params[])
{
	if(AccountInfo[playerid][pChatChannel8] == 1)
	    AccountInfo[playerid][pChatChannel8] = 0;
	else
	    AccountInfo[playerid][pChatChannel8] = 1;
	return 1;
}

CMD:chooseclass(playerid, params[])
{
	new iClassID, string[124];
	if(sscanf(params, "i", iClassID)) return SendClientMessage(playerid, COLOR_GRAD1, "[SYSTEM]: USAGE: /chooseclass [classID]");
 	if(iClassID <= 0 || iClassID >= 5) return SendClientMessage(playerid, COLOR_GRAD1, "[SYSTEM]: Invalid class selection.");
	format(string, sizeof(string), "[SYSTEM]: You've switched your class to %s", clsDta[iClassID][cName]);
	SendClientMessage(playerid, COLOR_GREEN, string);
	AccountInfo[playerid][pClassID] = iClassID;
	return 1;
}

CMD:currentclass(playerid, params[])
{
	new string[124];
	format(string, sizeof(string), "[SYSTEM]: Your current class is: %s", clsDta[AccountInfo[playerid][pClassID]][cName]);
	SendClientMessage(playerid, COLOR_GRAD1, string);
	return 1;
}

/*CMD:charrace(playerid, params[])
{
    ShowCharCreateRace(playerid);
	return 1;
}

CMD:charrace2(playerid, params[])
{
    HideCharCreateRace(playerid);
	return 1;
}*/

#include "commands.pwn"

CMD:checkpath(playerid, params[])
{
	new string[124];
	if(GetCharacterPath(playerid) != 0)
	{
		format(string, sizeof(string), "[SYSTEM]: Your current life path: [ID: %d][Name: %s]", GetCharacterPath(playerid), GetPathName(GetCharacterPath(playerid)));
		SendClientMessage(playerid, COLOR_GRAD2, string);
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "[SYSTEM]: You don't have a life path set, you have been set to Civilian.");
	    AccountInfo[playerid][pCharPath] = 1;
	}
	return 1;
}

CMD:setpath(playerid, params[])
{
	new iPathID, string[124];
	if(sscanf(params, "i", iPathID)) return SendClientMessage(playerid, COLOR_GRAD1, "[SYSTEM]: USAGE: /setpath [PathID]");
 	if(iPathID <= 0 || iPathID >= MAX_LIFE_PATHS) return SendClientMessage(playerid, COLOR_GRAD1, "[SYSTEM]: Invalid path selection.");
	format(string, sizeof(string), "[SYSTEM]: Your life path has been set to: [ID: %d][Name: %s]", iPathID, GetPathName(iPathID));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	AccountInfo[playerid][pCharPath] = iPathID;
	return 1;
}

CMD:veh(playerid, params[]) {
	if(AccountInfo[playerid][pAdmin] >= 4) {

		new
			iVehicle,
			iColors[2];

		if(sscanf(params, "iii", iVehicle, iColors[0], iColors[1])) {
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /veh [model ID] [color 1] [color 2]");
		}
		else if(!(400 <= iVehicle <= 611)) {
			SendClientMessage(playerid, COLOR_GRAD2, "Invalid model specified (model IDs start at 400, and end at 611).");
		}
		else if(!(0 <= iColors[0] <= 255 && 0 <= iColors[1] <= 255)) {
			SendClientMessage(playerid, COLOR_GRAD2, "Invalid color specified (IDs start at 0, and end at 255).");
		}
		else for(new iIterator; iIterator < sizeof(CreatedCars); iIterator++) if(iIterator >= 49) {
			return SendClientMessage(playerid, COLOR_GRAD1, "The maximum limit of 50 spawned vehicles has been reached.");
		}
		else if(CreatedCars[iIterator] == INVALID_VEHICLE_ID) {

			new
				Float: fVehPos[4];

			new fVW = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, fVehPos[0], fVehPos[1], fVehPos[2]);
			GetPlayerFacingAngle(playerid, fVehPos[3]);
			CreatedCars[iIterator] = CreateVehicle(iVehicle, fVehPos[0], fVehPos[1], fVehPos[2], fVehPos[3], iColors[0], iColors[1], -1);
			LinkVehicleToInterior(CreatedCars[iIterator], GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(CreatedCars[iIterator], fVW);
			return SendClientMessage(playerid, COLOR_GREY, "Vehicle spawned!");
		}
	}
	else SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
	return 1;
}

CMD:destroycars(playerid, params[])
{
    if(AccountInfo[playerid][pAdmin] < 4) {
        SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
        return 1;
    }
    for(new i = 0; i < sizeof(CreatedCars); i++) {
        if(CreatedCars[i] != INVALID_VEHICLE_ID) {
            DestroyVehicle(CreatedCars[i]);
            CreatedCars[i] = INVALID_VEHICLE_ID;
        }
    }
    SendClientMessage(playerid, COLOR_GREY, "   Created vehicles destroyed!");
    return 1;
}

CMD:destroycar(playerid, params[]) {
	if(AccountInfo[playerid][pAdmin] >= 4) {
		if(IsPlayerInAnyVehicle(playerid)) {
			for(new i = 0; i < sizeof(CreatedCars); ++i) if(CreatedCars[i] == GetPlayerVehicleID(playerid)) {
				DestroyVehicle(CreatedCars[i]);
				CreatedCars[i] = INVALID_VEHICLE_ID;
				return SendClientMessage(playerid, COLOR_GREY, "You have successfully despawned this vehicle.");
			}
			SendClientMessage(playerid, COLOR_GRAD1, "This vehicle is not admin-spawned.");
		}
		else SendClientMessage(playerid, COLOR_GRAD1, "You're not in any vehicle.");
	}
	else SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
	return 1;
}

stock IsAdminSpawnedVehicle(vehicleid)
{
	for(new i = 0; i < sizeof(CreatedCars); ++i) {
		if(CreatedCars[i] == vehicleid) return 1;
	}
	return 0;
}

CMD:setvw(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
	new giveplayerid, vw;
	if(sscanf(params, "ud", giveplayerid, vw)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /setvw [player] [virtual world]");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specified.");
	new string[128];
	SetPlayerVirtualWorld(giveplayerid,  vw);
	AccountInfo[giveplayerid][pVW] = vw;
	format(string, sizeof(string), "You have set %s's virtual world to %d.", GetPlayerNameEx(giveplayerid),  vw);
	SendClientMessage(playerid, COLOR_GRAD2, string);
	return 1;
}

CMD:setint(playerid, params[])
{
	if (AccountInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
	new giveplayerid, int;
	if(sscanf(params, "ud", giveplayerid, int)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /setint [player] [interiorid]");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specified.");
	new string[128];
	SetPlayerInterior(giveplayerid, int);
	AccountInfo[giveplayerid][pInterior] = int;
	format(string, sizeof(string), "You have set %s's interior to %d.", GetPlayerNameEx(giveplayerid), int);
	SendClientMessage(playerid, COLOR_GRAD2, string);
	return 1;
}

CMD:rehashall(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] < 1337)
	{
		SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
		return 1;
	}
	RehashDynamicDoors();
	return 1;
}

CMD:me(playerid, params[])
{
	if(AccountInfo[playerid][pIsLoggedIn] == false) return SendClientMessage(playerid, COLOR_GREY, "You're not logged in.");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /me [action]");
	new string[128];
	format(string, sizeof(string), "[ME]: %s %s", GetPlayerNameEx(playerid), params);
	ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE, COLOR_ORANGE);
	return 1;
}

CMD:do(playerid, params[])
{
	if(AccountInfo[playerid][pIsLoggedIn] == false) return SendClientMessage(playerid, COLOR_GREY, "You're not logged in.");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /do [action]");
	else if(strlen(params) > 120) return SendClientMessage(playerid, COLOR_GREY, "The specified message must not be longer than 120 characters in length.");
	new
		iCount,
		iPos,
		iChar;

	while((iChar = params[iPos++])) {
		if(iChar == '@') iCount++;
	}
	if(iCount >= 5) {
		return SendClientMessage(playerid, COLOR_GREY, "The specified message must not contain more than 4 '@' symbols.");
	}

	new string[150];
	format(string, sizeof(string), "[DO]: %s (( %s ))", params, GetPlayerNameEx(playerid));
	ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	return 1;
}

CMD:shout(playerid, params[]) {
	return cmd_sh(playerid, params);
}

CMD:sh(playerid, params[])
{
	if(AccountInfo[playerid][pIsLoggedIn] == false) return SendClientMessage(playerid, COLOR_GREY, "You're not logged in.");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: (/s)hout [shout chat]");
	new string[128];
	format(string, sizeof(string), "(shouts) %s!", params);
	SetPlayerChatBubble(playerid,string,COLOR_WHITE,60.0,5000);
	format(string, sizeof(string), "[shout]: %s shouts: %s!", GetPlayerNameEx(playerid), params);
	ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
	return 1;
}

CMD:b(playerid, params[])
{
	if(AccountInfo[playerid][pIsLoggedIn] == false) return SendClientMessage(playerid, COLOR_GREY, "You're not logged in.");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /b [local ooc chat]");
	new string[128];
	format(string, sizeof(string), "[OOC]: %s: (( %s ))", GetPlayerNameEx(playerid), params);
	ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	return 1;
}

CMD:goto(playerid, params[])
{
    if(AccountInfo[playerid][pAdmin] >= 2)
	{
		if(isnull(params))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /goto [location]");
			SendClientMessage(playerid, COLOR_GRAD1, "Locations 1: LS,SF,LV,RC,ElQue,Bayside,LSVIP,SFVIP,LVVIP,Famed,MHC,stadium1");
			SendClientMessage(playerid, COLOR_GRAD2, "Locations 2: stadium2,stadium3,stadium4,int1,mark,mark2,sfairport,dillimore,cave,doc,bank,mall,allsaints");
			SendClientMessage(playerid, COLOR_GRAD3, "Locations 3: countygen,cracklab,gym,rodeo,flint,idlewood,fbi,island,demorgan,doc,icprison,oocprison");
			SendClientMessage(playerid, COLOR_GRAD4, "Locations 4: garagesm,garagemed,garagelg,garagexlg,de_dust2");
			return 1;
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "You can not do this while spectating.");
			return 1;
		}
		if(strcmp(params,"ls",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1529.6,-1691.2,13.3);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"de_dust2",true) == 0)
		{
			SetPlayerPos(playerid,-1043.5205,2598.8110,140.8271);
		}
		else if(strcmp(params,"garagexlg",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar,1111.0139,1546.9510,5290.2793);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1111.0139,1546.9510,5290.2793);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"garagelg",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar,1192.8501,1540.0295,5290.2871);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1192.8501,1540.0295,5290.2871);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"garagemed",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar,1069.1473,1582.1029,5290.2529);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1069.1473,1582.1029,5290.2529);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"garagesm",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar,1198.1407,1589.2153,5290.2871);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1198.1407,1589.2153,5290.2871);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"cave",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1993.01, -1580.44, 86.39);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -1993.01, -1580.44, 86.39);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"sfairport",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1412.5375,-301.8998,14.1411);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -1412.5375,-301.8998,14.1411);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"sf",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1605.0,720.0,12.0);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -1605.0,720.0,12.0);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"lv",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1699.2, 1435.1, 10.7);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"island",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1081.0,4297.9,4.4);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -1081.0,4297.9,4.4);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"cracklab",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 2348.2871, -1146.8298, 27.3183);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 2348.2871, -1146.8298, 27.3183);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"bank",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1487.91, -1030.60, 23.66);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1487.91, -1030.60, 23.66);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"allsaints",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1192.78, -1292.68, 13.38);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1192.78, -1292.68, 13.38);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"countygen",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 2000.05, -1409.36, 16.99);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 2000.05, -1409.36, 16.99);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"gym",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 2227.60, -1674.89, 14.62);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 2227.60, -1674.89, 14.62);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

   		}
		else if(strcmp(params,"fbi",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 344.77,-1526.08,33.28);

			}
			else
			{
				SetPlayerPos(playerid, 344.77,-1526.08,33.28);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
  		else if(strcmp(params,"rc",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1253.70, 343.73, 19.41);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1253.70, 343.73, 19.41);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

   		}
     	else if(strcmp(params,"lsvip",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1810.39, -1601.15, 13.54);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1810.39, -1601.15, 13.54);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
     	else if(strcmp(params,"sfvip",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -2433.63, 511.45, 30.38);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -2433.63, 511.45, 30.38);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
       	else if(strcmp(params,"lvvip",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1875.7731, 1366.0796, 16.8998);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1875.7731, 1366.0796, 16.8998);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"demorgan",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 112.67, 1917.55, 18.72);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 112.67, 1917.55, 18.72);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"icprison",true) == 0)
		{
			SetPlayerPos(playerid, -2069.76, -200.05, 991.53);
			SetPlayerInterior(playerid,10);
			AccountInfo[playerid][pInterior] = 10;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
		}
		else if(strcmp(params, "doc", true) == 0)
		{
			SetPlayerPos(playerid, -2029.2322, -78.3302, 35.3203);
			SetPlayerInterior(playerid, 0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
		}
		else if(strcmp(params,"oocprison",true) == 0)
		{
			SetPlayerPos(playerid, -298.13, 1881.85, 29.89);
			SetPlayerInterior(playerid,1);
			AccountInfo[playerid][pInterior] = 1;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");

		}
		else if(strcmp(params,"stadium1",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1424.93, -664.59, 1059.86);
				LinkVehicleToInterior(tmpcar, 4);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -1424.93, -664.59, 1059.86);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,4);
			AccountInfo[playerid][pInterior] = 4;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"stadium2",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1395.96, -208.20, 1051.28);
				LinkVehicleToInterior(tmpcar, 7);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -1395.96, -208.20, 1051.28);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,7);
			AccountInfo[playerid][pInterior] = 7;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"stadium3",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1410.72, 1591.16, 1052.53);
				LinkVehicleToInterior(tmpcar, 14);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -1410.72, 1591.16, 1052.53);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,14);
			AccountInfo[playerid][pInterior] = 14;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"stadium4",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1394.20, 987.62, 1023.96);
				LinkVehicleToInterior(tmpcar, 15);
				SetVehicleVirtualWorld(tmpcar, 0);

    		}
			else
			{
				SetPlayerPos(playerid, -1394.20, 987.62, 1023.96);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,15);
			AccountInfo[playerid][pInterior] = 15;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"int1",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1416.107000,0.268620,1000.926000);
				LinkVehicleToInterior(tmpcar, 1);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1416.107000,0.268620,1000.926000);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,1);
			AccountInfo[playerid][pInterior] = 1;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"mark",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, GetPVarFloat(playerid, "tpPosX1"), GetPVarFloat(playerid, "tpPosY1"), GetPVarFloat(playerid, "tpPosZ1"));
				LinkVehicleToInterior(tmpcar, GetPVarInt(playerid, "tpInt1"));
			}
			else
			{
				SetPlayerPos(playerid, GetPVarFloat(playerid, "tpPosX1"), GetPVarFloat(playerid, "tpPosY1"), GetPVarFloat(playerid, "tpPosZ1"));
			}
			SetPlayerInterior(playerid, GetPVarInt(playerid, "tpInt1"));
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
		}
		else if(strcmp(params,"mark2",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, GetPVarFloat(playerid, "tpPosX2"), GetPVarFloat(playerid, "tpPosY2"), GetPVarFloat(playerid, "tpPosZ2"));
				LinkVehicleToInterior(tmpcar, GetPVarInt(playerid, "tpInt2"));
			}
			else
			{
				SetPlayerPos(playerid, GetPVarFloat(playerid, "tpPosX2"), GetPVarFloat(playerid, "tpPosY2"), GetPVarFloat(playerid, "tpPosZ2"));
			}
			SetPlayerInterior(playerid, GetPVarInt(playerid, "tpInt2"));
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
		}
		else if(strcmp(params,"mall",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1133.71,-1464.52,15.77);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1133.71,-1464.52,15.77);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"elque",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1446.5997,2608.4478,55.8359);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -1446.5997,2608.4478,55.8359);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"bayside",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -2465.1348,2333.6572,4.8359);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -2465.1348,2333.6572,4.8359);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;

		}
		else if(strcmp(params,"dillimore",true) == 0)
		{
		 	if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 634.9734, -594.6402, 16.3359);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 634.9734, -594.6402, 16.3359);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"famed",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1020.29, -1129.06, 23.87);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1020.29, -1129.06, 23.87);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"rodeo",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 587.0106,-1238.3374,17.8049);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 587.0106,-1238.3374,17.8049);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"flint",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -108.1058,-1172.5293,2.8906);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, -108.1058,-1172.5293,2.8906);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"idlewood",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1955.1357,-1796.8896,13.5469);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				SetPlayerPos(playerid, 1955.1357,-1796.8896,13.5469);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
		else if(strcmp(params,"mhc",true) == 0)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				Player_StreamPrep(playerid, 1700.2124, 1461.1771, 1145.7766, FREEZE_TIME);
				SetVehiclePos(tmpcar, 1700.2124, 1461.1771, 1145.7766);
				LinkVehicleToInterior(tmpcar, 0);
				SetVehicleVirtualWorld(tmpcar, 0);

			}
			else
			{
				Player_StreamPrep(playerid, 1649.7531, 1463.1614, 1151.9687, FREEZE_TIME);
			}
			SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid,0);
			AccountInfo[playerid][pInterior] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			AccountInfo[playerid][pVW] = 0;
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	}
	return 1;
}

CMD:dmalert(playerid, params[])
{
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /dmalert [playerid]");
	if(AccountInfo[playerid][pAdmin] >= 2 && AccountInfo[playerid][pAdmin] < 1338)
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "You can't submit reports as an administrator.");
		return 1;
	}
	if(AccountInfo[playerid][pRMuted] != 0)
	{
  		ShowPlayerDialog(playerid,7955,DIALOG_STYLE_MSGBOX,"Report blocked","You are blocked from submitting any reports!\n\nTips when reporting:\n- Report what you need, not who you need.\n- Be specific, report exactly what you need.\n- Do not make false reports.\n- Do not flame admins.\n- Report only for in-game items.\n- For shop orders use the /shoporder command","Close", "");
		return 1;
	}
 	if(GetPVarType(playerid, "HasReport")) {
		SendClientMessageEx(playerid, COLOR_GREY, "You can only have 1 active report at a time.");
	}
	//JustReported[playerid]=25;
	new string[128];
	format(string, sizeof(string), "{FF0000}(dmalert) %s (ID %d) is deathmatching.", GetPlayerNameEx(giveplayerid), giveplayerid);
	//SendReportToQue(playerid, string, 2, 1);
	SendClientMessageEx(playerid, COLOR_YELLOW, "Your DM report message was sent to the Admins.");
	return 1;
}

CMD:admhelp(playerid, params[])
{
	if (AccountInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessageEx(playerid, COLOR_GREEN,"_______________________________________");
		SendClientMessageEx(playerid, COLOR_GRAD1, "*** {FFFF00}Volunteer{B4B5B7} *** /mjail /kick /staff /togstaff /dmwatch /dmalert");
	}
	if (AccountInfo[playerid][pAdmin] >= 2)
	{
		SendClientMessageEx(playerid, COLOR_GRAD2,"*** REPORTS *** /reports /ar /tr /sta /nao /st /post /dmr *** MOVEMENT *** /up /dn /fd /bk /lt /rt /fly");
		SendClientMessageEx(playerid, COLOR_GRAD2,"*** {00FF00}Intern{BFC0C2} *** /aduty /kick /ban /prison /freeze /unfreeze /slap /warn /admins /spec /levelones");
		SendClientMessageEx(playerid, COLOR_GRAD2,"*** {00FF00}Intern{BFC0C2} *** /sendto /gotopveh /gotocar /jetpack /god /check /anetstats /ipcheck /ip /nrn /listguns");
		SendClientMessageEx(playerid, COLOR_GRAD2,"*** {00FF00}Intern{BFC0C2} *** /setvw /setint /vehname /gethere /gotoid /hospital /goto /revive /bigears /skick /damagecheck");
		SendClientMessageEx(playerid, COLOR_GRAD2,"*** {00FF00}Intern{BFC0C2} *** /requestevent /watch /dmwatchlist /mark(2) /n(un)mute /ad(un)mute /checkinv /lastshot");
	}
	if (AccountInfo[playerid][pAdmin] >= 3)
	{
		SendClientMessageEx(playerid, COLOR_GRAD3,"*** {00FF00}Staff{CBCCCE} *** /noooc /nonewbie /fine /pfine /takeadminweapons /prisonaccount /entercar /getcar");
		SendClientMessageEx(playerid, COLOR_GRAD3,"*** {00FF00}Staff{CBCCCE} *** /mole /setskin /countdown /release /forcedeath /rto(reset) /hhc");
		SendClientMessageEx(playerid, COLOR_GRAD3,"*** {00FF00}Staff{CBCCCE} *** /gotoco /leaders /wepreset /owarn /ofine /okills /respawncar(s)");
		SendClientMessageEx(playerid, COLOR_GRAD3,"*** {00FF00}Staff{CBCCCE} *** /reloadpvehicles /apark /aimpound /dmrmute /dmrlookup /dmtokens /sendtoid /dm");
	}
	if (AccountInfo[playerid][pAdmin] >= 4)
	{
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /asellbiz /fixvehall /givenos /blowup /setname /savechars /dmstrikereset /cnn /respawnvipcars");
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /veh /fixveh /sethp /setarmor /givegun /givemoney /setmoney /setstat /setfightstyle /switchgroup /switchfam");
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /fcreate /fdelete /adivorce /destroycar /destroycars /eventhelp /contracts /sprison /banip /unbanip");
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /groupban /deletehit /setinsurance /cmotd /givelicense /adestroyplant /tl(edit/text/status/next)");
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /gotolabel /createpvehicle /destroypvehicle /vto /vtoreset /admingatepw /gotogate /dedit /fedit");
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /hnext /dmpnext /g(status/near/next/edit) /(goto/goin)door /(goto/goin)house /(create/delete/goto)point");
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /hedit /dd(edit/next/name/pass) /dmpedit /dmpnear /gotomapicon /gangwarn /gangunban /setcapping /banaccount");
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /removepvehicle /rcabuse /createmailbox /adestroymailbox /b(edit/next/name) /adestroycrate /gotocrate");
		SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** /(create/edit/delete)gaspump /(goto/goin)biz /dvcreate /dvstatus /dvrespawn /dvedit /dveditslot /dvplate /checkvouchers");
	}
	if (AccountInfo[playerid][pAdmin] >= 1337)
	{
		SendClientMessageEx(playerid, COLOR_GRAD5,"*** {FF0000}General Manager{E3E3E3} *** /ha /setweather /makeleader /pedit /groupunban /groupcsfunban /giftall /removemoderator /makewatchdog");
		SendClientMessageEx(playerid, COLOR_GRAD5,"*** {FF0000}General Manager{E3E3E3} *** /permaban /setcolor /payday /clearallreports /eventreset /amotd /motd /vipmotd /givetoken /giftgvip");
		SendClientMessageEx(playerid, COLOR_GRAD5,"*** {FF0000}General Manager{E3E3E3} *** /vmute /vsuspend /gifts /rcreset /dvrespawnall /setarmorall /removewatchdog /dynamicgift /asellhouse");
		SendClientMessageEx(playerid, COLOR_GRAD5,"*** {FF0000}General Manager{E3E3E3} *** /togfireworks /togshopnotices /givebackpack /removebackpack /asellallhouses /asellallbiz");
		SendClientMessageEx(playerid, COLOR_GRAD5,"*** {FF0000}General Manager{E3E3E3} *** /givemask /removemask /banmask /unbanmask");
	}
	if (AccountInfo[playerid][pAdmin] >= 1338)
	{
		SendClientMessageEx(playerid, COLOR_GRAD5,"*** {298EFF}Supervisor{E3E3E3} *** /setsec /suspend /osuspend /ounsuspend /osetrmutes /rmute /clearall /specreset /pausespec /random /vrandom");
		SendClientMessageEx(playerid, COLOR_GRAD5,"*** {298EFF}Supervisor{E3E3E3} *** /giftreset /searchvipm /vipgifts /buddyinvite /rewardplay /doublexp /gpcipermaban /getplayerci /givetpgun /taketpgun");
	}
	if (AccountInfo[playerid][pAdmin] >= 99999)
	{
		SendClientMessageEx(playerid, COLOR_GRAD6,"*** {298EFF}CEO{F0F0F0} *** /togspec /togtp /kickres /givecredits /setcredits /settotalcredits /setstpay /resetstpay /pmotd");
		SendClientMessageEx(playerid, COLOR_GRAD6,"*** {298EFF}CEO{F0F0F0} *** /setcode /togdynamicgift /dgedit /viewgiftbox /odemote /makeadmin");
	}
	if (AccountInfo[playerid][pAdmin] >= 1) SendClientMessageEx(playerid, COLOR_GREEN,"_______________________________________");
	return 1;
}

CMD:admin(playerid, params[])
{
    if(AccountInfo[playerid][pAdmin] >= 1)
	{
		new choice[32], option2, option3;
		if(sscanf(params, "s[32]DD", choice, option2, option3))
		{
			SendClientMessageEx(playerid, COLOR_GREEN,"_______________________________________");
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /admin [option] [option2] [option3]");
			if(AccountInfo[playerid][pAdmin] >= 1) SendClientMessageEx(playerid, COLOR_GRAD1, "*** {FFFF00}Volunteer{B4B5B7} *** No option specified.");
			if(AccountInfo[playerid][pAdmin] >= 2) {
				SendClientMessageEx(playerid, COLOR_GRAD2,"*** REPORTS *** No options specified. | *** MOVEMENT *** No options specified.");
				SendClientMessageEx(playerid, COLOR_GRAD2,"*** {00FF00}Intern{BFC0C2} *** god");
			}
			if(AccountInfo[playerid][pAdmin] >= 3) SendClientMessageEx(playerid, COLOR_GRAD3,"*** {00FF00}Staff{CBCCCE} *** No option specified.");
			if(AccountInfo[playerid][pAdmin] >= 4) SendClientMessageEx(playerid, COLOR_GRAD4,"*** {EE9A4D}Assistant Manager{D8D8D8} *** No option specified.");
			if(AccountInfo[playerid][pAdmin] >= 1337) SendClientMessageEx(playerid, COLOR_GRAD5,"*** {FF0000}General Manager{E3E3E3} *** No option specified.");
			if(AccountInfo[playerid][pAdmin] >= 1338) SendClientMessageEx(playerid, COLOR_GRAD5,"*** {298EFF}Supervisor{E3E3E3} *** No option specified.");
			if(AccountInfo[playerid][pAdmin] >= 99999) SendClientMessageEx(playerid, COLOR_GRAD6,"*** {298EFF}CEO{F0F0F0} *** setadmin");
			return 1;
		}
		if(strcmp(choice,"setadmin",true) == 0)
		{
			if(AccountInfo[playerid][pAdmin] >= 1337)
			{
				if(option2 < 0 || option2 > MAX_PLAYERS) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /admin setadmin [player] [level]");
				else if(option3 < 0 || option3 > 99999) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /admin setadmin [player] [level]");
				else if(IsPlayerConnected(option2))
				{
					if(AccountInfo[option2][pAdmin] == option3) return SendClientMessageEx(playerid, COLOR_GREY, "This person already has this administrator level.");
					else {
						new szRank[128];
						switch(option3) {
							case 0: format(szRank, sizeof(szRank), "AdmCmd: %s has fired %s", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
							case 1: format(szRank, sizeof(szRank), "AdmCmd: %s has made %s a Volunteer.", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
							case 2: format(szRank, sizeof(szRank), "AdmCmd: %s has made %s an Intern.", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
							case 3: format(szRank, sizeof(szRank), "AdmCmd: %s has made %s Staff.", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
							case 4: format(szRank, sizeof(szRank), "AdmCmd: %s has made %s an Assistant Manager.", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
							case 1337: format(szRank, sizeof(szRank), "AdmCmd: %s has made %s a General Manager.", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
							case 1338: format(szRank, sizeof(szRank), "AdmCmd: %s has made %s a Supervisor.", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
							case 99999: format(szRank, sizeof(szRank), "AdmCmd: %s has made %s a C.E.O.", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
							default: format(szRank, sizeof(szRank), "AdmCmd: %s has made %s an undefined staff member.", GetPlayerNameEx(playerid), GetPlayerNameEx(option2));
						}

						AccountInfo[option2][pAdmin] = option3;
						ABroadCast(COLOR_LIGHTRED, szRank, 2);
						switch(option3) {
							case 0: format(szRank, sizeof(szRank), "You have been fired by %s.", GetPlayerNameEx(playerid));
							case 1: format(szRank, sizeof(szRank), "You have been made a Volunteer by %s.", GetPlayerNameEx(playerid));
							case 2: format(szRank, sizeof(szRank), "You have been made an Intern by %s.", GetPlayerNameEx(playerid));
							case 3: format(szRank, sizeof(szRank), "You have been made Staff by %s.", GetPlayerNameEx(playerid));
							case 4: format(szRank, sizeof(szRank), "You have been made an Assistant Manager by %s.", GetPlayerNameEx(playerid));
							case 1337: format(szRank, sizeof(szRank), "You have been made a General Manager by %s.", GetPlayerNameEx(playerid));
							case 1338: format(szRank, sizeof(szRank), "You have been made a Supervisor by %s.", GetPlayerNameEx(playerid));
							case 99999: format(szRank, sizeof(szRank), "You have been made a C.E.O. by %s.", GetPlayerNameEx(playerid));
							default: format(szRank, sizeof(szRank), "You have been made an undefined staff member by %s.", GetPlayerNameEx(playerid));
						}
						SendClientMessageEx(option2, COLOR_LIGHTBLUE, szRank);

						switch(option3) {
							case 0: format(szRank, sizeof(szRank), "You have fired %s.", GetPlayerNameEx(option2));
							case 1: format(szRank, sizeof(szRank), "You have made %s a Volunteer.", GetPlayerNameEx(option2));
							case 2: format(szRank, sizeof(szRank), "You have made %s an Intern.", GetPlayerNameEx(option2));
							case 3: format(szRank, sizeof(szRank), "You have made %s Staff.", GetPlayerNameEx(option2));
							case 4: format(szRank, sizeof(szRank), "You have made %s an Assistant Manager.", GetPlayerNameEx(option2));
							case 1337: format(szRank, sizeof(szRank), "You have made %s a General Manager.", GetPlayerNameEx(option2));
							case 1338: format(szRank, sizeof(szRank), "You have made %s a Supervisor.", GetPlayerNameEx(option2));
							case 99999: format(szRank, sizeof(szRank), "You have made %s a C.E.O.", GetPlayerNameEx(option2));
							default: format(szRank, sizeof(szRank), "You have made %s an undefined level administrator.", GetPlayerNameEx(option2));
						}
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szRank);
					}
				}
				else SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid player specified.");
			}
			else SendClientMessageEx(playerid, COLOR_GRAD1, NOTADMIN);
		}
		else if(strcmp(choice,"god",true) == 0)
		{
		    if(AccountInfo[playerid][pAdmin] >= 2)
			{
				new Float:health, Float:armor;
			    if(GetPVarType(playerid, "pGodMode"))
			    {
					health = GetPVarFloat(playerid, "pPreGodHealth");
					SetPlayerHealth(playerid,health);
					armor = GetPVarFloat(playerid, "pPreGodArmor");
					SetPlayerArmor(playerid, armor);
					DeletePVar(playerid, "pGodMode");
					DeletePVar(playerid, "pPreGodHealth");
					DeletePVar(playerid, "pPreGodArmor");
					SendClientMessage(playerid, COLOR_WHITE, "God mode disabled");
				}
				else
				{
					GetPlayerHealth(playerid,health);
					SetPVarFloat(playerid, "pPreGodHealth", health);
					GetPlayerArmour(playerid,armor);
					SetPVarFloat(playerid, "pPreGodArmor", armor);
				    SetPlayerHealth(playerid, 0x7FB00000);
				    SetPlayerArmor(playerid, 0x7FB00000);
				    SetPVarInt(playerid, "pGodMode", 1);
				    SendClientMessage(playerid, COLOR_WHITE, "God mode enabled");
				}
		    }
	    }
		else if(strcmp(choice,"lastshot",true) == 0)
		{
			if(AccountInfo[playerid][pAdmin] < 2) return SendClientMessageEx(playerid, COLOR_GREY, NOTADMIN);
			new iTargetID;
			if(sscanf(params, "u", iTargetID)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /admin lastshot [playerid]");
			if(!IsPlayerConnected(iTargetID)) return SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
			if(aLastShot[iTargetID] == INVALID_PLAYER_ID) return SendClientMessageEx(playerid, COLOR_GREY, "Player was not shot yet.");
			new string[128];
			format(string, sizeof(string), "%s was last shot by %s (ID: %d).",GetPlayerNameEx(iTargetID), GetPlayerNameEx(aLastShot[iTargetID]), aLastShot[iTargetID]);
			SendClientMessageEx(playerid, COLOR_YELLOW, string);
		}
		else if(strcmp(choice,"mark",true) == 0)
		{
		    if (AccountInfo[playerid][pAdmin] >= 2) {

				new
					Float: f_PlayerPos[3];

				GetPlayerPos(playerid, f_PlayerPos[0], f_PlayerPos[1], f_PlayerPos[2]);
				SetPVarFloat(playerid, "tpPosX1", f_PlayerPos[0]);
				SetPVarFloat(playerid, "tpPosY1", f_PlayerPos[1]);
				SetPVarFloat(playerid, "tpPosZ1", f_PlayerPos[2]);

				SetPVarInt(playerid, "tpInt1", GetPlayerInterior(playerid));
		        SendClientMessage(playerid, COLOR_GRAD1, "Teleporter destination set!");
		    }
		    else {
		        SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
		    }
		}
		else if(strcmp(choice,"mark2",true) == 0)
		{
		    if (AccountInfo[playerid][pAdmin] >= 2) {

				new
					Float: f_PlayerPos[3];

				GetPlayerPos(playerid, f_PlayerPos[0], f_PlayerPos[1], f_PlayerPos[2]);
				SetPVarFloat(playerid, "tpPosX2", f_PlayerPos[0]);
				SetPVarFloat(playerid, "tpPosY2", f_PlayerPos[1]);
				SetPVarFloat(playerid, "tpPosZ2", f_PlayerPos[2]);

				SetPVarInt(playerid, "tpInt2", GetPlayerInterior(playerid));
		        SendClientMessage(playerid, COLOR_GRAD1, "Teleporter destination set!");
		    }
		    else {
		        SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
		    }
		}
		else if(strcmp(choice,"setvw",true) == 0)
		{
			if(AccountInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_GRAD1, NOTADMIN);
			new giveplayerid, vw;
			if(sscanf(params, "ud", giveplayerid, vw)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /admin setvw [player] [virtual world]");
			if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specified.");
			new string[128];
			SetPlayerVirtualWorld(giveplayerid,  vw);
			AccountInfo[giveplayerid][pVW] = vw;
			format(string, sizeof(string), "You have set %s's virtual world to %d.", GetPlayerNameEx(giveplayerid),  vw);
			SendClientMessage(playerid, COLOR_GRAD2, string);
		}
		else if(strcmp(choice,"gotoid",true) == 0)
		{
			new giveplayerid = option2;
			if(option2 < 0 || option2 > MAX_PLAYERS) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /admin gotoid [player]");

			new Float:plocx,Float:plocy,Float:plocz;
			if (IsPlayerConnected(giveplayerid))
			{
				if (AccountInfo[playerid][pAdmin] >= 2)
				{
					if(GetPlayerState(giveplayerid) == PLAYER_STATE_SPECTATING)
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "That person is spectating someone.");
						return 1;
					}
					if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
					{
						SendClientMessageEx(playerid, COLOR_GRAD2, "You can not do this while spectating.");
						return 1;
					}
					GetPlayerPos(giveplayerid, plocx, plocy, plocz);
					SetPlayerVirtualWorld(playerid, AccountInfo[giveplayerid][pVW]);
					Streamer_UpdateEx(playerid, plocx, plocy, plocz);

					if (GetPlayerState(playerid) == 2)
					{
						new tmpcar = GetPlayerVehicleID(playerid);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
						SetPlayerPos(playerid,plocx,plocy+2, plocz);
						SetPlayerInterior(playerid, GetPlayerInterior(giveplayerid));
						SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(giveplayerid));
					}

					SendClientMessageEx(playerid, COLOR_GRAD1, "   You have been teleported!");
				}
				else
				{
					SendClientMessageEx(playerid, COLOR_GRAD1, NOTADMIN);
				}

			}
			else SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid player specified.");
		}
		else if(strcmp(choice,"",true) == 0)
		{

		}
		else if(strcmp(choice,"",true) == 0)
		{

		}
		else if(strcmp(choice,"",true) == 0)
		{

		}
		else if(strcmp(choice,"",true) == 0)
		{

		}
		else if(strcmp(choice,"",true) == 0)
		{

		}
	}
	return 1;
}

CMD:eject(playerid, params[])
{
	new targetid;
	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /eject [playerid]");
	if(!IsPlayerConnected(targetid)) return SendGuiInformation(playerid, "Information", "\n\nThis person is not connected.\nPlease try again.\n\n");
	if(playerid == targetid) return SendGuiInformation(playerid, "Information", "\n\nYou can't eject yourself from the vehicle.\n\n");
	if(!AccountInfo[targetid][pIsLoggedIn]) return SendClientMessage(playerid, COLOR_GREY, "\n\nThis person is not logged in. Please try again.\n\n");
	if(GetPlayerVehicleID(playerid) == 0) return SendGuiInformation(playerid, "Information", "\n\nYou are not in any vehicle. Please enter a vehicle and try again.\n\n");
	if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(targetid)) return SendGuiInformation(playerid, "\n\nInformation", "This player is not in your vehicle.\n\n");
	if(GetPlayerVehicleSeat(playerid) != 0) return SendGuiInformation(playerid, "Information", "\n\nYou are not the driver of the vehicle.\n\n");
	RemovePlayerFromVehicle(targetid);
	SendGuiInformation(targetid, "Information", "\n\nYou've been ejected from the vehicle by the driver.\n\n");
	return 1;
}

CMD:gotoco(playerid, params[])
{
	if(AccountInfo[playerid][pAdmin] >= 3)
	{
		new Float: pos[3], int;
		if(sscanf(params, "fffd", pos[0], pos[1], pos[2], int)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /gotoco [x coordinate] [y coordinate] [z coordinate] [interior]");

		SendClientMessageEx(playerid, COLOR_GRAD2, "You have been teleported to the coordinates specified.");
		SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		SetPlayerInterior(playerid, int);
	}
	return 1;
}

CreateLicenseTDs()
{
	License[0] = TextDrawCreate(192.000030, 157.795562, "LD_BEAT:chit");
	TextDrawLetterSize(License[0], 0.000000, 0.000000);
	TextDrawTextSize(License[0], 69.599952, 59.733345);
	TextDrawAlignment(License[0], 1);
	TextDrawColor(License[0], -1);
	TextDrawSetShadow(License[0], 0);
	TextDrawSetOutline(License[0], 0);
	TextDrawFont(License[0], 4);

	License[1] = TextDrawCreate(192.200042, 271.293304, "LD_BEAT:chit");
	TextDrawLetterSize(License[1], 0.000000, 0.000000);
	TextDrawTextSize(License[1], 69.599952, 59.733345);
	TextDrawAlignment(License[1], 1);
	TextDrawColor(License[1], -1);
	TextDrawSetShadow(License[1], 0);
	TextDrawSetOutline(License[1], 0);
	TextDrawFont(License[1], 4);

	License[2] = TextDrawCreate(356.800201, 275.279998, "LD_BEAT:chit");
	TextDrawLetterSize(License[2], 0.000000, 0.000000);
	TextDrawTextSize(License[2], 69.999961, 55.253341);
	TextDrawAlignment(License[2], 1);
	TextDrawColor(License[2], -1);
	TextDrawSetShadow(License[2], 0);
	TextDrawSetOutline(License[2], 0);
	TextDrawFont(License[2], 4);

	License[3] = TextDrawCreate(357.199890, 155.804458, "LD_BEAT:chit");
	TextDrawLetterSize(License[3], 0.000000, 0.000000);
	TextDrawTextSize(License[3], 69.999908, 72.177787);
	TextDrawAlignment(License[3], 1);
	TextDrawColor(License[3], -1);
	TextDrawSetShadow(License[3], 0);
	TextDrawSetOutline(License[3], 0);
	TextDrawFont(License[3], 4);

	License[4] = TextDrawCreate(410.800140, 175.224426, "whitebg");
	TextDrawLetterSize(License[4], 0.000000, 15.335680);
	TextDrawTextSize(License[4], 208.800018, 0.000000);
	TextDrawAlignment(License[4], 1);
	TextDrawColor(License[4], 0);
	TextDrawUseBox(License[4], true);
	TextDrawBoxColor(License[4], -1);
	TextDrawSetShadow(License[4], 0);
	TextDrawSetOutline(License[4], 0);
	TextDrawFont(License[4], 0);

	License[5] = TextDrawCreate(416.800018, 188.664428, "whitebg");
	TextDrawLetterSize(License[5], 0.000000, 12.465557);
	TextDrawTextSize(License[5], 202.000000, 0.000000);
	TextDrawAlignment(License[5], 1);
	TextDrawColor(License[5], 0);
	TextDrawUseBox(License[5], true);
	TextDrawBoxColor(License[5], -1);
	TextDrawSetShadow(License[5], 0);
	TextDrawSetOutline(License[5], 0);
	TextDrawFont(License[5], 0);

	License[6] = TextDrawCreate(388.599914, 169.753402, "whitebg");
	TextDrawLetterSize(License[6], 0.000000, 16.585557);
	TextDrawTextSize(License[6], 224.799972, 0.000000);
	TextDrawAlignment(License[6], 1);
	TextDrawColor(License[6], 0);
	TextDrawUseBox(License[6], true);
	TextDrawBoxColor(License[6], -1);
	TextDrawSetShadow(License[6], 0);
	TextDrawSetOutline(License[6], 0);
	TextDrawFont(License[6], 0);

	License[7] = TextDrawCreate(417.200012, 215.046661, "bgcolorsred");
	TextDrawLetterSize(License[7], 0.000000, 4.362350);
	TextDrawTextSize(License[7], 362.399993, 0.000000);
	TextDrawAlignment(License[7], 1);
	TextDrawColor(License[7], 0);
	TextDrawUseBox(License[7], true);
	TextDrawBoxColor(License[7], -16777178);
	TextDrawSetShadow(License[7], 0);
	TextDrawSetOutline(License[7], 0);
	TextDrawFont(License[7], 0);

	License[8] = TextDrawCreate(416.599975, 257.859954, "bgcolorsyellow");
	TextDrawLetterSize(License[8], 0.000000, 4.562348);
	TextDrawTextSize(License[8], 362.799987, 0.000000);
	TextDrawAlignment(License[8], 1);
	TextDrawColor(License[8], 0);
	TextDrawUseBox(License[8], true);
	TextDrawBoxColor(License[8], -65471);
	TextDrawSetShadow(License[8], 0);
	TextDrawSetOutline(License[8], 0);
	TextDrawFont(License[8], 0);

	License[9] = TextDrawCreate(416.599914, 257.859954, "bgcolorsshade");
	TextDrawLetterSize(License[9], 0.000000, 0.242351);
	TextDrawTextSize(License[9], 362.399963, 0.000000);
	TextDrawAlignment(License[9], 1);
	TextDrawColor(License[9], 0);
	TextDrawUseBox(License[9], true);
	TextDrawBoxColor(License[9], -16777196);
	TextDrawSetShadow(License[9], 0);
	TextDrawSetOutline(License[9], 0);
	TextDrawFont(License[9], 0);

	License[10] = TextDrawCreate(289.599975, 212.060028, "blueline");
	TextDrawLetterSize(License[10], 0.000000, -1.920617);
	TextDrawTextSize(License[10], 413.599975, 0.000000);
	TextDrawAlignment(License[10], 1);
	TextDrawColor(License[10], 0);
	TextDrawUseBox(License[10], true);
	TextDrawBoxColor(License[10], 41215);
	TextDrawSetShadow(License[10], 0);
	TextDrawSetOutline(License[10], 0);
	TextDrawFont(License[10], 0);

	License[11] = TextDrawCreate(317.199981, 199.111114, "driver license");
	TextDrawLetterSize(License[11], 0.210799, 0.878221);
	TextDrawAlignment(License[11], 1);
	TextDrawColor(License[11], -1);
	TextDrawSetShadow(License[11], 0);
	TextDrawSetOutline(License[11], 0);
	TextDrawBackgroundColor(License[11], 51);
	TextDrawFont(License[11], 2);
	TextDrawSetProportional(License[11], 1);

	License[12] = TextDrawCreate(390.399902, 178.204452, "Class~n~C");
	TextDrawLetterSize(License[12], 0.150399, 0.793599);
	TextDrawAlignment(License[12], 2);
	TextDrawColor(License[12], 255);
	TextDrawSetShadow(License[12], 0);
	TextDrawSetOutline(License[12], 0);
	TextDrawBackgroundColor(License[12], 51);
	TextDrawFont(License[12], 2);
	TextDrawSetProportional(License[12], 1);

	License[13] = TextDrawCreate(213.399963, 303.648925, "Los Santos, SA 98245");
	TextDrawLetterSize(License[13], 0.194799, 0.519822);
	TextDrawAlignment(License[13], 1);
	TextDrawColor(License[13], 255);
	TextDrawSetShadow(License[13], 0);
	TextDrawSetOutline(License[13], 0);
	TextDrawBackgroundColor(License[13], 51);
	TextDrawFont(License[13], 2);
	TextDrawSetProportional(License[13], 1);

	License[14] = TextDrawCreate(289.600006, 181.695556, "modelimageofuser");
	TextDrawLetterSize(License[14], 0.000000, 10.592961);
	TextDrawTextSize(License[14], 211.600036, 0.000000);
	TextDrawAlignment(License[14], 1);
	TextDrawColor(License[14], 0);
	TextDrawUseBox(License[14], true);
	TextDrawBoxColor(License[14], 102);
	TextDrawSetShadow(License[14], 0);
	TextDrawSetOutline(License[14], 0);
	TextDrawFont(License[14], 0);

	License[15] = TextDrawCreate(352.800018, 213.546691, "Expires");
	TextDrawLetterSize(License[15], 0.149199, 0.659200);
	TextDrawAlignment(License[15], 1);
	TextDrawColor(License[15], 162);
	TextDrawSetShadow(License[15], 0);
	TextDrawSetOutline(License[15], 0);
	TextDrawBackgroundColor(License[15], 51);
	TextDrawFont(License[15], 1);
	TextDrawSetProportional(License[15], 1);

	License[16] = TextDrawCreate(290.200042, 235.951141, "DOB");
	TextDrawLetterSize(License[16], 0.149199, 0.659200);
	TextDrawAlignment(License[16], 1);
	TextDrawColor(License[16], 162);
	TextDrawSetShadow(License[16], 0);
	TextDrawSetOutline(License[16], 0);
	TextDrawBackgroundColor(License[16], 51);
	TextDrawFont(License[16], 1);
	TextDrawSetProportional(License[16], 1);

	License[17] = TextDrawCreate(339.600128, 236.453384, "Issue Date");
	TextDrawLetterSize(License[17], 0.149199, 0.659200);
	TextDrawAlignment(License[17], 1);
	TextDrawColor(License[17], 162);
	TextDrawSetShadow(License[17], 0);
	TextDrawSetOutline(License[17], 0);
	TextDrawBackgroundColor(License[17], 51);
	TextDrawFont(License[17], 1);
	TextDrawSetProportional(License[17], 1);

	License[18] = TextDrawCreate(290.200103, 243.426696, "Endorsements");
	TextDrawLetterSize(License[18], 0.149199, 0.659200);
	TextDrawAlignment(License[18], 1);
	TextDrawColor(License[18], 162);
	TextDrawSetShadow(License[18], 0);
	TextDrawSetOutline(License[18], 0);
	TextDrawBackgroundColor(License[18], 51);
	TextDrawFont(License[18], 1);
	TextDrawSetProportional(License[18], 1);

	License[19] = TextDrawCreate(290.400146, 256.871124, "Restrictions");
	TextDrawLetterSize(License[19], 0.149199, 0.659200);
	TextDrawAlignment(License[19], 1);
	TextDrawColor(License[19], 162);
	TextDrawSetShadow(License[19], 0);
	TextDrawSetOutline(License[19], 0);
	TextDrawBackgroundColor(License[19], 51);
	TextDrawFont(License[19], 1);
	TextDrawSetProportional(License[19], 1);

	License[20] = TextDrawCreate(333.199951, 243.431121, "Sex");
	TextDrawLetterSize(License[20], 0.149199, 0.659200);
	TextDrawAlignment(License[20], 1);
	TextDrawColor(License[20], 162);
	TextDrawSetShadow(License[20], 0);
	TextDrawSetOutline(License[20], 0);
	TextDrawBackgroundColor(License[20], 51);
	TextDrawFont(License[20], 1);
	TextDrawSetProportional(License[20], 1);

	License[21] = TextDrawCreate(363.800079, 242.937805, "First Licensed");
	TextDrawLetterSize(License[21], 0.149199, 0.659200);
	TextDrawAlignment(License[21], 1);
	TextDrawColor(License[21], 162);
	TextDrawSetShadow(License[21], 0);
	TextDrawSetOutline(License[21], 0);
	TextDrawBackgroundColor(License[21], 51);
	TextDrawFont(License[21], 1);
	TextDrawSetProportional(License[21], 1);

	License[22] = TextDrawCreate(291.600036, 162.275527, "S");
	TextDrawLetterSize(License[22], 0.568000, 4.268088);
	TextDrawAlignment(License[22], 1);
	TextDrawColor(License[22], 41215);
	TextDrawSetShadow(License[22], 0);
	TextDrawSetOutline(License[22], 0);
	TextDrawBackgroundColor(License[22], 51);
	TextDrawFont(License[22], 2);
	TextDrawSetProportional(License[22], 1);

	License[23] = TextDrawCreate(305.600158, 182.186676, "an");
	TextDrawLetterSize(License[23], 0.245599, 1.634845);
	TextDrawAlignment(License[23], 1);
	TextDrawColor(License[23], 41215);
	TextDrawSetShadow(License[23], 0);
	TextDrawSetOutline(License[23], 0);
	TextDrawBackgroundColor(License[23], 51);
	TextDrawFont(License[23], 2);
	TextDrawSetProportional(License[23], 1);

	License[24] = TextDrawCreate(306.800140, 252.373458, "LD_DRV:silver");
	TextDrawLetterSize(License[24], 0.000000, 0.000000);
	TextDrawTextSize(License[24], 60.799991, 63.715549);
	TextDrawAlignment(License[24], 1);
	TextDrawColor(License[24], -185);
	TextDrawSetShadow(License[24], 0);
	TextDrawSetOutline(License[24], 0);
	TextDrawFont(License[24], 4);

	License[25] = TextDrawCreate(337.800048, 182.688888, "ndreas");
	TextDrawLetterSize(License[25], 0.198399, 1.580089);
	TextDrawAlignment(License[25], 1);
	TextDrawColor(License[25], 41215);
	TextDrawSetShadow(License[25], 0);
	TextDrawSetOutline(License[25], 0);
	TextDrawBackgroundColor(License[25], 51);
	TextDrawFont(License[25], 2);
	TextDrawSetProportional(License[25], 1);

	License[26] = TextDrawCreate(321.400085, 162.279983, "A");
	TextDrawLetterSize(License[26], 0.568000, 4.268088);
	TextDrawAlignment(License[26], 1);
	TextDrawColor(License[26], 41215);
	TextDrawSetShadow(License[26], 0);
	TextDrawSetOutline(License[26], 0);
	TextDrawBackgroundColor(License[26], 51);
	TextDrawFont(License[26], 2);
	TextDrawSetProportional(License[26], 1);
	return 1;
}

ShowLicenseTDs(playerid)
{
	new string[128], sext[16];
    for(new t; t < 26; t++)	TextDrawShowForPlayer(playerid, License[t]);
    for(new t; t < 10; t++)	PlayerTextDrawShow(playerid, LicenseP[t][playerid]);
	format(string, sizeof(string), "%s", GetPlayerNameEx(playerid));
	PlayerTextDrawSetString(playerid, LicenseP[0], string);
	//PlayerTextDrawSetString(playerid, LicenseP[1], GetPlayerAddress(playerid));
	//PlayerTextDrawSetString(playerid, LicenseP[2], AccountInfo[playerid][pLicenseID]);
	//PlayerTextDrawSetString(playerid, LicenseP[3], GetLicenseExpireDate(playerid));
	PlayerTextDrawSetString(playerid, LicenseP[4], string);
	format(string, sizeof(string), "%d-%d-%d", AccountInfo[playerid][pBirthM], AccountInfo[playerid][pBirthD], AccountInfo[playerid][pBirthY]);
	PlayerTextDrawSetString(playerid, LicenseP[5], string);
	PlayerTextDrawSetString(playerid, LicenseP[6], AccountInfo[playerid][pLicenseIssued]);
	//PlayerTextDrawSetString(playerid, LicenseP[7], GetPlayerEndorsements(playerid));
	//PlayerTextDrawSetString(playerid, LicenseP[8], GetPlayerRestricts(playerid));

	if(AccountInfo[playerid][pGender] == 1) { sext = "M"; } else { sext = "F"; }
	PlayerTextDrawSetString(playerid, LicenseP[9], sext);
	PlayerTextDrawSetString(playerid, LicenseP[10], AccountInfo[playerid][pLicenseFIssued]);
    return 1;
}

CreateLicensePlayerTDs(playerid)
{
	LicenseP[0][playerid] = CreatePlayerTextDraw(playerid, 213.599960, 290.702239, "Durland, Natsumi");
	PlayerTextDrawLetterSize(playerid, LicenseP[0][playerid], 0.194799, 0.519822);
	PlayerTextDrawAlignment(playerid, LicenseP[0][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[0][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[0][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[0][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[0][playerid], 2);
	PlayerTextDrawSetProportional(playerid, LicenseP[0][playerid], 1);

	LicenseP[1][playerid] = CreatePlayerTextDraw(playerid, 213.599975, 297.182342, "0000 X St");
	PlayerTextDrawLetterSize(playerid, LicenseP[1][playerid], 0.194799, 0.519822);
	PlayerTextDrawAlignment(playerid, LicenseP[1][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[1][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[1][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[1][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[1][playerid], 2);
	PlayerTextDrawSetProportional(playerid, LicenseP[1][playerid], 1);

	LicenseP[2][playerid] = CreatePlayerTextDraw(playerid, 289.599975, 211.057800, "0000000");
	PlayerTextDrawLetterSize(playerid, LicenseP[2][playerid], 0.134800, 1.087288);
	PlayerTextDrawAlignment(playerid, LicenseP[2][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[2][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[2][playerid], -1);
	PlayerTextDrawSetOutline(playerid, LicenseP[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[2][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[2][playerid], 2);
	PlayerTextDrawSetProportional(playerid, LicenseP[2][playerid], 1);

	LicenseP[3][playerid] = CreatePlayerTextDraw(playerid, 375.599975, 212.551071, "09-12-29");
	PlayerTextDrawLetterSize(playerid, LicenseP[3][playerid], 0.213600, 0.873244);
	PlayerTextDrawAlignment(playerid, LicenseP[3][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[3][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[3][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[3][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, LicenseP[3][playerid], 1);

	LicenseP[4][playerid] = CreatePlayerTextDraw(playerid, 295.400238, 220.519989, "durland, natsumi");
	PlayerTextDrawLetterSize(playerid, LicenseP[4][playerid], 0.135199, 0.450133);
	PlayerTextDrawAlignment(playerid, LicenseP[4][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[4][playerid], 162);
	PlayerTextDrawSetShadow(playerid, LicenseP[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[4][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[4][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[4][playerid], 2);
	PlayerTextDrawSetProportional(playerid, LicenseP[4][playerid], 1);

	LicenseP[5][playerid] = CreatePlayerTextDraw(playerid, 305.800079, 235.453262, "09-12-29");
	PlayerTextDrawLetterSize(playerid, LicenseP[5][playerid], 0.196799, 0.748800);
	PlayerTextDrawAlignment(playerid, LicenseP[5][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[5][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[5][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[5][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[5][playerid], 1);
	PlayerTextDrawSetProportional(playerid, LicenseP[5][playerid], 1);

	LicenseP[6][playerid] = CreatePlayerTextDraw(playerid, 370.400054, 235.457702, "07-23-18");
	PlayerTextDrawLetterSize(playerid, LicenseP[6][playerid], 0.196799, 0.748800);
	PlayerTextDrawAlignment(playerid, LicenseP[6][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[6][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[6][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[6][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[6][playerid], 1);
	PlayerTextDrawSetProportional(playerid, LicenseP[6][playerid], 1);

	LicenseP[7][playerid] = CreatePlayerTextDraw(playerid, 290.200042, 248.902175, "C H U");
	PlayerTextDrawLetterSize(playerid, LicenseP[7][playerid], 0.175999, 0.654222);
	PlayerTextDrawAlignment(playerid, LicenseP[7][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[7][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[7][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[7][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[7][playerid], 1);
	PlayerTextDrawSetProportional(playerid, LicenseP[7][playerid], 1);

	LicenseP[8][playerid] = CreatePlayerTextDraw(playerid, 290.400115, 262.346649, "D");
	PlayerTextDrawLetterSize(playerid, LicenseP[8][playerid], 0.175999, 0.654222);
	PlayerTextDrawAlignment(playerid, LicenseP[8][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[8][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[8][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[8][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[8][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[8][playerid], 1);
	PlayerTextDrawSetProportional(playerid, LicenseP[8][playerid], 1);

	LicenseP[9][playerid] = CreatePlayerTextDraw(playerid, 335.199951, 248.906616, "M");
	PlayerTextDrawLetterSize(playerid, LicenseP[9][playerid], 0.175999, 0.654222);
	PlayerTextDrawAlignment(playerid, LicenseP[9][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[9][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[9][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[9][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[9][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[9][playerid], 1);
	PlayerTextDrawSetProportional(playerid, LicenseP[9][playerid], 1);

	LicenseP[10][playerid] = CreatePlayerTextDraw(playerid, 364.199920, 248.413284, "05-16-2017");
	PlayerTextDrawLetterSize(playerid, LicenseP[10][playerid], 0.175999, 0.654222);
	PlayerTextDrawAlignment(playerid, LicenseP[10][playerid], 1);
	PlayerTextDrawColor(playerid, LicenseP[10][playerid], 255);
	PlayerTextDrawSetShadow(playerid, LicenseP[10][playerid], 0);
	PlayerTextDrawSetOutline(playerid, LicenseP[10][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LicenseP[10][playerid], 51);
	PlayerTextDrawFont(playerid, LicenseP[10][playerid], 1);
	PlayerTextDrawSetProportional(playerid, LicenseP[10][playerid], 1);
	return 1;
}











ptask resetplayerhealth[5000](playerid)
{
	new Float:health;
	GetPlayerHealth(playerid,health);
    if(AccountInfo[playerid][pPhase] == 1)
    {
	    if (health < 9999.0)
	    {
	        SetPlayerHealth(playerid, 9999.0);
	    }
	}
}



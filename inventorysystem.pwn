new Inventory[MAX_PLAYERS];
new InventoryColumns = 4;
//Basic Item Inventory
new InventoryRows = 10;
new MaxLikeItems = 50;
new MaxInventoryItems = InventoryColumns * InventoryRows * MaxLikeItems;
new MaxInventorySlots = InventoryColumns * InventoryRows;

enum E_INV_INFO
{
	INVSlotID,
	INVLevel,
	INVItem,
	INVSlots
};
new InventoryInfo[MAX_PLAYERS][MAX_BAGTYPES][E_INV_INFO];

stock OnPlayerOpenInventory(playerid)
{
    If(GetPVarInt(playerid, "IsInInventory") == 0)
	    SetPVarInt(playerid, "IsInInventory", 1);

	SendClientMessage(playerid, COLOR_GREEN, "[System]: You've opened your Inventory.");
	return 1;
}

stock OnPlayerCloseInventory(playerid)
{
	PlayerTextDrawHide(InventoryTD[0][playerid]);
	If(GetPVarInt(playerid, "IsInInventory") == 1)
	    SetPVarInt(playerid, "IsInInventory", 0);

	SendClientMessage(playerid, COLOR_GREEN, "[System]: You've closed your Inventory.");
	return 1;
}

stock OnPlayerChooseItem(playerid, item = 1)
{

	//you have chosen item %d in row %d, column %d.

	return 1;
}




















































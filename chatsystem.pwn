//Original ChatPanel base by Tamy

#include <YSI\y_hooks>

#define MAX_LINES 10

new Text:ChatLine[MAX_LINES];
new ChatText[MAX_LINES][128];

hook OnGameModeInit()
{
	createChatPanel();
	return 1;
}

hook OnGameModeExit()
{
	destroyChatPanel();
	return 1;
}

hook OnPlayerText(playerid, text[])
{
    SendClientMessageEx(text);
	return 1;
}

hook OnPlayerConnect(playerid)
{
    showPlayerChatPanel(playerid);
	return 1;
}

stock createChatPanel()
{
    new y=330;
	for(new i=0; i<MAX_LINES; i++)
	{
		if(!strlen(ChatText[i])) ChatText[i][0] = ' ';
		ChatLine[i] = TextDrawCreate(395, y, ChatText[i]);
		TextDrawAlignment(ChatLine[i], 1);
		TextDrawSetOutline(ChatLine[i], 1);
		TextDrawLetterSize(ChatLine[i], 0.2, 1.0);
		y += 10;
	}
}

stock updateChatPanel()
{
    for(new i=0; i<MAX_LINES; i++)
	{
		if(!strlen(ChatText[i])) ChatText[i][0] = ' ';
		else TextDrawSetString(ChatLine[i], ChatText[i]);
	}
}

stock hidePlayerChatPanel(playerid)
{
    for(new i=0; i<MAX_LINES; i++)
	{
	    TextDrawHideForPlayer(playerid, ChatLine[i]);
	}
}

stock showPlayerChatPanel(playerid)
{
    for(new i=0; i<MAX_LINES; i++)
	{
	    TextDrawShowForPlayer(playerid, ChatLine[i]);
	}
}

stock SendClientMessageEx(msgstr[], pancolor[]="white")
{
	new f=0;
	if(isValidPanelColor(pancolor) == 0) return print("Invalid color entered.");
	if(checkChatStr(msgstr) == 0) return print("Failed to write the message in the box due to invalid characters/string lenth.");
	for(new i=0; i<MAX_LINES; i++)
	{
		if(!strlen(ChatText[i]) || ChatText[i][0] == ' ')
		{
			format(ChatText[i], 128, "%s%s", panelColor(pancolor), msgstr);
			TextDrawSetString(ChatLine[i], ChatText[i]);
			f=1;
			return 1;
		}
	}
	if(!f)
	{
		for(new i=0; i<MAX_LINES; i++)
		{
			if(i == 9) {format(ChatText[i], 128, "%s%s", panelColor(pancolor), msgstr); TextDrawSetString(ChatLine[i], ChatText[i]); return 1;}
			if(strlen(ChatText[i]) && ChatText[i][0] != ' ')
			{
				format(ChatText[i], 128, ChatText[i+1]);
				TextDrawSetString(ChatLine[i], ChatText[i]);
			}

		}
	}
	return 0;
}


stock panelColor(pancol[])
{
    new str[128];
	format(str, 128, "~w~");
	if(!strcmp(pancol, "red", true)) format(str, 128, "~r~");
	else if(!strcmp(pancol, "blue", true)) format(str, 128, "~b~");
	else if(!strcmp(pancol, "yellow", true)) format(str, 128, "~y~");
	else if(!strcmp(pancol, "green", true)) format(str, 128, "~g~");
	return str;
}

stock isValidPanelColor(pancol[])
{
    if(!strcmp(pancol, "white", true) || !strcmp(pancol, "red", true) || !strcmp(pancol, "blue", true) || !strcmp(pancol, "yellow", true) || !strcmp(pancol, "green", true)) return 1;
	return 0;
}

stock checkChatStr(str[])
{
    new len=strlen(str);
	if(len < 1 || len > 64) return 0;
	if(str[len] == ' ') return 0;
	if(strfind(str, "~ ", true) != -1 || strfind(str, "\n ", true) != -1 || strfind(str, "|", true) != -1 || strfind(str, "%", true) != -1) return 0;
	return 1;
}

stock destroyChatPanel()
{
	for(new i=0; i<MAX_LINES; i++)
	{
		TextDrawDestroy(ChatLine[i]);
	}
}

task ChatPanel[1000]()
{
	updateChatPanel();
	return 1;
}


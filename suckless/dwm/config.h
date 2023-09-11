/*  ____             _                         ____          _
## |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
## | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
## | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
## |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
## -----------------------------------------------------------------
## https://darkncesscode.xyz
## https://github.com/codedarkness
## ---------------------------------------------------------------*/

/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  	= 1; /* border pixel of windows */
static const unsigned int gappx     	= 5; /* gaps between windows */
static const unsigned int snap      	= 32;/* snap pixel */
static const int showbar            	= 1; /* 0 means no bar */
static const int topbar             	= 1; /* 0 means bottom bar */
static const char *fonts[]          	= { "noto:size=10" };
static const char dmenufont[]       	= "noto:size=10";
static const char col_gray1[]       	= "#1E1F29"; /* backgroun color */
static const char col_gray2[]       	= "#282A36";
static const char col_gray3[]       	= "#7D7F8C";
static const char col_gray4[]       	= "#D7D7D7";
static const char col_gray5[]       	= "#5A5AA4";
static const char col_gray6[]       	= "#81A1C1";
static const char col_gray7[]       	= "#1F618D";
static const char col_cyan[]        	= "#5A5AA4";
static const char *colors[][3]      	= {
	/*               	  fg           bg         border   */
	[SchemeNorm]		= { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]			= { col_gray4, col_cyan,  col_cyan  },
	[SchemeStatus] 		= { col_gray3, col_gray1, "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel] 	= { col_gray5, col_gray1, "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
   	[SchemeTagsNorm] 	= { col_gray3, col_gray1, "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
   	[SchemeInfoSel]  	= { col_gray6, col_gray1, "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
   	[SchemeInfoNorm]  	= { col_gray6, col_gray1, "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* tagging */
static const char *tags[] = { "DEV", "WWW", "SYS", "GFX", "MPC", "CHT", "TUI", "CLI", "GUI" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      	  instance    title       		tags mask    iscentered		isfloating   	monitor */
	{ "URxvt",	 	  NULL,	      "alsamixer",      0,			 1,		  		1,	       		-1 },
	{ "Nitrogen",	  NULL,	      NULL,	         	0,	         1,       		1,         		-1 },
	{ "mpv",	 	  NULL,       NULL,             0,           0,       		1,         		-1 },
	{ "Lxappearance", NULL,	      NULL,             0,		 	 1,		  		1,	       		-1 },
	{ "Brave-browser",NULL,	      NULL,             1 << 1,	 	 0,		  		0,	       		-1 },
	{ "qutebrowser",  NULL,	      NULL,             1 << 1,	 	 0,		  		0,	       		-1 },
	{ NULL,	 	  	  NULL,	      "Save As",        0,			 1,		  		1,	       		-1 },
	{ NULL,	 	  	  NULL,	      "File Upload",    0,			 1,		  		1,	       		-1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[ ]",      tile },    /* first entry is default */
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[]  = { "alacritty", NULL };

/* Constants */
#define TERMINAL "alacritty"
#define TERMCLASS "Alacritty"

/* volume commands */
#include <X11/XF86keysym.h>

static const char *mutevol[] = { "amixer", "-q", "set", "Speaker", "toggle", NULL };
static const char *upvol[]	 = { "amixer", "-q", "set", "Speaker", "5%+", "unmute", NULL };
static const char *downvol[] = { "amixer", "-q", "set", "Speaker", "5%-", "unmute", NULL };

static Key keys[] = {
	/* modifier                     key        function        	argument */
	{ MODKEY,                       XK_Return, 					spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_Return, 					spawn,          SHCMD("st") },
	{ MODKEY,                       XK_b,      					togglebar,      {0} },
	{ MODKEY,                       XK_d,      					incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      					setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_i,      					incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_j,      					focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_j,      					rotatestack,    {.i = +1 } },
	{ MODKEY,                       XK_k,      					focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_k,      					rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_l,      					setmfact,       {.f = +0.05} },
	{ MODKEY,			            XK_o,      					spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_q,      					killclient,     {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_q,      					quit,           {1} },
	{ MODKEY|ShiftMask,             XK_x,      					quit,           {0} },
	{ MODKEY,                       XK_Tab,    					view,           {0} },
	{ MODKEY,                       XK_space,  					setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  					togglefloating,	{0} },
	{ MODKEY|ShiftMask,             XK_0,      					view,           {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  					focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, 					focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  					tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, 					tagmon,         {.i = +1 } },

	{ 0,							XK_Print,					spawn,			SHCMD("dc-scrot -d") },

	{ 0,							XF86XK_AudioMute,			spawn,			{.v = mutevol } },
	{ 0,							XF86XK_AudioLowerVolume,	spawn,			{.v = downvol } },
	{ 0,							XF86XK_AudioRaiseVolume,	spawn,			{.v = upvol } },

	/* My Keybindings */
	{ MODKEY,						XK_F1,						spawn,			SHCMD("brave") },
	{ MODKEY,						XK_F2,						spawn,			SHCMD("qutebrowser") },
	{ MODKEY,						XK_F3,						spawn,			SHCMD(TERMINAL " -e w3m https://search.darknesscode.xyz") },
	{ MODKEY,						XK_F11,						spawn,			SHCMD("./.dwm/nmcli/networkmanager_dmenu") },
	{ MODKEY,						XK_F12,						spawn,			SHCMD("blurlock") },
	{ MODKEY,						XK_0,						spawn,			SHCMD("./.dwm/sysact") },

	{ MODKEY,						XK_e,						spawn,			SHCMD(TERMINAL " -e neomutt")},
	{ MODKEY,						XK_m,						spawn,			SHCMD(TERMINAL " -e musikcube") },
	{ MODKEY,						XK_p,						spawn,			SHCMD(TERMINAL " -e pipe-viewer") },
	{ MODKEY,						XK_r,						spawn,			SHCMD(TERMINAL " -e ranger") },
	{ MODKEY,						XK_t,						spawn,			SHCMD(TERMINAL " -e arigram") },
	{ MODKEY,						XK_v,						spawn,			SHCMD(TERMINAL " -e vim") },
	{ MODKEY,						XK_w,						spawn,			SHCMD("qutebrowser") },

	{ MODKEY|Mod1Mask,				XK_w,						spawn,			SHCMD(TERMINAL " -e w3m https://search.darknesscode.xyz") },

	{ MODKEY|ControlMask,			XK_v,   					spawn,			SHCMD(TERMINAL " -e ranger ./Videos") },

	{ Mod1Mask,			            XK_Return, 					spawn,          SHCMD("st") },

	{ Mod1Mask,						XK_p,						spawn,			SHCMD(TERMINAL " -e castero") },
	{ Mod1Mask,						XK_r,						spawn,			SHCMD(TERMINAL " -e pyradio") },

	/* change tags (desktop) */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};


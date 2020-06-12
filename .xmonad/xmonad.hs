import XMonad
import XMonad.Config.Desktop
import Data.Monoid
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.FadeInactive
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.Gaps
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import System.IO (hPutStrLn)
import System.Exit

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "termite"
myBorderWidth   = 1
myGaps			= 5
myModMask       = mod1Mask
myWorkspaces    = ["1","2","3","4","5","6"]
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#6673bf"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: [([Char], X ())]
myKeys = [ ("M-w", 	spawn "/home/vinny/.scripts/wifi-scan")
	 , ("M-S-w",	spawn "/home/vinny/.scripts/wifi-disc")
	 , ("M-x",	spawn "/home/vinny/.scripts/exit")
	 , ("M-i", 	spawn "brave")
	 , ("M-f",	spawn "pcmanfm")
	 , ("<XF86AudioLowerVolume>", spawn "amixer -c 1 sset Master 10%-")
	 , ("<XF86AudioRaiseVolume>", spawn "amixer -c 1 sset Master 10%+")
	 , ("<XF86MonBrightnessDown>", spawn "light -U 10%")
	 , ("<XF86MonBrightnessUp>", spawn "light -A 10%")
	 ]
------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (tiled ||| grid ||| threeLayout ||| mtiled ) ||| noBorders Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = renamed [Replace "Tall"] $ gaps [(U,myGaps), (D,myGaps), (R,myGaps), (L,myGaps)] $ spacing myGaps $ Tall 1 (3/100) (1/2)
     mtiled = renamed [Replace "Mirror Tall"] $ gaps [(U,myGaps), (D,myGaps), (R,myGaps), (L,myGaps)] $ spacing myGaps $ Mirror (Tall 1 (3/100) (1/2))
     threeLayout = renamed [Replace "ThreeCol"] $ gaps [(U,myGaps), (D,myGaps), (R,myGaps), (L,myGaps)] $ spacing myGaps $ ThreeColMid 1 (3/100) (1/2)
     grid = renamed [Replace "Grid"] $ gaps [(U,myGaps), (D,myGaps), (R,myGaps), (L,myGaps)] $ spacing myGaps $ Grid(16/10)
------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
	, className =? "mpv"			--> doFloat
	, isFullscreen					--> (doF W.focusDown <+> doFullFloat)
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    spawnOnce "xwallpaper --zoom ~/.config/wall.png &"
    spawnOnce "xcompmgr -n &"
    spawnOnce "dunst -conf ~/.config/dunst/dunstrc &"
    spawnOnce "xsetroot -cursor_name left_ptr &"
    spawnOnce "~/.scripts/battery_alert &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmproc <- spawnPipe "xmobar /home/vinny/.config/xmobar/xmobarrc"
    xmonad $ docks $ ewmh $ fullscreenSupport desktopConfig
        { terminal           = myTerminal
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , layoutHook         = smartBorders $ myLayout
        , manageHook         = myManageHook <+> manageHook desktopConfig <+> manageDocks
        , handleEventHook    = myEventHook <+> handleEventHook desktopConfig
        , startupHook        = myStartupHook
        , logHook  = dynamicLogWithPP xmobarPP
        	   { ppOutput = \x -> hPutStrLn xmproc x
        	   , ppCurrent = xmobarColor "#6673bf" ""
         	   , ppVisible = xmobarColor "#6673bf" ""
        	   , ppHidden = xmobarColor "#808080" ""
			   , ppTitle = xmobarColor "#808080" "" . shorten 60
        	   , ppSep = " | "
        	   }
    	} `additionalKeysP` 	myKeys

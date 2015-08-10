import XMonad.Layout.NoBorders
import XMonad.Layout.FixedColumn
import XMonad.Actions.SpawnOn
import XMonad
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Actions.GridSelect

myModMask = mod4Mask

emacsCmd = "emacs --font 'Bitstream Vera Sans Mono-14'"
vivaldiCmd = "vivaldi"
eclipseCmd = "/home/tbje/scalaide/eclipse/eclipse"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
             [ ((modm, xK_F12), spawn "xtrlock")
             , ((modm, xK_v), spawn vivaldiCmd)
             , ((modm, xK_e), spawn emacsCmd)
             , ((modm, xK_f), spawn "qpdfview /home/tbje/tbjesoft/empty_PDF.pdf")
             , ((modm, xK_o), goToSelected defaultGSConfig)
             , ((modm, xK_c), spawn "xclock")
             , ((modm, xK_i), spawn eclipseCmd)
             , ((modm, xK_u), spawn "chromium")
             , ((modm, xK_0), spawn "/usr/bin/xmodmap ~/.Xmodmap")
             ]
             ++
             [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
             | (key, sc) <- zip [xK_a, xK_s, xK_d] [0..]
             , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

layout = tiled ||| Mirror tiled ||| smartBorders Full -- ||| FixedColumn 2 1 120 10
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 3/4

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

newKeys x  = myKeys x `M.union` keys defaultConfig x

wsEmacs = "emacs"
wsWww  = "www"
wsShell = "shell"

namedWorkspaces = [wsEmacs, wsWww, wsShell]
myWorkspaces = namedWorkspaces ++ map show [length namedWorkspaces..9]

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace program workspace =
  spawn program >> (windows $ W.greedyView workspace)

myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [
      [ className   =? "Vivaldi"         --> doF (W.shift wsWww) ]
    , [ className   =? "Firefox-bin"     --> doF (W.shift wsWww) ]
    , [ resource    =? "startupTerminal" --> doF (W.shift wsShell) ]
    , [ className   =? c                 --> doFloat | c <- myFloats]
    , [ title       =? t                 --> doFloat | t <- myOtherFloats]
    , [ resource    =? r                 --> doIgnore | r <- myIgnores]
    ]
    where
        myIgnores       = ["panel", "stalonetray", "trayer"]
        myFloats        = ["feh", "GIMP", "gimp", "gimp-2.4", "Galculator"]
        myOtherFloats   = ["alsamixer"]


main = xmonad $ defaultConfig
        { borderWidth        = 1
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , manageHook         = myManageHook
        , layoutHook         = layout
        , terminal           = "urxvt"
        , normalBorderColor  = "#808080"
        , focusedBorderColor = "#778899"
        , keys = newKeys
        , startupHook =
          spawn emacsCmd >> spawn vivaldiCmd >> spawn "urxvt -name startupTerminal"
        }

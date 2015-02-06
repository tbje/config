import XMonad.Layout.NoBorders
import XMonad.Layout.FixedColumn
import XMonad.Actions.CopyWindow
import XMonad
import qualified Data.Map as M
import qualified XMonad.StackSet as W

myModMask = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
             [ ((modm, xK_F12), spawn "xtrlock")
             , ((modm, xK_o), spawn "opera")
             , ((modm, xK_v), spawn "vivaldi")
             , ((modm, xK_e), spawn "emacs --font 'Bitstream Vera Sans Mono-14'")
             , ((modm, xK_c), spawn "xclock")
             , ((modm, xK_i), spawn "/home/tbje/eclipse/eclipse")
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

main = xmonad $ defaultConfig
        { borderWidth        = 1
        , modMask            = myModMask
        , layoutHook         = layout
        , terminal           = "urxvt"
        , normalBorderColor  = "#808080"
        , focusedBorderColor = "#778899"
        , keys = newKeys
        }

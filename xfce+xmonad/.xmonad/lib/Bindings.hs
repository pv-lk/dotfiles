module Bindings
  ( myKeys
  , myMouseBindings) where

import qualified Data.Map as M -- For keybindings.
import           Data.Maybe
import           Graphics.X11.ExtraTypes.XF86

import           XMonad
import qualified XMonad.StackSet as W

import qualified XMonad.Actions.FlexibleResize as Flex
import           XMonad.Actions.FloatKeys
import           XMonad.Actions.FloatSnap
import           XMonad.Actions.Minimize
import           XMonad.Actions.TopicSpace
import           XMonad.Actions.WindowMenu

import           XMonad.Layout.BinarySpacePartition
import           XMonad.Layout.Maximize
import           XMonad.Layout.ToggleLayouts
-- import qualified XMonad.Layout.WindowNavigation as N

import           XMonad.Prompt
import           XMonad.Prompt.Layout
import           XMonad.Prompt.Workspace

import           XMonad.Util.EZConfig

import           Config
import           Topics


myKeys = \conf -> mkKeymap conf $
  -- keep some defaults
  [ -- ("M-S-q"),    spawn xfce4-session-logout or io (exitWith ExitSuccess)
    ("M-,",         sendMessage (IncMasterN 1))
  , ("M-.",         sendMessage (IncMasterN (-1)))
    -- programs
  , ("M-<Return>",  spawn $ XMonad.terminal conf)

    -- emacs
  , ("M-e",         spawnEmacs "")
  , ("M-x a",       spawnEmacs "-e '(org-agenda-list)'")
  , ("M-x c",       spawnEmacs "-e '(org-capture)'")
  , ("M-x t",       spawnEmacs "-e '(org-todo-list)'")
  , ("M-<Tab>",     spawnEmacs "-e '(org-roam-dailies-today)'")
    -- rofi
  , ("M-<Space>",   spawn "rofi -show combi")
  , ("M-=",         spawn "rofi -modi calc -show")
  , ("M-M3-p",      spawn "rofi-pass")
  , ("M-M3-k",      spawn "~/.local/bin/rofi/rofi-hotkeys")
  , ("M-M3-s",      spawn "~/.local/bin/rofi/rofi-web-search")

    -- layout
    -- "M-<arrow>" Go and "M-S-<arrow>" Swap bindings from Navigation2D
  , ("M-C-<Right>",   sendMessage $ ExpandTowards R)
  , ("M-C-<Left>",    sendMessage $ ExpandTowards L)
  , ("M-C-<Up>",      sendMessage $ ExpandTowards U)
  , ("M-C-<Down>",    sendMessage $ ExpandTowards D)
  -- , ("M-C-S-<Right>", sendMessage $ ShrinkFrom R)
  -- , ("M-C-S-<Left>",  sendMessage $ ShrinkFrom L)
  -- , ("M-C-S-<Up>",    sendMessage $ ShrinkFrom U)
  -- , ("M-C-S-<Down>",  sendMessage $ ShrinkFrom D)
  -- , ("M-C-S-<Left>",  withFocused (keysResizeWindow (-50,0) (0,0)))
  -- , ("M-C-S-<Right>", withFocused (keysResizeWindow (50,0) (0,0)))
  -- , ("M-C-S-<Up>",    withFocused (keysResizeWindow (0,-50) (0,0)))
  -- , ("M-C-S-<Down>",  withFocused (keysResizeWindow (0,50) (0,0)))
  , ("M-S-t",         sendMessage NextLayout)
  , ("M-c l",         layoutPrompt def)

  -- windows
  , ("M-w",         kill)
  , ("M-c <Space>", windowMenu)
  , ("M-c f",       withFocused $ float)
  , ("M-c t",       withFocused $ windows . W.sink )
  , ("M-c z",       withFocused $ minimizeWindow)
  , ("M-c S-z",     withLastMinimized maximizeWindowAndFocus)
  , ("M-c x",       withFocused (sendMessage . maximizeRestore))

  -- workspaces / topics
  , ("M-M3-[",      promptedGoto)
  , ("M-M3-]",      promptedShift)
  , ("M-M3-;",      currentTopicAction myTopicConfig)
  ] ++
  [ (otherModMasks ++ "M-" ++ [key], action tag)
  | (tag, key)  <- zip myTopics "1234567890"
  , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
                               , ("S-", windows . W.shift)]
  ]

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [
      ((modMask, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)) -- set the window to floating mode and move by dragging
    , ((modMask, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) -- set the window to floating mode and resize by dragging
    ]
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application where

import           Control.Lens
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Auth
import           Snap.Snaplet.AcidState
import           Snap.Snaplet.Session

import           Types

data App = App
    { _heist :: Snaplet (Heist App)
    , _sess :: Snaplet SessionManager
    , _auth :: Snaplet (AuthManager App)
    , _flowers :: Snaplet (Acid FlowerDB)
    }

makeLenses ''App

instance HasHeist App where
    heistLens = subSnaplet heist

instance HasAcid App FlowerDB where
    getAcidStore = view (flowers . snapletValue)

type AppHandler = Handler App App

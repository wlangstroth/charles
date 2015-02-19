{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

import           Data.ByteString (ByteString)
import qualified Data.Map as Map

import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.AcidState
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Util.FileServe

import           Application
import           Types
import           Handlers

routes :: [(ByteString, Handler App App ())]
routes = [ ("", ifTop homePage)
         , ("/admin/flowers/:name", adminFlowerPage)
         , ("/admin/flowers", adminFlowerListPage)
         , ("/admin/flowers/delete/:name", deleteFlowerPage)
         , ("", serveDirectory "static")
         ]

app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    addRoutes routes
    h <- nestSnaplet "" heist $ heistInit "templates"
    s <- nestSnaplet "sess" sess $
           initCookieSessionManager "site_key.txt" "sess" (Just 3600)
    a <- nestSnaplet "auth" auth $
           initJsonFileAuthManager defAuthSettings sess "users.json"
    d <- nestSnaplet "flowers" flowers $ acidInit (FlowerDB Map.empty)
    addRoutes routes
    addAuthSplices h auth
    return $ App h s a d

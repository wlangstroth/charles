{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

import           Control.Applicative

import           Data.ByteString (ByteString)

import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.SqliteSimple
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Snaplet.SqliteSimple

import           Snap.Util.FileServe

import           Application
import           Handlers

routes :: [(ByteString, AppHandler ())]
routes = [ ("", ifTop homePage)
         , ("/login",  with auth handleLoginSubmit)
         , ("/logout", with auth handleLogout)
         , ("/flowers", flowerListPage)
         , ("", serveDirectory "static")
         ]

app :: SnapletInit App App
app = makeSnaplet "app" "Charles the Gardener site" Nothing $ do
    addRoutes routes
    h <- nestSnaplet "" heist $ heistInit "templates"
    s <- nestSnaplet "sess" sess $
           initCookieSessionManager "site_key.txt" "sess" (Just 3600)
    d <- nestSnaplet "db" db sqliteInit
    a <- nestSnaplet "auth" auth $ initSqliteAuth sess d
    addRoutes routes
    wrapSite (<|> error404Page)
    addAuthSplices h auth
    return $ App h s a d

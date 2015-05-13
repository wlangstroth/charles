{-# LANGUAGE OverloadedStrings #-}

module Handlers where

import           Control.Applicative
import           Prelude hiding (div)

import           Control.Monad.Trans (lift)

import qualified Data.Text as T
import           Data.Text (Text)

import           Text.Blaze
import           Text.Blaze.Html5 hiding (map)
import qualified Text.Blaze.Html5.Attributes as A
import           Text.Blaze.Renderer.XmlHtml

import           Text.Digestive.Heist ()
import           Text.Digestive.Snap ()

import           Heist
import qualified Heist.Interpreted as I
import qualified Text.XmlHtml as X

import           Snap.Core
import qualified Snap.Core as Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Heist

import           Application
import           Db


homePage :: AppHandler ()
homePage = Core.method GET $ renderWithSplices "index" $
            "flowers" ## flowerListSplice

flowerListSplice :: I.Splice AppHandler
flowerListSplice = do
    theFlowers <- lift flowerList
    return $ concatMap flowerRow theFlowers

flowerRow :: FlowerListing -> [X.Node]
flowerRow (FlowerListing _ latin common desc price bloom) =
    renderHtmlNodes $
        tr $ do
            td (toHtml latin)
            td (toHtml common)
            td (toHtml desc)
            td (toHtml price)
            td (toHtml bloom)

flowerListPage :: AppHandler ()
flowerListPage =  renderWithSplices "flowers" $ "flowers" ## flowerListSplice

galleryPage :: AppHandler ()
galleryPage = renderWithSplices "gallery" $ "gallery" ## imageGallerySplice

imageGallerySplice :: I.Splice AppHandler
imageGallerySplice = do
    images <- lift galleryList
    return $ map lightboxLink images

imageUrl :: GalleryImage -> Text
imageUrl (GalleryImage im s _) = T.concat [sourcePrefix s, im, ".jpg"]
  where
    sourcePrefix Twitter = "https://pbs.twimg.com/media/"
    sourcePrefix OtherSource = "http://thing.org/"

lightboxLink :: GalleryImage -> X.Node
lightboxLink image@(GalleryImage im s cap) =
    X.Element "div" [] [imageLink]
  where
    imageLink = X.Element "a" attributes [imageNode]
    attributes = [ ("class", "image-link")
                 , ("href", imageUrl image)
                 , ("data-lightbox", "gallery")
                 , ("data-title", cap)
                 ]
    imageNode = X.Element "img" [("class", "gallery-image"), ("src", thumb), ("alt", cap)] []
    thumb = T.concat [imageUrl image, ":thumb"]

-- User management ------------------------------------------------------------

handleLogin :: Maybe Text -> Handler App (AuthManager App) ()
handleLogin authError = heistLocal (I.bindSplices errs) $ render "login"
  where
    errs = maybe noSplices splice authError
    splice err = "loginError" ## I.textSplice err

handleLoginSubmit :: Handler App (AuthManager App) ()
handleLoginSubmit =
    loginUser "login" "password" Nothing
              (\_ -> handleLogin err) (redirect "/admin/flowers")
  where
    err = Just "Unknown user or password"

handleLogout :: Handler App (AuthManager App) ()
handleLogout = logout >> redirect "/"

handleNewUser :: Handler App (AuthManager App) ()
handleNewUser = Core.method GET handleForm <|> Core.method POST handleFormSubmit
  where
    handleForm = render "new_user"
    handleFormSubmit = registerUser "login" "password" >> redirect "/login"

error404Page :: AppHandler ()
error404Page = do
    modifyResponse $ setResponseStatus 404 "Not found"
    render "404"

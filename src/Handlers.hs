{-# LANGUAGE OverloadedStrings #-}

module Handlers where

import           Control.Applicative
import           Prelude hiding (div)

import           Control.Monad.Trans (lift)

import qualified Data.Text as T
-- import qualified Data.Text.Encoding as E

import           Text.Blaze
import           Text.Blaze.Html5 hiding (map)
import qualified Text.Blaze.Html5.Attributes as A
import           Text.Blaze.Renderer.XmlHtml

import           Text.Digestive as D
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

adminHomePage :: AppHandler ()
adminHomePage = Core.method GET $ render "admin-index"

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

adminFlowerListSplice :: I.Splice AppHandler
adminFlowerListSplice = do
    theFlowers <- lift flowerList
    return $ concatMap adminFlowerRow theFlowers

adminFlowerRow :: FlowerListing -> [X.Node]
adminFlowerRow (FlowerListing _ latin common desc price bloom) =
    renderHtmlNodes $
        tr $ do
            td $
                a ! A.href flowerLink $ toHtml latin
            td (toHtml common)
            td (toHtml desc)
            td (toHtml price)
            td (toHtml bloom)
  where
    flowerLink = toValue $ T.concat ["/admin/flowers/", latin]

adminFlowerListPage :: AppHandler ()
adminFlowerListPage =  renderWithSplices "admin-flower-list" $
                            "flowers" ## adminFlowerListSplice

flowerListPage :: AppHandler ()
flowerListPage =  renderWithSplices "flowers" $ "flowers" ## flowerListSplice

    -- (view, result) <- runForm "flower" newFlowerForm
    -- case result of
    --    Just flowerItem -> do
    --        _ <- update $ FlowerInsert flowerItem
    --        heistLocal (bindDigestiveSplices view) $
    --            renderWithSplices "admin-flower-list" $
    --                "flowers" ## adminFlowerListSplice
    --    Nothing -> heistLocal (bindDigestiveSplices view) $
    --               renderWithSplices "admin-flower-list" $
    --                   "flowers" ## adminFlowerListSplice

adminFlowerForm :: Monad m => Maybe FlowerListing -> Form T.Text m FlowerListing
adminFlowerForm flower = FlowerListing
    <$> "id" .: D.stringRead "Not a number" (fmap flowerId flower)
    <*> "latin" .: D.text (fmap flowerLatinName flower)
    <*> "common" .: D.text (fmap flowerCommonNames flower)
    <*> "description" .: D.text (fmap flowerDescription flower)
    <*> "price" .: D.text (fmap flowerPriceDescription flower)
    <*> "bloom" .: D.text (fmap flowerBloomRange flower)

newFlowerForm :: Monad m => Form T.Text m FlowerListing
newFlowerForm = FlowerListing
    <$> "id" .:  D.stringRead "Not a number" Nothing
    <*> "latin" .: D.text Nothing
    <*> "common" .: D.text Nothing
    <*> "description" .: D.text Nothing
    <*> "price" .: D.text Nothing
    <*> "bloom" .: D.text Nothing

handleLogin :: Maybe T.Text -> Handler App (AuthManager App) ()
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


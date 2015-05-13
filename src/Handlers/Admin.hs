{-# LANGUAGE OverloadedStrings #-}

module Handlers.Admin where

import           Snap.Core
import qualified Snap.Core as Core

import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Heist

import           Application
import           Db

adminHomePage :: AppHandler ()
adminHomePage = Core.method GET $ render "admin-index"

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
adminFlowerListPage = do
    (view, result) <- runForm "flower" newFlowerForm
    case result of
       Just flowerItem -> do
           void $ update $ addFlower flowerItem
           heistLocal (bindDigestiveSplices view) $
               renderWithSplices "admin-flower-list" $
                   "flowers" ## adminFlowerListSplice
       Nothing -> heistLocal (bindDigestiveSplices view) $
                  renderWithSplices "admin-flower-list" $
                      "flowers" ## adminFlowerListSplice


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


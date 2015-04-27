{-# LANGUAGE OverloadedStrings #-}

module Db where

import           Control.Applicative

import           Data.Text (Text)
import qualified Data.Text as T

import qualified Database.SQLite.Simple as S
import           Snap.Snaplet.SqliteSimple

import           Application


data FlowerListing = FlowerListing
    {
      flowerId :: Int
    , flowerLatinName :: Text
    , flowerCommonNames :: Text
    , flowerDescription :: Text
    , flowerPriceDescription :: Text
    , flowerBloomRange :: Text
    }
    deriving (Eq, Ord, Show)

instance FromRow FlowerListing where
    fromRow = FlowerListing
            <$> field
            <*> field
            <*> field
            <*> field
            <*> field
            <*> field

flowerList :: AppHandler [FlowerListing]
flowerList = query_ $ S.Query "SELECT * FROM flowers ORDER BY latin_name"

addFlower :: FlowerListing -> AppHandler ()
addFlower (FlowerListing _ l c d p b) =
    execute insertQuery (l,c,d,p,b)
  where
    insertQuery = S.Query $
        T.intercalate " "
            [ "INSERT INTO"
            , "flowers(latin_name,common_name,description,price_description,bloom_range)"
            , "values(?,?,?,?,?)"
            ]

lookupFlower :: Text -> Maybe FlowerListing
lookupFlower = undefined

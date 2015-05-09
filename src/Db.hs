{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}

module Db where

import           Data.Typeable

import           Control.Applicative
import           Control.Monad

import           Data.Text (Text)
import qualified Data.Text as T

import qualified Database.SQLite.Simple as S
import           Database.SQLite.Simple.FromField
import           Database.SQLite.Simple.Ok
import           Database.SQLite.Simple.Internal

import           Snap.Snaplet.SqliteSimple

import           Application


-- Flowers --------------------------------------------------------------------

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

-- Gallery images -------------------------------------------------------------

-- | This is to test out parsing a field from SQLite. I doubt it will actually
-- be necessary
data ImageSource = Twitter
                 | OtherSource
                 deriving (Eq, Ord, Show, Typeable)

data GalleryImage = GalleryImage
    {
      imageId :: Text
    , imageSource :: ImageSource
    , imageCaption :: Text
    }

parseImageSource :: Text -> Maybe ImageSource
parseImageSource t = case t of
    "Twitter"       -> Just Twitter
    "OtherSource"   -> Just OtherSource
    _               -> Nothing

instance FromField ImageSource where
    fromField f@(Field (S.SQLText txt) _) =
        case parseImageSource txt of
            Just txt -> Ok txt
            Nothing -> returnError ConversionFailed f "Should be an image source"
    fromField f = returnError ConversionFailed f "Expected SQLText"

instance FromRow GalleryImage where
    fromRow = GalleryImage
            <$> field
            <*> field
            <*> field

galleryList :: AppHandler [GalleryImage]
galleryList = query_ $ S.Query "SELECT * FROM gallery_images"

-- Tables ---------------------------------------------------------------------

createGalleryTable :: AppHandler ()
createGalleryTable =
    void $ execute_ (S.Query galleryTableQuery)
  where
    galleryTableQuery = T.intercalate " "
        [
          "CREATE TABLE IF NOT EXISTS gallery_images"
        , "("
        , "id TEXT PRIMARY KEY,"
        , "source TEXT,"
        , "caption TEXT"
        , ")"
        ]

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE TypeFamilies #-}

module Types where

import           Control.Applicative

import           Control.Monad.Reader
import           Control.Monad.State

import           Data.Aeson
import           Data.Data
import           Data.List
import           Data.Function
import           Data.SafeCopy
import           Data.Text (Text)
import           Data.Map (Map)
import qualified Data.Map as Map

import           Snap.Snaplet.AcidState


data FlowerListing = FlowerListing
    {
      flowerLatinName :: Text
    , flowerCommonNames :: Text
    , flowerDescription :: Text
    , flowerPriceDescription :: Text
    , flowerBloomRange :: Text
    }
    deriving (Typeable, Eq, Data, Show)

data FlowerDB = FlowerDB !(Map Text FlowerListing)
    deriving (Typeable)

deriveSafeCopy 0 'base ''FlowerListing
deriveSafeCopy 0 'base ''FlowerDB

flowerList :: Query FlowerDB [FlowerListing]
flowerList = do
    FlowerDB db <- ask
    return $ Map.elems db

flowerLookup :: Text -> Query FlowerDB (Maybe FlowerListing)
flowerLookup latin = do
    FlowerDB db <- ask
    return $ Map.lookup latin db

flowerInsert :: FlowerListing -> Update FlowerDB ()
flowerInsert flower = do
    FlowerDB db <- get
    put $ FlowerDB $ Map.insert (flowerLatinName flower) flower db

flowerDelete :: Text -> Update FlowerDB ()
flowerDelete latin = do
    FlowerDB db <- get
    put $ FlowerDB $ Map.delete latin db
    return ()

makeAcidic ''FlowerDB [ 'flowerList
                      , 'flowerLookup
                      , 'flowerInsert
                      , 'flowerDelete
                      ]

flowersByLatin :: [FlowerListing] -> [FlowerListing]
flowersByLatin = sortBy (compare `on` flowerLatinName)

instance ToJSON FlowerListing where
    toJSON (FlowerListing latin common desc price bloom) =
        object ["latinName" .= latin, "commonName" .= common, "description" .= desc, "price" .= price, "bloomRange" .= bloom]

instance FromJSON FlowerListing where
     parseJSON (Object v) = FlowerListing <$>
                            v .: "latinName" <*>
                            v .: "commonName" <*>
                            v .: "description" <*>
                            v .: "price" <*>
                            v .: "bloomRange"
     -- A non-Object value is of the wrong type, so fail.
     parseJSON _          = mzero

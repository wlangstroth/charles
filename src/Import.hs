{-# LANGUAGE OverloadedStrings #-}

module Import where

import qualified Data.Text as T

import qualified Database.SQLite.Simple as S

-- import           Types

insertFlower :: FlowerListing -> IO ()
insertFlower (FlowerListing lat cmn desc prc blm) = do
    conn <- S.open "flower_power.db"
    S.execute conn insertQuery (lat,cmn,desc,prc,blm)
  where
    insertQuery = S.Query $
        T.intercalate " " [ "INSERT INTO"
                          , "flowers(latin_name, common_name, description, price_description, bloom_range)"
                          , "values(?,?,?,?,?)"
                          ]

createFlowersTable :: IO ()
createFlowersTable = do
    conn <- S.open "flower_power.db"
    S.execute_ conn $ S.Query "CREATE TABLE flowers(id INTEGER PRIMARY KEY, latin_name TEXT, common_name TEXT, description TEXT, price_description TEXT, bloom_range TEXT)"

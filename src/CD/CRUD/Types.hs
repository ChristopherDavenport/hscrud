{-# language DeriveGeneric #-}
{-# language OverloadedStrings #-}
module CD.CRUD.Types (
  Person(..)
) where


import qualified Data.Text as T
import Data.Aeson

import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToField

import Data.UUID

------------------------------------------- Edge Types --------------------------------------------
data Person = Person {
  personId :: UUID
  ,personFirstName :: T.Text
  , personLastName :: T.Text
  , personAge :: Int
}

instance ToJSON Person where
  toJSON (Person id first last age) =
    object [ 
      "id" .= id
      ,"first" .= first
      , "last" .= last
      , "age" .= age
    ]

instance FromJSON Person where
  parseJSON = withObject "Person" $ \v -> Person
    <$> v .: "id"
    <*> v .: "first"
    <*> v .: "last"
    <*> v .: "age"

instance FromRow Person where
  fromRow = Person <$> field <*> field <*> field <*> field

instance ToRow Person where
  toRow (Person id first last age) = [toField id, toField first, toField last, toField age]

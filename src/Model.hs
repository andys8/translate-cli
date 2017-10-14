{-# LANGUAGE DeriveGeneric, OverloadedStrings #-}
module Model(RestResponse, RestResult, RestPhrase) where

import Data.Text (Text)
import GHC.Generics (Generic)

data Translation = Translation { translation :: String
                               } deriving (Show, Generic)

-- Rest Api

data RestPhrase = RestPhrase { text :: Text
                             , language :: Text
                             } deriving (Generic, Show)

data RestResult = RestResult { meaningId :: Integer
                             , phrase :: RestPhrase
                             } deriving (Generic, Show)

data RestResponse = RestResponse { result :: !Text
                                 , tuc :: [RestResult]
                                 } deriving (Generic, Show)



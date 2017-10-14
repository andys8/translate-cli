{-# LANGUAGE DeriveGeneric, OverloadedStrings #-}
module Model(RestResponse, RestResult, RestPhrase) where

import Data.Text (Text)
import GHC.Generics (Generic)


data RestPhrase = RestPhrase { text :: String
                             , language :: String
                             } deriving (Generic, Show)

data RestResult = RestResult { phrase :: Maybe RestPhrase
                             } deriving (Generic, Show)

data RestResponse = RestResponse { result :: String
                                 , tuc :: [RestResult]
                                 } deriving (Generic, Show)



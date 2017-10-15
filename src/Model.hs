{-# LANGUAGE DeriveGeneric, OverloadedStrings #-}
module Model(RestResponse(..), Translation(..), Phrase(..), toPhrases) where

import Data.Text (Text)
import GHC.Generics (Generic)
import Data.Maybe


data Phrase = Phrase { text :: String
                     , language :: String
                     } deriving (Generic, Show)

newtype Translation = Translation { phrase :: Maybe Phrase
                               } deriving (Generic, Show)

data RestResponse = RestResponse { result :: String
                                 , tuc :: [Translation]
                                 } deriving (Generic, Show)

toPhrases :: RestResponse -> [String]
toPhrases = fmap formatPhrase . getPhrases . tuc

getPhrases :: [Translation] -> [Phrase]
getPhrases = catMaybes . fmap phrase

formatPhrase :: Phrase -> String
formatPhrase (Phrase text lang) =
    "\x1b["
    ++ show (colorCode lang)
    ++ "m["
    ++ lang
    ++ "]\x1b[0m "
    ++ text


colorCode lang =
    case lang of
        "en" -> 32
        "de" -> 33
        _    -> 34


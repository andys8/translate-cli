{-# LANGUAGE DeriveGeneric, OverloadedStrings #-}
module Model(RestResponse, Translation, Phrase, toPhrases) where

import Data.Text (Text)
import GHC.Generics (Generic)
import Data.Maybe

data Phrase = Phrase { text :: String
                             , language :: String
                             } deriving (Generic, Show)

data Translation = Translation { phrase :: Maybe Phrase
                             } deriving (Generic, Show)

data RestResponse = RestResponse { result :: String
                                 , tuc :: [Translation]
                                 } deriving (Generic, Show)

toPhrases :: RestResponse -> [String]
toPhrases response = fmap formatPhrase $ getPhrases $ getTranslations response

getTranslations :: RestResponse -> [Translation]
getTranslations response = tuc response

getPhrases :: [Translation] -> [Phrase]
getPhrases results = catMaybes $ fmap phrase results

formatPhrase :: Phrase -> String
formatPhrase (Phrase text lang) = "[" ++ lang ++ "] " ++ text

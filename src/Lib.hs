{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

module Lib(translateText) where

import Network.Wreq
import Control.Lens ((&), (^.), (.~))
import Data.Text (Text, pack)
import GHC.Generics (Generic)
import Data.Aeson

import Model

instance FromJSON Phrase
instance FromJSON Translation
instance FromJSON RestResponse

translateText :: String -> IO()
translateText phrase = do
    r <- getWith (getOptions phrase) apiBase
    let body = r ^. responseBody
        decoded = eitherDecode body :: Either String RestResponse
    printPhrases $ fmap (take 5 . toPhrases) decoded

apiBase :: String
apiBase = "https://glosbe.com/gapi_v0_1/translate"

getOptions :: String -> Options
getOptions phrase = defaults
    & param "phrase" .~ [pack phrase]
    & param "from" .~ ["de"]
    & param "dest" .~ ["en"]
    & param "format" .~ ["json"]

printPhrases :: Either String [String] -> IO()
printPhrases phrases =
    case phrases of
        Left _ -> print "No result"
        Right phrases -> mapM_ putStrLn phrases


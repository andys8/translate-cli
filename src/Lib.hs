{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

module Lib(translateText) where

import Network.Wreq
import Control.Lens ((&), (^.), (.~))
import Data.Text (Text, pack)
import GHC.Generics (Generic)
import Data.Aeson

import Model

data Language = DeEn | EnDe

instance FromJSON Phrase
instance FromJSON Translation
instance FromJSON RestResponse

translateText :: String -> IO()
translateText phrase = do
    doRequest $ getLangOptions DeEn phrase
    doRequest $ getLangOptions EnDe phrase

apiBase :: String
apiBase = "https://glosbe.com/gapi_v0_1/translate"

doRequest :: Options -> IO()
doRequest options = do
    r <- getWith options apiBase
    let body = r ^. responseBody
        decoded = eitherDecode body :: Either String RestResponse
    printPhrases $ fmap (take 5 . toPhrases) decoded

getLangOptions :: Language -> String ->  Options
getLangOptions lang phrase =
    let (from, dest) =
            case lang of
                DeEn -> ("deu", "eng")
                EnDe -> ("eng", "deu")
    in defaults
    & param "phrase" .~ [pack phrase]
    & param "from" .~ [from]
    & param "dest" .~ [dest]
    & param "format" .~ ["json"]

printPhrases :: Either String [String] -> IO()
printPhrases phrases =
    case phrases of
        Left _ -> print "No result"
        Right phrases -> mapM_ putStrLn phrases


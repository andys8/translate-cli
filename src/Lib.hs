{-# LANGUAGE DeriveGeneric, OverloadedStrings, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}

module Lib(translateText) where

import Network.Wreq
import Control.Lens ((&), (^.), (^?), (.~), (^..))
import Data.Text (Text, pack)
import GHC.Generics (Generic)
import Data.Aeson 
import Data.Aeson.Lens (key)

import Model

instance FromJSON RestPhrase
instance FromJSON RestResult
instance FromJSON RestResponse

translateText :: String -> IO()
translateText phrase = do
    r <- getWith (getOptions phrase) $ apiBase
    let dr = eitherDecode (r ^. responseBody) :: Either String RestResponse
    print dr

apiBase :: String
apiBase = "https://glosbe.com/gapi_v0_1/translate"

--doRequest = do
--    r <- get $ apiBase ++ requestParams
--    putStrLn $ show $ r ^. responseBody

requestParams :: String
requestParams = "?from=de&dest=eng&format=json&phrase=haus"


getOptions :: String -> Options
getOptions phrase =
    let phraseText = pack phrase
    in defaults
        & param "phrase" .~ [phraseText]
        & param "from" .~ ["de"]
        & param "dest" .~ ["en"]
        & param "format" .~ ["json"]


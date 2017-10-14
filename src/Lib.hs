{-# LANGUAGE DeriveGeneric, OverloadedStrings, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}

module Lib(translateText) where

import Network.Wreq
import Control.Lens ((&), (^.), (^?), (.~), (^..))
import Data.Text (Text)
import GHC.Generics (Generic)
import Data.Aeson (decode, FromJSON)
import Data.Aeson.Lens (key)

import Model

instance FromJSON Model.RestPhrase
instance FromJSON Model.RestResult
instance FromJSON Model.RestResponse

translateText :: String -> IO()
translateText _ = apiRequest

apiBase :: String
apiBase = "https://glosbe.com/gapi_v0_1/translate"

--doRequest = do
--    r <- get $ apiBase ++ requestParams
--    putStrLn $ show $ r ^. responseBody

requestParams :: String
requestParams = "?from=de&dest=eng&format=json&phrase=haus"


apiRequest :: IO ()
apiRequest = do
    let opts = defaults & param "foo" .~ ["bar"]
    --r <- getWith opts apiBase
    r <- get $ apiBase ++ requestParams
    --putStrLn $ show (r ^. responseBody)
    putStrLn $ show $ (decode ((r ^. responseBody)) :: Maybe Model.RestResponse)

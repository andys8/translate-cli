{-# LANGUAGE DeriveGeneric, OverloadedStrings, ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}

module Lib
    ( translateText
    ) where

import Network.Wreq

import Control.Lens ((&), (^.), (^?), (.~), (^..))
import Data.Text (Text)
import GHC.Generics (Generic)
import qualified Control.Exception as E
import Data.Aeson (decode, FromJSON)
import Data.Aeson.Lens (key)

data Phrase = Phrase { text :: Text
                     , language :: Text
                     } deriving (Generic, Show)

data Result = Result { meaningId :: Integer
                     , phrase :: Phrase
                     } deriving (Generic, Show)

data Person = Person { result :: !Text
                     , tuc :: [Result]
                     } deriving (Generic, Show)

instance FromJSON Phrase
instance FromJSON Result
instance FromJSON Person

apiBase :: String
apiBase = "https://glosbe.com/gapi_v0_1/translate"

translateText :: String -> IO()
translateText _ = basic_asJSON

--doRequest = do
--    r <- get $ apiBase ++ requestParams
--    putStrLn $ show $ r ^. responseBody

requestParams :: String
requestParams = "?from=de&dest=eng&format=json&phrase=haus"


basic_asJSON :: IO ()
basic_asJSON = do
    let opts = defaults & param "foo" .~ ["bar"]
    --r <- getWith opts apiBase
    r <- get $ apiBase ++ requestParams
    --putStrLn $ show (r ^. responseBody)
    putStrLn $ show $ (decode ((r ^. responseBody)) :: Maybe Person)

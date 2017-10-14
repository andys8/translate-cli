{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import Lib
import Paths_translate_cli (version)
import Data.Version (showVersion)
import Data.Text (unpack)

parseVersion :: Parser (IO ())
parseVersion =
    subcommand "version" "Show version information" $ pure printVersion

parseMain :: Parser (IO ())
parseMain = fmap (translateText . unpack) parseArgs

parser :: Parser (IO ())
parser = parseVersion <|> parseMain

main :: IO ()
main = do
    cmd <- options "Translation tool for the commandline" parser
    cmd

printVersion :: IO()
printVersion = putStrLn $ showVersion version

parseArgs :: Parser Text
parseArgs = argText "text" "Text to translate"

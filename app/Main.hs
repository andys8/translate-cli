{-# LANGUAGE OverloadedStrings #-}
module Main where

import Turtle
import Lib
import Paths_translate_cli (version)
import Data.Version (showVersion)

--main :: IO ()
--main = someFunc


mainSubroutine :: IO ()
mainSubroutine = echo "Any tool just works!"

parseMain :: Parser (IO ())
parseMain = pure mainSubroutine

parseVersion :: Parser (IO ())
parseVersion =
    (subcommand "version" "Show version information" (pure version'))

parser :: Parser (IO ())
parser = parseMain <|> parseVersion

main :: IO ()
main = do
    cmd <- options "Translation tool for the commandline" parser
    cmd

version' :: IO()
version' = putStrLn (showVersion version)


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

parsePrint :: Parser (IO ())
parsePrint = fmap printText
    (subcommand "print" "Print specified text specified number of times" printArgs)

parser :: Parser (IO ())
parser = parseMain <|> parseVersion <|> parsePrint

main :: IO ()
main = do
    cmd <- options "Translation tool for the commandline" parser
    cmd

version' :: IO()
version' = putStrLn (showVersion version)

printText :: (Maybe Int, Text) -> IO()
printText (Nothing, text) = echo $ unsafeTextToLine text
printText ((Just i), text) = replicateM_ i (echo $ unsafeTextToLine text)

printArgs :: Parser (Maybe Int, Text)
printArgs = (,) <$> optional (optInt "times" 'n' "Number of times")
                <*> (argText "text" "Text to print")

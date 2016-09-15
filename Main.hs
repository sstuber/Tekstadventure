module Main where

import Prelude
import System.Environment
import System.FilePath
import Lexer
import Tokens
import Parser
import Fold

import Text.ParserCombinators.Parsec hiding (spaces)

main :: IO ()
main = do 
         input <- readFile "C:\\universiteit\\Projecten\\TekstAdventure\\Text.txt"
         let x = show . f . readTokens $ alexScanTokens input
         putStrLn x
            where 
                f (Just xs) = makeTree xs "Main"
                f Nothing = EmptyTree
                    


{-
symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

readExpr :: String -> String
readExpr input = case parse symbol "lisp" input of
    Left err -> "No match: " ++ show err
    Right val -> "Found value"

spaces :: Parser ()
spaces = skipMany1 space
-}




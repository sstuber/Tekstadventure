{-# LANGUAGE FlexibleContexts #-}

module Parser where
import Text.ParserCombinators.Parsec 
import Text.ParserCombinators.Parsec.Pos 

import Text.Parsec 
import Text.Parsec.Pos 
import System.Environment
import Tokens
import Prelude
import Data.Maybe

{-data SourcePos  = SourcePos SourceName !Line !Column
       deriving ( Eq, Ord )-}

readTokens :: [Token] -> Maybe [Dialog]
readTokens input = case parse parseProgram "" input of
    Left err -> Nothing
    Right out -> Just out

parseProgram :: (Monad m) => ParsecT [Token] u m [Dialog]
parseProgram = do
    dialogList <- many1 parseDialog
    return dialogList


parseDialog :: (Monad m) => ParsecT [Token] u m Dialog
parseDialog = do
    symbolT StartDialog
    identifier <- parseWord
    text <-  parseText
    actionList <- many parseAction
    symbolT EndDialog
    return $ Dialog identifier text actionList


{-
parseIdentifier :: GenParser Token Identifier
parseIdentifier = 
-}
--https://hackage.haskell.org/package/parsec-3.1.9/docs/Text-ParserCombinators-Parsec-Prim.html
-- token is the versie die gebruikt moet worden in combi met alex posn

satisfyT :: (Stream [Token] m Token) => (Token -> Bool) -> ParsecT [Token] u m Token
satisfyT f = tokenPrim (\t -> show t)
                       (\pos t cs -> updatePosition pos t)
                       (\t -> if f t then Just t else Nothing)

symbolT :: (Monad m) => Token -> ParsecT [Token] u m Token
symbolT t = satisfyT (==t)



isText:: Token -> Bool
isText (Text _) = True
isText _        = False 
--moet aangepast worden voor de positie  

updatePosition :: SourcePos -> Token -> SourcePos
updatePosition pos t = setSourceLine pos 1 

parseWord :: (Monad m) => ParsecT [Token] u m String
parseWord = do 
    (Text string) <- satisfyT isText
    return string

parseText :: (Monad m) => ParsecT [Token] u m String
parseText = do 
    symbolT StartText
    text <- many1 parseWord
    symbolT EndText
    return $ concat text



parseAction :: (Monad m) => ParsecT [Token] u m Action 
parseAction = do
    action <- parseContinue
    return action


parseContinue :: (Monad m) => ParsecT [Token] u m Action
parseContinue = do
    symbolT StartContinue
    text <- parseText
    identifier <- parseWord
    symbolT EndContinue
    return $ Continue text identifier


{
module Lexer where
import Tokens
}

%wrapper "basic"

$digit = 0-9			-- digits
$alpha = [a-zA-Z]		-- alphabetic characters

tokens :-

  $white+				;
  "--".*				;
  \/StartDialog				{ \s -> StartDialog }
  \/EndDialog         { \s -> EndDialog }
  \/StartContinue     { \s -> StartContinue }
  \/EndContinue       { \s -> EndContinue }
  \/StartText         { \s -> StartText }
  \/EndText           { \s -> EndText }
  [$alpha $digit]+    { \s -> Text s}
  

{
-- Each action has type :: String -> Token

-- The token type:
{-data Token =
  StartDialog   |
  EndDialog     |
  StartContinue |
  EndContinue   |
  StartText     |
  EndText       |
  Text String   

  deriving (Eq,Show)-}
{-
main = do
  s <- getContents
  print (alexScanTokens s)-}
}
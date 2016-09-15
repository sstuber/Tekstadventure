module Tokens where

data Token =
  StartDialog   |
  EndDialog     |
  StartContinue |
  EndContinue   |
  StartText     |
  EndText       |
  Text String   
  deriving (Eq,Show)

data Dialog =
    Dialog Identifier String [Action] |
    ErrorDialog
    deriving (Eq,Show)

data Action = 
    Continue String Identifier 
    deriving (Eq,Show)

type Identifier = String 

-- String is the test of the node
-- List is the list of possible actions after
data DiaTree = DiaTree String [ActionTree] 
              | EmptyTree
              | ErrorTree
    deriving (Eq,Show)

-- String is the Text of the action
-- DiaTree is where that particular action leads
data ActionTree = ContiTree String DiaTree
    deriving (Eq)

instance Show ActionTree where
  (ContiTree a b) = Show a
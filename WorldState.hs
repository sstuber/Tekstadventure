module WorldState where

import Tokens
import Control.Monad.Trans.State.Lazy
{-
State World World 
State is het datatype
1e world is the state datatype
2e world is het return datatype

-}
data World = World {
    dialog :: DiaTree
}

initiateWorld :: DiaTree -> World
initiateWorld d = World {
  dialog = d
}

getActionList :: State World [ActionTree]
getActionList = do 
    world <- get
    let (DiaTree _ list) = dialog world
    return list

setDialog :: DiaTree -> State World ()
setDialog d = do 
    world <- get
    put $ world { dialog = d }
    -- dialog is de get functie van World datatype

{-

evalstate (functions in the state monad) (initial state)
returns the return value

execState (functions in the state monad) (initial state)
returns the state


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

-- String is the text of the node
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
  show (ContiTree a b) = show a 
  -}
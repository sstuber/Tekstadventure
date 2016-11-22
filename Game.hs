module Game where

import Tokens
import Control.Monad
import System.IO
import Control.Monad.Trans.State.Lazy
import WorldState
import Prelude
import Data.Maybe
import Text.Read
{-
    write dialog
    write actions
    read reaction
    continue on that branch

-}
{-
    might be better for the toekomst to change all the tree's into one format
-}

{-  prints the text of the current situation
    then prints the actions with prefix numbers
    checks if the input is within the list of options
    continues the game if a correct
-}
runGame :: DiaTree -> IO ()
runGame  = gameHandler . initiateWorld

gameHandler :: World -> IO ()
gameHandler world = do
    let x@(DiaTree _ as) = dialog world 
    printDialog x
    printActions as 0
    actionIndex <- getResponse as -- action index might be 1 higher than the actual index
    if actionIndex < length as && 0 <= actionIndex 
        then  -- splits the actions of the normal dialog tree
            gameHandler $ execState (updateWorld actionIndex) world
            --doAction actionIndex as
        else 
            print "dumfuk" >> gameHandler world



printDialog :: DiaTree -> IO ()
printDialog (DiaTree dialog _) = do
    print dialog 


printActions :: [ActionTree] -> Int  -> IO ()
printActions (x:xs) i = do
    let index = i+ 1
    let toPrint = show index ++ " " ++ getAString x 
    print toPrint
    printActions xs index 
printActions [] _ = return ()

getAString :: ActionTree -> String
getAString (ContiTree a _) = a
-- handles the response. reads response 
getResponse :: [ActionTree] -> IO Int
getResponse as = do
    input <- getLine                -- make an input handler
    let mb = readMaybe input :: Maybe Int  -- inplement 
    fromInput mb
        where 
            fromInput (Nothing) = getResponse as
            fromInput (Just i)  = return i
    
updateWorld:: Int -> State World ()
updateWorld index = do
    aList <- getActionList
    let (ContiTree _ y) = aList !! index
    setDialog y


   {- if isNothing mb 
           then
               getResponse as
               -- input ain't no number 
               -- ask again
           else
                return . fromJust mb-}

   -- return . show . head input -- zit nog niet ingebouwd dat de
    --let index = head input

-- gets the dialog from the actionlist
-- continues the game with it
{-doAction :: Int -> [ActionTree] -> IO ()
doAction x ys = do
    let (ContiTree _ y) = ys !! x 
    gameHandler y
-}
{-
State World World
State is het datatype
1e world is the state datatype
2e world is het return datatype

-}



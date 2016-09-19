module Game where

import Tokens
import Control.Monad
import System.IO
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
gameHandler :: DiaTree -> IO ()
gameHandler x@(DiaTree _ as) = do
    printDialog x
    printActions 0 as
    actionIndex <- getResponse as -- action index might be 1 higher than the actual index
    if actionIndex < length as && 0 <= actionIndex 
        then  -- splits the actions of the normal dialog tree
            doAction actionIndex as
        else 
            print "dumfuk"
            gameHandler x



printDialog :: DiaTree -> IO ()
printDialog (DiaTree dialog _) = do
    print dialog 


printActions :: [ActionTree] -> Int  -> IO ()
printActions (x:xs) i = do
    let index = i+ 1
    let toPrint = index ++ " " ++ getAString x 
    print toPrint
    printActions index xs 
printActions [] = return ()

getAString :: ActionTree -> String
getAString (ContiTree a _) = a
-- handles the response. reads response 
getResponse :: [ActionTree] -> IO Int
getResponse as = do
    input <- getLine 
    let mb = readMaybe . head . input 
    if isNothing mb 
        then
            -- input ain't no number 
            -- ask again
        else
             return . (fromJust mb)

    return . show . head input -- zit nog niet ingebouwd dat de
    --let index = head input


-- gets the dialog from the actionlist
-- continues the game with it
doAction :: Int -> [ActionTree] -> IO ()
doAction x ys = do
    let (ContiTree _ y) = ys !! x 
    gameHandler y


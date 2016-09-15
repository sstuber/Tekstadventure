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
gameHandler :: DiaTree -> IO ()
gameHandler x@(DiaTree _ as) = do
    printDialog x
    printActions 0 as
    actionIndex <- getResponse as
    doAction actionIndex as





printDialog :: DiaTree -> IO ()
printDialog (DiaTree dialog _) = do
    print dialog 


printActions :: [ActionTree] -> Int  -> IO ()
printActions (x:xs) i = do
    let index = i+ 1
    let toPrint = 1 ++ " " ++ getAString x 
    print toPrint
    printActions index xs 
printActions [] = return ()

getAString :: ActionTree -> String
getAString (ContiTree a _) = a
-- handles the response. reads response 
getResponse :: [ActionTree] -> IO Int
getResponse as = do
    input <- getLine
    let index = head input


doAction :: Int -> [ActionTree] -> IO ()



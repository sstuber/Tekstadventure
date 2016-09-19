module Fold where

import Data.List
import Tokens
{-type DialogAlgebra dialog action 
    = ( 
        String -> String 





      )-}


{-
foldProgram :: DialogAlgebra dialog action -> [dialog] 
foldProgram (d1 a1) = foldList
    foldList ((Dialog _ _ _):xs) = foldDialog x : foldList xs 
    foldList ((Continue _ _ _):xs) = foldAction x : foldList xs 
    foldList [] = []
    foldDialog (Dialog ident text actionS)  = 
    foldAction (Continue text ident) = 
-}

--finds the dialog and creates a tree of it. finish condition needs work
createTree :: [Dialog] -> String-> DiaTree
createTree [] _       = EmptyTree
createTree _ "Stop"   = EmptyTree
createTree xs s       = makeBranch (findBranch xs s) xs

-- with the name of the branch it gives the branch
findBranch :: [Dialog] -> String -> Dialog
findBranch xs s = f $ find (\(Dialog i _ _) -> s == i  ) xs
    where 
        f Nothing   = ErrorDialog
        f (Just x)  = x

makeBranch :: Dialog -> [Dialog] -> DiaTree
makeBranch (Dialog ident text xs) ys = DiaTree text (mkActionTree xs ys)

mkActionTree :: [Action] -> [Dialog]-> [ActionTree]
mkActionTree xs zs = foldr (\x ys -> (convActionToTree x zs) : ys) [] xs
--actionTree (x:xs) ys = convActionToTree x ys : actionTree xs 
--actionTree [] _ = []

-- foldr (\x ys -> convActiontoTree x zs : ys) [] xs

convActionToTree :: Action -> [Dialog] -> ActionTree
convActionToTree (Continue text ident) ys =  ContiTree text (createTree ys ident)
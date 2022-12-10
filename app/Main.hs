module Main where

import Data.Char (isSpace)
import System.Environment (getArgs)


trim :: String -> String
trim = f . f
  where
    f = reverse . dropWhile (\c -> c == '\n' || isSpace c)


main :: IO ()
main = do
  args <- getArgs
  file <- readFile (head args)

  let ls = lines file

  let path = if length args > 1 then args !! 1 else ""

  writeFile (path <> "README.md") $ unlines $ encodeBlocks $ reverse $ toBlocks $ reverse $ parseLines ls

  return ()


data Line
  = MarkdownComment String
  | MarkdownCommentEnd String
  | ElmCode String


parseLines :: [String] -> [Line]
parseLines = foldl parseLine []


parseLine :: [Line] -> String -> [Line]
parseLine ls ('m' : 'o' : 'd' : 'u' : 'l' : 'e' : _) = ls
parseLine ls ('i' : 'm' : 'p' : 'o' : 'r' : 't' : _) = ls
parseLine ls l =
  case (ls, l) of
    (MarkdownComment _ : _, '-' : '}' : restLn) ->
      MarkdownCommentEnd restLn : ls
    (MarkdownComment _ : _, other) ->
      MarkdownComment other : ls
    (ElmCode _ : _, '{' : '-' : ' ' : restLn) ->
      MarkdownComment restLn : ls
    ([], '{' : '-' : ' ' : restLn) ->
      MarkdownComment restLn : ls
    (ElmCode _ : _, other) ->
      ElmCode other : ls
    ([], "") ->
      []
    (_, other) ->
      ElmCode other : ls


data Blocks
  = Markdown String
  | Elm String


toBlocks :: [Line] -> [Blocks]
toBlocks =
  foldl line2blocks []


line2blocks :: [Blocks] -> Line -> [Blocks]
line2blocks bs l =
  case (l, bs) of
    (ElmCode s1, Elm s2 : rest) ->
      Elm (s2 <> "\n" <> s1) : rest
    (ElmCode s1, _) ->
      Elm s1 : bs
    (MarkdownComment m1, Markdown m2 : rest) ->
      Markdown (m2 <> "\n" <> trim m1) : rest
    (MarkdownComment m1, _) ->
      Markdown (trim m1) : bs
    (MarkdownCommentEnd m1, Markdown m2 : rest) ->
      Markdown (m2 <> "\n" <> trim m1) : rest
    (MarkdownCommentEnd m1, _) ->
      Markdown (trim m1) : bs


encodeBlocks :: [Blocks] -> [String]
encodeBlocks lns =
  case lns of
    (Elm e : rest) -> "```elm\n" <> trim e <> "\n```\n" : encodeBlocks rest
    (Markdown m : rest) -> m : encodeBlocks rest
    [] -> []

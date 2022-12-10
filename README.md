# elm-generate-readme

Generate a README.md from an Elm file.

# Usage

  1. Use `{- ... -}` block comments for the readme. The rest is turned into a Markdown elm codeblock.
  2. Run `elm-generate-readme path/to/Readme.elm`

# Example

```elm
{- # Block comments

This block comment will be turned into markdown
-}


{-| Function doc

This will be included in the code block

-}
elmCode : String
elmCode =
    List.foldr (++) "" [ "Hello", ", ", "World!" ]
```

Will be turned into this:


````markdown
# Block comments

This block comment will be turned into markdown

```elm
{-| Function doc

This will be included in the code block

-}
elmCode : String
elmCode =
    List.foldr (++) "" [ "Hello", ", ", "World!" ]
```

````

# Motivation

  1. Compile the `Readme.elm` to make sure the examples actually work.
  2. No need to copy code from examples anymore.
  3. One source of truth
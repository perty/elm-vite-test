# Markdown editor in Elm by GitHub Copilot

I have done this almost solely by chatting with GitHub Copilot.

Demo is here: [https://elm-vite-test.vercel.app/](https://elm-vite-test.vercel.app/)

## Starting point

I started by from a template for Vite and Elm https://github.com/lindsaykwardell/vite-elm-template.

## Initial prompt

The initial prompt was as follows:

```
Create a basic markdown editor in Elm with the following features:

* Create model for markdown with default text "type markdown here"
* A text area where users can write markdown
* Show a live preview of the markdown text as I type
* Support for basic markdown syntax like headers, bold, italics
* The markdown text and resulting HTML should be saved in the model.
```

## Further conversation

The conversation was then about which Elm package I needed to install and how to use VSCode, which I was slightly rusty
at.

I asked for more features once I had tried the initial version. Copilot wrote code to interact with JavaScript to access
local storage.
Something I've done many times but still Copilot was easier to use.

At one point I asked for a slightly different style in the code when it comes to update and side effects. No problem
there to get a changed version.

Of course, I also got help with the CSS.

## Deployment

I knew already how to deploy to Vercel. So that was a matter of connecting the repository to my Vercel account. Vercel
has support for Vite.

## Conclusion

GitHub Copilot did the job well, as expected, even in Elm, a language not so widespread as JavaScript.

An interesting effect on my own thinking was that I started to think more about what I wanted and not how it should be
accomplished. 
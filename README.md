# SICP notes and solutions

These are my personal notes and solutions to SICP, 2nd ed. The exercise
solutions (in Scheme Lisp) are occasionally accompanied with an additional
document describing how I reached the solution.

The Markdown documents are written in Kramdown, which allows me to embed
KaTeX-compatible markup.

## VSCode setup

- Install `yzhang.markdown-all-in-one` and `goessner.mdmath`.

- Go into `Settings > @ext:yzhang.markdown-all-in-one`

- Disable `Markdown > Extension > Math`. This disables `markdown-all-in-one`'s
  basic KaTeX engine and favors `mdmath`'s more advanced KaTeX engine.

In my workflow, I usually use a split view, with raw MarkDown on the left and
the rendered preview output on the right. I really *should* have some kind of
script that compiles these Kramdown files into PDFs, but that's another entry on
the to-do stack about to overflow.

## Favorite exercises

- 1-19

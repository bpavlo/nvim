# Find and Replace

---

## The Three Tools

| Tool | Best for |
|------|----------|
| `:%s/old/new/g` | Text replacement, regex, multi-file patterns |
| `cgn` + `.` | Replace occurrences one-by-one with confirmation |
| `grn` | Rename a code symbol across the entire project (LSP) |

---

## `:%s` — Syntax

```
:[range]s/[pattern]/[replacement]/[flags]
```

### Range

| Range | Meaning |
|-------|---------|
| `%` | Whole file |
| _(nothing)_ | Current line only |
| `'<,'>` | Visual selection — auto-inserted when you press `:` in visual mode |
| `.,+5` | Current line + 5 lines below |
| `1,10` | Lines 1–10 |

### Flags

| Flag | Meaning |
|------|---------|
| `g` | All matches per line (without it: only first match per line) |
| `c` | Confirm each — press `y` yes, `n` no, `a` all, `q` quit |
| `i` | Case insensitive |
| `I` | Case sensitive (overrides `ignorecase` setting) |

---

## The Delimiter Trick (avoid most escaping)

`:%s` accepts **any** character as the delimiter, not just `/`.
Use `#`, `,`, or `|` when your pattern contains slashes:

```vim
" Painful:
:%s/foo\/bar\/baz/qux\/quux/g

" Clean:
:%s#foo/bar/baz#qux/quux#g
```

This eliminates the most common source of escaping pain.

---

## Literal Mode (`\V`) — turn off regex

Prefix your pattern with `\V` and everything is treated as literal text.
Only `\` still needs escaping (as `\\`).

```vim
" Replace foo(bar).baz literally — no regex interpretation:
:%s/\Vfoo(bar).baz/replaced/g
```

Use `\V` when replacing code snippets with symbols like `(`, `)`, `.`, `[`, `*`.

---

## Special Characters Reference

### In the pattern

| Character | Default meaning | Literal escape |
|-----------|----------------|----------------|
| `.` | Any character | `\.` |
| `*` | 0 or more of previous | `\*` |
| `[abc]` | Character class | `\[abc\]` |
| `\(` `\)` | Capture group | — (these ARE the escape) |
| `^` | Start of line | `\^` |
| `$` | End of line | `\$` |

### In the replacement

| Character | Meaning |
|-----------|---------|
| `&` | The entire match |
| `\1` `\2` | Back-reference to capture group 1, 2… |
| `\u` | Uppercase next character |
| `\l` | Lowercase next character |
| `\U` | Uppercase rest of replacement |
| `\L` | Lowercase rest of replacement |
| `\n` | Newline |

---

## Common Patterns

### Simple word replacement
```vim
:%s/foo/bar/g
```

### Case-insensitive
```vim
:%s/todo/DONE/gi
```

### Confirm each occurrence
```vim
:%s/old/new/gc
```

### Replace in visual selection only
```vim
" Select lines with V, then press : — Vim fills in '<,'>
:'<,'>s/old/new/g
```

### Rename with a capture group (keep part of the match)
```vim
" Change error("msg") to fmt.Errorf("msg")
:%s/error(\(.*\))/fmt.Errorf(\1)/g
```

### Surround a word with quotes
```vim
" foo -> "foo"
:%s/\<foo\>/"\0"/g
"   ^^   ^^   ^^-- & or \0 = the whole match
"   word boundary anchors
```

### Delete trailing whitespace
```vim
:%s/\s\+$//g
```

### Replace across multiple files (via quickfix)
```vim
" 1. Search with Snacks grep — <leader>fg
" 2. Send results to quickfix — press <C-q> in the picker
" 3. Run substitution on all quickfix files:
:cfdo %s/old/new/g | update
```

---

## `cgn` + `.` — Replace Occurrences One-by-One

This is faster than `:%s/.../gc` for simple word replacement with review.

1. Search for the word: `/foo` then `<Enter>`  
   Or just put the cursor on the word and press `*` (searches for exact word)
2. `cgn` — change the next match (deletes it and enters insert mode)
3. Type the replacement, press `<Esc>`
4. Press `.` to repeat on the next occurrence — or `n` to skip it

The `.` command repeats the entire "delete match + type replacement" action,
so you can step through every occurrence and choose to replace or skip.

---

## `grn` — LSP Rename (the right tool for code symbols)

For renaming a variable, function, or type — use LSP rename instead of `:%s`.

1. Put cursor on the symbol
2. `grn`
3. Type the new name, press `<Enter>`

**Why it's better than `:%s`:**
- Renames across the entire project, not just the current file
- Symbol-aware: won't rename a different variable that happens to share the name
- Handles imports, exports, references automatically

---

## Decision Guide

```
Renaming a code symbol?
  └── Yes → grn (LSP rename)
  └── No  → Is it a few occurrences you want to review?
              └── Yes → * then cgn + .
              └── No  → :%s with g flag
                          └── Pattern has / slashes? → use # as delimiter
                          └── Pattern has lots of symbols? → prefix with \V
```

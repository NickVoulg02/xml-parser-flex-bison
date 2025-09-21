# Android XML Parser (Flex & Bison)

This project is a **lexical and syntactic analyzer** for a subset of Android XML layout files.  
It was developed as part of the *Principles of Programming Languages & Compilers* course at the University of Patras (Spring 2023).

---

## 📌 Overview
The analyzer uses **Flex** for lexical analysis and **Bison** for parsing.  
It checks XML layout files for both **syntactic correctness** and **semantic rules**, such as:

- Root element must be `<LinearLayout>` or `<RelativeLayout>`.
- Mandatory attributes:
  - `android:layout_width` and `android:layout_height` (`wrap_content`, `match_parent`, or a positive integer).
  - `android:text` for `<TextView/>` and `<Button/>`.
  - `android:src` for `<ImageView/>`.
- Attribute checks:
  - `android:id` values must be **unique**.
  - `android:padding` must be a **positive integer**.
  - `android:progress` must be between `0` and `android:max`.
  - `android:checkedButton` must match the ID of a nested `<RadioButton/>`.
- Extra requirement: `<RadioGroup>` has a **mandatory attribute** `android:bnum` that defines the exact number of child `<RadioButton/>` elements.

If the XML file is correct, the analyzer prints the file back and confirms it is *properly formatted*.  
Otherwise, it reports **detailed error messages** with line numbers.

---

## 🛠️ Technologies
- **Flex** – Lexical analyzer
- **Bison** – Parser generator
- **C** – Semantic checks and error handling

---

## 🚀 Usage

### 1. Build
```bash
make
```

### 2. Run Example
```bash
./myParser input
```

### Output:
```bash
... (echoes XML content) ...
The XML file is properly formatted!
```

## 📂 Project Structure
- `ask_1.l` → Flex file (lexer)
- `ask_1.y` → Bison file (parser + grammar)
- `ask_1.tab.c/.h` → Auto-generated parser files
- `lex.yy.c` → Auto-generated lexer file
- `Makefile`


## ✨Authors
- Alexopoulos Vasileios (1084625)
- Voulgaris Nikolaos (1084626)

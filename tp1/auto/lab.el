(TeX-add-style-hook
 "lab"
 (lambda ()
   (setq TeX-command-extra-options
         "-shell-escape")
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "12pt" "letterpaper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "letterpaper" "top=0.5in") ("url" "obeyspaces") ("inputenc" "utf8") ("babel" "french")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (TeX-run-style-hooks
    "latex2e"
    "title-page"
    "report"
    "rep12"
    "geometry"
    "titlesec"
    "tocloft"
    "enumerate"
    "url"
    "algpseudocode"
    "graphicx"
    "inputenc"
    "amsmath"
    "amssymb"
    "babel"
    "pdfpages")
   (TeX-add-symbols
    '("vhdl" 1)
    '("file" 1)
    '("var" 1)
    "title"
    "tpnumber"))
 :latex)


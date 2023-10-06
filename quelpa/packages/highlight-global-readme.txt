When reading source code with EMACS, couples of related files will
be opened simultaneously. A function/variable defined in one file
will be referenced by another function in another file. A
highlight of the corresponding function/vairalbe accross these
buffers will make code reading much more friendly.

EMACS support multi highlight symbols in one buffer but not
accross multi buffers. This package provide highlighting of
symbols accross all buffer.

When new highlight is being added, only the windows of current
frame are updated. Whenever frame configration change(say new
window is added to current frame), window's highlight will be
updated to make windows currently showing always has the updated
highlights. This way is much more effecient than iterating the
overall buffer-list to update highlights for every buffer.

Multi symbols can be highlighted simultaneously. Different
highlights have different face. You could add your highlight face
to highlight-faces.

How to use?

Put the package into load-path, and load the packaget
    (require 'highlight-global)

Toggle highlight of current region (or symbol under cursor if
region is not active) and bind it like this:
    (global-set-key (kbd "M-H") 'highlight-frame-toggle)

Clear all highlight of current frame, and bind it like this:
    (global-set-key (kbd "M-C") 'clear-highlight-frame)
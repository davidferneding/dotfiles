; extends

((section
   (atx_heading)) @section.outer)

((section
   (setext_heading)) @section.outer)

((section
   (atx_heading)) @section.inner
  (#trim! @section.inner))

((section
   (setext_heading)) @section.inner
  (#trim! @section.inner))

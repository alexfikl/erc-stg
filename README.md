# ERC-STG: LaTeX Template

[![GitHub Actions Workflow Status](https://github.com/alexfikl/erc-stg/actions/workflows/ci.yml/badge.svg)](https://github.com/alexfikl/erc-stg/actions/workflows/ci.yml)
[![PDF/UA-2 Compliance](https://img.shields.io/badge/PDF%2FUA--2-Verified_with_veraPDF-blue)](https://verapdf.org/home)
[![Open in Overleaf](https://img.shields.io/static/v1?label=LaTeX&message=Open-in-Overleaf&color=47a141&style=flat&logo=overleaf)](https://www.overleaf.com/docs?snip_uri=https://github.com/alexfikl/erc-stg/archive/refs/heads/main.zip)

> [!NOTE]
> This is an **unofficial** template based on the templates provided by the ERC
> program (originally in RTF format). The template is fairly complete and has been
> update to the 2026 version of the ERC Starting Grants call. However, it was
> **not submitted to the ERC** and deemed eligible (to my knowledge), so use with
> care and double check with the official template. Any help ironing out
> discrepancies is highly appreciated!

LaTeX class and template for the European Research Council (ERC) Starting Grant
applications. The goal of this template is to be as close as possible to the
original template provided by the ERC. However, at this time (2024) the call
imposes very few strict rules for the formatting (margins, font size, font type),
so you are always free to be more creative with it. For a wonderfully colorful
example, see [a proposal by Matthew von Hippel](https://4gravitons.com/2024/03/15/an-open-source-grant-proposal/).

- Details and original template is provided [here](https://erc.europa.eu/apply-grant/starting-grant)
  (calls are updated each year).

- For a `rtf` version of the template, you must start the submission process.
  The template will then be available on the left-hand side in a section
  named "Download Part B templates".

## Usage

To use this template for your own grant proposal, you'll need to copy over
the Part B1 (`erc-stg-b1-template.tex`) and Part B2 (`erc-stg-b2-template.tex`)
template files. They both use the main document class definition from
`erc-stg.cls` and the bibliography file `bibliography.bib`. The repository also
contains two optional documents:

- `erc-stg-eligibility-extension-request-template.tex`: A template for the form
  needed to request an extension for the grant.
- `erc-stg-host-institution-letter-template.tex`: A template for the form needed
  to attest that the host institution is willing to participate in the project.

When starting to work on the proposal, add the `nocomments` option to the
`\documentclass` at the top to remove all the explanations from the document
itself. You can, of course, just delete them too.

## Building

> [!NOTE]
> To build with PDFLaTeX or XeLaTeX, the accessibility setup must be turned
> off. We recommend using LuaLaTeX whenever possible for this reason.

The resulting PDF files are included for easy viewing, but it is recommended to
build the two parts with e.g. `latexmk` as follows

```bash
latexmk -pdflua erc-stg-b1-template.tex
latexmk -pdflua erc-stg-b2-template.tex
```

Using `latexmk` is recommended because it will nicely handle generating the
bibliography for you. If you use an IDE or Overleaf, this will be handled
automatically.

## Accessibility (PDF/UA-2 Compliance)

> [!NOTE]
> Accessibility support (PDF/UA-2) is enabled automatically whenever
> `\DocumentMetadata` is provided before `\documentclass` in the templates.

By default, the current templates use the new [LaTeX
Tagging](https://latex3.github.io/tagging-project/) infrastructure to produce
more accessible PDFs (using the PDF/UA-2 standard for Universal Accessibility).
We currently pass the checks from [veraPDF](https://verapdf.org/), but this is
not sufficient for full compliance (i.e. some aspects cannot be checked
automatically, such as image contrast). The accessible build requires a pretty
modern LaTeX toolchain:

- **TeXLive 2025+**, the newer the better (Overleaf has TeXLive 2026).
- **LuaLaTeX**. PDFLaTeX and XeLaTeX cannot produce the required tagged PDFs. Note
  that PDFLaTeX can produce PDF/UA-2 documents, they do not pass the veraPDF checks
  at this point.

Other things to keep in mind when using tagged PDFs:

- Many common packages do not work with tagging. See the
  [official Tagging Status page](https://latex3.github.io/tagging-project/tagging-status/)
  for the compatibility status for most packages. Note that incompatible
  packages will still work most of the time, but they will not produce PDFs that
  can actually be used by screen readers or other accessibility software.
- There are strict requirements around figures and tables that need to be followed.
  See the [official documentation](https://latex3.github.io/tagging-project/documentation/usage-instructions)
  and [Overleaf's documentation](https://docs.overleaf.com/writing-and-editing/creating-accessible-pdfs)
  for more information on the various problems.

The tagged build should be easy to disable. You only need to delete or
comment out the `\DocumentMetadata` command at the top of the template files.

## Functionality

This packages provides the `erc-stg` class that is based on the KOMA-script
`scrartcl` class and accepts any options meant for it. It can be used as

```tex
\documentclass[11bp,arial,partone,draftproposal]{erc-stg}

% ... preamble ...

\begin{document}

% ... content ...

\end{document}
```

The class has some options that can be used in the `\documentclass` command (as
above). They are set in the existing template files already. Any unknown
options are forwarded to the `scrartcl` class. There are three options meant
for drafting:

- `layoutgrid`: overlays a grid on top of each page to check margins and
  other alignment issues.
- `draftproposal`: adds helpful drafting options, such as line numbers and
  a time stamp. This should also be removed from the templates when submitting.
- `nocomments`: disables the ERC template comments. These are just provided
  as documentation and should be disabled on the start of a new proposal.

The main options control the formatting of part B1 and B2. We have

- `partone`: overwrites `\maketitle` to create the Part B1 title page.
- `parttwo`: overwrites `\maketitle` for the Part B2 title.
- `timesnewroman`: selects the Times New Roman font (or TeX Gyre Terms) and
  ensures that the serif font is the default.
- `arial` selects the Arial font (or TeX Gyre Heros) and ensures
  the sans serif font is the default.

The class also provides a few useful commands that can be used in the proposal.
These should be set in both the Part B1 and Part B2 files to ensure that the
proposal metadata is available.

- `\ercauthor`, `\insertercauthor`: sets the full author name (first and last name).
- `\ercauthorlastname`, `\insertercauthorlastname`: sets the author's last name (used in the header).
- `\ercinstitution`, `\insertercinstitution`: sets the hosting institution.
- `\ercduration`, `\insertercduration`: sets the duration of the project (in months).
- `\erctitle`, `\inserterctitle`: sets the proposal title.
- `\ercacronym`, `\insertercacronym`: sets the proposal acronym (must match the title).
- `\ercsummary`: defines the summary that appears on the title page of Part B1.
- `\erccrossummary`: defines the cross-disciplinary proposal justification
  that appears on the title page of Part B1. If no such justification is needed,
  use the `\ercnocrosssummary` command to remove the box and text for this part.

The following optional helper environments are also defined:

- `erccomment`: exclusively used for the ERC documentation comments in the
  template. This is just there so that it can be globally disabled.
- `erccvitem`: a simple wrapper around `tabular` for adding nicely aligned
  CV items.
- `erctable`: a simple wrapper around `tabular` with consistent formatting.
- `erclongtable`: a simple wrapper around `longtable` with consistent
  formatting.

## Fonts

The official ERC guidelines require the Times New Roman, Arial or similar
fonts. On Windows, these should be available, but on Linux we fall back to the
*TeX Gyre* family of fonts. When using PDFLaTeX this class uses the `tgtermes`
package. When using XeLaTeX or LuaLaTeX, we try to load the Times New Roman
font and, if it is not available, the TeX Gyre Terms font (or Arial and TeX
Gyre Heros, respectively). The official manual recommends the *Nimbus* fonts
(Nimbus Roman and Nimbus Sans), which are metrically compatible with TeX Gyre.

If these do not work for you, you can load fonts yourself using e.g.

```tex
% on PDFLaTeX
\usepackage{newtxtext}
\usepackage{newtxmath}

% on XeLaTeX / LuaLaTeX
\setmainfont{Times New Roman}

% or Nimbus Roman, if Times New Roman is not available
\setmainfont{Nimbus Roman}

% or Nimbus Sans, if Arial is not available
\setmainfont{Nimbus Sans}
```

# Links

Various help around the web:

- [My personal story to obtain an ERC grant – 7 submissions, 4 interviews and 6 heartbreaks](https://www.noelresearchgroup.com/2022/03/17/my-personal-story-to-obtain-an-erc-grant-7-submissions-4-interviews-and-6-heartbreaks/): A little story about submitting ERC grants.
- [An "Open-Source" Grant Proposal](https://4gravitons.com/2024/03/15/an-open-source-grant-proposal/): Another proposal story.
- [Some Thoughts on Writing a Successful ERC Proposal](https://ncp.frs-fnrs.be/files/05_WB2017_10_23-ERC-event.pdf): Presentation slides.
- [UK Research and Innovation](https://www.youtube.com/@ukriforresearchers): YouTube webinars for various ERC grants.
- [Ghent University](https://www.ugent.be/en/research/funding/eu-int/horizoneurope/erc): Most big universities have some ERC grant help.

Other proposals:

- [PolyData (2025)](https://github.com/anteromontonio/erc-stg-2025).
- [SpWrinkle (2021)](https://github.com/ts4051/2021_ERC_StartingGrant).
- [REALDARK (2020)](https://github.com/caterina-doglioni/CoG-2020)
- [preQFT (2014)](https://github.com/drjjmc/preQFT_proposal).
- [FreeCo (2010)](https://figshare.com/articles/journal_contribution/My_successful_ERC_Starting_Grant_Proposal/7110767).

Other templates:

- By [Catrin Campbell-Moore (2024)](https://www.overleaf.com/latex/templates/unofficial-erc-template-with-versions-package/zyqqjfbckwqc).
- By [@trappitsch (2024)](https://github.com/trappitsch/erc_latex_template) (for ERC Research Grants).
- By [@birnstiel (2021)](https://github.com/birnstiel/erc_template).
- By [@PierreSenellart (2019)](https://github.com/PierreSenellart/erc-latex-template) (for ERC Consolidator Grants).
- By [@pgarner (2015)](https://github.com/pgarner/erc/tree/master).
- By [ARJ (2013)](https://www.arj.no/2013/02/03/erc-stg-latex/) (on [Overleaf](https://www.overleaf.com/latex/templates/unofficial-erc-starting-grant-latex-template/spvmnthfqyzm)).

# ERC-STG: LaTeX Template

[![GitHub Actions Workflow Status](https://github.com/alexfikl/erc-stg/actions/workflows/ci.yml/badge.svg)](https://github.com/alexfikl/erc-stg/actions/workflows/ci.yml)
[![Open in Overleaf](https://img.shields.io/static/v1?label=LaTeX&message=Open-in-Overleaf&color=47a141&style=flat&logo=overleaf)](https://www.overleaf.com/docs?snip_uri=https://github.com/alexfikl/erc-stg/archive/refs/heads/main.zip)

> [!NOTE]
> This is still a work in progress and it has not been submitted to ERC and
> deemed eligible. Any help is appreciated!

LaTeX class and template for the European Research Council (ERC) Starting Grant
applications. The goal of this template is to be as close as possible to the
original template provided by the ERC. However, at this time (2024) the call
imposes very few strict rules for the formatting (margins, font size, font type),
so you are always free to be more creative with it. For a wonderfully colorful
example, see [a proposal by Matthew von Hippel](https://4gravitons.com/2024/03/15/an-open-source-grant-proposal/).

* Details and original template is provided [here](https://erc.europa.eu/apply-grant/starting-grant)
  (calls are updated each year).

* For a `rtf` version of the template, you must start the submission process.
  The template will then be available on the left-hand side in a section
  named "Download Part B templates".

## Fonts

The official ERC guidelines require the Times New Roman, Arial or similar fonts.
On Windows, these should be available, but on Linux we fall back to the *Nimbus*
family of fonts. When using PDFLaTeX this class uses the `mathptmx` font. When
using XeLaTeX or LuaLaTeX, we try to load the Times New Roman font and, if it
is not available, the Nimbus Roman font (or Arial and Nimbus Sans, respectively).

If these do not work for you, you can load fonts yourself using e.g.
```tex
% on PDFLaTeX
\usepackage{newtxtext}
\usepackage{newtxmath}

% on XeLaTeX / LuaLaTeX
\setmainfont{Times New Roman}
```

## Building

The resulting PDF files are included for easy viewing, but it is recommended to
build the two parts with e.g. `latexmk` as follows
```bash
latexmk -pdflua erc-stg-b1-template.tex
latexmk -pdflua erc-stg-b2-template.tex
```

## Functionality

This packages provides the `erc-stg` class that is based on the
KOMA-script `scrartcl` class and accepts any options meant for it. It can
be used as
```tex
\documentclass[11pt,layoutgrid,draftproposal]{erc-stg}

% ... preamble ...

\begin{document}

% ... content ...

\end{document}
```

The class has three options meant for drafting:

* `layoutgrid`: overlays a grid on top of each page to check margins and
  other alignment issues.
* `draftproposal`: adds helpful drafting options, such as line numbers and
  a time stamp.
* `nocomments`: disables the ERC template comments. These are just provided
  as documentation and should be disabled on the start of a new proposal.

The part B1 and part B2 templates are quite different, so there are some
options to control their formatting:

* `partone`: overwrites `\maketitle` to create the Part B1 title page.
* `parttwo`: overwrites `\maketitle` for the Part B2 title.
* `timesnewroman`: selects the Times New Roman font (or Nimbus Roman) and
  ensures that the serif font is the default.
* `arial` selects the Arial font (or Helvetica or Nimbus Sans) and ensures
  the sans serif font is the default.

It also provides a few useful commands that can be used in the proposal. These
should be set in both the Part B1 and Part B2 files to ensure that the proposal
metadata is available.

* `\ercauthor`: sets the full author name (first and last name).
* `\ercauthorlastname`: sets the author's last name (used in the header).
* `\ercinstitution`: sets the hosting institution.
* `\ercduration`: sets the duration of the project (in months).
* `\erctitle`: sets the proposal title.
* `\ercacronym`: sets the proposal acronym (must match the title).
* `\ercsummary`: defines the summary that appears on the title page of Part B1.
* `\erccrossummary`: defines the cross-disciplinary proposal justification
  that appears on the title page of Part B1. If no such justification is needed,
  use the `\ercnocrosssummary` command to remove the box and text for this part.

The following optional helper environments are also defined:

* `erccomment`: exclusively used for the ERC documentation comments in the
  template.
* `erccvitem`: a simple wrapper around `tabular` for adding nicely aligned
  CV items.
* `erctable`: a simple wrapper around `tabular` with consistent formatting.
* `erclongtable`: a simple wrapper around `longtable` with consistent
  formatting.

# Links

Various help around the web:

* [My personal story to obtain an ERC grant – 7 submissions, 4 interviews and 6 heartbreaks](https://www.noelresearchgroup.com/2022/03/17/my-personal-story-to-obtain-an-erc-grant-7-submissions-4-interviews-and-6-heartbreaks/): A little story about submitting ERC grants.
* [An "Open-Source" Grant Proposal](https://4gravitons.com/2024/03/15/an-open-source-grant-proposal/): Another proposal story.
* [Some Thoughts on Writing a Successful ERC Proposal](https://ncp.frs-fnrs.be/files/05_WB2017_10_23-ERC-event.pdf): Presentation slides.
* [UK Research and Innovation](https://www.youtube.com/@ukriforresearchers): YouTube webinars for various ERC grants.
* [Ghent University](https://www.ugent.be/en/research/funding/eu-int/horizoneurope/erc): Most big universities have some ERC grant help.

Other proposals:
* [PolyData (2025)](https://github.com/anteromontonio/erc-stg-2025).
* [SpWrinkle (2021)](https://github.com/ts4051/2021_ERC_StartingGrant).
* [preQFT (2014)](https://github.com/drjjmc/preQFT_proposal).
* [FreeCo (2010)](https://figshare.com/articles/journal_contribution/My_successful_ERC_Starting_Grant_Proposal/7110767).

Other templates:
* By [Catrin Campbell-Moore (2024)](https://www.overleaf.com/latex/templates/unofficial-erc-template-with-versions-package/zyqqjfbckwqc).
* By [@trappitsch (2024)](https://github.com/trappitsch/erc_latex_template) (for ERC Research Grants).
* By [@birnstiel (2021)](https://github.com/birnstiel/erc_template).
* By [@PierreSenellart (2019)](https://github.com/PierreSenellart/erc-latex-template) (for ERC Consolidator Grants).
* By [@pgarner (2015)](https://github.com/pgarner/erc/tree/master).
* By [ARJ (2013)](https://www.arj.no/2013/02/03/erc-stg-latex/) (on [Overleaf](https://www.overleaf.com/latex/templates/unofficial-erc-starting-grant-latex-template/spvmnthfqyzm)).


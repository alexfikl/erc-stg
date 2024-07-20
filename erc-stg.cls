% <<< preamble

\def\fileversion{v1.0}
\def\filedate{2024/07/20}
\def\clsname{erc-stg}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\clsname}[\filedate\ \fileversion\ ERC Starting Grant Proposal]

% >>>

% <<< declare options

% draft features
\newif\if@draftproposal \@draftproposalfalse
\DeclareOption{draftproposal}{\@draftproposaltrue}

% documentation features
\newif\if@nocomments \@nocommentsfalse
\DeclareOption{nocomments}{\@nocommentstrue}

% grid
\newif\if@layoutgrid \@layoutgridfalse
\DeclareOption{layoutgrid}{\@layoutgridtrue}

% additional options passed to `scrartcl` class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\PassOptionsToClass{11pt}{scrartcl}

\ProcessOptions
\LoadClass{scrartcl}

% >>>

% <<< required packages

% NOTE: load packages after the class was loaded since they may depend on it

\RequirePackage{iftex}
\RequirePackage{xparse}
\RequirePackage{geometry}
\RequirePackage[hypertexnames=false,breaklinks=true]{hyperref}

% build fancy table required for organization description
\RequirePackage{array}
\RequirePackage[table]{xcolor}
\RequirePackage{longtable}
% customize headers and footers
\RequirePackage{scrlayer-scrpage}
% indent first paragraph in a section
\RequirePackage{indentfirst}
% set recommended spacing
\RequirePackage{setspace}

% >>>

% <<< commands

% NOTE: color used for header / footer
\definecolor{ERCGray}{RGB}{140, 140, 140}
\definecolor{ERCHighlight}{RGB}{210, 210, 210}

\newcommand{\ercauthor}[1]{\def\@ercauthor{#1}}
\newcommand{\ercapplicant}[1]{\def\@ercapplicant{#1}}
\newcommand{\ercinstitution}[1]{\def\@ercinstitution{#1}}
\newcommand{\ercduration}[1]{\def\@ercduration{#1}}

\newcommand{\erctitle}[1]{\def\@erctitle{#1}}
\newcommand{\ercacronym}[1]{\def\@ercacronym{#1}}

\def\@ercauthor{Applicant Name}
\def\@ercapplicant{Applicant's last name}
\def\@ercinstitution{Institution Name}
\def\@ercduration{XX months}

\def\@erctitle{Proposal Full Title}
\def\@ercacronym{ACRONYM}

% add a timestamp in draft mode
\if@nocomments
    \newcommand{\erccomment}[1]{\empty}
\else
    \newcommand{\erccomment}[1]{\textcolor{ERCGray}{#1}}
\fi

% >>>

% <<< required formatting

\singlespacing

% force serif fonts
\addtokomafont{disposition}{\rmfamily}
% additional options
\KOMAoptions{
    paper=A4,
    parskip=half*,
}

% required font is Times New Roman (or Nimbus Roman on Linux)
\ifpdftex
    \RequirePackage[T1]{fontenc}
    \RequirePackage{mathptmx}
\else
    \RequirePackage{fontspec}
    \IfFontExistsTF{Times New Roman}{
        \setmainfont[Ligatures=Rare]{Times New Roman}}{
        \IfFontExistsTF{Nimbus Roman}{
            \setmainfont{Nimbus Roman}
        }{\PackageWarning{erc-stg}{No Times New Roman font could be found}}}
\fi

\typearea{14}
\AfterCalculatingTypearea{
    \geometry{top=1.5cm, bottom=1.5cm, left=2cm, right=2cm, footskip=1cm, headsep=0.5cm}
}

% tighted sections a bit for more space
\RedeclareSectionCommand[beforeskip=0.5em, afterskip=0.5em]{section}
\RedeclareSectionCommand[beforeskip=0.5em, afterskip=0.5em]{subsection}
\RedeclareSectionCommand[beforeskip=0.25em, afterskip=0.25em]{subsubsection}

\addtokomafont{section}{\normalsize}
\renewcommand{\thesection}{Section \Alph{section}}

% >>>

% <<< extra formatting

% enable this to better check sizing
\if@layoutgrid
    \RequirePackage[
        grid, gridBG,
        gridunit=mm,
        gridcolor=ERCHighlight,
        subgridcolor=ERCHighlight,
        texcoord]{eso-pic}
\fi

\AtBeginDocument{
    % customize PDF bookmarks a bit
    \RequirePackage{bookmark}
    \bookmarksetup{numbered}

    \if@draftproposal
        \linenumbers
    \fi
}

% make links a bit less intrusive
\hypersetup{
    colorlinks=true,
    urlcolor=blue,
    citecolor=black,
    linkcolor=black
}

% add a timestamp in draft mode
\if@draftproposal
    \newcount\timehh\newcount\timemm
    \timehh=\time \divide\timehh by 60
    \timemm=\time \count255=\timehh \multiply\count255 by -60
        \advance\timemm by \count255
    \def\draftheader{\textit{[Draft of \today]}}
\else
    \def\draftheader{\empty}
\fi

% add line numbers if in draft mode
\if@draftproposal
    \RequirePackage[mathlines]{lineno}
    \RequirePackage{xcolor}
    \renewcommand{\linenumberfont}{
        \normalfont\footnotesize\textcolor{ERCGray}
    }
\fi

% >>>

% <<< page header/footer styles

\pagestyle{plain}
\clearpairofpagestyles

\def\callapplicant{\textnormal{\textcolor{ERCGray}{\@ercapplicant}}}
\def\callacronym{\textnormal{\textcolor{ERCGray}{\@ercacronym}}}
\def\callpart{\textnormal{\textcolor{ERCGray}{Part B1 \draftheader}}}
\def\pagefooter{\textnormal{\textcolor{ERCGray}{\thepage}}}

\cfoot[\pagefooter]{\pagefooter}
\ihead[\callapplicant]{\callapplicant}
\chead[\callpart]{\callpart}
\ohead[\callacronym]{\callacronym}

% >>>

% <<< title

\renewcommand{\maketitle}{
\vspace*{1cm}
\begin{center}
\textbf{\large ERC Starting Grant 2025}

\textbf{\Large Research Proposal [Part B1]\footnotemark}

\erccomment{
    \large
    \textbf{\textit{(Part B1 is evaluated in Step 1 and Step 2, \\
             Part B2 is evaluated in Step 2 only)}}
}

{\huge \@erctitle}

{\huge PROPOSAL \@ercacronym}
\end{center}

\bigskip

\textbf{Cover Page:}
\begin{itemize}[--]
    \item Name of the Principal Investigator (PI): \textit{\@ercauthor}
    \item Name of the PI's Host Institution for the project: \textit{\@ercinstitution}
    \item Proposal duration in months: \textit{\@ercduration}
\end{itemize}

\erccomment{Please delete all text highlighted in gray in this template.}

\noindent\fbox{
\parbox{\textwidth}{
\erccomment{Proposal summary (identical to the abstract from the online proposal
submission forms, section 1).}

\bigskip

\erccomment{The abstract (summary) should, at a glance, provide the reader with
a clear understanding of the objectives of the research proposal and how they will
be achieved. The abstract will be used as the short description of your research
proposal in the evaluation process and in communications to contact in particular
potential  independent external experts and/or to inform the Commission and/or
the programme management committees and/or relevant national funding agencies.
It must therefore be short and precise and should not contain confidential information.
}

\bigskip

\erccomment{Please use plain typed text, avoiding formulae and other special
characters. The abstract must be written in English. There is a limit of 2000
characters (spaces and line breaks included).}
}}

\erccomment{
Explain and justify the cross-panel or cross domain nature of your proposal, if
a secondary panel is indicated in the online proposal submission forms. There is
a limit of 1000 characters (spaces and line breaks included).}

\footnotetext{Instructions for completing Part B1 can be found in the
''\textit{Information for Applicants to the Starting and Consolidator Grant 2025 Calls}``.
}
\newpage
}

% >>>

% <<< table

\newenvironment{erctable}[2][\footnotesize]{
\begin{center}
#1 % Set the right size (and font maybe)
\newcommand{\ra}{\raggedright\arraybackslash}
\begin{tabular}{#2}
}{%
\end{tabular}
\end{center}
}

\newenvironment{erclongtable}[2][\footnotesize]{
\begin{center}
#1 % Set the right size (and font maybe)
\newcommand{\ra}{\raggedright\arraybackslash}
\begin{longtable}{#2}
}{%
\end{longtable}
\end{center}
}

% >>>

% <<< cv

% >>>

\recalctypearea

\endinput

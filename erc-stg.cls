% <<< preamble

\def\ercversion{11.0}
\def\fileversion{v2026.2}
\def\filedate{2026/08/18}
\def\clsname{erc-stg}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\clsname}[\filedate\ \fileversion\ ERC Starting Grant Proposal]

% >>>

% <<< declare options

% part B1 and B2
\newif\if@partone \@partonefalse
\DeclareOption{partone}{\@partonetrue}

\newif\if@parttwo \@parttwofalse
\DeclareOption{parttwo}{\@parttwotrue}

% use Times New Roman
\newif\if@timesnewroman \@timesnewromanfalse
\DeclareOption{timesnewroman}{\@timesnewromantrue}

% use Arial
\newif\if@arial \@arialfalse
\DeclareOption{arial}{\@arialtrue}

% enable tagging / accessibility functionality for PDF/UA-2
\newif\if@tagged \@taggedfalse
\DeclareOption{tagged}{\@taggedtrue}

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
\PassOptionsToClass{a4paper, fontsize=11bp}{scrartcl}

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
% enable comments
\RequirePackage{comment}

% >>>

% <<< tagging

% warn about tagging before we start
\if@tagged
    \ifpdftex
        \PackageWarning{erc-stg}{The 'tagged' option has no effect with pdfLaTeX. Compile with LuaLaTeX (TeX Live 2025+) to produce a tagged PDF}
    \fi
\fi

% provide the tagging commands used by the class.
\ifdefined\tagpdfstructbegin
    \let\tagstructbegin\tagpdfstructbegin
    \let\tagstructend\tagpdfstructend
\fi
\providecommand{\tagstructbegin}[1]{}
\providecommand{\tagstructend}{}

% custom roles
\if@tagged
    \tagpdfsetup{
        role/new-tag = {tag=erc-stg-comment, role=Div},
    }
\fi

% >>>

% <<< commands

\NewDocumentCommand \ercyear {} {\advance\year by 1 \the\year\advance\year by -1}

% NOTE: color used for comments
\definecolor{ERCGray}{RGB}{140, 140, 140}
% NOTE: color used for table headers
\definecolor{ERCTableGray}{RGB}{191, 191, 191}

\NewDocumentCommand \ercauthor { m } {\def\erc@author{#1}}
\NewDocumentCommand \ercauthorlastname { m } {\def\erc@authorlastname{#1}}
\NewDocumentCommand \ercinstitution { m } {\def\erc@institution{#1}}
\NewDocumentCommand \ercduration { m } {\def\erc@duration{#1}}

\NewDocumentCommand \erctitle { m } {\def\erc@title{#1}}
\NewDocumentCommand \ercacronym { m } {\def\erc@acronym{#1}}

\NewDocumentCommand \ercsummary { m } {\def\erc@summary{#1}}
\NewDocumentCommand \ercnocrosssummary { } {\def\erc@crosssummaryempty}
\NewDocumentCommand \erccrosssummary { m } {\def\erc@crosssummary{#1}}

% set defaults
\ercauthor{Applicant Name}
\ercauthorlastname{Applicant's Last Name}
\ercinstitution{Institution Name}
\ercduration{XX}
\erctitle{Proposal Full Title}
% \ercacronym{ACRONYM}

% inserting commands
\NewDocumentCommand \insertercauthor {} {\erc@author}
\NewDocumentCommand \insertercauthorlastname {} {\erc@authorlastname}
\NewDocumentCommand \insertercinstitution {} {\erc@institution}
\NewDocumentCommand \insertercduration {} {\erc@duration}
\NewDocumentCommand \inserterctitle {} {\erc@title}
\NewDocumentCommand \insertercacronym {} {\erc@acronym}

% enable comments only in draft mode
\if@draftproposal\else
    \@nocommentstrue
\fi

% define comment environments
\if@nocomments
    \excludecomment{erccomment}
    \NewDocumentCommand \erchidden { m } {\empty}
\else
    \NewDocumentCommand \erchidden { m } {%
        \tagstructbegin{tag=erc-stg-comment}%
        \textcolor{ERCGray}{#1}%
        \tagstructend}
    \newenvironment{erccomment}{%
        \tagstructbegin{tag=erc-stg-comment}%
        \vspace{-0.5cm}
        \setlength{\parskip}{1em}%
        \setlength{\parindent}{0pt}
        \color{ERCGray}}{\medskip\tagstructend}
\fi

\if@nocomments
\def\erc@summary{\hfill \vspace{10.5cm}}
\else
\def\erc@summary{
\erchidden{Proposal summary (identical to the abstract from the online proposal
submission forms, section 1). \\}

\erchidden{The abstract (summary) should, at a glance, provide the reader with
a clear understanding of the objectives of the research proposal and how they will
be achieved. The abstract will be used as the short description of your research
proposal in the evaluation process and in communications to contact in particular
potential independent external experts and/or to inform the Commission and/or
the programme management committees and/or relevant national funding agencies.
It must therefore be short and precise and should not contain confidential information. \\}

\erchidden{Please use plain typed text, avoiding formulae and other special
characters. The abstract must be written in English. There is a limit of 2000
characters (spaces and line breaks included). \\}

\vspace{3.3cm}
}
\def\erc@crosssummary{
\erchidden{
If a secondary panel is indicated in the online proposal submission forms, please
explain and justify the cross-panel or cross-domain nature of your proposal here.
There is a limit of 1000 characters (spaces and line breaks included).
}

\vspace{2cm}
}
\fi

% >>>

% <<< required formatting

\singlespacing

\ifpdftex
    \RequirePackage[T1]{fontenc}
\else
    \RequirePackage{fontspec}
\fi

% required font is Times New Roman (or TeX Gyre on Linux)
\if@timesnewroman
    \ifpdftex
        \RequirePackage{tgtermes}
    \else
        \IfFontExistsTF{Times New Roman}{
            \setmainfont[Ligatures={TeX,Rare}]{Times New Roman}}{
            \IfFontExistsTF{TeX Gyre Termes}{
                \setmainfont[Ligatures=TeX]{TeX Gyre Termes}
            }{\PackageWarning{erc-stg}{No Times New Roman-type font could be found}}}
    \fi

    % force serif fonts
    \addtokomafont{disposition}{\rmfamily}
\fi

\if@arial
    \ifpdftex
        \RequirePackage{tgheros}

        % force sans serif fonts
        \renewcommand{\familydefault}{\sfdefault}
    \else
        \IfFontExistsTF{Arial}{
            \setmainfont[Ligatures=TeX]{Arial}}{
            \IfFontExistsTF{TeX Gyre Heros}{
                \setmainfont[Ligatures=TeX]{TeX Gyre Heros}
            }{\PackageWarning{erc-stg}{No Arial-type font could be found}}}
    \fi
\fi

\typearea{14}
\AfterCalculatingTypearea{
    \geometry{top=1.75cm, bottom=1.5cm, left=2cm, right=2cm, footskip=0.5cm, headsep=0.5cm}
}

% tighted sections a bit for more space
% NOTE: this is uglier, but seems to work with tagging (which KOMA-Script does not support)
\renewcommand\section{\@startsection{section}{1}{\z@}{0.5em}{0.5em}{\large\bfseries\itshape}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}{0.5em}{0.5em}{\normalsize\bfseries\itshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}{0.25em}{0.25em}{\normalsize\bfseries\itshape}}

\addtokomafont{section}{\normalsize}
\addtokomafont{subsection}{\normalsize\underline}
\addtokomafont{subsubsection}{\normalsize}
\renewcommand{\thesection}{Section \Alph{section}}

% >>>

% <<< extra formatting

% enable this to better check sizing
\if@layoutgrid
    \RequirePackage[
        grid, gridBG,
        gridunit=mm,
        gridcolor=ERCTableGray,
        subgridcolor=ERCTableGray,
        texcoord]{eso-pic}
    \geometry{showframe=true}
\fi

\AtBeginDocument{
    % customize PDF bookmarks a bit
    \RequirePackage{bookmark}
    \bookmarksetup{numbered}

    % set the PDF metadata title from the proposal title
    \hypersetup{pdftitle={\erc@title}}
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

\def\callapplicant{\erc@authorlastname}
\def\callacronym{\textnormal{\@ifundefined{erc@acronym}{ACRONYM}{\erc@acronym}}}
\def\pagefooter{\textnormal{\thepage}}
\if@parttwo
    \def\callpart{\textnormal{Part B2 \draftheader}}
\else
    \def\callpart{\textnormal{Part B1 \draftheader}}
\fi

\cfoot[\pagefooter]{\pagefooter}
\ihead[\callapplicant]{\callapplicant}
\chead[\callpart]{\callpart}
\ohead[\callacronym]{\callacronym}

% >>>

% <<< title

\if@tagged\tagpdfsetup{tabsorder=structure}\fi

\if@partone
    \renewcommand{\maketitle}{
    \vspace*{0.9cm}
    \begin{center}
    \textbf{\large ERC Starting Grant \ercyear}

    \textbf{\Large Part B1\footnotemark}

    \footnotetext{Instructions for completing Part B1 can be found in the
    ``\textit{Information for Applicants to the Starting and Consolidator Grant
    \ercyear\ Calls}''.
    }

    \erchidden{
    \large
    \textbf{\textit{
        (Part B1 is evaluated in Step 1 and Step 2, \\
        Part B2 is evaluated in Step 2 only)}}
    }

    \vspace{0.3cm}
    \tagstructbegin{tag=Title}
    {\huge \erc@title}

    \vspace{0.3cm}
    {\huge \@ifundefined{erc@acronym}{PROPOSAL ACRONYM}{\erc@acronym}}
    \tagstructend
    \end{center}

    \bigskip

    \noindent \textbf{Cover Page:}
    {
    \setlength{\leftmargini}{15pt}
    \setlength{\itemsep}{0pt}
    \begin{itemize}
        \setlength{\parskip}{0pt}
        \item[--] Name of the Principal Investigator (PI): \textit{\erc@author}
        \item[--] Name of the PI's Host Institution for the project: \textit{\erc@institution}
        \item[--] Proposal duration in months: \textit{\erc@duration{} months} \\
    \end{itemize}
    }

    \erchidden{Text highlighted in grey should be deleted. \\}

    \noindent\fbox{\parbox{0.987\textwidth}{\erc@summary}}

    \@ifundefined{erc@crosssummaryempty}{
    \noindent\fbox{\parbox{0.987\textwidth}{\erc@crosssummary}}}{}

    \newpage

    \if@draftproposal
        \linenumbers
    \fi
    }
\fi

\if@parttwo
    \renewcommand{\maketitle}{
    \vspace*{0.65cm}
    \begin{center}
    \textbf{\Large ERC Starting Grant \ercyear}

    \textbf{\Large Part B2\footnotemark}

    \textbf{\Large \textit{(\underline{not} evaluated in Step 1)}}
    \end{center}

    \footnotetext{Instructions for completing Part B2 can be found in the
    ''\textit{Information for Applicants to the Starting and Consolidator Grant
    \ercyear\ Calls}``.
    }

    \if@draftproposal
        \linenumbers
    \fi
    }
\fi

% >>>

% <<< table

\newenvironment{erctable}[2][\normalsize]{
\begin{center}
#1 % Set the right size (and font maybe)
\newcommand{\ra}{\raggedright\arraybackslash}
\begin{tabular}{#2}
}{%
\end{tabular}
\end{center}
}

\newenvironment{erclongtable}[2][\normalsize]{
\begin{center}
#1 % Set the right size (and font maybe)
\newcommand{\ra}{\raggedright\arraybackslash}
\begin{longtable}{#2}
}{%
\end{longtable}
\end{center}
}

\newenvironment{erccvitem}{
\if@tagged\tagpdfsetup{table/tagging=presentation}\fi
\noindent
\begin{tabular}{>{\centering}m{0.16\textwidth}m{0.84\textwidth}}
}{
\end{tabular}
}

\newenvironment{granttable}{
\if@tagged\tagpdfsetup{table/tagging=true, table/header-rows={1}}\fi
\begin{erctable}[\normalsize]{
    |m{0.13\textwidth}
    |m{0.13\textwidth}
    |m{0.13\textwidth}
    |m{0.13\textwidth}
    |m{0.13\textwidth}
    |m{0.195\textwidth}
    |} \hline
\rowcolor{ERCTableGray}
\centering\arraybackslash \textit{Project title} &
\centering\arraybackslash \textit{Funding source} &
\centering\arraybackslash \textit{Amount (Euros)} &
\centering\arraybackslash \textit{Period} &
\centering\arraybackslash \textit{Role of the PI} &
\centering\arraybackslash \textit{Relation to current ERC proposal\footnotemark[2]} \\
\hline
}{
\end{erctable}
}

% >>>

% <<< cv

% >>>

\recalctypearea

\endinput

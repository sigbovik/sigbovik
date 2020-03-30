% sigbovik-review.cls
%
% A document class for SIGBOVIK reviews
%
% Shamelessly cobbled together from the old SIGBOVIK
% review template.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sigbovik-review}[2020/02/03 SIGBOVIK Review Class]
\LoadClass[12pt]{article}

\RequirePackage{amsmath}
\RequirePackage{fullpage}
\RequirePackage{graphicx}
\RequirePackage{multirow}
\RequirePackage{todonotes}
\RequirePackage{times}
\RequirePackage{wrapfig}

\setlength\parindent{0pt}
\setlength\parskip{12pt}

\renewcommand{\author}[1]{\def\@author{#1}}
\newcommand{\rating}[1]{\def\@rating{#1}}
\newcommand{\confidence}[1]{\def\@confidence{#1}}
\newcommand{\papernum}[1]{\def\@papernum{#1}}
\newcommand{\papertitle}[1]{\def\@papertitle{#1}}
\global\let\@author\@empty
\global\let\@rating\@empty
\global\let\@confidence\@empty
\global\let\@papernum\@empty
\global\let\@papertitle\@empty

\pagestyle{empty}

\renewcommand{\maketitle}{%
  {\sffamily%
  \begin{tabular}{l p{0.9\textwidth}}
    \multirow{3}{*}{\IfFileExists{ach.png}{%
    \includegraphics[width=1in]{ach.png}%
    }{%
    \textbf{ACH LOGO}
    }%
    } & {\Large \em CONFIDENTIAL COMMITTEE MATERIALS}\\\\
      & \textbf{\Huge{SIGBOVIK'20 3-Blind Paper Review}}\\\\
      & {\LARGE Paper \@papernum: \@papertitle }\\\\
    \hline\\
  \end{tabular}}
  \vspace{3em}
  {\large\bf%
  \begin{tabular}{l}
    Reviewer: \@author\\
    Rating: \@rating\\
    Confidence: \@confidence\\
  \end{tabular}}
}

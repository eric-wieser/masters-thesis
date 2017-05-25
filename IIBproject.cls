\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{IIBproject}[2016/06/05 - Default margins 25mm. Title page changed. supervisor needed. Bugs to tl136@cam.ac.uk]
\newif\if@cuedwide
\@cuedwidefalse

\DeclareOption{a5paper}
    {\ClassError{IIBproject}{Option `a5paper' not supported}{}}
\DeclareOption{b5paper}
    {\ClassError{IIBproject}{Option `b5paper' not supported}{}}
\DeclareOption{twocolumn}%
    {\ClassError{IIBproject}{Option `twocolumn' not supported}{}}
\DeclareOption{titlepage}%
    {\ClassError{IIBproject}{Option `titlepage' not supported}{}}
\DeclareOption{wide}
    {\@cuedwidetrue\typeout{Wide option selected}}
\PassOptionsToClass{12pt,a4paper}{report}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}
\usepackage{textpos}
\usepackage{graphicx}
\usepackage{geometry}
\geometry{margin=25mm}
\if@cuedwide
\oddsidemargin=0pt \evensidemargin=0pt \topmargin=0pt \textwidth=421pt \textheight=612pt
\fi
\def\supervisor#1{\gdef\@supervisor{#1}\gdef\thesupervisor{#1}}

\renewcommand\maketitle{%
  \begin{titlepage}
  \null
  \includegraphics{Engineering.png}

  \begin{textblock*}{\textwidth}(0mm,43mm)
    \centering
    \LARGE \@title
  \end{textblock*}
  \par

  \begin{textblock*}{\textwidth}(0mm,122mm)
    \begin{flushright}
      Author Name: \@author{}\\
      Supervisor: \@supervisor{}\\
      \hspace{0cm}\\
      Date: \today
    \end{flushright}
  \end{textblock*}

  \begin{table}[b]
    \begin{tabularx}{\linewidth}{@{}X@{}}
    I hereby declare that, except where specifically indicated, the work 
    submitted herein is my own original work.\\
    \\
    Signed:~\hrulefill\hrulefill\hrulefill\hspace{2em} Date:~\hrulefill
    \end{tabularx}
  \end{table}
\end{titlepage}}

\endinput


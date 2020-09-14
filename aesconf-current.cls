%% Template for AES conferences and conventions
%% This class uses several other well-made packages to redefine 
%% the basic style of the standard article class into the AES format.
%%
%% Copyright (c) 2015 Tapani Pihlajamäki
%% All rights reserved
%% Template use rights are given to Audio Engineering Society, Inc.
%% for using the template for conferences and conventions, and thus
%% the authors in these conferences and conventions are free to use and
%% necessarily modify (but not rerelease) the template. 

%% Packages required in this class
% fixltx2e (official general latex fixes) - this will be replaced with latexrelease
% etoolbox (provides programming tools)
% graphicx (graphics)
% fontenc (font encodings)
% mathptmx (times font with math support)
% helvet (helvetica font)
% courier (courier font)
% abstract (formats abstract)
% titling (formats main title)
% authblk (formats author and affiliation) (seems not to be in MikTeX)
% titlesec (formats section titles)
% caption (formats captions)
\ProvidesClass{aesconf}[2015/07/29, Version 1.1.1]
\NeedsTeXFormat{LaTeX2e}

% Version history
% 1.0, initial release
% 1.1.1, adds support for engineering briefs


% This is done to ensure bugfixes in the latex kernel. This has to be supplied for the users
% older latex kernels.
\RequirePackage[current]{latexrelease}

%% Define the conference info here
\def \AESConferenceNumber {149\textsuperscript{st} }
\def \AESConferenceLocation {New York, NY, USA}
\def \AESConferenceDate {2020 October 19 -- October 23}
\def \AESConferenceTopic {Convention}








% Define required new commands for correspondence, lastnames and shorttitle.
% Idea for these is from the old AES convention template by Adam H. Lewenberg.
\newcommand*{\correspondence}[2]{%
  \gdef\AESCorrAuthor{#1}%
  \gdef\AESCorrEmail{#2}%
}%
\newcommand*{\lastnames}[1]{\gdef\AESLastnames{#1}}%
\newcommand*{\shorttitle}[1]{\gdef\AESShortTitle{#1}}%

% New command for ebrief number
\newcommand*{\ebriefnumber}[1]{\gdef\AESEBriefNumber{#1}}%



% Require some additional programming tools
\RequirePackage{etoolbox} 

% Set some conditionals
\newtoggle{convention} 
\newtoggle{peer_reviewed}
\newtoggle{e_brief}


% Declare class options
\DeclareOption{convention}{
	\toggletrue{convention}
}
\DeclareOption{conference}{
	\togglefalse{convention}
}
\DeclareOption{peer-reviewed}{
	\toggletrue{peer_reviewed}
}
\DeclareOption{e-brief}{
	\toggletrue{e_brief}
	\togglefalse{peer_reviewed}
}



\ExecuteOptions{convention}
\ProcessOptions\relax

%% These are the AES legal stuff included

\iftoggle{e_brief}{
\def \AESLegalText {This Engineering Brief was selected on the basis of a submitted synopsis. The author is solely responsible for its presentation, and the AES takes no responsibility for the contents. All rights reserved. Reproduction of this paper, or any portion thereof, is not permitted without direct permission from the Audio Engineering Society.}}
{\iftoggle{peer_reviewed}{
\def \AESLegalText {This paper was peer-reviewed as a complete manuscript for presentation at this \iftoggle{convention}{convention}{conference}. This paper is available in the AES E-Library (http://www.aes.org/e-lib) all rights reserved. Reproduction of this paper, or any portion thereof, is not permitted without direct permission from the Journal of the Audio Engineering Society.}}
{\def \AESLegalText {This \iftoggle{convention}{convention}{conference} paper was selected based on a submitted abstract and 750-word precis that have been peer reviewed by at least two qualified anonymous reviewers. The complete manuscript was not peer reviewed. This \iftoggle{convention}{convention}{conference} paper has been reproduced from the author's advance manuscript without editing, corrections, or consideration by the Review Board. The AES takes no responsibility for the contents. This paper is available in the AES E-Library (http://www.aes.org/e-lib), all rights reserved. Reproduction of this paper, or any portion thereof, is not permitted without direct permission from the Journal of the Audio Engineering Society.}}}






% First load the normal article class as we only modify it
\LoadClass[a4paper,10pt,oneside,twocolumn]{article} 

% Make sure graphics are available
\RequirePackage{graphicx}

% Set general geometry
\setlength{\parindent}{0pt} 
\setlength{\parskip}{0.7em plus 0.8em minus 0.5em} 
\setlength{\columnsep}{2em}

% Setting the fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{mathptmx} 
\RequirePackage[scaled=.92]{helvet}
\RequirePackage{courier}


% Create placeholder for the AES top title. This has to be defined in the main tex to work
% properly with user parameters.
\newsavebox{\AEStop}

% Redefine abstract for our purposes
\RequirePackage{abstract}
\renewcommand{\abstractnamefont}{\sffamily\normalsize\bfseries\MakeUppercase}
\renewcommand{\abstracttextfont}{\normalsize}
\renewcommand{\absnamepos}{flushleft}
\setlength{\absleftindent}{0pt}
\setlength{\absrightindent}{0pt}
\setlength{\absparindent}{0pt}
\setlength{\absparsep}{0.5em plus 0.2em minus 0.2em}
\setlength{\abstitleskip}{-1.5em}



% Redefine main title
\RequirePackage{titling}
\pretitle{\vspace{-1.5cm}\usebox{\AEStop}\begin{flushleft}\LARGE\sffamily\bfseries} 
\posttitle{\end{flushleft}}
\preauthor{\begin{flushleft}}
\postauthor{\par \vspace{0.5em} \normalfont Correspondence should be addressed to \AESCorrAuthor \space (\texttt{\AESCorrEmail}) \end{flushleft} \vspace{-4.6em}}
\date{}

% This package is used for authors and affiliations in the main document
\RequirePackage{authblk}
\renewcommand\Authfont{\rmfamily\normalsize}
\renewcommand\Affilfont{\rmfamily\itshape\small}





% Redefine section titles
\RequirePackage[bf,sf,small,raggedright,compact,pagestyles]{titlesec} 

% Redefine headers (using above included titlesec)
% First we clear the plain style so the first page is correct
\renewpagestyle{plain}{
	\sethead[][][] % even
			{}{}{} % odd
	\setfoot[][][] % even
			{}{}{} % odd
}
% Then we define AES style for the rest of the article
\RequirePackage{lastpage} 
\newpagestyle{AES}[\normalsize\sffamily]{
	\headrule%
	\renewcommand{\makeheadrule}{\rule[-.4\baselineskip]{\textwidth}{1.5pt}}%
	%\setheadrule{1.0pt}%
	\sethead[\AESLastnames][][\AESShortTitle] % even
			{\AESLastnames}{}{\AESShortTitle} % odd
	\footrule%
	\renewcommand{\makefootrule}{\rule[.8\baselineskip]{\textwidth}{1.5pt}}%
	%\setfootrule{1.5pt}%
	\setfoot[][
		\begin{tabular}[t]{c}%
			AES \AESConferenceNumber \iftoggle{convention}{Convention}{Conference on \AESConferenceTopic}, \AESConferenceLocation, \AESConferenceDate \\%
			Page \thepage\ of \pageref{LastPage}%
		\end{tabular}%
	][] % even
		{}{%	
		\begin{tabular}[t]{c}%
			AES \AESConferenceNumber \iftoggle{convention}{Convention}{Conference on \AESConferenceTopic}, \AESConferenceLocation, \AESConferenceDate \\%
			Page \thepage\ of \pageref{LastPage}%
		\end{tabular}%
	}{} % odd
}

\pagestyle{AES}

% Redefine captions
\RequirePackage[bf,hang]{caption} 
\captionsetup[figure]{name=Fig.}






\endinput


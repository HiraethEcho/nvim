---
title: templates
---

```snippets
snippet template(basic) "Basic template" b
  \documentclass{article}

  \usepackage{amsfonts}
  \usepackage[all]{xy}
  \usepackage{amssymb}
  \usepackage{amsmath}
  \usepackage{mathrsfs}
  \usepackage{amsthm}
  \usepackage{enumerate}
  \usepackage[hidelinks]{hyperref}
  \usepackage{tikz}
  \usepackage{float}

  \usepackage{geometry}
  \geometry{a4paper,left=2cm,right=2cm,top=2cm,bottom=2cm}

  \newtheorem{definition}{Definition}[section]
  \newtheorem{proposition}[definition]{Proposition}
  \newtheorem{lemma}[definition]{Lemma}
  \newtheorem{theorem}[definition]{Theorem}
  \newtheorem{corollary}[definition]{Corollary}
  \newtheorem{remark}[definition]{Remark}
  \newtheorem{fact}[definition]{Fact}
  \newtheorem{assertion}[definition]{Assertion}
  \newtheorem{example}[definition]{Example}
  \newtheorem{problem}{Problem}
  \newtheorem*{ques}{Question}
  \setcounter{section}{0}

  \title{$1}
  \author{$2}
  %\date{\today}

  \begin{document}
  \maketitle
  %\tableofcontents
  %\newpage
  $0
  \end{document}
```

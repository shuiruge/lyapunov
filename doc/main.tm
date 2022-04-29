<TeXmacs|2.1.1>

<style|<tuple|article|padded-paragraphs>>

<\body>
  <\hide-preamble>
    \;

    <assign|axiom-text|<macro|Ansatz>>
  </hide-preamble>

  <chapter|Lyapunov Function>

  <\notation>
    Overall notations in this section are:

    <\itemize>
      <item><math|<with|font|cal|M>> a manifold, and <math|\<mu\>> its
      measure, e.g. <math|\<mu\><around*|(|x|)>=<sqrt|g<around*|(|x|)>>> if
      <math|<with|font|cal|M>> is Riemannian with metric <math|g<rsub|a b>>;

      <item>if <math|p<around*|(|x|)>> the distribution of random variable
      <math|X>, then

      <\equation*>
        <around*|\<langle\>|f|\<rangle\>><rsub|p>=<around*|\<langle\>|f|\<rangle\>><rsub|X>=\<bbb-E\><rsub|x\<sim\>p><around*|[|f<around*|(|x|)>|]>\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
        p<around*|(|x|)> f<around*|(|x|)>;
      </equation*>

      <item>if <math|D> is a set of samples, then

      <\equation*>
        <around*|\<langle\>|f|\<rangle\>><rsub|D>\<assign\><frac|1|<around*|\||D|\|>><big|sum><rsub|x\<in\>D>f<around*|(|x|)>;
      </equation*>

      <item>let <math|<with|font|cal|N><around*|(|\<mu\>,\<Sigma\>|)>>
      denotes normal distribution with mean <math|\<mu\>> and covariance
      <math|\<Sigma\>>;

      <item>given function <math|g>, let <math|f<around*|{|g|}>>, or
      <math|f<rsub|<around*|{|g|}>>>, denote a function constructed out of
      <math|g>, that is,

      <\equation*>
        f<around*|{|\<cdummy\>|}>:<around*|(|<with|font|cal|M>\<rightarrow\>A|)>\<rightarrow\><around*|(|<with|font|cal|M>\<rightarrow\>B|)>;
      </equation*>

      <item>for conditional maps <math|f>, let <math|f<around*|(|x\|y|)>>
      denotes the map of <math|x> with <math|y> given and fixed, and
      <math|f<around*|(|x;y|)>> denotes the map of <math|x> with <math|y>
      given but mutable;

      <item>r.v. is short for random variable, i.i.d. for independent
      identically distributed, s.t. for such that, and a.e. for almost every.
    </itemize>
  </notation>

  <section|Lyapunov Function>

  <\definition>
    [Lyapunov Function]

    Given an autonomous dynamics<\footnote>
      That is, ordinary differential equations that do not explicitly depend
      on time. The word autonomous means independent of time.
    </footnote>,

    <\equation*>
      <frac|\<mathd\>x<rsup|a>|\<mathd\>t>=f<rsup|a><around*|(|x|)>,
    </equation*>

    a Lyapunov function of this dynamics, <math|V<around*|(|x|)>>, is a
    scalar function s.t. <math|\<nabla\><rsub|a>V<around*|(|x|)>
    f<rsup|a><around*|(|x|)>\<leqslant\>0> and the equality holds if and only
    if <math|f<rsup|a><around*|(|x|)>=0>.
  </definition>

  Along the phase trajectory, a Lyapunov function will monomotically
  decrease. So, it reflects the stability of the dynamics.

  The problem is how to find a Lyapunov function for a given autonomous
  dynamics, if there is any. Here we propose a simulation based method that
  furnishes a criterion on whether a Lyapunov function for this autonomous
  dynamics exists or not, and then to reveal an analytic approximation to the
  true Lyapunov function if it exists.

  We first extend the autonomous (determinate) dynamics to a stochastical
  dynamics<\footnote>
    Stochastic dynamics is defined in <reference|definition: Stochastic
    Dynamics>.
  </footnote>, as

  <\equation*>
    \<mathd\>X<rsup|a>=f<rsup|a><around*|(|X|)>
    \<mathd\>t+\<mathd\>W<rsup|a>,
  </equation*>

  where <math|\<mathd\>W<rsup|a>\<sim\><with|font|cal|N><around*|(|0,2T
  \<delta\><rsup|a b>\<mathd\>t|)>> and parameter <math|T\<gtr\>0>. Then, we
  sample an essemble of particles independently evolving along this
  stochastic dynamics. As a set of Markov chains, this simulation will reach
  a stationary distribution. This is true if the Markov chain is irreducible
  and recurrent. These condition is hard to check. But, in practice, there is
  criterion that if the chains have converged at a finite time.<\footnote>
    E.g., Gelman-Rubin-Brooks plot.
  </footnote> If it has converged, we get an empirical distribution, denoted
  as <math|p<rsub|D>>, that approximates to the true stationary distribution.

  Now, we to find an analytic approximation to the empirical distribution
  <math|p<rsub|D>>. This can be done by any universal approximator, such as
  neural network. Say, an universal approximator
  <math|E<around*|(|\<cdummy\>;\<theta\>|)>> parameterized by
  <math|\<theta\>>, and define <math|q<rsub|E>> as

  <\equation*>
    q<rsub|E><around*|(|x;\<theta\>|)>\<assign\><frac|exp<around*|(|-E<around*|(|x;\<theta\>|)>/T|)>|Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>,
  </equation*>

  where <math|Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
  exp<around*|(|-E<around*|(|x;\<theta\>|)>/T|)>>.

  Then, we construct the loss as

  <\equation*>
    L<around*|(|\<theta\>|)>\<assign\>T D<rsub|KL><around*|(|p<rsub|D>\<\|\|\>q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>|)>=T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)> ln p<rsub|D><around*|(|x|)>-T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)> ln q<rsub|E><around*|(|x;\<theta\>|)>.
  </equation*>

  The first term is independent of <math|\<theta\>>, thus omitable. Thus, the
  loss becomes

  <\align>
    <tformat|<table|<row|<cell|L<around*|(|\<theta\>|)>=>|<cell|-T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)> ln q<rsub|E><around*|(|x;\<theta\>|)>>>|<row|<cell|=>|<cell|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)> E<around*|(|x;\<theta\>|)>+T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)> ln Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>>|<row|<cell|<around*|[|p<rsub|D>
    is empirical|]>=>|<cell|\<bbb-E\><rsub|x\<sim\>p<rsub|D>><around*|[|E<around*|(|x;\<theta\>|)>|]>>>|<row|<cell|<around*|[|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)>=1|]>+>|<cell|ln
    Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>.>>>>
  </align>

  <\lemma>
    <\equation*>
      T<frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>>ln
      Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>=-\<bbb-E\><rsub|x\<sim\>q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|]>.
    </equation*>
  </lemma>

  <small|<\proof>
    Directly,

    <\align>
      <tformat|<table|<row|<cell|T<frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>>ln
      Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>=>|<cell|T<frac|1|Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>><frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>>Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>>|<row|<cell|<around*|{|Z<rsub|E>\<assign\>\<cdots\>|}>=>|<cell|T<frac|1|Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>><frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      \<mathe\><rsup|-E<around*|(|x;\<theta\>|)>/T>>>|<row|<cell|=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      <frac|\<mathe\><rsup|-E<around*|(|x;\<theta\>|)>/T>|Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>><frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>>>|<row|<cell|<around*|{|q<rsub|E>\<assign\>\<cdots\>|}>=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      q<rsub|E><around*|(|x;\<theta\>|)><frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>.>>|<row|<cell|=>|<cell|-\<bbb-E\><rsub|x\<sim\>q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|]>.>>>>
    </align>

    Thus, proof ends.
  </proof>>

  This implies

  <\align>
    <tformat|<table|<row|<cell|>|<cell|<frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>|)>=\<bbb-E\><rsub|x\<sim\>p<rsub|D>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|]>-\<bbb-E\><rsub|x\<sim\>q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|]>,>>>>
  </align>

  where the second term can be computed via persistent MCMC. So, during this
  computation, we employ two different sets of Markov chains that are
  consistently evolving. The first is constructed by the stochastic dynamics,
  and the second by the persistent MCMC of <math|q<rsub|E>>. Along the
  gradient descent steps of <math|\<theta\>>, on the chains of
  <math|p<rsub|D>> <math|E> is sunk, while on the chains of <math|q<rsub|E>>
  <math|E> is elevated. Gradient descent stops when the two parts balance,
  where <math|q<rsub|E>> fits <math|p<rsub|D>> best.

  Finally, we claim that the <math|E> we find at the best fit
  <math|\<theta\>> is a Lyapunov of the original autonomous (determinate)
  dynamics. We first claim that the evolution of the distribution of the
  stochastic dynamics, <math|p<around*|(|x,t|)>>, by lemma <reference|lemma:
  Macroscopic Landscape>, is

  <\equation*>
    <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
    f<rsup|a><around*|(|x|)>|]>+T \<Delta\>p<around*|(|x,t|)>,
  </equation*>

  where Laplacian <math|\<Delta\>\<assign\>\<delta\><rsup|a
  b>\<nabla\><rsub|a>\<nabla\><rsub|b>>. In the end,
  <math|p\<rightarrow\>q<rsub|E>> where <math|\<partial\>p/\<partial\>t\<rightarrow\>0>.
  Here, it becomes

  <\equation*>
    0=-\<nabla\><rsub|a>E<around*|(|x|)> f<rsup|a><around*|(|x|)>-\<delta\><rsup|a
    b> \<nabla\><rsub|a>E <around*|(|x|)>\<nabla\><rsub|b>E<around*|(|x|)>+T
    <around*|[|\<nabla\><rsub|a>f<rsup|a><around*|(|x|)>+\<Delta\>E<around*|(|x|)>|]>.
  </equation*>

  As <math|T\<rightarrow\>0>, the stochastic dynamics reduces to the
  original, and we arrive at

  <\equation*>
    \<nabla\><rsub|a>E<around*|(|x|)> f<rsup|a><around*|(|x|)>=-\<delta\><rsup|a
    b> \<nabla\><rsub|a>E <around*|(|x|)>\<nabla\><rsub|b>E<around*|(|x|)>\<leqslant\>0,
  </equation*>

  where equality holds if and only if <math|\<nabla\><rsub|a>E<around*|(|x|)>=0>.
  Thus, <math|E<around*|(|x|)>> is a Lyapunov function.

  <appendix|Useful Lemmas>

  <subsection|Kramers\UMoyal Expansion>

  Kramers\UMoyal Expansion relates the microscopic landscape, i.e. the
  dynamics of Brownian particles, and the macroscopic landscape, i.e. the
  evolution of distribution.

  <\lemma>
    <label|lemma: Kramers\UMoyal Expansion>[Kramers\UMoyal Expansion]

    Given random variable <math|X> and time parameter <math|t>, consider
    random variable <math|\<epsilon\>> whose distribution is
    <math|<around*|(|x,t|)>>-dependent. After <math|\<Delta\>t>, particles in
    position <math|x> jump to <math|x+\<epsilon\>>. Then, we have

    <\equation*>
      p<around*|(|x,t+\<Delta\>t|)>-p<around*|(|x,t|)>=<big|sum><rsub|n=1><rsup|+\<infty\>><frac|<around*|(|-1|)><rsup|n>|n!>\<nabla\><rsub|a<rsub|1>>\<cdots\>\<nabla\><rsub|a<rsub|n>><around*|[|p<around*|(|x,t|)>M<rsup|a<rsub|1>\<cdots\>a<rsub|n>><around*|(|x,t|)>|]>
      ,
    </equation*>

    where <math|M<rsup|a<rsub|1>\<cdots\>a<rsub|n>><around*|(|x,t|)>>
    represents the <math|n>-order moments of <math|\<epsilon\>>

    <\equation*>
      M<rsup|a<rsub|1>\<cdots\>a<rsub|n>><around*|(|x,t|)>\<assign\><around*|\<langle\>|\<epsilon\><rsup|a<rsub|1>>\<cdots\>\<epsilon\><rsup|a<rsub|n>>|\<rangle\>><rsub|\<epsilon\>>.
    </equation*>
  </lemma>

  <\small>
    <\proof>
      The trick is introducing a smooth test function,
      <math|h<around*|(|x|)>>. Denote

      <\equation*>
        I<rsub|\<Delta\>t><around*|[|h|]>\<assign\><big|int>\<mathd\>\<mu\><around*|(|x|)>
        p<around*|(|x,t+\<Delta\>t|)>h<around*|(|x|)>.
      </equation*>
    </proof>

    The transition probability from <math|x> at <math|t> to <math|y> at
    <math|t+\<Delta\>t> is <math| <big|int>\<mathd\>\<mu\><around*|(|\<epsilon\>|)>
    p<rsub|\<epsilon\>><around*|(|\<epsilon\>;x,t|)>
    \<delta\><around*|(|x+\<epsilon\>-y|)>>. This implies

    <\equation*>
      p<around*|(|y,t+\<Delta\>t|)>=<big|int>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> <around*|[|<big|int>\<mathd\>\<mu\><around*|(|\<epsilon\>|)>
      p<rsub|\<epsilon\>><around*|(|\<epsilon\>;x,t|)>
      \<delta\><around*|(|x+\<epsilon\>-y|)>|]>.
    </equation*>

    With this,

    <\align>
      <tformat|<table|<row|<cell|I<rsub|\<Delta\>t><around*|[|h|]>\<assign\>>|<cell|<big|int>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t+\<Delta\>t|)>h<around*|(|x|)>>>|<row|<cell|<around*|{|x\<rightarrow\>y|}>=>|<cell|<big|int>\<mathd\>\<mu\><around*|(|y|)>
      p<around*|(|y,t+\<Delta\>t|)>h<around*|(|y|)>>>|<row|<cell|<around*|[|p<around*|(|y,t+\<Delta\>t|)>=\<cdots\>|]>=>|<cell|<big|int>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)><big|int>\<mathd\>\<mu\><around*|(|y|)>
      \ <big|int>\<mathd\>\<mu\><around*|(|\<epsilon\>|)>
      p<rsub|\<epsilon\>><around*|(|\<epsilon\>;x,t|)>
      \<delta\><around*|(|x+\<epsilon\>-y|)>
      h<around*|(|y|)>>>|<row|<cell|<around*|{|Integrate over
      y|}>=>|<cell|<big|int>\<mathd\>\<mu\><around*|(|x|)> p<around*|(|x,t|)>
      <big|int>\<mathd\>\<mu\><around*|(|\<epsilon\>|)>
      p<rsub|\<epsilon\>><around*|(|\<epsilon\>;x,t|)>
      h<around*|(|x+\<epsilon\>|)>.>>>>
    </align>

    Taylor expansion <math|h<around*|(|x+\<epsilon\>|)>> on
    <math|\<epsilon\>> gives

    <\equation*>
      I<rsub|\<Delta\>t><around*|[|h|]>=<big|int>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)>h<around*|(|x|)>+<big|sum><rsub|n=1><rsup|+\<infty\>><frac|1|n!><big|int>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> <around*|[|\<nabla\><rsub|a<rsub|1>>\<cdots\>\<nabla\><rsub|a<rsub|n>>h<around*|(|x|)>|]>
      <big|int>\<mathd\>\<mu\><around*|(|\<epsilon\>|)>
      p<rsub|\<epsilon\>><around*|(|\<epsilon\>;x,t|)>
      \<epsilon\><rsup|a<rsub|1>>\<cdots\>\<epsilon\><rsup|a<rsub|n>>.
    </equation*>

    Integrating by part on <math|x> for the second term, we find

    <\equation*>
      I<rsub|\<Delta\>t><around*|[|h|]>=<big|int>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)>h<around*|(|x|)>+<big|sum><rsub|n=1><rsup|+\<infty\>><frac|<around*|(|-1|)><rsup|n>|n!><big|int>\<mathd\>\<mu\><around*|(|x|)>
      h<around*|(|x|)> \<nabla\><rsub|a<rsub|1>>\<cdots\>\<nabla\><rsub|a<rsub|n>><around*|[|p<around*|(|x,t|)>
      <big|int>\<mathd\>\<mu\><around*|(|\<epsilon\>|)>
      p<rsub|\<epsilon\>><around*|(|\<epsilon\>;x,t|)>
      \ \<epsilon\><rsup|a<rsub|1>>\<cdots\>\<epsilon\><rsup|a<rsub|n>>|]>.
    </equation*>

    Denote <math|n>-order moments of <math|\<epsilon\>> as
    <math|M<rsup|a<rsub|1>\<cdots\>a<rsub|n>><around*|(|x,t|)>\<assign\><around*|\<langle\>|\<epsilon\><rsup|a<rsub|1>>\<cdots\>\<epsilon\><rsup|a<rsub|n>>|\<rangle\>><rsub|\<epsilon\>>>
    and recall the definition of <math|I<rsub|\<Delta\>t><around*|[|h|]>>,
    then we arrive at

    <\equation*>
      <big|int>\<mathd\>\<mu\><around*|(|x|)>
      <around*|[|p<around*|(|x,t+\<Delta\>t|)>-p<around*|(|x,t|)>|]>
      h<around*|(|x|)>=<big|sum><rsub|n=1><rsup|+\<infty\>><frac|<around*|(|-1|)><rsup|n>|n!><big|int>\<mathd\>\<mu\><around*|(|x|)>
      h<around*|(|x|)> \<nabla\><rsub|a<rsub|1>>\<cdots\>\<nabla\><rsub|a<rsub|n>><around*|[|p<around*|(|x,t|)>M<rsup|a<rsub|1>\<cdots\>a<rsub|n>><around*|(|x,t|)>|]>.
    </equation*>

    Since <math|h<around*|(|x|)>> is arbitrary, we conclude that

    <\equation*>
      p<around*|(|x,t+\<Delta\>t|)>-p<around*|(|x,t|)>=<big|sum><rsub|n=1><rsup|+\<infty\>><frac|<around*|(|-1|)><rsup|n>|n!>\<nabla\><rsub|a<rsub|1>>\<cdots\>\<nabla\><rsub|a<rsub|n>><around*|[|p<around*|(|x,t|)>M<rsup|a<rsub|1>\<cdots\>a<rsub|n>><around*|(|x,t|)>|]>.
    </equation*>
  </small>

  <appendix|Stochastic Dynamics>

  <subsection|Random Walk>

  Given <math|\<forall\>x\<in\><with|font|cal|M>> and any time <math|t>,
  consider a series of i.i.d. random variables (random walks),

  <\equation*>
    <around*|{|\<varepsilon\><rsub|i><rsup|a>:i=1\<ldots\>n<around*|(|t|)>|}>,
  </equation*>

  where, for <math|\<forall\>i>, <math|\<varepsilon\><rsup|a><rsub|i>\<sim\>P>
  for some distribution <math|P>, with the mean <math|0> and covariance
  <math|\<Sigma\><rsup|a b><around*|(|x,t|)>>, and the walk steps

  <\equation*>
    n<around*|(|t|)>=<big|int><rsub|0><rsup|t>\<mathd\>\<tau\>
    <frac|\<mathd\>n|\<mathd\>t><around*|(|x<around*|(|\<tau\>|)>,\<tau\>|)>.
  </equation*>

  For any time interval <math|\<Delta\>t>, this series of random walks leads
  to a difference

  <\equation*>
    \<Delta\>x<rsup|a>\<assign\><big|sum><rsub|i=n<around*|(|t|)>><rsup|n<around*|(|t+\<Delta\>t|)>>\<varepsilon\><rsup|a><rsub|i>.
  </equation*>

  Then, we have

  <\theorem>
    [Brownian Motion]

    As <math|\<mathd\>n/\<mathd\>t\<rightarrow\>+\<infty\>>,

    <\equation*>
      \<Delta\>x<rsup|a>=\<Delta\>W<rsup|a>+\<omicron\><around*|(|<frac|\<mathd\>n|\<mathd\>t><around*|(|x,t|)>|)>,
    </equation*>

    where

    <\equation*>
      \<Delta\>W<rsup|a>\<sim\><with|font|cal|N><around*|(|0,\<Delta\>t
      \<Sigma\><rsup|a b><around*|(|x,t|)>|)>.
    </equation*>
  </theorem>

  <small|<\proof>
    Let

    <\equation*>
      <wide|W|~><rsup|a><around*|(|x,t|)>\<assign\><frac|1|<sqrt|n<around*|(|t+\<Delta\>t|)>-n<around*|(|t|)>>><big|sum><rsub|i=n<around*|(|t|)>><rsup|n<around*|(|t+\<Delta\>t|)>>\<varepsilon\><rsup|a><rsub|i>,
    </equation*>

    we have <math|\<Delta\>x<rsup|a>=<sqrt|n<around*|(|t+\<Delta\>t|)>-n<around*|(|t|)>>
    <wide|W|~><rsup|a><around*|(|x,t|)>>. Since
    <math|n<around*|(|t+\<Delta\>t|)>-n<around*|(|t|)>=<frac|\<mathd\>n|\<mathd\>t><around*|(|x,t|)>
    \<Delta\>t+o<around*|(|\<Delta\>t|)>>, we have

    <\equation*>
      \<Delta\>x<rsup|a>=<sqrt|n<around*|(|t+\<Delta\>t|)>-n<around*|(|t|)>>
      <wide|W|~><rsup|a><around*|(|x,t|)>=<sqrt|<frac|\<mathd\>n|\<mathd\>t><around*|(|x,t|)>
      \<Delta\>t> <wide|W|~><rsup|a><around*|(|x,t|)>+\<omicron\><around*|(|<sqrt|\<Delta\>t>|)>.
    </equation*>

    If

    <\equation*>
      <frac|\<mathd\>n|\<mathd\>t><around*|(|x,t|)> \<Sigma\><rsup|a
      b><around*|(|x,t|)>=<with|font|cal|O><around*|(|1|)>
    </equation*>

    as <math|\<mathd\>n/\<mathd\>t\<rightarrow\>+\<infty\>>, that is, more
    steps per unit time, then, by central limit theorem (for
    multi-dimension),

    <\equation*>
      \<Delta\>x<rsup|a>=\<Delta\>W<rsup|a>+\<omicron\><around*|(|<frac|\<mathd\>n|\<mathd\>t><around*|(|x,t|)>|)>,
    </equation*>

    where

    <\equation*>
      \<Delta\>W<rsup|a>\<sim\><with|font|cal|N><around*|(|0,\<Delta\>t
      \<Sigma\><rsup|a b><around*|(|x,t|)>|)>.
    </equation*>
  </proof>>

  In reality, the space cannot be infinite, we live in a box, no matter how
  large it is.

  <subsection|Stochastic Dynamics><label|appendix: Stochastic Dynamics>

  A stochastic dynamics is defined by two parts. The first is deterministic,
  and the second is a random walk. Precisely,

  <\definition>
    <label|definition: Stochastic Dynamics>[Stochastic Dynamics]

    Given <math|\<mu\><rsup|a><around*|(|x,t|)>> and <math|\<Sigma\><rsup|a
    b><around*|(|x,t|)>> on <math|<with|font|cal|M>\<times\>\<bbb-R\>>,

    <\equation*>
      \<mathd\>x<rsup|a>=\<mu\><rsup|a><around*|(|x,t|)>
      \<mathd\>t+\<mathd\>W<rsup|a><around*|(|x,t|)>,
    </equation*>

    where <math|\<mathd\>W<rsup|a><around*|(|x,t|)>> is a random walk with
    covariance <math|\<Sigma\><rsup|a b><around*|(|x,t|)> \<mathd\>t>.
  </definition>

  <\lemma>
    <label|lemma: Macroscopic Landscape>[Macroscopic Landscape]

    Consider an ensemble of particles, randomly sampled at an initial time,
    evolving along a stochastic dynamics <reference|definition: Stochastic
    Dynamics>. By saying \Pensemble\Q, we mean that the number of particles
    has the order of Avogadro's constant, s.t. the distribution of the
    particles can be viewed as smooth. Let <math|p<around*|(|x,t|)>> denotes
    the distribution. Then we have

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      \<mu\><rsup|a><around*|(|x,t|)>|]>+<frac|1|2>
      \<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>\<Sigma\><rsup|a
      b><around*|(|x,t|)>|]>.
    </equation*>
  </lemma>

  <small|<\proof>
    From the difference of the stochastic dynamics,

    <\equation*>
      \<Delta\>x<rsup|a>=\<mu\><rsup|a><around*|(|x,t|)> \<Delta\>t+
      \<Delta\>W<rsup|a><around*|(|x,t|)>,
    </equation*>

    by Kramers\UMoyal expansion <reference|lemma: Kramers\UMoyal Expansion>,
    we have

    <\equation*>
      p<around*|(|x,t+\<Delta\>t|)>-p<around*|(|x,t|)>=<big|sum><rsub|n=1><rsup|+\<infty\>><frac|<around*|(|-1|)><rsup|n>|n!>\<nabla\><rsub|a<rsub|1>>\<cdots\>\<nabla\><rsub|a<rsub|n>><around*|[|p<around*|(|x,t|)><around*|\<langle\>|\<Delta\>x<rsup|a<rsub|1>>\<cdots\>\<Delta\>x<rsup|a<rsub|n>>|\<rangle\>><rsub|\<Delta\>x>|]>.
    </equation*>

    For <math|n=1>, since <math|\<mathd\>W<rsup|a><around*|(|x,t|)>> is a
    random walk, <math|<around*|\<langle\>|\<Delta\>W<rsup|a><around*|(|x,t|)>|\<rangle\>><rsub|\<Delta\>W<around*|(|x,t|)>>=0>.
    Then the term is <math|-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)><around*|\<langle\>|\<Delta\>x<rsup|a>|\<rangle\>><rsub|\<Delta\>x>|]>=-\<nabla\><rsub|a><around*|{|p<around*|(|x,t|)>
    \<mu\><rsup|a><around*|(|x,t|)>|}>\<Delta\>t>. And for <math|n=2>, by
    noticing that, as a random walk, <math|<around*|\<langle\>|\<Delta\>W<rsup|a><around*|(|x,t|)>
    \<Delta\>W<rsup|b><around*|(|x,t|)>|\<rangle\>><rsub|\<Delta\>W<around*|(|x,t|)>>=<with|font|cal|O><around*|(|\<Delta\>t|)>>,
    we have, up to <math|o<around*|(|\<Delta\>t|)>>, only
    <math|<around*|(|1/2|)> \<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>\<Sigma\><rsup|a
    b><around*|(|x,t|)>|]> \<Delta\>t> left. For <math|n\<geqslant\>3>, all
    are <math|o<around*|(|\<Delta\>t|)>>. So, we have

    <\equation*>
      p<around*|(|x,t+\<Delta\>t|)>-p<around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      \<mu\><rsup|a><around*|(|x,t|)>|]>+<frac|1|2>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>\<Sigma\><rsup|a
      b><around*|(|x,t|)>|]>\<Delta\>t+o<around*|(|\<Delta\>t|)>.
    </equation*>

    Letting <math|\<Delta\>t\<rightarrow\>0>, we find

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      \<mu\><rsup|a><around*|(|x,t|)>|]>+<frac|1|2>
      \<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>\<Sigma\><rsup|a
      b><around*|(|x,t|)>|]>.
    </equation*>

    Thus proof ends.
  </proof>>
</body>

<\initial>
  <\collection>
    <associate|font-base-size|8>
    <associate|page-medium|paper>
    <associate|page-screen-margin|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|algorithm: RL|<tuple|7|5>>
    <associate|appendix: Stochastic Dynamics|<tuple|B.2|9>>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|B.2|8>>
    <associate|auto-11|<tuple|B.2|8>>
    <associate|auto-12|<tuple|B.2|9>>
    <associate|auto-2|<tuple|1|1>>
    <associate|auto-3|<tuple|A|3>>
    <associate|auto-4|<tuple|A.1|4>>
    <associate|auto-5|<tuple|B|5>>
    <associate|auto-6|<tuple|B.1|5>>
    <associate|auto-7|<tuple|B.2|7>>
    <associate|auto-8|<tuple|B.2|7>>
    <associate|auto-9|<tuple|B.2|7>>
    <associate|definition: Stochastic Dynamics|<tuple|6|9>>
    <associate|footnote-1|<tuple|1|2>>
    <associate|footnote-2|<tuple|2|3>>
    <associate|footnote-3|<tuple|3|3>>
    <associate|footnote-4|<tuple|4|3>>
    <associate|footnote-5|<tuple|5|4>>
    <associate|footnote-6|<tuple|6|6>>
    <associate|footnote-7|<tuple|7|6>>
    <associate|footnote-8|<tuple|8|6>>
    <associate|footnr-1|<tuple|1|2>>
    <associate|footnr-2|<tuple|2|3>>
    <associate|footnr-3|<tuple|3|3>>
    <associate|footnr-4|<tuple|4|3>>
    <associate|footnr-5|<tuple|5|4>>
    <associate|footnr-6|<tuple|6|6>>
    <associate|footnr-7|<tuple|7|6>>
    <associate|footnr-8|<tuple|8|6>>
    <associate|lemma: Conditional Distribution|<tuple|5|5>>
    <associate|lemma: Kramers\UMoyal Expansion|<tuple|4|7>>
    <associate|lemma: Macroscopic Landscape|<tuple|7|9>>
    <associate|lemma: Vector Fields|<tuple|4|7>>
    <associate|theorem: Fokker-Planck|<tuple|3|2>>
    <associate|theorem: Stochastic Dynamics|<tuple|4|3>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|2fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|font-size|<quote|1.19>|1<space|2spc>Lyapunov
      Function> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|1fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Relaxation>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Lyapunov
      Function> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Ambient
      & Latent Variables> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Minimize
      Free Energy Principle> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|5<space|2spc>Example:
      Continuous Hopfield Network> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      A<space|2spc>Useful Lemmas> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.5fn>

      <with|par-left|<quote|1tab>|A.1<space|2spc>Vector Fields
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <with|par-left|<quote|1tab>|A.2<space|2spc>Kramers\UMoyal Expansion
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      B<space|2spc>Stochastic Dynamics> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10><vspace|0.5fn>

      <with|par-left|<quote|1tab>|B.1<space|2spc>Random Walk
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|B.2<space|2spc>Stochastic Dynamics
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>
    </associate>
  </collection>
</auxiliary>
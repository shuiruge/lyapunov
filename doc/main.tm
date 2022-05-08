<TeXmacs|2.1.1>

<style|<tuple|article|padded-paragraphs>>

<\body>
  <\hide-preamble>
    \;

    <assign|axiom-text|<macro|Ansatz>>
  </hide-preamble>

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

      <item>for conditional maps <math|f>, let <math|f<around*|(|x\|y|)>>
      denotes the map of <math|x> with <math|y> given and fixed, and
      <math|f<around*|(|x;y|)>> denotes the map of <math|x> with <math|y>
      given but mutable;

      <item>r.v. is short for random variable, and i.i.d. for independent
      identically distributed.

      <item>ODE for ordinary differential equation(s), SDE for stochastic
      differential equation(s).

      <item>Laplacian <math|\<Delta\>\<assign\>\<nabla\><rsub|a>\<nabla\><rsup|a>>.
    </itemize>
  </notation>

  <section|Lyapunov Function>

  <\definition>
    [Lyapunov Function]

    Given an autonomous<\footnote>
      That is, ordinary differential equations that do not explicitly depend
      on time. The word autonomous means independent of time.
    </footnote> ODE,

    <\equation*>
      <frac|\<mathd\>x<rsup|a>|\<mathd\>t>=f<rsup|a><around*|(|x|)>,
    </equation*>

    a Lyapunov function, <math|V<around*|(|x|)>>, of it is a scalar function
    such that <math|\<nabla\><rsub|a>V<around*|(|x|)>
    f<rsup|a><around*|(|x|)>\<leqslant\>0> and the equality holds if and only
    if <math|f<rsup|a><around*|(|x|)>=0>.
  </definition>

  Along the phase trajectory, a Lyapunov function monomotically decreases.
  So, it reflects the stability of the ODE.

  <\question>
    Given an autonomous ODE, whether a Lyapunov function of it exists or not?
  </question>

  <\question>
    And how to construct, or approximate to, it if there is any?
  </question>

  Here we propose a simulation based method that furnishes a criterion on
  whether a Lyapunov function exists or not, and then reveals an analytic
  approximation to the Lyapunov function if it exists.

  We first extend the autonomous ODE to a SDE<\footnote>
    SDE is defined in <reference|definition: Stochastic Dynamics>.
  </footnote>, as

  <\equation*>
    \<mathd\>X<rsup|a>=f<rsup|a><around*|(|X|)> \<mathd\>t+<sqrt|2T >
    \<mathd\>W<rsup|a>,
  </equation*>

  where <math|\<mathd\>W<rsup|a>\<sim\><with|font|cal|N><around*|(|0,\<delta\><rsup|a
  b>\<mathd\>t|)>> and parameter <math|T\<gtr\>0>. Then, we sample an
  essemble of \Pparticles\Q independently evolving along this SDE. As a set
  of Markov chains, this simulation will arrive at a stationary distribution.
  This is true if the Markov chain is irreducible and recurrent. These
  conditions are hard to check. But, in practice, there is criterion on the
  convergence of a chain at a finite time.<\footnote>
    E.g., Gelman-Rubin-Brooks plot.
  </footnote> If it has converged, we get an empirical distribution, denoted
  as <math|p<rsub|D>>, that approximates to the true stationary distribution.

  Next, we are to find an analytic approximation to the empirical
  distribution <math|p<rsub|D>>. This can be taken by any universal
  approximator, such as neural network. Say, an universal approximator
  <math|E<around*|(|\<cdummy\>;\<theta\>|)>> parameterized by
  <math|\<theta\>>, and define <math|q<rsub|E>> as

  <\equation*>
    q<rsub|E><around*|(|x;\<theta\>|)>\<assign\><frac|exp<around*|(|-E<around*|(|x;\<theta\>|)>/T|)>|Z<rsub|E><around*|(|\<theta\>|)>>,
  </equation*>

  where <math|Z<rsub|E><around*|(|\<theta\>|)>\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
  exp<around*|(|-E<around*|(|x;\<theta\>|)>/T|)>>. Then, we construct the
  loss as

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
    p<rsub|D><around*|(|x|)> ln Z<rsub|E><around*|(|\<theta\>|)>>>|<row|<cell|=>|<cell|<around*|\<langle\>|E<around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|p<rsub|D>>>>|<row|<cell|<around*|[|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)>=1|]>+>|<cell|T ln
    Z<rsub|E><around*|(|\<theta\>|)>.>>>>
  </align>

  We find the best fit <math|\<theta\><rsub|\<star\>>\<assign\>argmin<rsub|\<theta\>>L<around*|(|\<theta\>|)>>
  by using gradient descent. Notice the relation

  <\lemma>
    <\equation*>
      T<frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>>ln
      Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>=-<around*|\<langle\>|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>>.
    </equation*>
  </lemma>

  <small|<\proof>
    Directly,

    <\align>
      <tformat|<table|<row|<cell|T<frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>>ln
      Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>=>|<cell|T<frac|1|Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>><frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>>Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>>|<row|<cell|<around*|{|Z<rsub|E>\<assign\>\<cdots\>|}>=>|<cell|T<frac|1|Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>><frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      \<mathe\><rsup|-E<around*|(|x;\<theta\>|)>/T>>>|<row|<cell|=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      <frac|\<mathe\><rsup|-E<around*|(|x;\<theta\>|)>/T>|Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>><frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>>>|<row|<cell|<around*|{|q<rsub|E>\<assign\>\<cdots\>|}>=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      q<rsub|E><around*|(|x;\<theta\>|)><frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>.>>|<row|<cell|=>|<cell|-<around*|\<langle\>|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>>.>>>>
    </align>

    Thus, proof ends.
  </proof>>

  This implies

  <\align>
    <tformat|<table|<row|<cell|>|<cell|<frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>|)>=<around*|\<langle\>|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|p<rsub|D>>-<around*|\<langle\>|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>>.>>>>
  </align>

  Both of the two terms can be computed by Monte Carlo integral. Since
  <math|p<rsub|D>> has been an empirical distribution, the computation of the
  first Monte Carlo integral is straight forward. The second can be computed
  in the same way of generating the empirical distribution <math|p<rsub|D>>,
  by noticing

  <\lemma>
    Markov chains by SDE

    <\equation*>
      \<mathd\>X<rsup|a>=-\<nabla\><rsup|a>E<around*|(|x|)>
      \<mathd\>t+<sqrt|2T> \<mathd\>V<rsup|a>,
    </equation*>

    where <math|\<mathd\>V<rsup|a>\<sim\><with|font|cal|N><around*|(|0,\<delta\><rsup|a
    b> \<mathd\>t|)>> and <math|T\<gtr\>0>, will converge to
    <math|q<rsub|E>>.
  </lemma>

  <small|<\proof>
    By lemma <reference|lemma: Macroscopic Landscape>, the distribution
    <math|p<around*|(|x,t|)>> of the Markov chains generated by the SDE obeys

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      \<nabla\><rsup|a>E<around*|(|x|)>|]>+T \<Delta\>p<around*|(|x,t|)>.
    </equation*>

    It's straight forward to check that <math|q<rsub|E>> is a stationary
    solution to this equation. And for any initial value of
    <math|p<around*|(|x,t|)>>, it always relax to <math|q<rsub|E>>. Indeed,

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>|\<mathd\>t> T
      D<rsub|KL><around*|(|p\<\|\|\>q<rsub|E>|)>=>|<cell|<frac|\<mathd\>|\<mathd\>t>
      T <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> <around*|[|ln p<around*|(|x,t|)>-ln
      q<rsub|E><around*|(|x|)>|]>>>|<row|<cell|=>|<cell|T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)> <around*|[|ln
      p<around*|(|x,t|)>-ln q<rsub|E><around*|(|x|)>+1|]>>>|<row|<cell|<around*|{|<frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=\<cdots\>|}>=>|<cell|T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      \<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      \<nabla\><rsup|a>E<around*|(|x|)>+T
      \<nabla\><rsup|a>p<around*|(|x,t|)>|]> <around*|[|ln
      p<around*|(|x,t|)>-ln q<rsub|E><around*|(|x|)>+1|]>>>|<row|<cell|<around*|{|Integral
      by part|}>=>|<cell|-T <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)><around*|[|p<around*|(|x,t|)>
      \<nabla\><rsup|a>E<around*|(|x|)>+T
      \<nabla\><rsup|a>p<around*|(|x,t|)>|]> \ \<nabla\><rsub|a><around*|[|ln
      p<around*|(|x,t|)>-ln q<rsub|E><around*|(|x|)>+1|]>>>|<row|<cell|=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> \<nabla\><rsub|a><around*|[|E<around*|(|x|)>+T ln
      p<around*|(|x,t|)>|]> \ \<nabla\><rsup|a><around*|[|E<around*|(|x|)>+T
      ln p<around*|(|x,t|)>|]>>>|<row|<cell|\<leqslant\>>|<cell|0,>>>>
    </align>

    and the equility holds if and only if
    <math|\<nabla\><rsub|a><around*|[|E<around*|(|x|)>+T ln
    p<around*|(|x,t|)>|]>=0> for <math|\<forall\>x>, that is,
    <math|p<around*|(|x,t|)>\<equiv\>q<rsub|E><around*|(|x|)>>.
  </proof>>

  Even though the <math|\<theta\>> is keep changing during the gradient
  descent process, as long as it's controlled so as to be slowly varying, we
  can use the same strategy as the persistent contrastive divergence trick to
  simplify the computation. \ So, during the gradient descent steps, we
  employ two distinct sets of Markov chains that are consistently evolving.
  The first is generated by the SDE to <math|p<rsub|D>>, and the second by
  the SDE to <math|q<rsub|E>>. Along the gradient descent steps of
  <math|\<theta\>>, on the chains to <math|p<rsub|D>> <math|E> is suppressed,
  while on the chains to <math|q<rsub|E>> <math|E> is elevated. Gradient
  descent stops when the two parts balance, where <math|q<rsub|E>> fits
  <math|p<rsub|D>> best.

  Finally, we claim that the <math|E> we find at the best fit
  <math|\<theta\><rsub|\<star\>>> is a Lyapunov function of the original
  autonomous ODE. By lemma <reference|lemma: Macroscopic Landscape>, the
  distribution <math|p<around*|(|x,t|)>> of the Markov chains generated by
  the SDE to <math|p<rsub|D>> obeys

  <\equation*>
    <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
    f<rsup|a><around*|(|x|)>|]>+T \<Delta\>p<around*|(|x,t|)>.
  </equation*>

  In the end, <math|p\<rightarrow\>p<rsub|D>\<approx\>q<rsub|E>> where
  <math|\<partial\>p/\<partial\>t\<rightarrow\>0>. Here, it becomes

  <\equation*>
    0=-\<nabla\><rsub|a>E<around*|(|x|)> f<rsup|a><around*|(|x|)>-\<delta\><rsup|a
    b> \<nabla\><rsub|a>E <around*|(|x|)>\<nabla\><rsub|b>E<around*|(|x|)>+T
    <around*|[|\<nabla\><rsub|a>f<rsup|a><around*|(|x|)>+\<Delta\>E<around*|(|x|)>|]>.
  </equation*>

  As <math|T\<rightarrow\>0>, the SDE reduces to the original autonomous ODE,
  and we arrive at

  <\equation*>
    \<nabla\><rsub|a>E<around*|(|x|)> f<rsup|a><around*|(|x|)>=-\<delta\><rsup|a
    b> \<nabla\><rsub|a>E <around*|(|x|)>\<nabla\><rsub|b>E<around*|(|x|)>\<leqslant\>0,
  </equation*>

  where equality holds if and only if <math|\<nabla\><rsub|a>E<around*|(|x|)>=0>.
  Thus, <math|E<around*|(|x|)>> is a Lyapunov function of
  <math|\<mathd\>x<rsup|a>/\<mathd\>t=f<rsup|a><around*|(|x|)>>.

  <section|Minimize Free Energy Principle>

  <\definition>
    [Free Energy]

    Given <math|E:<with|font|cal|M>\<rightarrow\>\<bbb-R\>> and
    <math|T\<gtr\>0>, free energy is a functional of distribution, defined as

    <\equation*>
      F<rsub|E><around*|[|p|]>\<assign\><around*|\<langle\>|E|\<rangle\>><rsub|p>-T
      H<around*|[|p|]>.
    </equation*>
  </definition>

  Free energy is a balanced result. Indeed, on one hand, we want to minimize
  the expectation of energy; and on the other hand, we want to minimize the
  prior knowledge on <math|p>. The parameter <math|T> weighs this balance.

  <\lemma>
    Let

    <\equation*>
      q<rsub|E><around*|(|x|)>\<assign\><frac|exp<around*|(|-E<around*|(|x|)>/T|)>|Z<rsub|E>>,
    </equation*>

    where <math|Z<rsub|E>\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    exp<around*|(|-E<around*|(|x|)>/T|)>>, then we have

    <\equation*>
      F<around*|[|q<rsub|E>|]>=-T ln Z<rsub|E>.
    </equation*>
  </lemma>

  <small|<\proof>
    Since

    <\equation*>
      q<rsub|E><around*|(|x|)>=<frac|exp<around*|(|-E<around*|(|x|)>/T|)>|Z<rsub|E>>,
    </equation*>

    we have

    <\align>
      <tformat|<table|<row|<cell|T H<around*|[|q<rsub|E>|]>=>|<cell|-T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      q<rsub|E><around*|(|x|)> ln q<rsub|E><around*|(|x|)>>>|<row|<cell|=>|<cell|-T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      q<rsub|E><around*|(|x|)> <around*|[|-E<around*|(|x|)>/T-ln
      Z<rsub|E>|]>>>|<row|<cell|=>|<cell|<around*|\<langle\>|E|\<rangle\>><rsub|q<rsub|E>>+T
      ln Z<rsub|E>.>>>>
    </align>

    Then,

    <\align>
      <tformat|<table|<row|<cell|F<around*|[|q<rsub|E>|]>\<assign\>>|<cell|<around*|\<langle\>|E|\<rangle\>><rsub|q<rsub|E>>-T
      H<around*|[|q<rsub|E>|]>>>|<row|<cell|=>|<cell|<around*|\<langle\>|E|\<rangle\>><rsub|q<rsub|E>>-<around*|\<langle\>|E|\<rangle\>><rsub|q<rsub|E>>-T
      ln Z<rsub|E>>>|<row|<cell|=>|<cell|-T ln Z<rsub|E>.>>>>
    </align>

    Thus proof ends.
  </proof>>

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

  <subsection|Stochastic Dynamics><label|appendix: Stochastic Dynamics>

  A stochastic dynamics, or stochastic differential equations (SDE), is
  defined by two parts. The first is deterministic, and the second is a
  random walk. Precisely,

  <\definition>
    <label|definition: SDE>Given <math|f<rsup|a><around*|(|x,t|)>>,
    <math|g<rsup|a><rsub|b><around*|(|x,t|)>>, and <math|\<Sigma\><rsup|a
    b><around*|(|x,t|)>> on <math|<with|font|cal|M>\<times\>\<bbb-R\>>,
    stochastic differential equations is defined as

    <\equation*>
      \<mathd\>x<rsup|a>=f<rsup|a><around*|(|x,t|)>
      \<mathd\>t+g<rsup|a><rsub|b><around*|(|x,t|)>
      \<mathd\>W<rsup|b><around*|(|x,t|)>,
    </equation*>

    where <math|\<mathd\>W<rsup|a><around*|(|x,t|)>> is a random walk with
    covariance <math|\<Sigma\><rsup|a b><around*|(|x,t|)> \<mathd\>t>.
  </definition>

  <\lemma>
    <label|lemma: Macroscopic Landscape>[Macroscopic Landscape]

    Consider an ensemble of particles, randomly sampled at an initial time,
    evolving along a SDE <reference|definition: Stochastic Dynamics>. By
    saying \Pensemble\Q, we mean that the number of particles has the order
    of Avogadro's constant, s.t. the distribution of the particles can be
    viewed as smooth. Let <math|p<around*|(|x,t|)>> denotes the distribution.
    Then we have

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      f<rsup|a><around*|(|x,t|)>|]>+<frac|1|2>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>
      K<rsup|a b><around*|(|x,t|)>|]>,
    </equation*>

    where <math|K<rsup|a b>\<assign\>g<rsup|a><rsub|c><around*|(|x,t|)>
    g<rsup|b><rsub|d><around*|(|x,t|)> \<Sigma\><rsup|c d><around*|(|x,t|)>>.
  </lemma>

  <small|<\proof>
    From the difference of the SDE,

    <\equation*>
      \<Delta\>x<rsup|a>=f<rsup|a><around*|(|x,t|)> \<Delta\>t+
      g<rsup|a><rsub|b><around*|(|x,t|)> \<Delta\>W<rsup|a><around*|(|x,t|)>,
    </equation*>

    by Kramers\UMoyal expansion <reference|lemma: Kramers\UMoyal Expansion>,
    we have

    <\equation*>
      p<around*|(|x,t+\<Delta\>t|)>-p<around*|(|x,t|)>=<big|sum><rsub|n=1><rsup|+\<infty\>><frac|<around*|(|-1|)><rsup|n>|n!>\<nabla\><rsub|a<rsub|1>>\<cdots\>\<nabla\><rsub|a<rsub|n>><around*|[|p<around*|(|x,t|)><around*|\<langle\>|\<Delta\>x<rsup|a<rsub|1>>\<cdots\>\<Delta\>x<rsup|a<rsub|n>>|\<rangle\>><rsub|\<Delta\>x>|]>.
    </equation*>

    For <math|n=1>, since <math|\<mathd\>W<rsup|a><around*|(|x,t|)>> is a
    random walk, <math|<around*|\<langle\>|\<Delta\>W<rsup|a><around*|(|x,t|)>|\<rangle\>><rsub|\<Delta\>W<around*|(|x,t|)>>=0>.
    Then the term is

    <\equation*>
      -\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)><around*|\<langle\>|\<Delta\>x<rsup|a>|\<rangle\>><rsub|\<Delta\>x>|]>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      f<rsup|a><around*|(|x,t|)>|]>\<Delta\>t.
    </equation*>

    And for <math|n=2>, by noticing that, as a random walk,
    <math|<around*|\<langle\>|\<Delta\>W<rsup|a><around*|(|x,t|)>
    \<Delta\>W<rsup|b><around*|(|x,t|)>|\<rangle\>><rsub|\<Delta\>W<around*|(|x,t|)>>=<with|font|cal|O><around*|(|\<Delta\>t|)>>,
    we have,

    <\equation*>
      <frac|1|2>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>
      <around*|\<langle\>|\<Delta\>x<rsup|a>
      \<Delta\>x<rsup|b>|\<rangle\>><rsub|\<Delta\>x>|]>=<frac|1|2>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>
      g<rsup|a><rsub|c><around*|(|x,t|)> g<rsup|b><rsub|d><around*|(|x,t|)>
      \<Sigma\><rsup|c d><around*|(|x,t|)>|]>
      \<Delta\>t+\<omicron\><around*|(|\<Delta\>t|)>.
    </equation*>

    \;

    For <math|n\<geqslant\>3>, all are <math|o<around*|(|\<Delta\>t|)>>. So,
    we have

    <\equation*>
      p<around*|(|x,t+\<Delta\>t|)>-p<around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      f<rsup|a><around*|(|x,t|)>|]>+<frac|1|2>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>
      g<rsup|a><rsub|c><around*|(|x,t|)> g<rsup|b><rsub|d><around*|(|x,t|)>
      \<Sigma\><rsup|c d><around*|(|x,t|)>|]>
      \<Delta\>t+o<around*|(|\<Delta\>t|)>.
    </equation*>

    Letting <math|\<Delta\>t\<rightarrow\>0>, we find

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      \<mu\><rsup|a><around*|(|x,t|)>|]>+<frac|1|2>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|p<around*|(|x,t|)>
      g<rsup|a><rsub|c><around*|(|x,t|)> g<rsup|b><rsub|d><around*|(|x,t|)>
      \<Sigma\><rsup|c d><around*|(|x,t|)>|]>.
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
    <associate|appendix: Stochastic Dynamics|<tuple|B.2|5>>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|2|3>>
    <associate|auto-3|<tuple|A|3>>
    <associate|auto-4|<tuple|A.1|4>>
    <associate|auto-5|<tuple|B|4>>
    <associate|auto-6|<tuple|B.1|5>>
    <associate|auto-7|<tuple|B.2|?>>
    <associate|definition: SDE|<tuple|9|5>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-2|<tuple|2|1>>
    <associate|footnote-3|<tuple|3|1>>
    <associate|footnr-1|<tuple|1|1>>
    <associate|footnr-2|<tuple|2|1>>
    <associate|footnr-3|<tuple|3|1>>
    <associate|lemma: Kramers\UMoyal Expansion|<tuple|7|3>>
    <associate|lemma: Macroscopic Landscape|<tuple|10|5>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Lyapunov
      Function> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      A<space|2spc>Useful Lemmas> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <with|par-left|<quote|1tab>|A.1<space|2spc>Kramers\UMoyal Expansion
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      B<space|2spc>Stochastic Dynamics> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <with|par-left|<quote|1tab>|B.1<space|2spc>Random Walk
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|B.2<space|2spc>Stochastic Dynamics
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>
    </associate>
  </collection>
</auxiliary>
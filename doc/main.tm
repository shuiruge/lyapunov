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
      identically distributed;

      <item>ODE for ordinary differential equation(s), SDE for stochastic
      differential equation(s);

      <item>Laplacian <math|\<Delta\>\<assign\>\<nabla\><rsub|a>\<nabla\><rsup|a>>;

      <item>let <math|<with|font|cal|D><rsub|v>> denotes the Lie derivative
      along direction <math|v>;

      <item><math|<with|font|cal|C><rsup|p><around*|(|A,B|)>> denotes
      <math|p>-order smooth function from <math|A> to B, and
      <math|<with|font|cal|C><rsup|p><around*|(|A|)>> shorten for
      <math|<with|font|cal|C><rsup|p><around*|(|A,\<bbb-R\>|)>>.
    </itemize>
  </notation>

  <section|Lyapunov Function>

  <subsection|Definition>

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

  <subsection|Construction of Lyapunov Function>

  <\question>
    Given an autonomous ODE, whether a Lyapunov function of it exists or not?
  </question>

  <\question>
    And how to construct one if there is any?
  </question>

  Here we propose a simulation based method that furnishes a criterion on
  whether a Lyapunov function exists or not, and then reveals an analytic
  approximation to the Lyapunov function if it exists.

  We first extend the autonomous ODE to a SDE<\footnote>
    SDE is defined in <reference|definition: SDE>.
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
    E.g., visualization by animation of histograms. Practically, we find that
    the Gelman-Rubin-Brooks plot won't work in some cases.
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

  <\align>
    <tformat|<table|<row|<cell|L<around*|(|\<theta\>|)>\<assign\>>|<cell|T
    D<rsub|KL><around*|(|p<rsub|D>\<\|\|\>q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>|)>>>|<row|<cell|=>|<cell|T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)> ln p<rsub|D><around*|(|x|)>-T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    p<rsub|D><around*|(|x|)> ln q<rsub|E><around*|(|x;\<theta\>|)>.>>>>
  </align>

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
    By theorem <reference|theorem: Fokker-Planck Equation>, the distribution
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

  Notice that the best fit <math|\<theta\><rsub|\<star\>>> depends on
  <math|T> implicitly. We take a series of <math|T>,
  <math|<around*|{|T<rsub|1>,T<rsub|2>,\<ldots\>|}>>, that tends to
  <math|0<rsub|+>>. And for each <math|T<rsub|i>>, we repeat the previous
  process to find the best fit <math|\<theta\><rsub|\<star\>>> for this
  <math|T<rsub|i>>. When <math|T<rsub|i>> tends to <math|0>, we claim that
  the best fit <math|E>, denoted by <math|E<rsub|\<star\>>>, satisfies
  <math|\<nabla\><rsub|a>E<rsub|\<star\>><around*|(|x|)>
  f<rsup|a><around*|(|x|)>\<leqslant\>0> for
  <math|\<forall\>x\<in\><with|font|cal|M>>, and the equality holds if and
  only if <math|E<rsub|\<star\>><around*|(|x|)>=0>.

  <small|<\proof>
    For simplification, we denote <math|E<rsub|\<star\>>> by <math|E> within
    this proof.

    By theorem <reference|theorem: Fokker-Planck Equation>, the distribution
    <math|p<around*|(|x,t|)>> of the Markov chains generated by the SDE to
    <math|p<rsub|D>> obeys

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|x,t|)>
      f<rsup|a><around*|(|x|)>|]>+T \<Delta\>p<around*|(|x,t|)>.
    </equation*>

    In the end, <math|p\<rightarrow\>p<rsub|D>\<approx\>q<rsub|E>> where
    <math|\<partial\>p/\<partial\>t\<rightarrow\>0>, we have

    <\align>
      <tformat|<table|<row|<cell|0=>|<cell|<around*|[|-\<nabla\><rsub|a><around*|[|q<rsub|E><around*|(|x|)>
      f<rsup|a><around*|(|x|)>|]>+T \<Delta\>q<rsub|E><around*|(|x|)>|]>>>|<row|<cell|<around*|{|q<rsub|E>=\<cdots\>|}>=>|<cell|-<frac|1|Z<rsub|E>>\<nabla\><rsub|a><around*|[|\<mathe\><rsup|-E<around*|(|x|)>/T>
      f<rsup|a><around*|(|x|)>|]>+T \<Delta\>\<mathe\><rsup|-E<around*|(|x|)>/T>>>|<row|<cell|<around*|[|1st
      term|]>=>|<cell|<frac|1|T Z<rsub|E>>\<mathe\><rsup|-E<around*|(|x|)>/T>
      \<nabla\><rsub|a>E<around*|(|x|)>f<rsup|a><around*|(|x|)>-\<mathe\><rsup|-E<around*|(|x|)>/T>\<nabla\><rsub|a>f<rsup|a><around*|(|x|)>>>|<row|<cell|<around*|[|2nd
      term|]>+>|<cell|<frac|1|T Z<rsub|E>>
      \<mathe\><rsup|-E<around*|(|x|)>/T>
      \<nabla\><rsub|a>E<around*|(|x|)>\<nabla\><rsup|a>E<around*|(|x|)>-\<mathe\><rsup|-E<around*|(|x|)>/T>
      \<Delta\>E<around*|(|x|)>>>|<row|<cell|=>|<cell|<frac|1|T
      Z<rsub|E>>\<mathe\><rsup|-E<around*|(|x|)>/T>\<times\><around*|{|\<nabla\><rsub|a>E<around*|(|x|)>f<rsup|a><around*|(|x|)>+\<nabla\><rsub|a>E<around*|(|x|)>\<nabla\><rsup|a>E<around*|(|x|)>-T
      <around*|[|\<nabla\><rsub|a>f<rsup|a><around*|(|x|)>+\<Delta\>E<around*|(|x|)>|]>|}>.>>>>
    </align>

    As <math|T\<rightarrow\>0>, we arrive at

    <\equation*>
      \<nabla\><rsub|a>E<around*|(|x|)>f<rsup|a><around*|(|x|)>=-\<nabla\><rsub|a>E<around*|(|x|)>\<nabla\><rsup|a>E<around*|(|x|)>\<leqslant\>0,
    </equation*>

    and the equality holds if and only if
    <math|\<nabla\><rsub|a>E<around*|(|x|)>=0>.
  </proof>>

  <with|color|red|TODO: Proof that <math|\<nabla\><rsub|a>E<around*|(|x|)>=0\<Rightarrow\>f<rsup|a><around*|(|x|)>=0>.>

  <subsection|Parameterized ODE>

  Next, we consider parameterized ODE, that is,
  <math|f<around*|(|x|)>\<rightarrow\>f<around*|(|x;\<varphi\>|)>>, where
  <math|\<varphi\>> denotes collection of parameters. For instance, in the
  case of oscillator, <math|\<varphi\>> can be the stiffness factor. In this
  situation, we want to construct a Lyapunov function, not only as a function
  of <math|x>, but also of <math|\<varphi\>>, that is,
  <math|E<around*|(|x,\<varphi\>|)>>, such that for
  <math|\<forall\><around*|(|x,\<varphi\>|)>> in the domain, we have

  <\equation*>
    <frac|\<partial\>E|\<partial\>x<rsup|a>><around*|(|x,\<varphi\>|)>
    f<rsup|a><around*|(|x;\<varphi\>|)>\<leqslant\>0,
  </equation*>

  where the equality holds if and only <math|f<rsup|a><around*|(|x;\<varphi\>|)>=0>.

  Even though a completely new question, with some trick, it can be reduced
  to the one we have solved.

  <\example>
    Consider the one-dimensional ODE with a parameter <math|r>,

    <\equation*>
      <frac|\<mathd\>x|\<mathd\>t>=r-x.
    </equation*>

    It is equivalent to an augmented ODE

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>x|\<mathd\>t>=>|<cell|r-x;>>|<row|<cell|<frac|\<mathd\>r|\<mathd\>t>=>|<cell|0.>>>>
    </align>

    And, it has a Lyapunov function

    <\equation*>
      E<around*|(|x,r|)>=<frac|1|2><around*|(|r-x|)><rsup|2>.
    </equation*>

    Indeed, since <math|<around*|(|\<partial\>E/\<partial\>x|)><around*|(|x,r|)>=x-r>,
    <math|<around*|(|\<partial\>E/\<partial\>x|)><around*|(|x,r|)>
    f<around*|(|x|)>=-<around*|(|r-x|)><rsup|2>\<leqslant\>0>. Given
    <math|r>, it's a valley centered at <math|r> along <math|x>-aixs. By the
    way, <math|<around*|(|\<partial\>E/\<partial\>r|)><around*|(|x,r|)>=r-x>.
    We find that the place where <math|<around*|(|\<partial\>E/\<partial\>x|)><around*|(|x,r|)>=0>
    has <math|<around*|(|\<partial\>E/\<partial\>r|)><around*|(|x,r|)>=0>.

    Obviously, as a function of <math|<around*|(|x,r|)>>, the Markov chain
    constructed via <math|E<around*|(|x,r|)>> cannot relax. However, since
    the SDE along <math|r>-axis is a pure Brownian motion, particles obey a
    normal distribution with the standard derivative
    <math|\<sigma\><rsub|\<varphi\>>\<sim\><sqrt|t>>. Thus
    <math|\<mathd\>\<sigma\><rsub|\<varphi\>>/\<mathd\>t\<sim\>1/<sqrt|t>\<rightarrow\>0>,
    as <math|t\<rightarrow\>+\<infty\>>, indicating that the
    <math|p<rsub|D><around*|(|x,t|)>> becomes slow varying as <math|t> large
    enough. In other word, the <math|p<rsub|D>> will approximately relaxes
    along <math|r>-axis, and finally this approximation becomes \Pgood
    enough\Q. With this consideration, we can say
    <math|q<rsub|E><around*|(|x|)>=lim<rsub|t\<rightarrow\>+\<infty\>>p<rsub|D><around*|(|x,t|)>>
    again.
  </example>

  The parameterized ODE

  <\equation*>
    <frac|\<mathd\>x<rsup|a>|\<mathd\>t>=f<rsup|a><around*|(|x;\<varphi\>|)>
  </equation*>

  is equivalent to the augmented ODE without
  parameter<math|<frac|\<mathd\>y<rsup|a>|\<mathd\>t>=F<rsup|a><around*|(|y|)>>,
  where <math|y=<around*|(|x,\<varphi\>|)>> and
  <math|F\<assign\><around*|(|f,0|)>>. Now, to solve the problem with the
  parameterized ODE, we simply solve the equivalent one with the augmented
  ODE, using the same method we have proposed. Following the previous
  process, again, we find the distribution <math|p<around*|(|x,t|)>> of the
  Markov chains generated by the SDE to <math|p<rsub|D>> obeys

  <\equation*>
    <frac|\<partial\>p|\<partial\>t><around*|(|y,t|)>=-\<nabla\><rsub|a><around*|[|p<around*|(|y,t|)>
    F<rsup|a><around*|(|y|)>|]>+T \<Delta\>p<around*|(|y,t|)>.
  </equation*>

  Since the <math|\<varphi\>> components of <math|F> vanish, it becomes

  <\equation*>
    <frac|\<partial\>p|\<partial\>t><around*|(|x,\<varphi\>,t|)>=-<frac|\<partial\>|\<partial\>x<rsup|\<alpha\>>><around*|[|p<around*|(|x,\<varphi\>,t|)>
    f<rsup|\<alpha\>><around*|(|x;\<varphi\>|)>|]>+T
    \<Delta\><rsub|x>p<around*|(|x,\<varphi\>,t|)>+T
    \<Delta\><rsub|\<varphi\>>p<around*|(|x,\<varphi\>,t|)>.
  </equation*>

  Thus, as <math|\<partial\>p/\<partial\>t\<rightarrow\>0> and
  <math|p\<rightarrow\>q<rsub|E>>, and as <math|T\<rightarrow\>0>,

  <\equation*>
    <frac|\<partial\>E|\<partial\>x<rsup|\<alpha\>>><around*|(|x,\<varphi\>|)>
    f<rsup|\<alpha\>><around*|(|x;\<varphi\>|)>+\<delta\><rsup|\<alpha\>\<beta\>>
    <frac|\<partial\>E|\<partial\>x<rsup|\<alpha\>>>
    <around*|(|x,\<varphi\>|)> <frac|\<partial\>E|\<partial\>x<rsup|\<beta\>>><around*|(|x,\<varphi\>|)>+\<delta\><rsup|\<alpha\>\<beta\>>
    <frac|\<partial\>E|\<partial\>\<varphi\><rsup|\<alpha\>>>
    <around*|(|x,\<varphi\>|)> <frac|\<partial\>E|\<partial\>\<varphi\><rsup|\<beta\>>><around*|(|x,\<varphi\>|)>=0.
  </equation*>

  We arrive at

  <\equation*>
    <frac|\<partial\>E|\<partial\>x<rsup|\<alpha\>>><around*|(|x,\<varphi\>|)>
    f<rsup|\<alpha\>><around*|(|x;\<varphi\>|)>=-<around*|[|\<delta\><rsup|\<alpha\>\<beta\>>
    <frac|\<partial\>E|\<partial\>x<rsup|\<alpha\>>>
    <around*|(|x,\<varphi\>|)> <frac|\<partial\>E|\<partial\>x<rsup|\<beta\>>><around*|(|x,\<varphi\>|)>+\<delta\><rsup|\<alpha\>\<beta\>>
    <frac|\<partial\>E|\<partial\>\<varphi\><rsup|\<alpha\>>>
    <around*|(|x,\<varphi\>|)> <frac|\<partial\>E|\<partial\>\<varphi\><rsup|\<beta\>>><around*|(|x,\<varphi\>|)>|]>\<leqslant\>0,
  </equation*>

  and equality holds if and only <math|<around*|(|\<partial\>E/\<partial\>x<rsup|a>|)><around*|(|x,\<varphi\>|)>=0>
  and <math|<around*|(|\<partial\>E/\<partial\>\<varphi\><rsup|a>|)><around*|(|x,\<varphi\>|)>=0>.

  <subsection|Implementation>

  Implementation can be found in <shell|src/Lyapunov.jl> in <julia|julia>.
  And tested, found in <shell|test/TestLyapunov.jl>, on damped oscillators
  with and without fixed stiffness factor. Both underdamped and overdamped
  cases are considered. This method, as the results manifestly show, is
  surprisingly effective.

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

  <small|<\proof>
    The trick is introducing a smooth test function, <math|h<around*|(|x|)>>.
    Denote

    <\equation*>
      I<rsub|\<Delta\>t><around*|[|h|]>\<assign\><big|int>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t+\<Delta\>t|)>h<around*|(|x|)>.
    </equation*>

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
  </proof>>

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
    <label|theorem: Brownian Motion>[Brownian Motion]

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
    <math|g<rsup|a b><around*|(|x,t|)>>, and <math|\<Sigma\><rsup|a
    b><around*|(|x,t|)>> on <math|<with|font|cal|M>\<times\>\<bbb-R\>>,
    stochastic differential equations is defined as

    <\equation*>
      \<mathd\>x<rsup|a>=f<rsup|a><around*|(|x,t|)> \<mathd\>t+g<rsup|a
      b><around*|(|x,t|)> \<mathd\>W<rsub|b><around*|(|x,t|)>,
    </equation*>

    where <math|\<mathd\>W<rsub|a><around*|(|x,t|)>> is a Brownian motion
    <reference|theorem: Brownian Motion> with covariance
    <math|\<Sigma\><rsub|a b><around*|(|x,t|)> \<mathd\>t>.
  </definition>

  Consider an ensemble of particles, randomly sampled at an initial time,
  evolving along a SDE <reference|definition: SDE>. By saying \Pensemble\Q,
  we mean that the number of particles has the order of Avogadro's constant,
  s.t. the distribution of the particles can be viewed as smooth. Let
  <math|p<around*|(|x,t|)>> denotes the distribution. Then we have

  <\theorem>
    <label|theorem: Fokker-Planck Equation>[Fokker-Planck Equation]

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|[|f<rsup|a><around*|(|x,t|)>
      p<around*|(|x,t|)>|]>+\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|K<rsup|a
      b><around*|(|x,t|)> p<around*|(|x,t|)>|]>,
    </equation*>

    where <math|K<rsup|a b>\<assign\><around*|(|1/2|)>g<rsup|a
    c><around*|(|x,t|)> g<rsup|b d><around*|(|x,t|)> \<Sigma\><rsub|c
    d><around*|(|x,t|)>>.
  </theorem>

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

  <subsection|Fokker-Planck Equation in Detail>

  Here, we discuss the Fokker-Planck in detail. As a result, some useful
  lemmas are claimed.

  First, notice that Fokker-Planck is linear, thus it can be re-written by
  linear operator

  <\equation*>
    <frac|\<partial\>|\<partial\>t>p<around*|(|x,t|)>=<wide|L|^><rsub|FP><around*|(|x,t|)>
    p<around*|(|x,t|)>,
  </equation*>

  where <math|<wide|L|^><rsub|FP><around*|(|x,t|)>\<assign\>-\<nabla\><rsub|a>f<rsup|a><around*|(|x,t|)>+\<nabla\><rsub|a>\<nabla\><rsub|b>K<rsup|a
  b><around*|(|x,t|)>>. Then, we have

  <\lemma>
    <label|lemma: Adjoint Operator>[Adjoint Operator] The adjoint operator of
    <math|><math|<wide|L|^><rsub|FP><around*|(|x,t|)>> is

    <\equation*>
      <wide|L|^><rsub|FP><rsup|\<dagger\>><around*|(|x,t|)>=f<rsup|a><around*|(|x,t|)>\<nabla\><rsub|a>+K<rsup|a
      b><around*|(|x,t|)>\<nabla\><rsub|a>\<nabla\><rsub|b>.
    </equation*>
  </lemma>

  <small|<\proof>
    Directly, for <math|\<forall\>t>,

    <\align>
      <tformat|<table|<row|<cell|<around*|\<langle\>|h<around*|\||<wide|L|^><rsub|FP>|\|>g|\<rangle\>>=>|<cell|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      h<around*|(|x|)> <wide|L|^><rsub|FP><around*|(|x,t|)>
      g<around*|(|x|)>>>|<row|<cell|=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      h<around*|(|x|)> \<nabla\><rsub|\<alpha\>><around*|[|f<rsup|a><around*|(|x,t|)>g<around*|(|x|)>|]>+<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      h<around*|(|x|)>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|K<rsup|a
      b><around*|(|x,t|)>g<around*|(|x|)>|]>>>|<row|<cell|<around*|{|Integral
      by part|}>=>|<cell|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      g<around*|(|x|)> f<rsup|a><around*|(|x,t|)>\<nabla\><rsub|a>h<around*|(|x|)>+<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>K<rsup|a
      b><around*|(|x,t|)>g<around*|(|x|)>
      \<nabla\><rsub|a>\<nabla\><rsub|b>h<around*|(|x|)>>>|<row|<cell|<around*|{|By
      definition|}>=>|<cell|<around*|\<langle\>|g<around*|\||<wide|L|^><rsub|FP><rsup|\<dagger\>>|\|>h|\<rangle\>>.>>>>
    </align>

    This is held for any <math|h> and <math|g>, we thus find

    <\equation*>
      <wide|L|^><rsub|FP><rsup|\<dagger\>><around*|(|x,t|)>=f<rsup|a><around*|(|x,t|)>\<nabla\><rsub|a>+K<rsup|a
      b><around*|(|x,t|)>\<nabla\><rsub|a>\<nabla\><rsub|b>.
    </equation*>
  </proof>>

  Another useful lemma comes from a general formula.

  <\lemma>
    <label|lemma: Decomposition>[Decompostion] Given
    <math|\<varphi\>\<in\><with|font|cal|C><rsup|1><around*|(|<with|font|cal|M>\<times\>\<bbb-R\>|)>>,
    and

    <\equation*>
      h<rsup|a><around*|(|x,t|)>\<assign\>f<rsup|a><around*|(|x,t|)>+K<rsup|a
      b><around*|(|x,t|)> \<nabla\><rsub|b>\<varphi\><around*|(|x,t|)>-\<nabla\><rsub|b>K<rsup|a
      b><around*|(|x,t|)>,
    </equation*>

    then

    <\equation*>
      \<nabla\><rsub|a><around*|(|h<rsup|a><around*|(|x,t|)>
      \<mathe\><rsup|-\<varphi\><around*|(|x,t|)>>|)>=-<wide|L|^><rsub|FP><around*|(|x,t|)>
      \<mathe\><rsup|-\<varphi\><around*|(|x,t|)>>.
    </equation*>
  </lemma>

  <small|<\proof>
    Because of

    <\align>
      <tformat|<table|<row|<cell|h<rsup|a><around*|(|x,t|)>=>|<cell|f<rsup|a><around*|(|x,t|)>+K<rsup|a
      b><around*|(|x,t|)> \<nabla\><rsub|b>\<varphi\><around*|(|x,t|)>-\<nabla\><rsub|b>K<rsup|a
      b><around*|(|x,t|)>>>|<row|<cell|=>|<cell|f<rsup|a><around*|(|x,t|)>-\<mathe\><rsup|\<varphi\><around*|(|x,t|)>>
      \<nabla\><rsub|b><around*|(|K<rsup|a b><around*|(|x,t|)>
      \<mathe\><rsup|-\<varphi\><around*|(|x,t|)>>|)>,>>>>
    </align>

    we have

    <\align>
      <tformat|<table|<row|<cell|\<nabla\><rsub|a><around*|(|h<rsup|a><around*|(|x,t|)>
      \<mathe\><rsup|-\<varphi\><around*|(|x,t|)>>|)>=>|<cell|\<nabla\><rsub|a><around*|(|f<rsup|a><around*|(|x,t|)>
      \<mathe\><rsup|-\<varphi\><around*|(|x,t|)>>-\<nabla\><rsub|b><around*|(|K<rsup|a
      b><around*|(|x,t|)> \<mathe\><rsup|-\<varphi\><around*|(|x,t|)>>|)>|)>>>|<row|<cell|=>|<cell|-<wide|L|^><rsub|FP><around*|(|x,t|)>
      \<mathe\><rsup|-\<varphi\><around*|(|x,t|)>>.>>>>
    </align>

    Thus proof ends.
  </proof>>

  <subsection|Relaxation>

  Given Fokker-Planck equation <reference|theorem: Fokker-Planck Equation>,
  we claim that any two initial distributions will evolve into one final
  distribution as time <math|t\<rightarrow\>+\<infty\>>. To prove this, we
  simply have to show that, for any two initial distributions, the distance
  between them decreases as time increasing, and finally vanishes in the
  limit. That is, relaxation happens.

  <\theorem>
    <label|theorem: Relaxation>[Relaxation]

    For <math|\<forall\>p<around*|(|x,t|)>,q<around*|(|x,t|)>\<in\><with|font|cal|C><rsup|2><around*|(|<with|font|cal|M>\<times\>\<bbb-R\>|)>>
    as time-dependent distributions obeying the Fokker-Planck equation
    <reference|theorem: Fokker-Planck Equation>, we have

    <\equation*>
      <frac|\<mathd\>|\<mathd\>t> D<rsub|KL><around*|(|p<around*|(|\<cdummy\>,t|)>\|q<around*|(|\<cdummy\>,t|)>|)>\<leqslant\>0,
    </equation*>

    and the equality holds if and only if
    <math|p<around*|(|\<cdummy\>,t|)>=q<around*|(|\<cdummy\>,t|)>> for some
    <math|t>.
  </theorem>

  <\proof>
    TODO
  </proof>

  <subsection|Stationary Solution>

  When the <math|f<rsup|a>> and <math|K<rsup|a b>> of the Fokker-Planck
  equation <reference|theorem: Fokker-Planck Equation> are independent of
  <math|t>, we can consider the stationary solution <math|p<around*|(|x,t|)>>
  such that <math|\<partial\>p/\<partial\>t=0> for
  <math|\<forall\><around*|(|x,t|)>>. In this case, the Fokker-Planck
  equation reduces to

  <\equation*>
    <wide|L|^><rsub|FP><around*|(|x|)> p<around*|(|x|)>=-\<nabla\><rsub|a><around*|[|f<rsup|a><around*|(|x|)>
    p<around*|(|x|)>|]>+\<nabla\><rsub|a>\<nabla\><rsub|b><around*|[|K<rsup|a
    b><around*|(|x|)> p<around*|(|x|)>|]>=0.
  </equation*>

  Notice that, by theorem <reference|theorem: Relaxation>, if there exists
  such a stationary distribution (i.e. a normalized stationary solution),
  then any initial distribution will finally relax to it.

  <\theorem>
    <label|theorem: Stationary Solution>[Stationary Solution]

    For <math|\<forall\>\<varphi\>\<in\><with|font|cal|C><rsup|1><around*|(|<with|font|cal|M>|)>>,
    <math|T\<in\>\<bbb-R\><rsub|+>>, <math|exp<around*|(|-\<varphi\><around*|(|x|)>|)>>
    is a stationary solution of Fokker-Planck if and only if the

    <\equation*>
      h<rsup|a><around*|(|x|)>\<assign\>f<rsup|a><around*|(|x|)>+K<rsup|a
      b><around*|(|x|)> \<nabla\><rsub|b>\<varphi\><around*|(|x|)>-\<nabla\><rsub|b>K<rsup|a
      b><around*|(|x|)>
    </equation*>

    satisfies, for <math|\<forall\>x\<in\><with|font|cal|M>>,

    <\equation*>
      <with|font|cal|D><rsub|h>\<varphi\><around*|(|x|)>=\<nabla\><rsub|a>h<rsup|a><around*|(|x|)>.
    </equation*>
  </theorem>

  <small|<\proof>
    Directly from the lemma <reference|lemma: Decomposition>,
    <math|\<nabla\><rsub|a><around*|(|h<rsup|a><around*|(|x|)>
    \<mathe\><rsup|-\<varphi\><around*|(|x|)>>|)>=<wide|L|^><rsub|FP><around*|(|x|)>
    \<mathe\><rsup|-\<varphi\><around*|(|x|)>>>.
  </proof>>

  In the case <math|K<rsup|a b><around*|(|x|)>=2 g<rsup|a b><around*|(|x|)>>,
  where <math|g<rsup|a b>> is the Riemmann metric, we have
  <math|h<rsup|a>=f<rsup|a>+\<nabla\><rsup|a>\<varphi\>>. Thus,
  <math|f<rsup|a>=-\<nabla\><rsup|a>\<varphi\>+h<rsup|a>>. This is an analogy
  to the Helmholtz's decompostion, except that the <math|h<rsup|a>> may not
  be divergence-free. Indeed, the divergence of <math|h<rsup|a>> is compactly
  related to <math|\<varphi\>>. And when <math|h<rsup|a>> does be
  divergence-free, then the Lie derivative of <math|\<varphi\>> along
  direction <math|h<rsup|a>> vanishes, that is, <math|h<rsup|a>> goes along
  the counterline of <math|\<varphi\>>.
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
    <associate|appendix: Stochastic Dynamics|<tuple|B.2|6>>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|B.2|6>>
    <associate|auto-11|<tuple|B.3|7>>
    <associate|auto-12|<tuple|B.4|7>>
    <associate|auto-13|<tuple|B.5|7>>
    <associate|auto-2|<tuple|1.1|1>>
    <associate|auto-3|<tuple|1.2|1>>
    <associate|auto-4|<tuple|1.3|3>>
    <associate|auto-5|<tuple|1.4|4>>
    <associate|auto-6|<tuple|A|4>>
    <associate|auto-7|<tuple|A.1|4>>
    <associate|auto-8|<tuple|B|5>>
    <associate|auto-9|<tuple|B.1|5>>
    <associate|definition: SDE|<tuple|8|6>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-2|<tuple|2|1>>
    <associate|footnote-3|<tuple|3|1>>
    <associate|footnr-1|<tuple|1|1>>
    <associate|footnr-2|<tuple|2|1>>
    <associate|footnr-3|<tuple|3|1>>
    <associate|lemma: Adjoint Operator|<tuple|10|?>>
    <associate|lemma: Decomposition|<tuple|11|?>>
    <associate|lemma: Kramers\UMoyal Expansion|<tuple|6|4>>
    <associate|theorem: Brownian Motion|<tuple|7|5>>
    <associate|theorem: Fokker-Planck Equation|<tuple|9|6>>
    <associate|theorem: Relaxation|<tuple|12|?>>
    <associate|theorem: Stationary Solution|<tuple|13|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Lyapunov
      Function> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>Definition
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>Construction of Lyapunov
      Function <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <with|par-left|<quote|1tab>|1.3<space|2spc>Parameterized ODE
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|1tab>|1.4<space|2spc>Implementation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      A<space|2spc>Useful Lemmas> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6><vspace|0.5fn>

      <with|par-left|<quote|1tab>|A.1<space|2spc>Kramers\UMoyal Expansion
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      B<space|2spc>Stochastic Dynamics> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8><vspace|0.5fn>

      <with|par-left|<quote|1tab>|B.1<space|2spc>Random Walk
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9>>

      <with|par-left|<quote|1tab>|B.2<space|2spc>Stochastic Dynamics
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|B.3<space|2spc>Fokker-Planck Equation in
      Detail <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|B.4<space|2spc>Relaxation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|<quote|1tab>|B.5<space|2spc>Stationary Distribution
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>
    </associate>
  </collection>
</auxiliary>
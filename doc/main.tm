<TeXmacs|2.1.1>

<style|<tuple|article|pagella-font|padded-paragraphs>>

<\body>
  <\hide-preamble>
    \;

    <assign|axiom-text|<macro|Ansatz>>
  </hide-preamble>

  <section|Lyapunov Function>

  <\notation>
    Overall notations in this section are:

    <\itemize>
      <item><math|<with|font|cal|M>> a manifold, and <math|\<mu\>> its
      measure, e.g. <math|\<mu\><around*|(|x|)>=<sqrt|g<around*|(|x|)>>> if
      <math|<with|font|cal|M>> is Riemannian with metric <math|g<rsub|a b>>;

      <item>if <math|p<around*|(|x|)>> the distribution of random variable
      <math|X>, then

      <\equation*>
        <around*|\<langle\>|f|\<rangle\>><rsub|p>=<around*|\<langle\>|f|\<rangle\>><rsub|X>\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
        p<around*|(|x|)> f<around*|(|x|)>.
      </equation*>

      <item>if <math|D> is a set of samples, then

      <\equation*>
        <around*|\<langle\>|f|\<rangle\>><rsub|D>\<assign\><frac|1|<around*|\||D|\|>><big|sum><rsub|x\<in\>D>f<around*|(|x|)>.
      </equation*>

      <item>given function <math|g>, let <math|f<around*|{|g|}>>, or
      <math|f<rsub|<around*|{|g|}>>>, denote a function constructed out of
      <math|g>, that is,

      <\equation*>
        f<around*|{|\<cdummy\>|}>:<around*|(|<with|font|cal|M>\<rightarrow\>A|)>\<rightarrow\><around*|(|<with|font|cal|M>\<rightarrow\>B|)>.
      </equation*>
    </itemize>
  </notation>

  <subsection|Maximize Entropy Principle>

  First we propose a generic form of stationary distribution that extends the
  Boltzmann distribution by minimizing prior knowledge. Or, say, by
  maximizing information.

  <\theorem>
    <label|theorem: Jaynes's MaxEnt Principle>[Jaynes's MaxEnt Principle]

    Given <math|<around*|{|g<rsub|i><around*|(|x|)>\|i=1,\<ldots\>,N|}>>,
    maximizing entropy with constraints <math|<around*|{|<around*|\<langle\>|g<rsub|i>|\<rangle\>><rsub|X>=0\|i=1,\<ldots\>,N|}>>
    implies

    <\equation*>
      p<around*|(|x;\<lambda\>|)>=<frac|exp<around*|(|<big|sum><rsub|i><rsup|N>\<lambda\><rsub|i>
      g<rsub|i><around*|(|x|)>|)>|Z<around*|(|\<lambda\>|)>>,
    </equation*>

    where

    <\equation*>
      Z<around*|(|\<lambda\>|)>\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      exp<around*|(|<big|sum><rsub|i><rsup|N>\<lambda\><rsub|i>
      g<rsub|i><around*|(|x|)>|)>,
    </equation*>

    and <math|\<lambda\>> solved from

    <\equation*>
      \<nabla\><rsub|a> ln Z<around*|(|\<lambda\>|)>=0.
    </equation*>
  </theorem>

  <small|<\proof>
    The form of <math|p<rsub|\<lambda\>>> can be directly derived from
    variational of the functional

    <\equation*>
      L<around*|[|p|]>\<assign\>-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x|)> ln p<around*|(|x|)>+<big|sum><rsub|i><rsup|N>\<lambda\><rsub|i>
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x|)> g<rsub|i><around*|(|x|)>+\<mu\><around*|(|<big|int><rsub|<with|font|cal|M>>\<mathd\>x
      p<around*|(|x|)>-1|)>
    </equation*>

    Next, we solve <math|\<lambda\>>. It can be solved from constraints
    <math|<around*|\<langle\>|g<rsub|i>|\<rangle\>><rsub|X>=0> for
    <math|i=1,\<ldots\>,N>. Notice the relation

    <\align>
      <tformat|<table|<row|<cell|<frac|\<partial\>ln
      Z|\<partial\>\<lambda\><rsub|i>><around*|(|\<lambda\>|)>=>|<cell|<frac|1|Z<around*|(|\<lambda\>|)>><frac|\<partial\>Z|\<partial\>\<lambda\><rsub|i>><around*|(|\<lambda\>|)>>>|<row|<cell|<around*|{|Z<around*|(|\<lambda\>|)>\<assign\>\<cdots\>|}>=>|<cell|<frac|1|Z<around*|(|\<lambda\>|)>><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      <frac|\<partial\>|\<partial\>\<lambda\><rsub|i>>exp<around*|(|<big|sum><rsub|j><rsup|N>\<lambda\><rsub|j>
      g<rsub|j><around*|(|x|)>|)>>>|<row|<cell|<around*|{|Calculus|}>=>|<cell|<frac|1|Z<around*|(|\<lambda\>|)>><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      exp<around*|(|<big|sum><rsub|j><rsup|N>\<lambda\><rsub|j>
      g<rsub|j><around*|(|x|)>|)> g<rsub|i><around*|(|x|)>>>|<row|<cell|<around*|{|p<around*|(|x;\<lambda\>|)>\<assign\>\<cdots\>|}>=>|<cell|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x;\<lambda\>|)> g<rsub|i><around*|(|x|)>>>|<row|<cell|<around*|{|Definition|}>=>|<cell|<around*|\<langle\>|g<rsub|i>|\<rangle\>><rsub|X>>>|<row|<cell|<around*|{|Constraint|}>=>|<cell|0.>>>>
    </align>

    It shows that the solution of <math|\<lambda\>> stablizes <math|ln
    Z<around*|(|\<lambda\>|)>>.
  </proof>>

  <subsection|Relaxation>

  Next, we illustrate how, during a non-equilibrium process, a distribution
  <math|p> relaxes to its stationary distribution <math|q>, and how this
  process relates to the variational inference. Further, we try to find the
  most generic dynamics that underlies the non-equilibrium to equilibrium
  process, on both macroscopic (distribution) and microscopic (\Pparticle\Q)
  viewpoints.

  First, we shall define what relaxation is, via free energy.

  <\definition>
    [Free Energy]

    Let <math|E<around*|(|x|)>:<with|font|cal|M>\<rightarrow\>\<bbb-R\>>.
    Define stationary distribution

    <\equation*>
      q<rsub|E><around*|(|x|)>\<assign\><frac|exp<around*|(|-E<around*|(|x|)>/T|)>|Z>,
    </equation*>

    where <math|T\<gtr\>0> and <math|Z\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    exp<around*|(|-E<around*|(|x|)>/T|)>>. Given <math|E>, for any
    time-dependent distribution <math|p<around*|(|x,t|)>>, define free energy
    as

    <\equation*>
      F<rsub|E><around*|[|p<around*|(|\<cdummy\>,t|)>|]>\<assign\>T
      \ D<rsub|KL><around*|(|p\<\|\|\>q<rsub|E>|)>-T ln
      Z=T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> ln<frac|p<around*|(|x,t|)>|q<rsub|E><around*|(|x|)>>-T
      ln Z.
    </equation*>

    Or, equivalently,

    <\equation*>
      F<rsub|E><around*|[|p<around*|(|\<cdummy\>,t|)>|]>\<assign\><around*|\<langle\>|E|\<rangle\>><rsub|p<around*|(|\<cdummy\>,t|)>>-T
      H<around*|[|p<around*|(|\<cdummy\>,t|)>|]>,
    </equation*>

    where entropy functional <math| H<around*|[|p<around*|(|\<cdummy\>,t|)>|]>:=<around*|\<langle\>|-ln
    p<around*|(|\<cdummy\>,t|)>|\<rangle\>><rsub|p>>.
  </definition>

  <\definition>
    [Relaxation]

    For a time-dependent distribution <math|p<around*|(|x,t|)>> on
    <math|<with|font|cal|M>>, we say <math|p> relaxes to <math|q<rsub|E>> if
    and only if<strong|> the free energy <math|F<rsub|E><around*|[|p<around*|(|\<cdummy\>,t|)>|]>>
    monotonically decreases to its minimum<math|>, where
    <math|p<around*|(|\<cdummy\>,t|)>=q<rsub|E>>.
  </definition>

  We can visualize this relaxation process by an imaginary ensemble of
  juggling \Pparticles\Q (or \Pbees\Q). Initially, they are arbitrarily
  positioned. This forms a distribution of \Pparticles\Q <math|p>. With some
  underlying dynamics, these \Pparticles\Q moves and finally the distribution
  relaxes, if it can, to a stationary distribution <math|q<rsub|E>>.
  Apparently, the underlying dynamics and the <math|E> are correlated. We
  first provide a way of peeping the underlying dynamics, that is, the
  \Pflux\Q.

  <\theorem>
    [Conservation of \PMass\Q]

    \ For any time-dependent distribution <math|p<around*|(|x,t|)>>, there
    exists a \Pflux\Q <math|f<rsup|a><around*|{|p|}><around*|(|x,t|)>> s.t.

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>+\<nabla\><rsub|a><around*|(|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|)>=0.
    </equation*>
  </theorem>

  What is the dynamics of <math|p> by which any initial <math|p> will finally
  relax to <math|q<rsub|E>>? That is, what is the sufficient (and essential)
  condition of relaxing to <math|q<rsub|E>> for any <math|p>? Because of the
  conservation of \Pmass\Q, the dynamics of <math|p>, i.e.
  <math|\<partial\>p/\<partial\>t>, is determined by a \Pflux\Q,<strong|>
  <math|f<rsup|a>>. Thus, this sufficient (and essential) condition must be
  about the <math|f<rsup|a>>.

  <\lemma>
    Given <math|p> and <math|<around*|(|x,t|)>>, for any
    <math|f<rsup|a><around*|{|p|}><around*|(|x,t|)>>, we can always construct
    a <math|K<rsup|a b><around*|{|p|}><around*|(|x,t|)>> s.t.

    <\equation*>
      f<rsup|a><around*|{|p|}><around*|(|x,t|)>=-K<rsup|a
      b><around*|{|p|}><around*|(|x,t|)> \<nabla\><rsub|b><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}>.
    </equation*>
  </lemma>

  <small|<\proof>
    For any vector <math|f<rsup|a>> and <math|v<rsub|a>>, we can always
    construct a tensor <math|K<rsup|a b>> s.t. <math|f<rsup|a>=K<rsup| a b>
    v<rsub|b>>. Indeed, we can rotate <math|v<rsub|a>> to the direction of
    <math|f<rsup|a>> and then dimension-wise recale to <math|f<rsup|a>>. This
    rotation and dimension-wise rescaling compose the linear transform
    <math|K<rsup|a b>>. Now, letting

    <\equation*>
      v<rsub|a>=-\<nabla\><rsub|a><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}>,
    </equation*>

    we arrive at the conclusion.
  </proof>>

  Now, we claim a sufficient condition of relaxing to <math|q<rsub|E>> for
  any <math|p>.

  <\theorem>
    [Fokker-Planck Equation]

    If the symmetric part of <math|K<rsup|a
    b><around*|{|p|}><around*|(|x,t|)>> is positive definite for any <math|p>
    and <math|<around*|(|x,t|)>>, then any <math|p> evolves by this \Pflux\Q
    will relax to <math|q<rsub|E>>.
  </theorem>

  <small|<\proof>
    Directly

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>F<rsub|E>|\<mathd\>t><around*|[|p<around*|(|\<cdummy\>,t|)>|]>=>|<cell|T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>>>|<row|<cell|<around*|{|Conservation
      of mass|}>=>|<cell|-T <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      \<nabla\><rsub|a><around*|[|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|]><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>.>>>>
    </align>

    Since

    <\equation*>
      \<nabla\><rsub|a><around*|[|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|]><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>=\<nabla\><rsub|a><around*|{|<around*|[|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|]><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>|}>-
      <around*|[|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|]>\<nabla\><rsub|a><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>,
    </equation*>

    we have

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>F<rsub|E>|\<mathd\>t><around*|[|p<around*|(|\<cdummy\>,t|)>|]>=>|<cell|-T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      \<nabla\><rsub|a><around*|[|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|]><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>>>|<row|<cell|=>|<cell|-T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      \<nabla\><rsub|a><around*|{|<around*|[|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|]><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>|}>+T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      <around*|[|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|]>\<nabla\><rsub|a><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>>>|<row|<cell|<around*|{|Divergence
      theorem|}>=>|<cell|-T <big|int><rsub|\<partial\><with|font|cal|M>>\<mathd\>S<rsub|a>
      p<around*|(|x,t|)> f<rsup|a><around*|{|p|}><around*|(|x,t|)><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>+T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> f<rsup|a><around*|{|p|}><around*|(|x,t|)>\<nabla\><rsub|a><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>>>>>
    </align>

    The first term vanishes.<\footnote>
      <with|color|red|To-do: Explain the reason explicitly.>
    </footnote> Then, direct calculus shows

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>F<rsub|E>|\<mathd\>t><around*|[|p<around*|(|\<cdummy\>,t|)>|]>=>|<cell|T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> f<rsup|a><around*|{|p|}><around*|(|x,t|)>\<nabla\><rsub|a><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>>>|<row|<cell|=>|<cell|T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> f<rsup|a><around*|{|p|}><around*|(|x,t|)><around*|[|\<nabla\><rsub|a>ln
      p<around*|(|x,t|)>-\<nabla\><rsub|a>ln
      q<around*|(|x|)>|]>>>|<row|<cell|<around*|{|q<around*|(|x|)>\<assign\>\<cdots\>|}>=>|<cell|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> f<rsup|a><around*|{|p|}><around*|(|x,t|)><around*|[|T
      \<nabla\><rsub|a>ln p<around*|(|x,t|)>+\<nabla\><rsub|a>E<around*|(|x|)>|]>>>|<row|<cell|=>|<cell|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>p<around*|(|x,t|)>
      f<rsup|a><around*|{|p|}><around*|(|x,t|)> \<nabla\><rsub|a><around*|{|T
      ln p<around*|(|x,t|)>+E<around*|(|x|)>|}>.>>>>
    </align>

    By the previous lemma, we have

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>F<rsub|E>|\<mathd\>t><around*|[|p<around*|(|\<cdummy\>,t|)>|]>=>|<cell|<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>p<around*|(|x,t|)>
      f<rsup|a><around*|{|p|}><around*|(|x,t|)> \<nabla\><rsub|a><around*|{|T
      ln p<around*|(|x,t|)>+E<around*|(|x|)>|}>>>|<row|<cell|<around*|{|f<rsup|a>=\<cdots\>|}>=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>p<around*|(|x,t|)>K<rsup|a
      b><around*|{|p|}><around*|(|x,t|)> \<nabla\><rsub|a><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}> \<nabla\><rsub|b><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}>.>>>>
    </align>

    Letting <math|S<rsup|a b>\<assign\><around*|(|K<rsup|a b>+K<rsup|b
    a>|)>/2> and <math|A<rsup|a b>\<assign\><around*|(|K<rsup|a b>-K<rsup|b
    a>|)>/2>, we have <math|K<rsup|a b>=S<rsup|a b>+A<rsup|a b>>, where
    <math|S<rsup|a b>> is symmetric and <math|A<rsup|a b>> anti-symmetric.
    Then,

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>F<rsub|E>|\<mathd\>t><around*|[|p<around*|(|\<cdummy\>,t|)>|]>=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>p<around*|(|x,t|)><around*|[|S<rsup|a
      b><around*|{|p|}><around*|(|x,t|)>+A<rsup|a
      b><around*|{|p|}><around*|(|x,t|)>|]> \<nabla\><rsub|a><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}> \<nabla\><rsub|b><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}>>>|<row|<cell|<around*|{|A<rsup|a
      b>=A<rsup|b a>|}>=>|<cell|-<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>p<around*|(|x,t|)>S<rsup|a
      b><around*|{|p|}><around*|(|x,t|)> \<nabla\><rsub|a><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}> \<nabla\><rsub|b><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}>.>>>>
    </align>

    The condition claims that <math|S<rsup|a
    b><around*|{|p|}><around*|(|x,t|)>> is positive definite for any <math|p>
    and <math|<around*|(|x,t|)>>. Then, the integrad is a positive definite
    quadratic form, being positive if and only if
    <math|\<nabla\><rsub|a><around*|{|T ln
    p<around*|(|x,t|)>+E<around*|(|x|)>|}>\<neq\>0>. Then, we find
    <math|<around*|(|\<mathd\>F<rsub|E>/\<mathd\>t|)><around*|[|p<around*|(|\<cdummy\>,t|)>|]>\<less\>0>
    as long as <math|\<nabla\><rsub|a><around*|{|T ln
    p<around*|(|x,t|)>+E<around*|(|x|)>|}>\<neq\>0> at some <math|x>, i.e.
    <math|p\<neq\>q>, and <math|<around*|(|\<mathd\>F<rsub|E>/\<mathd\>t|)><around*|[|p<around*|(|\<cdummy\>,t|)>|]>=0>
    if and only if <math|\<nabla\><rsub|a><around*|{|T ln
    p<around*|(|x,t|)>+E<around*|(|x|)>|}>=0> for <math|\<forall\>x>, i.e.
    <math|p=q>. Thus proof ends.
  </proof>>

  <\remark>
    [Sufficent but Not Essential]

    However, this is not an essntial condition of relaxing to
    <math|q<rsub|E>> for any <math|p>. Indeed, we proved the integrand of
    <math|<around*|(|\<mathd\>F<rsub|E>/\<mathd\>t|)><around*|[|p<around*|(|\<cdummy\>,t|)>|]>>
    is negative everywhere, which implies the integral, i.e.
    <math|<around*|(|\<mathd\>F<rsub|E>/\<mathd\>t|)><around*|[|p<around*|(|\<cdummy\>,t|)>|]>>,
    is negative. But, we cannot exclude the case where the integrand is not
    negative everywhere, whereas the integral is still negative. During the
    proof, this is the only place that leads to the non-essential-ness, which
    is hard to overcome.
  </remark>

  As the dynamics of distribution is a macroscopic viewpoint, the microscopic
  viewpoint, i.e. the stochastic dynamics of single \Pparticle\Q, is as
  follow.

  <\theorem>
    [Langevin Equation]

    If <math|K<rsup|a b>> is symmetric, then TODO

    <\equation*>
      \<mathd\>x<rsup|a>=K<rsup|a b><around*|(|x,t|)>
      \<nabla\><rsub|b>E<around*|(|x|)> \<mathd\>t+<sqrt|2 T>
      \<mathd\>W<rsup|a><around*|(|x,t|)>,
    </equation*>

    \ where

    <\equation*>
      <around*|\<langle\>|\<mathd\>W<rsup|a><around*|(|x,t|)>
      \<mathd\>W<rsup|b><around*|(|x,t|)>|\<rangle\>><rsub|\<mathd\>W>=K<rsup|a
      b><around*|(|x,t|)>.
    </equation*>
  </theorem>

  <\question>
    Given a Langevin-like equaiton, how can we determine if there exists the
    <math|E>, or the stationary distribution <math|q<rsub|E>>?
  </question>

  <\question>
    Further, if it exists, then how can we reveal it? Precisely, in the case
    <math|T\<rightarrow\>0>, given <math|<around*|(|\<mathd\>x<rsup|a>/\<mathd\>t|)>=h<rsup|a><around*|(|x,t|)>>,
    how can we reconstruct the <math|E> and find a positive definite
    <math|K<rsup|a b>>, s.t. <math|h<rsup|a><around*|(|x|)>=K<rsup|a
    b><around*|(|x,t|)>\<nabla\><rsub|b>E<around*|(|x|)>>?
  </question>

  <subsection|Minimize Free Energy Principle>

  In the real world, there can be two types of variables: ambient and latent.
  The ambient variables are those observed directly, like sensory inputs or
  experimental observations. While the latent are usually more simple and
  basic aspects, like wave-function in QM.

  We formulate the <math|E> as a funciton of
  <math|<around*|(|v,h|)>\<in\><with|font|cal|V>\<times\><with|font|cal|H>>,
  where <math|v>, for visible, represents the ambient and <math|h>, for
  hidden, represents the latent. Then we have

  <\lemma>
    [Conditional Free Energy]

    Given <math|v>, if define

    <\equation*>
      Z<around*|(|v|)>\<assign\><big|int><rsub|<with|font|cal|H>>\<mathd\>h
      exp<around*|(|-E<around*|(|v,h|)>/T|)>,
    </equation*>

    then we have a (conditional) free energy of distribution
    <math|p<around*|(|h|)>>

    <\align>
      <tformat|<table|<row|<cell|F<rsub|E><around*|[|p|]>\<assign\>>|<cell|T
      D<rsub|KL><around*|(|p\<\|\|\>q<rsub|E><around*|(|\<cdummy\>\|v|)>|)>-T
      ln Z<around*|(|v|)>>>|<row|<cell|=>|<cell|<around*|\<langle\>|E<around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|p>-T
      H<around*|[|p|]>.>>>>
    </align>
  </lemma>

  <small|<\proof>
    By definition,

    <\equation*>
      q<rsub|E><around*|(|v,h|)>=<frac|exp<around*|(|-E<around*|(|v,h|)>/T|)>|<big|int><rsub|<with|font|cal|<with|font|cal|V>>>\<mathd\>v<rprime|'>
      <big|int><rsub|<with|font|cal|H>>\<mathd\>h<rprime|'>
      exp<around*|(|-E<around*|(|v<rprime|'>,h<rprime|'>|)>/T|)>>.
    </equation*>

    Interestingly, by integrating over the latent <math|h>

    <\equation*>
      q<rsub|E><around*|(|v|)>=<frac|<big|int><rsub|<with|font|cal|H>>\<mathd\>h
      exp<around*|(|-E<around*|(|v,h|)>/T|)>|<big|int><rsub|<with|font|cal|<with|font|cal|V>>>\<mathd\>v<rprime|'>
      <big|int><rsub|<with|font|cal|H>>\<mathd\>h<rprime|'>
      exp<around*|(|-E<around*|(|v<rprime|'>,h<rprime|'>|)>/T|)>>,
    </equation*>

    we find

    <\equation*>
      q<rsub|E><around*|(|h\|v|)>=<frac|exp<around*|(|-E<around*|(|v,h|)>/T|)>|<big|int><rsub|<with|font|cal|H>>\<mathd\>h<rprime|'>
      exp<around*|(|-E<around*|(|v,h<rprime|'>|)>/T|)>>.
    </equation*>

    So, given <math|v>,

    <\align>
      <tformat|<table|<row|<cell|F<rsub|E><around*|[|p|]>\<assign\>>|<cell|T
      D<rsub|KL><around*|(|p\<\|\|\>q<rsub|E><around*|(|\<cdummy\>\|v|)>|)>-T
      ln Z<around*|(|v|)>>>|<row|<cell|<around*|{|D<rsub|KL>\<assign\>\<cdots\>|}>=>|<cell|T
      <big|int><rsub|<with|font|cal|H>>\<mathd\>h p<around*|(|h|)> ln
      p<around*|(|h|)>-T <big|int><rsub|<with|font|cal|H>>\<mathd\>h
      p<around*|(|h|)> ln q<rsub|E><around*|(|h\|v|)>-T ln
      Z<around*|(|v|)>>>|<row|<cell|<around*|[|H<around*|[|p|]>=\<cdots\>|]>=>|<cell|-T
      H<around*|[|p|]>>>|<row|<cell|<around*|[|q<rsub|E><around*|(|h\|v|)>=\<cdots\>|]>+>|<cell|
      <big|int><rsub|<with|font|cal|H>>\<mathd\>h p<around*|(|h|)>
      E<around*|(|v,h|)>+<big|int><rsub|<with|font|cal|H>>\<mathd\>h
      p<around*|(|h|)><big|int><rsub|<with|font|cal|H>>\<mathd\>h<rprime|'>
      exp<around*|(|-E<around*|(|v,h<rprime|'>|)>/T|)>>>|<row|<cell|->|<cell|T
      ln Z<around*|(|v|)>>>|<row|<cell|<around*|{|<big|int><rsub|<with|font|cal|H>>\<mathd\>h
      p<around*|(|h|)>=1|}>=>|<cell|-T H<around*|[|p|]>+<big|int><rsub|<with|font|cal|H>>\<mathd\>h
      p<around*|(|h|)> E<around*|(|v,h|)>>>|<row|<cell|<around*|{|<around*|\<langle\>|E<around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|p>=\<cdots\>|}>=>|<cell|<around*|\<langle\>|E<around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|p>-T
      H<around*|[|p|]>.>>>>
    </align>

    Thus, proof ends.
  </proof>>

  <\axiom>
    [Minimize Free Energy Principle]

    Let <math|p<around*|(|h|)>> the latent distribution. On one hand, we want
    to locate it to the minimum of <math|E>. That is, given the ambient
    <math|v>, we want to minimize <math|<around*|\<langle\>|E<around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|p>>,
    where we have marginalized the latent. On the other hand, we shall keep
    the minimal prior knowledge on the latent, that is, maximize
    <math|H<around*|[|p|]>>. So, we minimize
    <math|><math|<around*|\<langle\>|E<around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|p>-T
    H<around*|[|p|]>>, where the positive constant <math|T> balances the two
    aspects. This happens to be the (conditional) free energy.
  </axiom>

  <\lemma>
    If <math|E> is in a function family parameterized by
    <math|\<theta\>\<in\>\<bbb-R\><rsup|N>>, then we have

    <\equation*>
      <frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>><around*|{|-T ln
      Z<around*|(|v|)>|}>=<around*|\<langle\>|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>\|v|)>>.
    </equation*>
  </lemma>

  Thus, we propose an EM-like algorithm that minimizes the free energy, as

  <\theorem>
    [Recall-and-Learn]

    To minimize free energy <math|F<rsub|E><around*|[|p|]>>, we have two
    steps:

    <\enumerate-numeric>
      <item>minimize <math|<around*|\<langle\>|E<around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|p>-T
      H<around*|[|p|]>> by Langevin dynamics until relaxation, where
      <math|p=q<rsub|E><around*|(|\<cdummy\>\|v|)>>; then

      <item>minimize <math|-T ln Z<around*|(|v|)>> by gradient descent and
      replacing <math|<around*|\<langle\>|<around*|(|\<partial\>E/\<partial\>\<theta\><rsup|\<alpha\>>|)><around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|<with|color|red|q<rsub|E>><around*|(|\<cdummy\>\|v|)>>\<rightarrow\><around*|\<langle\>|<around*|(|\<partial\>E/\<partial\>\<theta\><rsup|\<alpha\>>|)><around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|<with|color|red|p>>>.
    </enumerate-numeric>

    By repeating these two steps, we get smaller and smaller free energy.
  </theorem>

  For instance, in a brain, the first step can be illustrated as recalling,
  and the second as learning (searching for a more proper memory).

  <subsection|Example: Continuous Hopfield Network>

  Let <math|U<rsup|\<alpha\>\<beta\>>> and <math|I<rsup|\<alpha\>>>
  constants, and <math|L<rsub|v>> and <math|L<rsub|h>> scalar functions.
  Define <math|f<rsub|\<alpha\>><around*|(|h|)>\<assign\>\<partial\>L<rsub|h>/\<partial\>h<rsup|\<alpha\>>>,
  <math|g<rsub|\<alpha\>><around*|(|v|)>\<assign\>\<partial\>L<rsub|v>/\<partial\>v<rsup|\<alpha\>>>.
  Then the deterministic version of continuous Hopfield network is

  <\align>
    <tformat|<table|<row|<cell|<frac|\<mathd\>v<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|U<rsup|\<alpha\>\<beta\>>
    f<rsub|\<beta\>><around*|(|h|)>-v<rsup|\<alpha\>>+I<rsup|\<alpha\>>;>>|<row|<cell|<frac|\<mathd\>h<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|<around*|(|U<rsup|T>|)><rsup|\<alpha\>\<beta\>>
    g<rsub|\<beta\>><around*|(|v|)>-h<rsup|\<alpha\>>,>>>>
  </align>

  where <math|U> describes the strength of connection between neurons, and
  <math|f>, <math|g> the activation functions of latent and ambient,
  respectively. Further, we have the <math|E> constructed as

  <\equation*>
    E<around*|(|v,h|)>=<around*|[|<around*|(|v<rsup|\<alpha\>>-I<rsup|\<alpha\>>|)>
    g<rsub|\<alpha\>><around*|(|v|)>-L<rsub|v><around*|(|v|)>|]>+<around*|[|h<rsup|\<alpha\>>
    f<rsub|\<alpha\>><around*|(|h|)>-L<rsub|h><around*|(|h|)>|]>-U<rsup|\<alpha\>\<beta\>>
    g<rsub|\<alpha\>><around*|(|v|)> f<rsub|\<beta\>><around*|(|h|)>,
  </equation*>

  which implies

  <\equation*>
    K=<matrix|<tformat|<table|<row|<cell|K<rsub|v>>|<cell|0>>|<row|<cell|0>|<cell|K<rsub|h>>>>>>,
  </equation*>

  where <math|K<rsub|v><around*|(|v|)>=\<partial\><rsup|2>L<rsub|v><around*|(|v|)><rsup|-1>>,
  <math|<space|0.6spc>K<rsub|h><around*|(|h|)>=\<partial\><rsup|2>L<rsub|h><around*|(|h|)><rsup|-1>>.
  Then we find the stochastic version, as

  <\align>
    <tformat|<table|<row|<cell|<frac|\<mathd\>v<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|U<rsup|\<alpha\>\<beta\>>
    f<rsub|\<beta\>><around*|(|h|)>-v<rsup|\<alpha\>>+I<rsup|\<alpha\>>+<sqrt|2
    T> \<mathd\>W<rsub|v><rsup|\<alpha\>><around*|(|v|)>;>>|<row|<cell|<frac|\<mathd\>h<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|<around*|(|U<rsup|T>|)><rsup|\<alpha\>\<beta\>>
    g<rsub|\<beta\>><around*|(|v|)>-h<rsup|\<alpha\>>+<sqrt|2 T>
    \<mathd\>W<rsub|h><rsup|\<alpha\>><around*|(|h|)>,>>>>
  </align>

  where

  <\align>
    <tformat|<table|<row|<cell|<around*|\<langle\>|\<mathd\>W<rsup|\<alpha\>><rsub|v><around*|(|v|)>
    \<mathd\>W<rsup|\<alpha\>><rsub|v><around*|(|v|)>|\<rangle\>>=>|<cell|<around*|[|\<partial\><rsup|2>L<rsub|v><around*|(|v|)><rsup|-1>|]><rsup|\<alpha\>\<beta\>>;>>|<row|<cell|<around*|\<langle\>|\<mathd\>W<rsup|\<alpha\>><rsub|h><around*|(|h|)>
    \<mathd\>W<rsup|\<beta\>><rsub|h><around*|(|h|)>|\<rangle\>>=>|<cell|<around*|[|\<partial\><rsup|2>L<rsub|h><around*|(|h|)><rsup|-1>|]><rsup|\<alpha\>\<beta\>>.>>>>
  </align>

  In addition, we find, along the gradient descent trajectory of <math|U>,
  the difference is

  <\equation*>
    \<Delta\>U<rsup|\<alpha\>\<beta\>>\<propto\><around*|\<langle\>|-<frac|\<partial\>E|\<partial\>U<rsup|\<alpha\>\<beta\>>><around*|(|v,h|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>\|v|)>>=<around*|\<langle\>|g<rsub|\<alpha\>><around*|(|v|)>
    f<rsub|\<beta\>><around*|(|h|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>\|v|)>>.
  </equation*>

  Since <math|f> and <math|g> are activation functions, we recover the
  Hebbian rule, that is, neurons that fire together wire together.

  <appendix|Useful Lemmas>

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

  \;
</body>

<\initial>
  <\collection>
    <associate|font-base-size|8>
    <associate|math-font|math-pagella>
    <associate|page-medium|paper>
    <associate|page-screen-margin|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|1.1|1>>
    <associate|auto-3|<tuple|1.2|3>>
    <associate|auto-4|<tuple|1.3|4>>
    <associate|auto-5|<tuple|1.4|?>>
    <associate|auto-6|<tuple|A|?>>
    <associate|footnote-1|<tuple|1|3>>
    <associate|footnr-1|<tuple|1|3>>
    <associate|lemma: Kramers\UMoyal Expansion|<tuple|14|4>>
    <associate|theorem: Jaynes's MaxEnt Principle|<tuple|2|1>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Lyapunov
      Function> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>Relaxation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>In the Real World
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      A<space|2spc>Useful Lemmas> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>
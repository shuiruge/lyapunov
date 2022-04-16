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
        <around*|\<langle\>|f|\<rangle\>><rsub|p>=<around*|\<langle\>|f|\<rangle\>><rsub|X>\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
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

  <section|Relaxation>

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

    where <math|T\<gtr\>0> and <math|Z<rsub|E>\<assign\><big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
    exp<around*|(|-E<around*|(|x|)>/T|)>>. Given <math|E>, for any
    time-dependent distribution <math|p<around*|(|x,t|)>>, define free energy
    as

    <\equation*>
      F<rsub|E><around*|[|p<around*|(|\<cdummy\>,t|)>|]>\<assign\>T
      \ D<rsub|KL><around*|(|p\<\|\|\>q<rsub|E>|)>-T ln
      Z<rsub|E>=T<big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      p<around*|(|x,t|)> ln<frac|p<around*|(|x,t|)>|q<rsub|E><around*|(|x|)>>-T
      ln Z<rsub|E>.
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

  <\lemma>
    [Conservation of \PMass\Q]

    \ For any time-dependent distribution <math|p<around*|(|x,t|)>>, there
    exists a \Pflux\Q <math|f<rsup|a><around*|{|p|}><around*|(|x,t|)>> s.t.

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>+\<nabla\><rsub|a><around*|(|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|)>=0.
    </equation*>
  </lemma>

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
    <label|theorem: Fokker-Planck Equation>[Fokker-Planck Equation]

    If, for any <math|p> and <math|t>, the symmetric part of <math|K<rsup|a
    b><around*|{|p|}><around*|(|x,t|)>> is a.e. positive definite on
    <math|<with|font|cal|M>>, then any <math|p> evolves by this \Pflux\Q will
    relax to <math|q<rsub|E>>.
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
      p<around*|(|x,t|)>|]><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>|}>>>|<row|<cell|+>|<cell|T
      <big|int><rsub|<with|font|cal|M>>\<mathd\>\<mu\><around*|(|x|)>
      <around*|[|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|]>\<nabla\><rsub|a><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>>>|<row|<cell|<around*|[|Divergence
      theorem|]>=>|<cell|-T <big|int><rsub|\<partial\><with|font|cal|M>>\<mathd\>S<rsub|a>
      p<around*|(|x,t|)> f<rsup|a><around*|{|p|}><around*|(|x,t|)><around*|[|ln<frac|p<around*|(|x,t|)>|q<around*|(|x|)>>+1|]>>>|<row|<cell|+>|<cell|T
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
  viewpoint, i.e. the stochastic dynamics of single \Pparticle\Q<\footnote>
    For the conception of stochastic dynamics, c.f. <reference|appendix:
    Stochastic Dynamics>.
  </footnote>, is as follow.

  <\theorem>
    <label|theorem: Stochastic Dynamics>[Stochastic Dynamics]

    If <math|K<rsup|a b>> is symmetric, independent of <math|p> and almost
    everywhere smooth on <with|font|cal|M><\footnote>
      <with|color|red|TODO: Check this.>
    </footnote>, then Fokker-Planck equation is equivalent to the stochastic
    dynamics

    <\equation*>
      \<mathd\>x<rsup|a>=<around*|[|T \<nabla\><rsub|b>K<rsup|a
      b><around*|(|x,t|)>-K<rsup|a b><around*|(|x,t|)>
      \<nabla\><rsub|b>E<around*|(|x|)>|]> \<mathd\>t+<sqrt|2 T>
      \<mathd\>W<rsup|a><around*|(|x,t|)>,
    </equation*>

    where

    <\equation*>
      \<mathd\>W\<sim\><with|font|cal|N><around*|(|0,K<around*|(|x,t|)>
      \<mathd\>t|)>.
    </equation*>
  </theorem>

  <small|<\proof>
    By the lemma <reference|lemma: Macroscopic Landscape>, we find

    <\equation*>
      \<mu\><rsup|a><around*|(|x,t|)>=T \<nabla\><rsub|b>K<rsup|a
      b><around*|(|x,t|)>-K<rsup|a b><around*|(|x,t|)>
      \<nabla\><rsub|b>E<around*|(|x|)>
    </equation*>

    and

    <\equation*>
      \<Sigma\><rsup|a b><around*|(|x,t|)>=2 T K<rsup|a b><around*|(|x,t|)>.
    </equation*>

    Then, directly,

    <\align>
      <tformat|<table|<row|<cell|<frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=>|<cell|-\<nabla\><rsub|a><around*|{|p<around*|(|x,t|)>
      \<mu\><rsup|a><around*|(|x,t|)>|}>+<frac|1|2>
      \<nabla\><rsub|a>\<nabla\><rsub|b><around*|(|p<around*|(|x,t|)>\<Sigma\><rsup|a
      b><around*|(|x,t|)>|)>>>|<row|<cell|=>|<cell|\<nabla\><rsub|a><around*|{|p<around*|(|x,t|)>
      <around*|[|K<rsup|a b><around*|(|x,t|)>
      \<nabla\><rsub|b>E<around*|(|x|)>-T \<nabla\><rsub|b>K<rsup|a
      b><around*|(|x,t|)>|]>|}>+\<nabla\><rsub|a>\<nabla\><rsub|b><around*|{|T
      p<around*|(|x,t|)>K<rsup|a b><around*|(|x,t|)>|}>>>|<row|<cell|<around*|{|Expand|}>=>|<cell|\<nabla\><rsub|a><around*|{|K<rsup|a
      b><around*|(|x,t|)> \<nabla\><rsub|b>E<around*|(|x|)>
      p<around*|(|x,t|)>|}><with|color|<pattern|C:\\Program Files
      (x86)\\TeXmacs\\misc\\patterns\\vintage\\granite-light.png||>|-
      \<nabla\><rsub|a><around*|{|T \<nabla\><rsub|b>K<rsup|a
      b><around*|(|x,t|)> p<around*|(|x,t|)>|}>>>>|<row|<cell|+>|<cell|
      \<nabla\><rsub|a><around*|{|T K<rsup|a
      b><around*|(|x,t|)>\<nabla\><rsub|b>p<around*|(|x,t|)>|}><with|color|<pattern|C:\\Program
      Files (x86)\\TeXmacs\\misc\\patterns\\vintage\\granite-light.png||>|+\<nabla\><rsub|a><around*|{|T
      \<nabla\><rsub|b>K<rsup|a b><around*|(|x,t|)>p<around*|(|x,t|)>|}>>>>|<row|<cell|=>|<cell|\<nabla\><rsub|a><around*|{|K<rsup|a
      b><around*|(|x,t|)> \<nabla\><rsub|b>E<around*|(|x|)>
      p<around*|(|x,t|)>|}>+\<nabla\><rsub|a><around*|{|T K<rsup|a
      b><around*|(|x,t|)>\<nabla\><rsub|b>p<around*|(|x,t|)>|}>,>>>>
    </align>

    which is just the Fokker-Planck equation. Indeed, the Fokker-Planck
    equation <reference|theorem: Fokker-Planck Equation> is

    <\align>
      <tformat|<table|<row|<cell|<frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=>|<cell|-\<nabla\><rsub|a><around*|(|f<rsup|a><around*|{|p|}><around*|(|x,t|)>
      p<around*|(|x,t|)>|)>>>|<row|<cell|<around*|{|f<rsup|a>=\<cdots\>|}>=>|<cell|\<nabla\><rsub|a><around*|(|K<rsup|a
      b><around*|{|p|}><around*|(|x,t|)> \<nabla\><rsub|b><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}>
      p<around*|(|x,t|)>|)>>>|<row|<cell|<around*|{|K<rsup|a b> independent
      of p|}>=>|<cell|\<nabla\><rsub|a><around*|(|K<rsup|a
      b><around*|(|x,t|)> \<nabla\><rsub|b><around*|{|T ln
      p<around*|(|x,t|)>+E<around*|(|x|)>|}>
      p<around*|(|x,t|)>|)>>>|<row|<cell|<around*|{|Expand|}>=>|<cell|\<nabla\><rsub|a><around*|{|K<rsup|a
      b><around*|(|x,t|)> \<nabla\><rsub|b>E<around*|(|x|)>
      p<around*|(|x,t|)>|}>+\<nabla\><rsub|a><around*|{|T K<rsup|a
      b><around*|(|x,t|)> \<nabla\><rsub|b>p<around*|(|x,t|)>|}>,>>>>
    </align>

    exactly the same. Thus proof ends.
  </proof>>

  <\question>
    Given a stochastic dynamics, how can we determine if there exists the
    <math|E>, or the stationary distribution <math|q<rsub|E>>?
  </question>

  <\question>
    Further, if it exists, then how can we reveal it? Precisely, in the case
    <math|T\<rightarrow\>0>, given <math|<around*|(|\<mathd\>x<rsup|a>/\<mathd\>t|)>=h<rsup|a><around*|(|x,t|)>>,
    how can we reconstruct the <math|E> and find a positive definite
    <math|K<rsup|a b>>, s.t. <math|h<rsup|a><around*|(|x|)>=K<rsup|a
    b><around*|(|x,t|)>\<nabla\><rsub|b>E<around*|(|x|)>>?
  </question>

  The scalar function <math|E> is called <em|Lyapunov function>. Given an
  autonomous dynamical system<\footnote>
    That is, ordinary differential equations that do not explicitly depend on
    time. The word autonomous means independent of time.
  </footnote>, along the phase trajectory, Lyapunov function will
  monomotically decrease. So, it reflects the stability of the dynamical
  system. Next, we investigate, for any autonomous dynamical system, if
  there's a Lynapunov function, s.t.

  <\equation*>
    <frac|\<mathd\>x<rsup|a>|\<mathd\>t>=f<rsup|a><around*|(|x|)>=K<rsup|a
    b><around*|(|x|)> \<nabla\><rsub|b>E<around*|(|x|)>,
  </equation*>

  Notice that, this is an autonomous stocastical dynamics with
  <math|T\<rightarrow\>0>.

  <\definition>
    [Phase Tape]

    Given an autonomous dynamical system <math|\<mathd\>x<rsup|a>/dt=f<rsup|a><around*|(|x|)>>
    on <math|<with|font|cal|M>> and a hypersurface <math|<with|font|cal|S>>
    with <math|dim<around*|(|<with|font|cal|S>|)>\<less\>dim<around*|(|<with|font|cal|M>|)>>.
    A phase tape <math|PT<around*|(|<with|font|cal|S>,t|)>\<assign\><around*|{|x<rsup|a><around*|(|s|)>:s\<in\><around*|[|0,t|]>,x<rsup|a><around*|(|0|)>\<in\><with|font|cal|S>|}>>.
  </definition>

  <\theorem>
    [Existance of Lyapunov Function]

    If there's no limit cycle, then there exists a Lyapunov function,
    constructed as follow. First\ 
  </theorem>

  <section|Ambient & Latent Variables>

  In the real world, there can be two types of variables: ambient and latent.
  The ambient variables are those observed directly, like sensory inputs or
  experimental observations. While the latent are usually more simple and
  basic aspects, like wave-function in QM.

  We formulate the <math|E> as a funciton of
  <math|<around*|(|v,h|)>\<in\><with|font|cal|V>\<times\><with|font|cal|H>>,
  where <math|v>, for visible, represents the ambient and <math|h>, for
  hidden, represents the latent. Then, we extend the free energy to

  <\definition>
    [Conditional Free Energy]

    Given <math|v>, if define

    <\equation*>
      Z<rsub|E><around*|(|v|)>\<assign\><big|int><rsub|<with|font|cal|H>>\<mathd\>\<mu\><around*|(|h|)>
      exp<around*|(|-E<around*|(|v,h|)>/T|)>,
    </equation*>

    then we have a conditional free energy of distribution
    <math|p<around*|(|h|)>> defined as

    <\equation*>
      F<rsub|E><around*|[|p\|v|]>\<assign\>T
      D<rsub|KL><around*|(|p\<\|\|\>q<rsub|E><around*|(|\<cdummy\>\|v|)>|)>-T
      ln Z<rsub|E><around*|(|v|)>.
    </equation*>
  </definition>

  Directly, we have

  <\lemma>
    <label|lemma: Conditional Distribution>

    <\equation*>
      q<rsub|E><around*|(|h\|v|)>=<frac|exp<around*|(|-E<around*|(|v,h|)>/T|)>|<big|int><rsub|<with|font|cal|H>>\<mathd\>\<mu\><around*|(|h|)>
      exp<around*|(|-E<around*|(|v,h|)>/T|)>>,
    </equation*>

    which is simply the <math|q<rsub|E>> with the <math|v> in the
    <math|E<around*|(|v,h|)>> fixed.
  </lemma>

  Thus,

  <\theorem>
    <\equation*>
      F<rsub|E><around*|[|p\|v|]>=<around*|\<langle\>|E<around*|(|v,\<cdummy\>|)>|\<rangle\>><rsub|p>-T
      H<around*|[|p|]>.
    </equation*>
  </theorem>

  <section|Minimize Free Energy Principle>

  If <math|E> is in a function family parameterized by
  <math|\<theta\>\<in\>\<bbb-R\><rsup|N>>, denoted as
  <math|E<around*|(|x;\<theta\>|)>>, then we want to find the most generic
  distribution <math|q<rsub|E>> in the function family of <math|E> s.t. the
  expection <math|<around*|\<langle\>|E<around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>>
  is minimized. For instance, given ambient <math|v>, we want to locates
  <math|v> on the minimum of <math|E>, that is
  <math|<around*|\<langle\>|E<around*|(|v,\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>\|v;\<theta\>|)>>>
  (c.f. lemma <reference|lemma: Conditional Distribution>).

  On one hand, we want to minimize <math|<around*|\<langle\>|E<around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>>;
  on the other hand, we shall keep the minimal prior knowledge on
  <math|q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>, that is, maximize
  <math|H<around*|[|q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>|]>>. So, we
  find the <math|\<theta\>> that minimizes
  <math|<around*|\<langle\>|E<around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>-T
  H<around*|[|q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>|]>>, where the
  positive constant <math|T> balances the two aspects. This happens to be the
  free energy.

  Next, we propose an algorithm that establishes the free energy
  minimization. First, notice the relation

  <\lemma>
    <\equation*>
      <frac|\<partial\>|\<partial\>\<theta\><rsup|\<alpha\>>><around*|{|-T ln
      Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>|}>=<around*|\<langle\>|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>.
    </equation*>
  </lemma>

  So, we have an EM-like algorithm, as

  <with|theorem-text|<macro|Algorithm>|<\theorem>
    <label|algorithm: RL>[Recall and Learn (RL)]

    To minimize free energy <math|F<rsub|E><around*|[|p|]>>, we have two
    steps:

    <\enumerate-numeric>
      <item>minimize <math|<around*|\<langle\>|E<around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|p>-T
      H<around*|[|p|]>> by the stochastic dynamics until relaxation, where
      <math|p=q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>; then

      <item>minimize <math|-T ln Z<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>
      by gradient descent and replacing <math|<around*|\<langle\>|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|<with|color|blue|q<rsub|E<around*|(|\<cdummy\>;\<theta\>|)>>>>\<rightarrow\><around*|\<langle\>|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<cdummy\>;\<theta\>|)>|\<rangle\>><rsub|<with|color|blue|p>>>.
    </enumerate-numeric>

    By repeating these two steps, we get smaller and smaller free energy.
  </theorem>>

  For instance, in a brain, the first step can be illustrated as recalling,
  and the second as learning (searching for a more proper memory, or code of
  information). So we call this algorithm <em|recall and learn>.

  During the optimization, the first term minimizes the expectation of
  <math|E<around*|(|\<cdummy\>;\<theta\>|)>>, while the second term smoothes
  <math|E<around*|(|\<cdummy\>;\<theta\>|)>>. Since the
  <math|q<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>> is invariant for
  <math|E<around*|(|x;\<theta\>|)>\<rightarrow\>E<around*|(|x;\<theta\>|)>+Const>,
  we shall eliminate this symmetry by re-defining

  <\equation*>
    E<around*|(|x;\<theta\>|)>\<rightarrow\>E<around*|(|x;\<theta\>|)>-E<around*|(|x<rsub|\<star\>>;\<theta\>|)>,
  </equation*>

  for any <math|x<rsub|\<star\>>\<in\><with|font|cal|M>> given.

  <section|Example: Continuous Hopfield Network>

  Here, we provide a biological inspired example, for illustrating both the
  stochastic dynamics <reference|theorem: Stochastic Dynamics> and the RL
  algorithm <reference|algorithm: RL>.

  <\definition>
    [Continuous Hopfield Network]

    Let <math|U<rsup|\<alpha\>\<beta\>>> and <math|I<rsup|\<alpha\>>>
    constants, and <math|L<rsub|v><around*|(|v|)>> and
    <math|L<rsub|h><around*|(|h|)>> scalar functions. Define
    <math|f<rsub|\<alpha\>>\<assign\>\<partial\><rsub|\<alpha\>>L<rsub|h>>,
    <math|g<rsub|\<alpha\>>\<assign\>\<partial\><rsub|\<alpha\>>L<rsub|v>>.
    Then the dynamics of continuous Hopfield network is defined as<\footnote>
      Originally illustrated in <hlink|Large Associative Memory Problem in
      Neurobiology and Machine Learning|https://arxiv.org/abs/2008.06996>,
      Dmitry Krotov and<nbsp>John Hopfield, 2020.
    </footnote>

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>v<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|U<rsup|\<alpha\>\<beta\>>
      f<rsub|\<beta\>><around*|(|h|)>-v<rsup|\<alpha\>>+I<rsup|\<alpha\>>;>>|<row|<cell|<frac|\<mathd\>h<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|U<rsup|\<beta\>\<alpha\>>
      g<rsub|\<beta\>><around*|(|v|)>-h<rsup|\<alpha\>>,>>>>
    </align>

    where <math|U> describes the strength of connection between neurons, and
    <math|f>, <math|g> the activation functions of latent and ambient,
    respectively. Further, we have the <math|E> constructed as

    <\equation*>
      E<around*|(|v,h|)>=<around*|[|<around*|(|v<rsup|\<alpha\>>-I<rsup|\<alpha\>>|)>
      g<rsub|\<alpha\>><around*|(|v|)>-L<rsub|v><around*|(|v|)>|]>+<around*|[|h<rsup|\<alpha\>>
      f<rsub|\<alpha\>><around*|(|h|)>-L<rsub|h><around*|(|h|)>|]>-U<rsub|\<alpha\>\<beta\>>
      g<rsup|\<alpha\>><around*|(|v|)> f<rsup|\<beta\>><around*|(|h|)>.
    </equation*>
  </definition>

  Next, we convert this deterministic dynamics to its stochastic version.

  <\theorem>
    If <math|f=\<partial\>L<rsub|h>> and <math|g=\<partial\>L<rsub|v>> are
    linear functions, and the Hessian matrix of <math|L<rsub|v>> and
    <math|L<rsub|h>> are positive definite, then the stochastic dynamics of
    the continuous Hopfield network is

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>v<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|K<rsub|v><rsup|\<alpha\>\<beta\>>
      <around*|[|U<rsub|\<beta\>\<gamma\>>
      f<rsup|\<gamma\>><around*|(|h|)>-v<rsub|\<beta\>>+I<rsub|\<beta\>>|]>+<sqrt|2
      T> \<mathd\>W<rsub|v><rsup|\<alpha\>>;>>|<row|<cell|<frac|\<mathd\>h<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|K<rsup|\<alpha\>\<beta\>><rsub|h>
      <around*|[|U<rsub|\<gamma\>\<beta\>>
      g<rsup|\<gamma\>><around*|(|v|)>-h<rsup|\<beta\>>|]>+<sqrt|2 T>
      \<mathd\>W<rsub|h><rsup|\<alpha\>>,>>>>
    </align>

    where <math|K<rsub|v>\<assign\><around*|[|\<partial\><rsup|2>L<rsub|v><around*|(|v|)>|]><rsup|-1>>
    and <math|K<rsub|h>\<assign\><around*|[|\<partial\><rsup|2>L<rsub|h><around*|(|h|)>|]><rsup|-1>>
    are constant matrices.<\footnote>
      Here the <math|\<partial\><rsup|2>L> is the Hessian matrix, and
      <math|<around*|[|\<partial\><rsup|2>L|]><rsup|-1>> the inverse matrix.
    </footnote>
  </theorem>

  <small|<\proof>
    Directly, we have

    <\align>
      <tformat|<table|<row|<cell|<frac|\<partial\>E|\<partial\>v<rsup|\<alpha\>>><around*|(|v,h|)>=>|<cell|<with|color|<pattern|C:\\Program
      Files (x86)\\TeXmacs\\misc\\patterns\\vintage\\granite-light.png||>|g<rsub|\<alpha\>><around*|(|v|)>>+<around*|(|v<rsup|\<beta\>>-I<rsup|\<beta\>>|)>
      <frac|\<partial\>g<rsub|\<beta\>>|\<partial\>v<rsup|\<alpha\>>><around*|(|v|)><with|color|<pattern|C:\\Program
      Files (x86)\\TeXmacs\\misc\\patterns\\vintage\\granite-light.png||>|-<frac|\<partial\>L<rsub|v>|\<partial\>v<rsup|\<alpha\>>><around*|(|v|)>>-U<rsup|\<beta\>\<gamma\>>
      f<rsub|\<gamma\>><around*|(|h|)> <frac|\<partial\>g<rsub|\<beta\>>|\<partial\>v<rsup|\<alpha\>>><around*|(|v|)>>>|<row|<cell|<around*|{|g<rsub|\<alpha\>>=<frac|\<partial\>L<rsub|v>|\<partial\>v<rsup|\<alpha\>>>|}>=>|<cell|-<around*|[|U<rsup|\<beta\>\<gamma\>>
      f<rsub|\<gamma\>><around*|(|h|)>+v<rsup|\<beta\>>-I<rsup|\<beta\>>|]>
      <frac|\<partial\>g<rsub|\<beta\>>|\<partial\>v<rsup|\<alpha\>>><around*|(|v|)>;>>>>
    </align>

    and

    <\align>
      <tformat|<table|<row|<cell|<frac|\<partial\>E|\<partial\>h<rsup|\<alpha\>>><around*|(|v,h|)>=>|<cell|<with|color|<pattern|C:\\Program
      Files (x86)\\TeXmacs\\misc\\patterns\\vintage\\granite-light.png||>|f<rsub|\<alpha\>><around*|(|h|)>>+h<rsup|\<beta\>>
      <frac|\<partial\>f<rsub|\<beta\>>|\<partial\>h<rsup|\<alpha\>>><around*|(|h|)><with|color|<pattern|C:\\Program
      Files (x86)\\TeXmacs\\misc\\patterns\\vintage\\granite-light.png||>|-<frac|\<partial\>L<rsub|h>|\<partial\>h<rsup|\<alpha\>>><around*|(|h|)>>-U<rsup|\<gamma\>\<beta\>>
      g<rsub|\<gamma\>><around*|(|v|)> <frac|\<partial\>f<rsub|\<beta\>>|\<partial\>h<rsup|\<alpha\>>><around*|(|h|)>>>|<row|<cell|<around*|{|f<rsub|\<alpha\>>=<frac|\<partial\>L<rsub|h>|\<partial\>h<rsup|\<alpha\>>>|}>=>|<cell|-<around*|[|U<rsup|\<gamma\>\<beta\>>
      g<rsub|\<gamma\>><around*|(|v|)>+h<rsup|\<beta\>>|]>
      <frac|\<partial\>f<rsub|\<beta\>>|\<partial\>h<rsup|\<alpha\>>><around*|(|h|)>.>>>>
    </align>

    If <math|f> and <math|g> are linear functions, then
    <math|\<partial\><rsup|2>f> and <math|\<partial\><rsup|2>g> vanish. Thus,
    comparing with <reference|theorem: Stochastic Dynamics>, we find
    <math|K<rsub|v>=\<partial\><rsup|2>L<rsub|v><around*|(|v|)><rsup|-1>>,
    <math|K<rsub|h>=\<partial\><rsup|2>L<rsub|h><around*|(|h|)><rsup|-1>>,
    and <math|\<nabla\>K=0>. That is,

    <\align>
      <tformat|<table|<row|<cell|<frac|\<mathd\>v<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|K<rsup|\<alpha\>\<beta\>><rsub|v>
      <around*|[|U<rsub|\<beta\>\<gamma\>>
      f<rsup|\<gamma\>><around*|(|h|)>-v<rsub|\<beta\>>+I<rsub|\<beta\>>|]>+<sqrt|2
      T> \<mathd\>W<rsub|v><rsup|\<alpha\>>;>>|<row|<cell|<frac|\<mathd\>h<rsup|\<alpha\>>|\<mathd\>t>=>|<cell|K<rsup|\<alpha\>\<beta\>><rsub|h>
      <around*|[|U<rsub|\<gamma\>\<beta\>>
      g<rsup|\<gamma\>><around*|(|v|)>-h<rsup|\<beta\>>|]>+<sqrt|2 T>
      \<mathd\>W<rsub|h><rsup|\<alpha\>>,>>>>
    </align>

    Thus proof ends.
  </proof>>

  <\remark>
    [Hebbian Rule]

    In addition, we find, along the gradient descent trajectory of <math|U>,
    the difference is

    <\equation*>
      \<Delta\>U<rsup|\<alpha\>\<beta\>>\<propto\><around*|\<langle\>|-<frac|\<partial\>E|\<partial\>U<rsub|\<alpha\>\<beta\>>><around*|(|v,h;U|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>\|v|)>>=<around*|\<langle\>|g<rsup|\<alpha\>><around*|(|v|)>
      f<rsup|\<alpha\>><around*|(|h|)>|\<rangle\>><rsub|q<rsub|E><around*|(|\<cdummy\>\|v|)>>.
    </equation*>

    Since <math|f> and <math|g> are activation functions, we recover the
    Hebbian rule, that is, neurons that fire together wire together.
  </remark>

  <\remark>
    [Simplified Brain]

    This model can be viewed as a simplified model of brain. Indeed, in the
    equation (1) of Dehaene et al. (2003)<\footnote>
      <hlink|A neuronal network model linking subjective reports and
      objective physiological data during conscious
      perception|https://www.pnas.org/content/100/14/8520>, Stanislas
      Dehaene, Claire Sergent, and Jean-Pierre Changeux, 2003.
    </footnote>, when the <math|V> are limited to a small region, and the
    <math|\<tau\>>s are large, then the coefficients, i.e. the <math|m>s and
    <math|h>s, can be regarded as constants. The equation (1), thus, reduces
    to the continuous Hopfield network.
  </remark>

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

  <appendix|Stochastic Dynamics>

  <subsection|Random Walk>

  Given <math|\<forall\>x\<in\><with|font|cal|M>> and any time <math|t>,
  consider a series of i.i.d. random variables (random walks),

  <\equation*>
    <around*|{|\<varepsilon\><rsub|i><rsup|a>:i=1\<ldots\>n<around*|(|t|)>|}>,
  </equation*>

  where, for <math|\<forall\>i>, <math|\<varepsilon\><rsup|a><rsub|i>\<sim\>P>
  for some distribution <math|P>, with the mean <math|0> and covariance
  <math|\<Sigma\><around*|(|x,t|)>>, and the walk steps

  <\equation*>
    n<around*|(|t|)>=<big|int><rsub|0><rsup|t>\<mathd\>\<tau\>
    <frac|\<mathd\>n|\<mathd\>t><around*|(|x<around*|(|\<tau\>|)>,\<tau\>|)>.
  </equation*>

  For any time interval <math|\<Delta\>t>, this series of random walks leads
  to a difference

  <\equation*>
    \<Delta\>x<rsup|a>\<assign\><big|sum><rsub|i=n<around*|(|t|)>><rsup|n<around*|(|t+\<Delta\>t|)>>\<varepsilon\><rsup|a><rsub|i>.
  </equation*>

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
  steps per unit time, then, by central limit theorem (for multi-dimension),

  <\equation*>
    \<Delta\>x<rsup|a>=\<Delta\>W<rsup|a>+\<omicron\><around*|(|<frac|\<mathd\>n|\<mathd\>t><around*|(|x,t|)>|)>,
  </equation*>

  where

  <\equation*>
    \<Delta\>W<rsup|a>\<sim\><with|font|cal|N><around*|(|0,\<Delta\>t
    \<Sigma\><rsup|a b><around*|(|x,t|)>|)>.
  </equation*>

  <subsection|Stochastic Dynamics><label|appendix: Stochastic Dynamics>

  A stochastic dynamics is defined by two parts. The first is deterministic,
  and the second is a random walk. Precisely,

  <\definition>
    [Stochastic Dynamics]

    Given <math|\<mu\><rsup|a><around*|(|x,t|)>> and <math|\<Sigma\><rsup|a
    b><around*|(|x,t|)>> on <math|<with|font|cal|M>\<times\>\<bbb-R\>>,

    <\equation*>
      \<mathd\>x<rsup|a>=\<mu\><rsup|a><around*|(|x,t|)>
      \<mathd\>t+\<mathd\>W<rsup|a><around*|(|x,t|)>,
    </equation*>

    where <math|\<mathd\>W<rsup|a><around*|(|x,t|)>> is a random walk with
    covariance <math|\<Sigma\><rsup|a b><around*|(|x,t|)>>.
  </definition>

  Consider an ensemble of particles, each obeys this stochastic dynamics.
  This ensemble will form a distribution, evolving with time <math|t>, say
  <math|p<around*|(|t|)>>. The equation of this evolution is

  <\lemma>
    <label|lemma: Macroscopic Landscape>[Macroscopic Landscape]

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|t|)>=-\<nabla\><rsub|a><around*|{|p<around*|(|x,t|)>
      \<mu\><rsup|a><around*|(|x,t|)>|}>+<frac|1|2>
      \<nabla\><rsub|a>\<nabla\><rsub|b><around*|{|p<around*|(|x,t|)>\<Sigma\><rsup|a
      b><around*|(|x,t|)>|}>.
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
      <frac|p<around*|(|x,t+\<Delta\>t|)>-p<around*|(|x,t|)>|\<Delta\>t>=-\<nabla\><rsub|a><around*|{|p<around*|(|x,t|)>
      \<mu\><rsup|a><around*|(|x,t|)>|}>+<frac|1|2>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|{|p<around*|(|x,t|)>\<Sigma\><rsup|a
      b><around*|(|x,t|)>|}>+o<around*|(|1|)>.
    </equation*>

    Letting <math|\<Delta\>t\<rightarrow\>0>, we find

    <\equation*>
      <frac|\<partial\>p|\<partial\>t><around*|(|x,t|)>=-\<nabla\><rsub|a><around*|{|p<around*|(|x,t|)>
      \<mu\><rsup|a><around*|(|x,t|)>|}>+<frac|1|2>\<nabla\><rsub|a>\<nabla\><rsub|b><around*|{|p<around*|(|x,t|)>\<Sigma\><rsup|a
      b><around*|(|x,t|)>|}>.
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
    <associate|algorithm: RL|<tuple|15|4>>
    <associate|appendix: Stochastic Dynamics|<tuple|B.2|7>>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|5|8>>
    <associate|auto-11|<tuple|5.1|8>>
    <associate|auto-12|<tuple|5.2|8>>
    <associate|auto-2|<tuple|1|1>>
    <associate|auto-3|<tuple|2|4>>
    <associate|auto-4|<tuple|3|4>>
    <associate|auto-5|<tuple|4|5>>
    <associate|auto-6|<tuple|A|6>>
    <associate|auto-7|<tuple|B|7>>
    <associate|auto-8|<tuple|B.1|7>>
    <associate|auto-9|<tuple|B.2|7>>
    <associate|footnote-1|<tuple|1|2>>
    <associate|footnote-10|<tuple|10|8>>
    <associate|footnote-2|<tuple|2|3>>
    <associate|footnote-3|<tuple|3|3>>
    <associate|footnote-4|<tuple|4|3>>
    <associate|footnote-5|<tuple|5|5>>
    <associate|footnote-6|<tuple|6|5>>
    <associate|footnote-7|<tuple|7|5>>
    <associate|footnote-8|<tuple|8|5>>
    <associate|footnote-9|<tuple|9|6>>
    <associate|footnr-1|<tuple|1|2>>
    <associate|footnr-10|<tuple|10|8>>
    <associate|footnr-2|<tuple|2|3>>
    <associate|footnr-3|<tuple|3|3>>
    <associate|footnr-4|<tuple|4|3>>
    <associate|footnr-5|<tuple|5|5>>
    <associate|footnr-6|<tuple|6|5>>
    <associate|footnr-7|<tuple|7|5>>
    <associate|footnr-8|<tuple|8|5>>
    <associate|footnr-9|<tuple|9|6>>
    <associate|lemma: Conditional Distribution|<tuple|12|4>>
    <associate|lemma: Kramers\UMoyal Expansion|<tuple|20|6>>
    <associate|lemma: Macroscopic Landscape|<tuple|22|7>>
    <associate|theorem: Fokker-Planck Equation|<tuple|6|2>>
    <associate|theorem: Stochastic Dynamics|<tuple|8|3>>
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

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Ambient
      & Latent Variables> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Minimize
      Free Energy Principle> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Example:
      Continuous Hopfield Network> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      A<space|2spc>Useful Lemmas> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      B<space|2spc>Stochastic Dynamics> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.5fn>

      <with|par-left|<quote|1tab>|B.1<space|2spc>Random Walk
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <with|par-left|<quote|1tab>|B.2<space|2spc>Stochastic Dynamics
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|5<space|2spc>Drafts>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10><vspace|0.5fn>

      <with|par-left|<quote|1tab>|5.1<space|2spc>Trial 1
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|5.2<space|2spc>Trial 2
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>
    </associate>
  </collection>
</auxiliary>
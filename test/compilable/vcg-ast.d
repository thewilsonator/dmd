module vcg;
// REQUIRED_ARGS: -vcg-ast -o-
// PERMUTE_ARGS:
// POST_SCRIPT: compilable/extra-files/vcg-ast-postscript.sh

template Seq(A...)
{
    alias Seq = A;
}

auto a = Seq!(1,2,3);


template R(T)
{
  struct _R { T elem; }
}

typeof(R!int._R.elem) x;


static foreach(enum i; 0..3)
{
    mixin("int a" ~ i.stringof ~ " = 1;");
}

void foo()
{
    static foreach(enum i; 0..3)
    {
        mixin("int a" ~ i.stringof ~ " = 1;");
    }
}

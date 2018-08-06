/*
TEST_OUTPUT:
---
fail_compilation/diptemplateconstraint(31): Error: template `foo` cannot deduce function from argument types !()(), candidates are:
fail_compilation/diptemplateconstraint.d(17):        foo()()
        not satisfied: zero
            satisfied: `1`
satisfied: one
fail_compilation/diptemplateconstraint.d(24):        foo()()
        not satisfied: zero
        not satisfied: `0`
            satisfied: five
            satisfied: `4`
---
*/

void foo()()
if (0, "zero")
if (1)
if (1, "one")
{
}

void foo()()
if (0, "zero")
if (0)
if (5, "fi"~"ve")
if (4)
{
}
void main()
{
    foo();
}

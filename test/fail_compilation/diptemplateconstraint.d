/*
TEST_OUTPUT:
---
fail_compilation/diptemplateconstraint(19): Error: template `foo` cannot deduce function from argument types !()(), candidates are:
fail_compilation/diptemplateconstraint(11):        onlineapp.bar()()
            satisfied: `1`
        not satisfied: zero
---
*/

void foo()()
if (1)
if (0, "zero")
{
}

void main()
{
    foo();
}

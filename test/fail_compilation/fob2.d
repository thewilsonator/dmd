/* Testing Ownership/Borrowing system
REQUIRED_ARGS: -preview=dip1021
 */

int* malloc();
void free(int*);

/* TEST_OUTPUT:
---
fail_compilation/fob2.d(110): Error: variable `fob2.foo1.b1` has undefined state and cannot be read
fail_compilation/fob2.d(103): Error: variable `fob2.foo1.p` is left dangling at return
---
*/

#line 100

@live int foo1(int i)
{
    int* p = malloc();
    scope const(int)* b1, b2;
    if (i)
        b1 = p;
    else
        b2 = p;
    *p = 3;
    return *b1;
}

/* TEST_OUTPUT:
---
fail_compilation/fob2.d(203): Error: variable `fob2.zoo2.p` is passed as Owner more than once
fail_compilation/fob2.d(202): Error: variable `fob2.zoo2.p` is left dangling at return
---
*/

#line 200

@live void zoo2() {
    int* p = malloc();
    foo2(p, p + 1);
}

@live void foo2( scope int* p, scope int* q );

/* TEST_OUTPUT:
---
fail_compilation/fob2.d(303): Error: variable `fob2.foo3.b` is left dangling at return
---
*/

#line 300

@live void foo3()
{
    scope int* b = malloc();
}

/* TEST_OUTPUT:
---
fail_compilation/fob2.d(427): Error: variable `fob2.test43.p` is both Owner and Undefined
fail_compilation/fob2.d(429): Error: variable `fob2.test43.p` has undefined state and cannot be read
fail_compilation/fob2.d(429): Error: variable `fob2.test43.p` is not Owner, cannot consume its value
fail_compilation/fob2.d(432): Error: variable `fob2.test43.p` has undefined state and cannot be read
fail_compilation/fob2.d(432): Error: variable `fob2.test43.p` is not Owner, cannot consume its value
---
*/
#line 400


bool f();

@live void test41(int* p, int i)
{
    for (; f(); ++i)
    {
        --i;
        free(p);
        p = null;
    }
    free(p);
}

@live void test42(int* p, int i)
{
    for (; f(); ++i)
    {
        --i;
    }
    free(p);
}


@live void test43(int* p, int i)
{
    for (; f(); ++i)
    {
        free(p);
        --i;
    }
    free(p);
}

/* TEST_OUTPUT:
---
fail_compilation/fob2.d(506): Error: variable `fob2.test51.p` has undefined state and cannot be read
fail_compilation/fob2.d(515): Error: variable `fob2.test52.p` has undefined state and cannot be read
---
*/

// https://issues.dlang.org/show_bug.cgi?id=20747

#line 500

@live test51()
{
    int x;
    scope p = &x;
    x = 3;
    *p = 4;
}


@live void test52()
{
    int x = 5;
    auto p = &x;
    auto q = &x;
    *p = 3;
}


@live void test53()
{
    scope int x;
    scope int y;
    y = x;
    x = 3;
    y = 4;
}

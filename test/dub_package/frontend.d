#!/usr/bin/env dub
/+dub.sdl:
dependency "dmd" path="../.."
+/
import std.stdio;

// test frontend
void main()
{
    import dmd.frontend;
    import std.algorithm : each;

    initDMD;
    findImportPaths.each!addImport;

    auto m = parseModule("test.d", q{
        void foo()
        {
            foreach (i; 0..10) {}
        }
    });

    m.fullSemantic;
    auto generated = m.prettyPrint;

    auto expected =q{import object;
void foo()
{
    {
        int __key2 = 0;
        int __limit3 = 10;
        for (; __key2 < __limit3; __key2 += 1)
        {
            int i = __key2;
        }
    }
}
};
    assert(expected == generated, generated);
}

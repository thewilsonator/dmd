struct C {
    A a;
}

struct A {
    B b;
}

struct B {
    struct Inner {
        C c;
    }
}

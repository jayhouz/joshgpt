node Person {
    has name: str;
}

edge Friend{}
edge Family{}

with entry {

    p1 = Person(name = "Jason");
    p2 = Person(name = "Loggee");
    p3 = Person(name = "Josh");

    root ++> p1;
    root ++> p3;
    p1 +>:Friend:+> p2;
    print(p1.name, p2.name, p3.name);
    print([root-->], 'are connected to root');
    print([p1-->], 'are connected to p1');
}

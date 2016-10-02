import com.vasileff.ceylon.bitset {
    BitSet
}
import ceylon.test {
    test, assertEquals
}

shared test void testBitSetOnBitSet() {
    // BitSet.whatever(BitSet)
    assert (BitSet{1,2,3}.superset(BitSet{1,3}));
    assert (!BitSet{1,2,3}.superset(BitSet{1,4}));
    assert (BitSet{1,2,3}.subset(BitSet{1,2,3,4}));
    assert (!BitSet{1,2,3}.subset(BitSet{1,2,4}));

    assertEquals(BitSet{1,2,3}.union(BitSet{4,5,6}), set { 1,2,3,4,5,6 });
    assertEquals(BitSet{1,2,3}.union(BitSet{1,2,3,4}), set { 1,2,3,4 });
    assertEquals(BitSet{1,2,3}.or(BitSet{4,5,6}), set { 1,2,3,4,5,6 });
    assertEquals(BitSet{1,2,3}.or(BitSet{1,2,3,4}), set { 1,2,3,4 });

    assertEquals(BitSet{1,2,3}.exclusiveUnion(BitSet{3,4,5}), set { 1,2,4,5 });
    assertEquals(BitSet{1,2,3}.exclusiveUnion(BitSet{1,2,3}), set { });
    assertEquals(BitSet{1,2,3}.xor(BitSet{3,4,5}), set { 1,2,4,5 });
    assertEquals(BitSet{1,2,3}.xor(BitSet{1,2,3}), set { });

    assertEquals(BitSet{1,2,3}.and(BitSet{4,5,6}), set { });
    assertEquals(BitSet{1,2,3}.and(BitSet{1,3,4}), set { 1,3 });
    assertEquals(BitSet{1,2,3}.intersection(BitSet{4,5,6}), set { });
    assertEquals(BitSet{1,2,3}.intersection(BitSet{1,3,4}), set { 1,3 });

    assertEquals(BitSet{1,2,3}.complement(BitSet{}), set { 1,2,3 });
    assertEquals(BitSet{1,2,3}.complement(BitSet{3,4}), set { 1,2 });
    assertEquals(BitSet{1,2,3}.andNot(BitSet{}), set { 1,2,3 });
    assertEquals(BitSet{1,2,3}.andNot(BitSet{3,4}), set { 1,2 });
}

shared void testSetOnBitSet() {
    // Set.whatever(BitSet)
    assert (set{1,2,3}.superset(BitSet{1,3}));
    assert (!set{1,2,3}.superset(BitSet{1,4}));
    assert (set{1,2,3}.subset(BitSet{1,2,3,4}));
    assert (!set{1,2,3}.subset(BitSet{1,2,4}));

    assertEquals(set{1,2,3}.union(BitSet{4,5,6}), set { 1,2,3,4,5,6 });
    assertEquals(set{1,2,3}.union(BitSet{1,2,3,4}), set { 1,2,3,4 });

    assertEquals(set{1,2,3}.exclusiveUnion(BitSet{3,4,5}), set { 1,2,4,5 });
    assertEquals(set{1,2,3}.exclusiveUnion(BitSet{1,2,3}), set { });

    assertEquals(set{1,2,3}.intersection(BitSet{4,5,6}), set { });
    assertEquals(set{1,2,3}.intersection(BitSet{1,3,4}), set { 1,3 });

    assertEquals(set{1,2,3}.complement(BitSet{}), set { 1,2,3 });
    assertEquals(set{1,2,3}.complement(BitSet{3,4}), set { 1,2 });
}

shared void testBitSetOnSet() {
    // BitSet.whatever(Set)
    assert (BitSet{1,2,3}.superset(set{1,3}));
    assert (!BitSet{1,2,3}.superset(set{1,4}));

    assert (BitSet{1,2,3}.subset(set{1,2,3,4}));
    assert (!BitSet{1,2,3}.subset(set{1,2,4}));

    assertEquals(BitSet{1,2,3}.union(set{4,5,6}), set { 1,2,3,4,5,6 });
    assertEquals(BitSet{1,2,3}.union(set{1,2,3,4}), set { 1,2,3,4 });

    assertEquals(BitSet{1,2,3}.exclusiveUnion(set{3,4,5}), set { 1,2,4,5 });
    assertEquals(BitSet{1,2,3}.exclusiveUnion(set{1,2,3}), set { });

    assertEquals(BitSet{1,2,3}.intersection(set{4,5,6}), set { });
    assertEquals(BitSet{1,2,3}.intersection(set{1,3,4}), set { 1,3 });

    assertEquals(BitSet{1,2,3}.complement(set{}), set { 1,2,3 });
    assertEquals(BitSet{1,2,3}.complement(set{3,4}), set { 1,2 });
}

shared void testBitsetIterator() {
    assertEquals(BitSet {}.sequence(), []);
    assertEquals(BitSet {0}.sequence(), [0]);
    assertEquals(BitSet {1, 3}.sequence(), [1, 3]);
}

shared void run() {
    testBitSetOnBitSet();
    testBitSetOnSet();
    testSetOnBitSet();
    testBitsetIterator();
    print("BitSet tests complete.");
}

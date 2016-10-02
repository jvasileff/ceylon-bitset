import ceylon.whole {
    Whole, zero
}

shared final class BitSet
        satisfies Set<Integer> {

    Whole bits;
    Integer highValue;

    new ofWhole(Whole bits) {
        assert (!bits.negative);
        // TODO expose Whole.bitLength and Whole.bitLengthUnsigned
        variable value highValue = -1;
        variable value w = bits;
        while (!w.zero) {
            w = w.rightArithmeticShift(1);
            highValue++;
        }
        this.bits = bits;
        this.highValue = highValue;
    }

    shared new ({Integer*} elements) {
        variable value bits = zero;
        variable value highValue = -1;
        // TODO add method to Whole to set multiple bits
        for (element in elements) {
            "BitSet elements must be positive"
            assert (element >= 0);
            bits = bits.set(element);
            if (element > highValue) {
                highValue = element;
            }
        }
        this.bits = bits;
        this.highValue = highValue;
    }

    shared actual Iterator<Integer> iterator() {
        if (highValue == -1) {
            return emptyIterator;
        }
        return object satisfies Iterator<Integer> {
            variable value nextElement = 0;
            shared actual Integer | Finished next() {
                while (true) {
                    if (nextElement > highValue) {
                        return finished;
                    }
                    if (bits.get(nextElement++)) {
                        return nextElement - 1;
                    }
                }
            }
        };
    }

    shared BitSet and(BitSet other)
        =>  BitSet.ofWhole(bits.and(other.bits));

    shared BitSet or(BitSet other)
        =>  BitSet.ofWhole(bits.or(other.bits));

    shared BitSet xor(BitSet other)
        =>  BitSet.ofWhole(bits.xor(other.bits));

    "Return a [[BitSet]] containing all elements of this `BitSet` that are not contained
     in the specified `BitSet`."
    shared BitSet andNot(BitSet other)
        =>  BitSet.ofWhole(bits.and(other.bits.not));

    shared BitSet set(Integer index, Boolean bit = true) {
        assert(!index.negative);
        return BitSet.ofWhole(bits.set(index, bit));
    }

    shared actual Set<Integer | Other> union<Other>(Set<Other> set)
            given Other satisfies Object {
        if (is BitSet set) {
            return or(set);
        }
        return super.union(set);
    }

    shared actual Set<Integer | Other> exclusiveUnion<Other>(Set<Other> set)
            given Other satisfies Object {
        if (is BitSet set) {
            return xor(set);
        }
        return super.exclusiveUnion(set);
    }

    shared actual Set<Integer & Other> intersection<Other>(Set<Other> set)
            given Other satisfies Object {
        if (is BitSet set) {
            assert (is Set<Other> result = and(set));
            return result;
        }
        return super.intersection(set);
    }

    shared actual Set<Integer> complement<Other>(Set<Other> set)
            given Other satisfies Object {
        if (is BitSet set) {
            assert (is Set<Other> result = andNot(set));
            return result;
        }
        return super.complement(set);
    }

    shared actual Boolean superset(Set<Object> set) {
        if (is BitSet set) {
            return or(set).xor(this).empty;
        }
        return super.superset(set);
    }

    shared actual Boolean subset(Set<Object> set) {
        if (is BitSet set) {
            return or(set).xor(set).empty;
        }
        return super.subset(set);
    }

    contains(Object element)
        =>  if (is Integer element)
            then bits.get(element)
            else false;

    empty => highValue == -1;

    hash => (super of Set<Integer>).hash;

    equals(Object other)
        =>  if (is BitSet other)
            then bits == other.bits
            else (super of Set<Integer>).equals(other);
}

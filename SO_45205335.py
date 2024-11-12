import itertools
import timeit
import numpy as np
import pandas as pd

# Function definitions for each method
def method_1(n):
    return list(itertools.permutations(range(n), 2))

def method_2(n):
    def pairs_exclude_diagonal(it):
        i1, i2 = itertools.tee(it, 2)
        l2 = list(i2)
        for x in i1:
            for y in l2:
                if x != y:
                    yield (x, y)
    return list(pairs_exclude_diagonal(range(n)))

def method_3(n):
    def pairs_exclude_diagonal(it):
        for x, y in itertools.product(it, repeat=2):
            if x != y:
                yield (x, y)
    return list(pairs_exclude_diagonal(range(n)))

def method_4(n):
    def pairs_exclude_diagonal(it):
        items = list(it)
        for i, x in enumerate(items):
            for j, y in enumerate(items):
                if i != j:
                    yield (x, y)
    return list(pairs_exclude_diagonal(range(n)))

def method_5(n):
    def pairs_exclude_diagonal(it):
        items = list(it)
        return [(x, y) for i, x in enumerate(items) for j, y in enumerate(items) if i != j]
    return pairs_exclude_diagonal(range(n))

def method_6(n):
    def pairs_exclude_diagonal(it):
        items = list(it)
        for x, y in itertools.combinations(items, 2):
            yield (x, y)
            yield (y, x)
    return list(pairs_exclude_diagonal(range(n)))

# Method testing
methods = [method_1, method_2, method_3, method_4, method_5, method_6]
ranges = [2, 3, 4, 5]
n_sim = 100

# Recording execution times
results = np.zeros((len(methods), len(ranges)))

for i, method in enumerate(methods):
    for j, r in enumerate(ranges):
        times = timeit.repeat(lambda: method(r), repeat=n_sim, number=1)
        results[i, j] = np.mean(times)



df = pd.DataFrame(results, columns=ranges, index=[f'Method_{i+1}' for i in range(len(methods))])
print(df)


# [Advent of Code 2019](https://adventofcode.com/2019/)

This is my attempt at solving the Advent Of Code problems in Julia (what else?),
trying to provide reasonably efficient solutions.


## Performances

```sh
export AOC_PERF=1
julia --project test/runtests.jl
```

| Title | Mem [MiB] | Allocs | Time [ms] |
|:----- | ---------:| ------:| ---------:|
| 1.1   |      0.01 |    222 |      0.03 |
| 1.2   |      0.01 |    222 |      0.03 |
| 2.1   |      0.01 |    182 |      0.03 |
| 2.2   |      0.02 |    192 |      9.03 |
| 3.1   |      20.9 |   1284 |     35.52 |
| 3.2   |     16.74 |   1314 |     30.78 |
| 4.1   |       0.0 |      0 |      7.88 |
| 4.2   |       0.0 |      0 |      8.78 |
| 5.1   |      0.05 |    720 |      0.11 |
| 5.2   |      0.05 |    718 |      0.11 |
| 6     |      1.21 |  20187 |      1.29 |
| 7.1   |      0.11 |   1888 |      0.34 |
| 7.2   |      0.07 |    859 |       0.7 |
| 8.1   |      0.15 |    124 |      0.21 |
| 8.2   |      0.15 |     59 |      0.22 |
| 9.1   |      0.06 |   1016 |      0.15 |
| 9.2   |      0.07 |   1019 |      9.91 |

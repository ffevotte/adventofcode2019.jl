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
| 1.1   |      0.01 |    222 |      0.14 |
| 1.2   |      0.01 |    222 |      0.13 |
| 2.1   |      0.01 |    172 |      0.17 |
| 2.2   |      0.01 |    174 |      3.26 |
| 3.1   |      20.9 |   1284 |     31.66 |
| 3.2   |     16.74 |   1314 |     29.59 |
| 4.1   |       0.0 |      0 |      7.57 |
| 4.2   |       0.0 |      0 |      8.31 |
| 5.1   |      0.05 |    707 |      0.22 |
| 5.2   |      0.05 |    707 |       0.2 |
| 6     |      1.21 |  20187 |      1.23 |
| 7.1   |      0.04 |    674 |      0.35 |
| 7.2   |      0.07 |    825 |      0.66 |

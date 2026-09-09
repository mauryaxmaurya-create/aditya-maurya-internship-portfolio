# Sydney Route Optimisation with Heuristic Search

## Overview

This project models a route through 20 public locations in central Sydney as a travelling salesperson problem. The route starts and ends at Sydney Town Hall and visits every other location once. Because exhaustive search is impractical, the project compares simulated annealing and a genetic algorithm against a nearest-neighbour baseline.

## Tools and techniques

- Python, NumPy, pandas and Matplotlib
- Haversine distance matrix for geographic coordinates
- Simulated annealing with neighbourhood moves
- Genetic algorithm with selection, crossover and mutation
- Repeated-trial evaluation using controlled random seeds
- Route validation and visual comparison

## Results

The nearest-neighbour baseline produced a route of 12.344 km. Both search methods found a best route of 8.8959 km.

| Metric | Simulated annealing | Genetic algorithm |
|---|---:|---:|
| Mean route distance | 8.9719 km | 8.9111 km |
| Standard deviation | 0.2058 km | 0.0029 km |
| Runs within 1% of pooled best | 80% | 100% |
| Improvement over baseline | 27.32% | 27.81% |

The genetic algorithm was selected for the original dataset because its solutions were substantially more consistent. A second experiment added UTS Tower as a 21st location without retuning: simulated annealing then achieved the lower mean distance (10.2448 km versus 10.2952 km). This showed that the preferred method depends on the data and deployment conditions.

## Repository contents

- `notebooks/sydney_route_optimisation.ipynb` — complete implementation, experiments and visualisations
- `docs/report.pdf` — project report
- `docs/notebook_output.pdf` — rendered notebook output

## Responsible use and limitations

The model uses straight-line geographic distance rather than a pedestrian or road network. It therefore does not account for access restrictions, opening hours, traffic, disability access, weather or worker breaks. A deployed system should use a routing API and allow a worker to review or override the suggested route.

## Project context

Individual university project completed for Introduction to Artificial Intelligence.

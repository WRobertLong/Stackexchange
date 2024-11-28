import numpy as np
from scipy.optimize import minimize
import cvxpy as cp
from pyomo.environ import ConcreteModel, Var, Objective, Constraint, NonNegativeReals, SolverFactory, minimize as pyomo_minimize
import time

# Data
A = np.array([
    [1, 2, 3, 4, 5],
    [2, 3, 4, 5, 6],
    [3, 4, 5, 6, 7]
])
y = np.array([10, 15, 20])
bounds = [
    (1.4816, 2.1056),
    (1.6004, 2.3538),
    (2.3500, 4.4341),
    (1.5171, 2.1779),
    (2.2372, 4.0488)
]

# --- SciPy Solver ---
start = time.time()


def objective_scipy(x):
    return np.sum(np.abs(A @ x - y))


x0 = np.mean(bounds, axis=1)
scipy_result = minimize(
    objective_scipy, x0, bounds=bounds, method='SLSQP'
)
scipy_time = time.time() - start
scipy_x = scipy_result.x
print(f"SciPy Optimal x: {scipy_x}, Time Taken: {scipy_time:.6f} seconds")

# --- CVXPY Solver ---
start = time.time()
x_cvxpy = cp.Variable(5)
objective_cvxpy = cp.Minimize(cp.norm1(A @ x_cvxpy - y))
constraints_cvxpy = [bounds[i][0] <= x_cvxpy[i] for i in range(
    5)] + [x_cvxpy[i] <= bounds[i][1] for i in range(5)]
problem_cvxpy = cp.Problem(objective_cvxpy, constraints_cvxpy)
problem_cvxpy.solve()
cvxpy_time = time.time() - start
cvxpy_x = x_cvxpy.value
print(f"CVXPY Optimal x: {cvxpy_x}, Time Taken: {cvxpy_time:.6f} seconds")

# --- Pyomo Solver ---
start = time.time()
model = ConcreteModel()
model.x = Var(range(5), bounds=lambda model, i: bounds[i])
model.z = Var(range(3), domain=NonNegativeReals)

# Objective


def objective_pyomo(model):
    return sum(model.z[i] for i in range(3))


model.objective = Objective(rule=objective_pyomo, sense=pyomo_minimize)

# Constraints


def abs_constraint_upper(model, i):
    return model.z[i] >= sum(A[i, j] * model.x[j] for j in range(5)) - y[i]


model.abs_upper = Constraint(range(3), rule=abs_constraint_upper)


def abs_constraint_lower(model, i):
    return model.z[i] >= -(sum(A[i, j] * model.x[j] for j in range(5)) - y[i])


model.abs_lower = Constraint(range(3), rule=abs_constraint_lower)

solver = SolverFactory('glpk')
solver.solve(model)
pyomo_time = time.time() - start
pyomo_x = [model.x[i].value for i in range(5)]
print(f"Pyomo Optimal x: {pyomo_x}, Time Taken: {pyomo_time:.6f} seconds")

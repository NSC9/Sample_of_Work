def code():
    import matplotlib.pyplot as plt
    import numpy as np
    import sympy as sy
    import pandas as pd

    #define our function
    def f(x): return x

    #define the limits
    a = 0
    b = 1
    
    #define n as a symbolic variable
    n = sy.Symbol('n')

    #determine the width https://i.imgur.com/TWOYvz1.png
    width = (b-a)/n



    #example of how symbols and numbers play
    for i in range(1,10):
        print(f(a + i*width))
    
    def f(x): return x**2

    for i in range(1,10):
        print(f(a + i*width))

    print("\n")
    i, n = sy.symbols('i, n')
    sy.summation(i, (i, 1, n))
    sy.pprint(sy.summation(i**2, (i, 1, n)))
    print("\n")

    def riemann(a, b, n):
        #This is a function to evaluate our riemann sum formula
        #first we determine the width
        width = (b - a)/n
        #then we determine the heights and their sum
        #define symbols i and n as symbolic variables
        i, n = sy.symbols('i, n')
        s = sy.summation(f(a + (b-a)/n*i), (i, 1, n))
        #finally we return the results of the sum
        return sy.pprint(width*s)

    def f(x): return x

    riemann(0, 1, n)





code()

def source():
    source= "https://calc-again.readthedocs.io/en/latest/calc_notebooks/0.7_calc_Definite-Integral.html"
def notes():
    #What one fool can do, another can.
    #   -(Ancient Simian Proverb.)
    # These dreadful symbols are:
    # d which merely means “a little bit of.”
    # Thus dx means an element of x;
    #  or du means a element of u.
    # this big S means "the sum of"
    # https://i.imgur.com/4L7MXGs.png

    # thus https://i.imgur.com/suzhlU0.png means 
    # the sum of all the elements of x
    # the sum or also called 'the integral of'
    # so the integral of dx is equal to x
    # integral means the whole
    # so the integral of dx adds all the elements together to form x

    #example
    # 1 hour  = x
    # the integral of dx = x
    # 1 hour = the integral of dx
    # 1 hour  = 3600 seconds
    #dee-eks (dx) are called "differentials"
    # the long S is stands for "the integral of" or sum
    # x = integral
    # dx to x : 3600 seconds to 1hour
    # dx * dx is negligible, being a small quantity of the second order

    #lets say x is a pile of hay
    #we want to add more hay to the pile
    #we could express this mathematically as:
    # x + dx
    string = "hello"

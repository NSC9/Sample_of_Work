# Sympy v1.12
from sympy.simplify.fu import TR22
from sympy import *
import warnings
warnings.filterwarnings("ignore")
import random
from sympy.abc import x,y,theta,pi
f,g,h,j,i = Function('f'),Function('g'),Function('h'),Function('j'),0
keywords = {"polylog","Ei","gamma","Piecewise","li","erf",
             "hyper","fresnel","Li","expint","zoo","nan","oo","abs",
             "re","EulerGamma", "sinh","tanh", "cosh",'sign',"abs",
             "atan","csc","asin","Ci","Si"}
keywords2 = {"sin","cos","tan"}
def randconst(i):
    random_number = random.randint(-7, 7)
    if random_number == 0:
        random_number = random.choice([-7, 7])
    return random_number

aa,bb,cc = randconst(i),randconst(i),randconst(i)
def power(x):      
    return aa*x**bb+cc

def randvar(i):
    return Symbol(random.choice([i for i in ['phi','psi','v','t','x','z','y']]), real=True)                                               

def dmain(x):
    def random_math(x): 
        funs = [power,power,sqrt,cbrt]#,ln,exp,sin,cos,tan]   
        operations = [f(g(x))+h(x)*j(x)]
        operation = operations[random.randrange(0,len(operations))]
        return [[[[operation.replace(f, i) for i in funs]\
                 [random.randrange(0,len(funs))].replace(g, i) for i in funs]\
                 [random.randrange(0,len(funs))].replace(h, i) for i in funs]\
                 [random.randrange(0,len(funs))].replace(j, i) for i in funs]\
                 [random.randrange(0,len(funs))]
    return random_math(x)
def imain(x):
    def random_math2(x):  
        funs = [power,power,sqrt,cbrt]#,ln,exp,tan,cos,sin]   
        operations = [f(x)+h(x)]
        operation = operations[random.randrange(0,len(operations))]
        return [[[[operation.replace(f, i) for i in funs]\
                 [random.randrange(0,len(funs))].replace(g, i) for i in funs]\
                 [random.randrange(0,len(funs))].replace(h, i) for i in funs]\
                 [random.randrange(0,len(funs))].replace(j, i) for i in funs]\
                 [random.randrange(0,len(funs))]
    return random_math2(x)
derror = True
def dtest():
    global derror
    global setup1
    x = randvar(i)
    setup1 = dmain(x)
    practice1 = Derivative(setup1,x)       
    p1eq = Eq(practice1,practice1.doit(),evaluate=False)
    if any(kw in str(setup1) for kw in keywords2):
        setup1 = setup1.replace(x,theta)
        practice1 = Derivative(setup1,theta)   
        p1eq = Eq(practice1,practice1.doit(),evaluate=False)
    if p1eq.rhs != 0 and not any(kw in str(p1eq) for kw in keywords):
        derror = False
    return p1eq
dcount=0
while derror == True: 
    dcount+=1
    # print("...generating derivative %s"%dcount)
    output1 = dtest()
ierror = True
def itest():
    global ierror
    global setup2
    x = randvar(i)
    setup2 = imain(x)
    practice2 = Integral(setup2,x) 
    p2eq = Eq(practice2,practice2.doit(),evaluate=False)
    integral = "Integral"
    if str(factor_terms(p2eq.lhs)) != str(factor_terms(p2eq.rhs)) and not any(kw in str(p2eq) for kw in keywords)\
    and str(p2eq.lhs) != str(-p2eq.rhs)and not any(kw in str(p2eq.rhs) for kw in integral): 
        if any(kw in str(setup2) for kw in keywords2):
            setup2 = setup2.replace(x,theta)
            practice2 = Integral(setup2,theta)  
            p2eq = Eq(practice2,practice2.doit(),evaluate=False)
        ierror = False
    return p2eq
icount = 0
while ierror == True:
    icount+=1
    # print("...generating integral %s"%icount)
    output2 = itest()

questionmark = Symbol('?')
addsymbol = Symbol('+')
s1 = 15
s2 = 4
keywords5 = {"exp","log"}
def question():
    eqn = Eq(nsimplify(output1.lhs),questionmark)
    eqn2 = Eq(nsimplify(output2.lhs),questionmark)
    if any(kw in str(output1) for kw in keywords5):
        p = plot(setup1,title="q1's expression",size = (s1,s2),show=False,legend=True,line_color = 'orange',yscale='log')
    else:
        p = plot(setup1,title="q1's expression",size = (s1,s2),show=False,legend=True,line_color = 'orange')
    if any(kw in str(output2) for kw in keywords5):
        p2 = plot(setup2,title="q2's expression",size=(s1,s2),show=False,legend=True,line_color = 'orange',yscale='log')
    else:
        p2 = plot(setup2,title="q2's expression",size=(s1,s2),show=False,legend=True,line_color = 'orange')
    #eqn3 = Eq(nsimplify(output3.lhs),questionmark)
    return print("q1)"),display(eqn),print("q2)"),display(eqn2)#,p.show(),p2.show()#,print("q3"),display(eqn3)
def answer():
    eqn = TR22(Eq(nsimplify(output1.lhs),nsimplify(output1.rhs)))
    eqn2 = TR22(Eq(nsimplify(output2.lhs),nsimplify(output2.rhs)))
    if any(kw in str(output1) for kw in keywords5):
        p = plot(eqn.rhs,setup1,title="Derivative from q1",size = (s1,s2),show=False,legend=True,yscale='log')
    else:
        p = plot(eqn.rhs,setup1,title="Derivative from q1",size = (s1,s2),show=False,legend=True)
    if any(kw in str(output2) for kw in keywords5):
        p2 = plot(eqn2.rhs,setup2,title="Integral from q2",size = (s1,s2),show=False,legend=True,yscale='log')
    else: 
        p2 = plot(eqn2.rhs,setup2,title="Integral from q2",size = (s1,s2),show=False,legend=True)
    #eqn3 = TR22(Eq(nsimplify(output3.lhs),nsimplify(output3.rhs)))
    return print("a1)"),display(eqn),print("a2)"),display(eqn2)#,p.show(),p2.show()#,print("a3"),display(eqn3)
def calculus():
    print("\n")
    print('Solve with Pen and Paper:')
    print("\n")
    question()
    print("\n")
    answer()
    print("----------------------------------------------------------------------")

    
def resources():
    print("\n")
    print("for help on q1&q2: copy/paste expressions into https://www.derivative-calculator.net/ or https://www.integral-calculator.com/")
    print("     Differentiate:",str(nsimplify(output1.lhs))[11:-4])
    print("     Integrate:",str(nsimplify(output2.lhs))[9:-4]) 
    print("\n")

def main():
    calculus()
    resources()
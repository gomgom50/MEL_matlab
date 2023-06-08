from sympy import symbols, Function, Derivative, parse_expr

def replace_partial_derivatives(expr_str):
    # Parse the string into a symbolic expression
    expr = parse_expr(expr_str)
    
    # Find all Derivative objects
    derivatives = expr.atoms(Derivative)
    
    # Perform replacement
    for derivative in derivatives:
        var = derivative.args[0]  # Variable being derived
        var_dot = symbols(f"{var.name}dot")  # New symbol with 'dot' notation
        expr = expr.subs(derivative, var_dot)
    
    return str(expr)

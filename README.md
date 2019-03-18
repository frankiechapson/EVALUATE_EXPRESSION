# Value of an expression

## An Oracle PL/SQL solution to get the value of an expression independently of its type


This simple, but usefull function returns with the value of an expression. 
If you got the original expression instead of its value (in case if they are different) that means the expression is wrong and the function handle its as a constant string.
    
Example:

    exec  dbms_output.put_line('constant number    : ' || EVALUATE_EXPRESSION ( '42' ) );
    exec  dbms_output.put_line('constant string    : ' || EVALUATE_EXPRESSION ( 'Dog' ) );
    exec  dbms_output.put_line('sql expression     : ' || EVALUATE_EXPRESSION ( 'decode( 1, 2, 3, 4 )' ) );
    exec  dbms_output.put_line('a select           : ' || EVALUATE_EXPRESSION ( 'select * from dual' ) );
    exec  dbms_output.put_line('plsql expression   : ' || EVALUATE_EXPRESSION ( 'sqlerrm' ) );
    exec  dbms_output.put_line('math expression    : ' || EVALUATE_EXPRESSION ( '23*54/75*44' ) );
    exec  dbms_output.put_line('date expression    : ' || EVALUATE_EXPRESSION ( 'add_months(trunc(sysdate,''mm''),4) + 3' ) );
    exec  dbms_output.put_line('boolean expression : ' || EVALUATE_EXPRESSION ( '1=2' ) );

Results:

    constant number    : 42
    constant string    : Dog
    sql expression     : 4
    select             : X
    plsql expression   : ORA-0000: normal, successful completion
    math expression    : 728,64
    date expression    : 2019.07.04 00:00:00
    boolean expression : FALSE

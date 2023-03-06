create or replace function EVALUATE_EXPRESSION( I_EXPRESSION in varchar2 
                                              ) return varchar2 is
/* *************************************************************

    This simple function returns with the value of an expression
    
    History of changes
    yyyy.mm.dd | Version | Author         | Changes
    -----------+---------+----------------+-------------------------
    2019.03.18 |  1.0    | Ferenc Toth    | Created 
    2023.03.06 |  1.1    | Ferenc Toth    | return I_EXPRESSION; instead of null

************************************************************* */

    PRAGMA AUTONOMOUS_TRANSACTION;
    V_RESULT    varchar2( 32000 );

begin
    -- SQL expression?
    begin
        execute immediate 'select '||I_EXPRESSION||' from dual' into V_RESULT;
    exception when others then
        -- a SELECT?
        begin
            execute immediate I_EXPRESSION into V_RESULT;
        exception when others then
            -- a PL/SQL expression? 
            begin
                execute immediate 'begin :result := ' || I_EXPRESSION || '; end;' using out V_RESULT;
            exception when others then
                -- a boolean expression? 
                begin
                    execute immediate 'begin if ' || I_EXPRESSION || ' then :result := ''TRUE''; else :result := ''FALSE''; end if; end;' using out V_RESULT;
                exception when others then
                    return I_EXPRESSION;
                end;
            end;
        end;
    end;
    rollback;
    return V_RESULT;
end;
/




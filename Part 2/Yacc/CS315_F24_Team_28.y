%token EOL_COMMENT COMMA SC INT_T FLOAT_T CHAR_T STRING_T BOOL_T IF ELSE ELSE_IF TRUE FALSE WHILE RETURN BREAK VOID PRINT INPUT MAIN GET_HEADING GET_ALTITUDE GET_TIME MANAGE_NOZZLE VERTICAL_MOVEMENT MOVE_UP MOVE_DOWN STOP TURN_NOZZLE_ON TURN_NOZZLE_OFF HORIZONTAL_MOVEMENT TURN_HEADING TURN_LEFT TURN_RIGHT MOVE_FORWARD MOVE_BACKWARD MOVE_DRONE EQ_TRIANGLE MOVE_FOR_DURATION SPRAY_FIELD AND_OP OR_OP EQ NEQ NOT_OP LT LTE GT GTE LP RP LCB RCB ASSIGN_OP PLU_OP MIN_OP MUL_OP DIV_OP INT FLOAT BOOL_VAR_NAME VAR_NAME STRING CHAR INCR_OP DECR_OP FOR CONNECT_URL 
%%
program: stmt_list {printf("Input program is valid.\n"); return 0;}

stmt_list: stmt
	| stmt stmt_list
	;

stmt: declaration_stmt 
	| assign_stmt 
	| conditional_stmt 
	| loop_stmt
	| break_stmt
	| func_def_stmt
	| func_call_stmt
	| comment
	;

comment: EOL_COMMENT;

declaration_stmt: data_type var_name SC 
	| data_type assign_stmt
	| data_type bool_var_name SC
	;

data_type: INT_T
     	| FLOAT_T
     	| CHAR_T
     	| STRING_T
     	| BOOL_T
	;

var_name: VAR_NAME;

assign_stmt: var_name ASSIGN_OP expression SC 
	| var_name ASSIGN_OP func_call_stmt
	| bool_var_name ASSIGN_OP logic_expression SC
	| bool_var_name ASSIGN_OP func_call_stmt
	| var_name ASSIGN_OP STRING SC 
	| var_name ASSIGN_OP CHAR SC 
	;

expression: arithmetic_expression 
	| logic_expression
	;

else_if_stmt: ELSE_IF LP logic_expression RP LCB non_func_def_stmt_list RCB 
            | else_if_stmt ELSE_IF LP logic_expression RP LCB non_func_def_stmt_list RCB
            ;

conditional_stmt: if_with_elif 
                | if_wo_elif 
                ;

if_with_elif: IF LP logic_expression RP LCB non_func_def_stmt_list RCB else_if_stmt optional_else 
            ;

if_wo_elif: IF LP logic_expression RP LCB non_func_def_stmt_list RCB optional_else
          ;

optional_else: | ELSE LCB non_func_def_stmt_list RCB
             ;


arithmetic_expression: arithmetic_expression PLU_OP arithmetic_term 
	| arithmetic_expression MIN_OP arithmetic_term 
	| arithmetic_term
	;

arithmetic_term: arithmetic_term DIV_OP arithmetic_factor 
	| arithmetic_term MUL_OP arithmetic_factor 
	| arithmetic_factor
	;

arithmetic_factor: LP arithmetic_expression RP 
	| INT 
 	| FLOAT 
  	| var_name
	;

logic_expression: logic_expression OR_OP logic_term
	| logic_term
	;

logic_term: logic_term AND_OP logic_factor
	| logic_factor
	;

logic_factor: LP logic_expression RP
	| NOT_OP logic_factor
	| comparison_expression
	| logic_val
	| bool_var_name
	;

bool_var_name: BOOL_VAR_NAME

comparison_expression: arithmetic_expression comparison_op arithmetic_expression;

logic_val: TRUE 
    	| FALSE
	;

comparison_op: EQ 
    	| NEQ
    	| LT 
    	| LTE 
    	| GT 
    	| GTE
	;

non_func_def_stmt_list: non_func_def_stmt  
	| non_func_def_stmt non_func_def_stmt_list
	;

non_func_def_stmt: declaration_stmt 
  	| assign_stmt 
 	| conditional_stmt 
  	| loop_stmt
  	| break_stmt
  	| func_call_stmt
  	| comment
	;

loop_stmt: while_loop | for_loop;

while_loop: WHILE LP logic_expression RP LCB non_func_def_stmt_list RCB
	| WHILE LP logic_expression RP LCB RCB
	;

for_loop: FOR LP for_variable SC logic_expression SC for_statement RP LCB stmt_list RCB;

for_variable: declaration_stmt
            | empty_stmt;

for_statement: assign_stmt
             | increment_stmt
             | decrement_stmt
             | empty_stmt;

increment_stmt: var_name INCR_OP;

decrement_stmt: var_name DECR_OP;

rtrn_stmt_non_empty: RETURN expression SC; 

rtrn_stmt_empty: RETURN empty_stmt SC;

break_stmt: BREAK SC;

func_def_stmt: non_void_func_def_stmt 
	| void_func_def_stmt
	;

non_void_func_def_stmt: data_type func_name LP param_list RP LCB func_stmt_list rtrn_stmt_non_empty RCB
	| data_type func_name LP RP LCB func_stmt_list rtrn_stmt_non_empty RCB
	;

func_name: VAR_NAME;

void_func_def_stmt: VOID func_name LP param_list RP LCB func_stmt_list RCB 
	| VOID func_name LP RP LCB func_stmt_list RCB 
	| VOID func_name LP param_list RP LCB func_stmt_list rtrn_stmt_empty RCB 
	| VOID func_name LP RP LCB func_stmt_list rtrn_stmt_empty RCB 
	;

param_list: param 
	| param COMMA param_list
	;

param: data_type var_name;

func_stmt_list: func_stmt | func_stmt func_stmt_list;

func_stmt: declaration_stmt 
     	| assign_stmt 
     	| conditional_stmt 
    	| loop_stmt
     	| break_stmt
     	| func_call_stmt
	| comment
	;

func_call_stmt: func_name LP input_list RP SC 
	| func_name LP RP SC
        | prim_func_stmt
	| print_stmt
	| input_stmt
	;

input_list: input 
 	| input COMMA input_list
	;

input: expression 
 	| STRING;

print_stmt: PRINT LP input RP SC ;

input_stmt: INPUT LP input RP SC;

prim_func_stmt: get_heading
              | get_altitude
              | get_time
              | movement
              | manage_nozzle
              | turn_heading
	      | connect_url;

empty_stmt: ;

get_heading: GET_HEADING LP RP SC;

get_altitude: GET_ALTITUDE LP RP SC;

get_time: GET_TIME LP RP SC;

manage_nozzle: turn_nozzle_on
             | turn_nozzle_off;

turn_nozzle_on: TURN_NOZZLE_ON LP RP SC;

turn_nozzle_off: TURN_NOZZLE_OFF LP RP SC;

movement : vertical_movement | horizontal_movement | stop;

vertical_movement: move_up
                 | move_down;

move_up: MOVE_UP LP prim_func_input RP SC;

move_down: MOVE_DOWN LP prim_func_input RP SC;

horizontal_movement: move_forward
                   | move_backward;

stop: STOP LP RP SC;

move_forward: MOVE_FORWARD LP prim_func_input RP SC;

move_backward: MOVE_BACKWARD LP prim_func_input RP SC;

turn_heading: turn_right
             | turn_left;

turn_right: TURN_RIGHT LP RP SC;

turn_left: TURN_LEFT LP RP SC;

connect_url: CONNECT_URL LP STRING RP SC;

prim_func_input: arithmetic_expression
%%
#include "lex.yy.c"
int yyerror(char* s){
  fprintf(stderr, "%s on line %d\n",s, yylineno);
  return 1;
}
int main() {
yyparse();
return 0;
}
